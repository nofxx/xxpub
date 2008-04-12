#!/usr/bin/env ruby
#
# mongrel_processes This is a startup script for use in /etc/init.d
#
# chkconfig:    2345 80 20
#
# description:  This will find all of your rails apps and start them with mongrel_cluster vi their mongrel_cluster.conf file
#               Point the script to your deploy root for your rails apps, and it will attempt to launch every app that has a mongrel_cluster.conf file
# updated by nofxx

require 'fileutils'

SCRIPT_NAME = 'mongrel_processes'
APP_DIR = '/var/www/vrails'
SCRIPT_VERSION = '0.6'



def is_cluster?(app)
  File.exists?(File.join(APP_DIR, app, "config", "mongrel_cluster.yml"))
end

def is_started?(app)
  Dir.open(File.join(APP_DIR, app, "log")).each { |filename| return true if filename =~ /mongrel.*pid/ }
end

def wipe_cluster(app)
  Dir.open(File.join(APP_DIR, app, "log")).each { |filename| FileUtils::rm( File.join(APP_DIR, app, "current", "log", filename)) if filename =~ /mongrel.*pid/ }
end

def start(app)
  if is_started?(app) == true
    puts "#{app} is already started"
  else
    puts "starting #{app}"
    `mongrel_rails cluster::start -C #{File.join(APP_DIR, app, "config", "mongrel_cluster.yml")}`     
  end
end

def stop(app)
  if is_started?(app) == true
    puts "stopping #{app}"
    `mongrel_rails cluster::stop -C #{File.join(APP_DIR, app, "config", "mongrel_cluster.yml")}`
  else
    puts "#{app} is already stopped"
  end
end

def force_restart(app)
  puts
  puts "#{app} is being force restarted"
  puts "force stopping #{app}"
  wipe_cluster(app)
  puts "starting #{app}"
  `mongrel_rails cluster::start -C #{File.join(APP_DIR, app, "config", "mongrel_cluster.yml")}`         
end


# add that first line for readability 
puts

if %w{stop restart}.include? ARGV.first
  Dir.open(APP_DIR).each do |app|
    stop app if is_cluster?(app) 
  end
end

if %w{start restart}.include? ARGV.first
  Dir.open(APP_DIR).each do |app|
    start app if is_cluster?(app)
  end
end

if ARGV.first == "force_restart"
  Dir.open(APP_DIR).each do |app|
    force_restart app if is_cluster?(app) 
  end
end

if ARGV.first == "version"
  puts "#{SCRIPT_NAME} version #{SCRIPT_VERSION}"
end


unless %w{start stop restart force_restart version}.include? ARGV.first
        puts "Usage: /n#{SCRIPT_NAME} {start|stop|restart|force_restart|version}"
        exit
end
