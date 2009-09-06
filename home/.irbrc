# -*- mode: ruby; -*-
require 'rubygems'
%w{irb/completion irb/ext/save-history pp benchmark tempfile}.map(&method(:require))
begin
  require 'what_methods'
  require 'map_by_method'
rescue LoadError; end


# Class
#
class Object
   include Hirb::Console if defined?(Hirb)
  def local_methods(obj = self)
    (obj.methods - (obj.class.superclass || Object).instance_methods).sort
  end

  def table_methods
    defaults = local_methods.inject({}) {|h,e| h[e] = [];h }
    table defaults.map {|e| [e[0],e[1].join(",")] }, :headers=>%w{commands aliases}, :max_width=>80
  end

  #
  # Benchmark
  #
  # q { block }
  # q(n) { block }
  def q(repetitions=100, &block)
    Benchmark.bmbm do |b|
      b.report {repetitions.times &block}
    end
    nil
  end

  # b n, lambda{ }, lambda{ } ...
  def b(*stuff)
    rep, stuff = stuff.partition{ |s| s.kind_of? Numeric }
    rep.length ||= [1_000_000]
    rep.each do |r|
      puts "\n                         Running #{r} times"
      Benchmark.bmbm do |b|
        stuff.each { |s| b.report(s .to_s) { r.times &s } }
      end
    end
    "-----------------------------------------"
  end

  # RI access
  def ri(obj = '')
    puts `ri #{obj}`
  end

  def reset_irb()
    exec $0
  end

  #
  # Vim
  @irb_temp_code = nil

  def vim(file=nil)
    file = file.to_s + ".rb" if file
    file = file || @irb_temp_code || Tempfile.new("irb_tempfile").path+".rb"
    system("vim #{file}")
    if(File.exists?(file) && File.size(file)>0)
      Object.class_eval(File.read(file))
      @irb_temp_code = file
      "Vim.vidi.run!"
    else
      "No file loaded."
    end
  rescue => e
    puts "Error on vim: #{e}"
  end
  alias vi vim
end

#
# Rails stuff
#

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

unless RUBY_VERSION > '1.9'
  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  IRB.conf[:IRB_RC] = lambda do
    if defined?(ActiveRecord::Base)
      begin
        name = User.column_names.include?("name")
        login = User.column_names.include?("login")
        if name || login
          instance_eval <<RUBY
          def method_missing(name, *args, &block)
            super unless args.empty? && block.nil?
            instance_variable_get("@user_\#{name}") ||
            instance_variable_set("@user_\#{name}", User.find_by_#{name ? 'name' : 'login'}(name.to_s))
         end
RUBY
        end
      rescue
      end
      ActiveRecord::Base.logger = Logger.new(STDOUT)
    end
  end
end


#class Array
#  alias :__orig_inspect :inspect
 # def inspect
 #   (length > 20) ? "[#{first}, ... #{length} elements ...,#{last}]" : __orig_inspect
 # end
#end

#class Hash
#  alias :__orig_inspect :inspect
#  def inspect
#    (length > 20) ? "{:#{[keys[0]]} => #{[values[0]]}, ... #{length} keys ... }" : __orig_inspect
#  end
#end

#
# Some Test Data
#
HASH = { :one => 'Marley', :two => 'Barley', :three => 'Harley', :four => 'Farley'} unless defined?(HASH)
ARRAY = HASH.keys unless defined?(ARRAY)

at_exit { puts "Teh mais bro!" }
