# -*- mode: ruby; -*-
%w{irb/completion irb/ext/save-history pp rubygems}.map(&method(:require))
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

#Wirble.init
#Wirble.colorize

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

class Object
  def local_methods(obj = self)
    (obj.methods - (obj.class.superclass || Object).instance_methods).sort
  end
end

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
