# Asset Model (a.k.a Garbage Truck)
# Basic mobile unit, capable of harvesting garbage.
# Belongs to a Contract, Places dots on the map.
# Caching and Sonar capabilities. Beware!
class Asset < ActiveRecord::Base
  
  MOVER_STATES = [ :moving, :harvesting, :unknown ]
  
  acts_as_cached        :ttl      => 5.minutes
  acts_as_state_machine :initial  => :unknown
  
  with_options :enter => :close_operation, :exit => :open_operation do |opener|
    opener.state :unknown
    opener.state :parked
  end
  
  with_options :exit => :close_order do |mover|
    mover.state :moving,      :enter => Proc.new { |o| o.open_order :moving }
    mover.state :harvesting,  :enter => Proc.new { |o| o.open_order :harvesting }
    mover.state :unloading,   :enter => Proc.new { |o| o.open_order :unloading }
  end
  
  event :begin_harvesting do
    transitions :to => :harvesting, :from => MOVER_STATES
  end
  
  event :stop_harvesting do
    transitions  :to => :moving, :from => MOVER_STATES
  end
  
  event :unload do
    transitions :to => :unloading, :from => MOVER_STATES
  end
  
  event :stop do
    transitions :to => :unloading,  :from => MOVER_STATES,  :guard => :in_refinery?
    transitions :to => :parked,     :from => MOVER_STATES,  :guard => :in_base?
  end
  
  event :move do
    transitions :to => :moving, :from => :parked,     :guard => :not_in_base?
    transitions :to => :moving, :from => :unloading,  :guard => :not_in_refinery?
    transitions :to => :moving, :from => :unknown
  end
  
  
  # Associations
  belongs_to :contract, :dependent => :destroy
  delegate :dumps, :garages, :to => :contract
  
  has_many :operations
  has_one :operation, :conditions => { :is_open => true }
  delegate :harvests, :transits, :flushes, :order, :to => :operation
  
  # TODO: Handle plot through plottings
#  has_many :plots, :before_add => [ :on_plot ]

  has_many :plottings
  
  has_many :plots, :through => :plottings
  
  has_one :latest_plot, :class_name => "Plot", :order => "id DESC"
  
  attr_accessor :plot
  attr_reader :in_refinery, :in_base
  delegate :speed, :date, :the_geom, :event_id, :event_memo, :to => :plot
  alias :position :the_geom
  
  
  # Instance Methods
  def in_refinery?
    @in_refinery
  end

  def in_base?
    @in_base
  end

  def not_in_refinery?
    not in_refinery?
  end

  def not_in_base?
    not in_base?
  end
  
  def operating?
    !!latest_operation
  end

  def latest_operation
    self.cached(:operation, :ttl => 10.minutes)
  end

  def on_plot(p)
    begin
      say "toasting plot #{p}"
      self.plot = p
      check_collisions
      handle_event
      self.last_update = p.date
    rescue Exception => e
      str = "Ack! State Machine FAIL! Asset: #{self.id}, Plot: #{p} => #{e}, Trace: #{e.backtrace}"
      puts str
      return false
    end
    return true
  end

  def open_order(otype)
    p = self.plot
    opts = { :started_on => p.date, 
      :odometer_at_start => p.odometer }
    sender = case otype
      when :harvesting
        :harvests
      when :moving
        :transits
      when :unloading
        :flushes
      else
        nil
    end
    self.operation(true).send(sender).create!(opts) unless sender.nil?
  end

  def icon
    "lorry_#{self.current_state.to_s}.png".gsub('unknown','parked')
  end
  
  def status
    case self.current_state
      when :unknown
        "Nenhuma operação"
      when :moving
        "Em movimento"
      when :harvesting
        "Coletando"
      when :parked
        "Estacionado"
      when :unloading
        "Descarregando"
      else
        "Ocioso"
    end
  end
  
  def marker(opts={})
    position = self.cached(:latest_plot, :ttl => 10.minutes)
    return if position.nil? || position.the_geom.nil?
    opts.reverse_merge!(
      :title => "Caminhão #{self.title}: #{self.status}",
      :icon => Variable.new("marker_#{self.current_state.to_s}")
    )
    GMarker.from_georuby(position.the_geom,opts)
  end
  
  def title
    self.plate.blank? ? self.id.to_s : self.plate.to_s
  end

  def toast!
    t = self.plottings.find(:first, :conditions => { :toasted => false })
    return if t.nil?
    transaction do
      t.toast!
      self.save!
    end
  end
  protected
  
  def say(message="updated")
    puts "#{self.class.to_s} is #{self.id} #{message}! [#{self.last_update}]"
  end
  
  def close_order
    say 'closing an order'
    self.operation.order.close!
  end
  
  def open_operation
    say 'opening an operation'
    self.operations.create!(:started_on => @plot.date)
    self.operation(true)
  end
  
  def close_operation
    say 'closing an operation'
    self.operation.update_attributes!(:ended_on => @plot.date)
    self.operation.close!
  end

  def check_collisions
    say 'is checking collisions'
    p = self.plot
    @in_refinery, @in_base = *[self.dumps,self.garages].map do |a| 
      a.count(:conditions => {:site => @plot.the_geom}) > 0 
    end
  end

  def handle_event
    p = self.plot
    case p.event_id
      when 1
        (p.speed > 0) ? self.move! : self.stop!
      when 12
        self.begin_harvesting!
      when 14
        self.stop_harvesting!
      when 16
        self.unload!
    end
    unless self.operation.nil?
      self.operation.on_plot(p) 
      self.operation.valid?
    else
      true
    end
  end
  
end