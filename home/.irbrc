# -*- mode: ruby; -*-
%w{irb/completion irb/ext/save-history pp rubygems benchmark}.map(&method(:require))
begin
  require 'what_methods'
rescue LoadError; end

begin
  require "wirble"
  Wirble.init(:skip_prompt=>true,:skip_history=>true)
  Wirble.colorize
rescue LoadError => e
  puts "Seems you don't have Wirble installed: #{e}"
end
begin
  require "hirb"
  extend Hirb::Console
rescue LoadError => e
  puts "Install hirb!!: #{e}"
end

#
# Prompt stuff
#
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb.history"

if IRB.conf[:PROMPT]
  IRB.conf[:PROMPT][:SNAZZY] = {
    :PROMPT_I => ">> ",
    :PROMPT_C => "*> ",
    :PROMPT_N => "%i> ",
    :PROMPT_S => "%l> ",
    :RETURN   => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :SNAZZY
end

#
# Class
#
class Object
   include Hirb::Console
  def local_methods(obj = self)
    (obj.methods - (obj.class.superclass || Object).instance_methods).sort
  end

  def table_methods
    defaults = local_methods.inject({}) {|h,e| h[e] = [];h }
    table defaults.map {|e| [e[0],e[1].join(",")] }, :headers=>%w{commands aliases}, :max_width=>80
  end
end

class Array
  alias :__orig_inspect :inspect
  def inspect
    (length > 20) ? "[#{first}, ... #{length} elements ...,#{last}]" : __orig_inspect
  end
end

class Hash
  alias :__orig_inspect :inspect
  def inspect
    (length > 20) ? "{:#{[keys[0]]} => #{[values[0]]}, ... #{length} keys ... }" : __orig_inspect
  end
end

#
# Instance
#
def quick(repetitions=100, &block)
  Benchmark.bmbm do |b|
    b.report {repetitions.times &block}
  end
  nil
end

# RI access
def ri(obj = '')
  puts `ri #{obj}`
end

def reset_irb()
  exec $0
end


# configure vim
@irb_temp_code = nil

def vim(file=nil)
  file = file.to_s if file
  file = file || @irb_temp_code || Tempfile.new("irb_tempfile").path+".rb"
  system("vim #{file}")
  if(File.exists?(file) && File.size(file)>0)
    Object.class_eval(File.read(file))
    @irb_temp_code = file
    "File loaded from Vim."
  else
    "No file loaded."
  end
rescue => e
  puts "Error on vim: #{e}"
end
puts "Vim available."


#
# Rails stuff
#

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

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

#
# Some Test Data
#
HASH = { :one => 'Marley', :two => 'Barley', :three => 'Harley', :four => 'Farley'} unless defined?(HASH)
ARRAY = HASH.keys unless defined?(ARRAY)
