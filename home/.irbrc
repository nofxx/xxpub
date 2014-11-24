# -*- mode: ruby; -*-
#require 'rubygems'
%w{irb/completion irb/ext/save-history benchmark tempfile}.map(&method(:require))

# ap -> awesome_print
%w{what_methods looksee did_you_mean ap pp}.each do |mod|
  begin
  require mod
  rescue LoadError => e
    puts "#{mod} not available.."
  end
end

begin
  require "wirble"
  Wirble.init(:skip_prompt=>true,:skip_history=>false,:history_size=>5000)
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
IRB.conf[:SAVE_HISTORY] = 8000
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
  include Hirb::Console if const_defined?("Hirb")
  def local_methods(obj = self)
    (obj.methods - (obj.class.superclass || Object).instance_methods).map(&:to_s).sort
  end

  def table_methods
    defaults = local_methods.inject({}) {|h,e| h[e] = [];h }
    table defaults.map {|e| [e[0],e[1].join(",")] }, :headers=>%w{commands aliases}, :max_width=>80
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
# Benchmark
#

# q { block }
# q(n) { block }
def q(repetitions=100, &block)
  Benchmark.bmbm do |b|
    b.report {repetitions.times { block.call }}
  end
  nil
end

# b n, lambda{ }, lambda{ } ...
def b(*stuff)
  rep, stuff = stuff.partition{ |s| s.kind_of? Numeric }
  rep << 1_000 if rep.empty?
  rep.each do |r|
    puts "\nRunning -> #{r} times"
    Benchmark.bmbm do |b|
      stuff.each_with_index do |s, i|
        if s.respond_to?(:call)
          b.report("Lambda ##{i}") { r.times { s.call } }
        else
          b.report(s.inspect) { r.times { eval(s.to_s) } }
        end
      end
    end
  end
  "DONE"
end

# RI access
def ri(obj = '')
  puts `ri #{obj}`
end

def reset_irb
  exec $0
end

# Emacs
#
@irb_temp_code = nil

def e(file=nil)
  file = file.to_s if file
  file = file || @irb_temp_code || Tempfile.new("irb_tempfile").path+".rb"
  system("emacs -nw #{file}")
  if(File.exists?(file) && File.size(file)>0)
    Object.class_eval(File.read(file))
    @irb_temp_code = file
    "Emacs to the rescue!"
  else
    "No file loaded."
  end
rescue => e
  puts "Error on emacs #{e}"
end

#
# Vim
@irb_temp_code = nil

def vim(file=nil)
  file = file.to_s if file
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


#
# Rails stuff
#

# .irbrc to log goodies like SQL/Mongo queries to $stdout if in Rails 3 console
if defined?(Rails) && Rails.respond_to?(:logger)
  require 'logger'
  Rails.logger = Logger.new($stdout)
  if defined?(Mongoid)
    Mongoid.logger = Rails.logger
  end
end

# # Called after the irb session is initialized and Rails has
# # been loaded (props: Mike Clark).
# IRB.conf[:IRB_RC] = lambda do
#   if defined?(ActiveRecord::Base)
#     begin
#       name = User.column_names.include?("name")
#       login = User.column_names.include?("login")
#       if name || login
#         instance_eval <<RUBY
#           def method_missing(name, *args, &block)
#             super unless args.empty? && block.nil?
#             instance_variable_get("@user_\#{name}") ||
#             instance_variable_set("@user_\#{name}", User.find_by_#{name ? 'name' : 'login'}(name.to_s))
#          end
# RUBY
#       end
#     rescue
#     end
#     ActiveRecord::Base.logger = Logger.new(STDOUT)
#   end
# end

#
# Some Test Data
#
H = { :one => 'Marley', :two => 'Barley', :three => 'Harley', :four => 'Farley'} unless defined?(H)
A = H.keys unless defined?(A)

at_exit { puts "Teh mais bro!" }
