#!/usr/bin/env ruby

require 'rubygems'
require 'eventmachine'

module HttpHeaders
  def post_init
    send_data ARGV[0] || "HEY" #GET /\r\n\r\n"
    @data = ""
  end

  def receive_data(data)
    @data << data
    EventMachine::stop_event_loop

  end

  def connection_completed
    puts "DONE."
  end

  def unbind
    p @data
    if @data =~ /[\n][\r]*[\n]/m
      $`.each {|line| puts ">>> #{line}" }
    end

    EventMachine::stop_event_loop
  end
end

EventMachine::run do
  EventMachine::connect 'localhost', 8080, HttpHeaders
end
