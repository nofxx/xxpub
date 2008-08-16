#!/usr/bin/env ruby
#
# mongrel_processes startup script looks for 'mongrel_cluster.yml'
# and starts your mongrels servers on boot!
#
# updated by nofxx
# checks for capistrano

require 'fileutils'
require 'yaml'

SCRIPT_NAME = 'mongrel_processes'
#APP_DIR = /var/www/apps/
APP_DIR = '/var/www/vrails'
SCRIPT_VERSION = '0.8'

def capified?(app)
  File.exists?(File.join(APP_DIR, app, "current")) ? "current" : ""
end

def cluster?(app)
  File.exists?(File.join(APP_DIR, app, capified?(app), "config", "mongrel_cluster.yml"))
end

def started?(app)
  Dir.open(File.join(APP_DIR, app, capified?(app), "log")).each { |filename| return true if filename =~ /mongrel.*pid/ }
end

def wipe_cluster(app)
  Dir.open(File.join(APP_DIR, app, capified?(app), "log")).each { |filename| FileUtils::rm( File.join(APP_DIR, app, capified?(app), "log", filename)) if filename =~ /mongrel.*pid/ }
end

def start(app)
  if started?(app) == true
    puts "#{app} cluster is already active."
  else
    puts "Starting #{app}"
    `mongrel_rails cluster::start -C #{File.join(APP_DIR, app, capified?(app), "config", "mongrel_cluster.yml")}`     
  end
end

def stop(app)
  if started?(app) == true
    puts "Stopping #{app}"
    `mongrel_rails cluster::stop -C #{File.join(APP_DIR, app, capified?(app), "config", "mongrel_cluster.yml")}`
  else
    puts "#{app} is already stopped."
  end
end

def force_restart(app)
  puts
  puts "#{app} is being force restarted!"
  puts "Halting #{app}"
  wipe_cluster(app)
  start(app)         
end


# add that first line for readability 
puts

if %w{stop restart}.include? ARGV.first
  Dir.open(APP_DIR).each do |app|
    stop app if cluster?(app) 
  end
end

if %w{start restart}.include? ARGV.first
  Dir.open(APP_DIR).each do |app|
    start app if cluster?(app)
  end
end

if ARGV.first == "force_restart"
  Dir.open(APP_DIR).each do |app|
    force_restart app if cluster?(app) 
  end
end

if ARGV.first == "version"
  puts "#{SCRIPT_NAME} v#{SCRIPT_VERSION}"
end


unless %w{start stop restart force_restart version}.include? ARGV.first
        puts "Usage: #{SCRIPT_NAME} {start|stop|restart|force_restart|version}"
        exit
end
