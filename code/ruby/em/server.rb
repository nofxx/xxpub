#!/usr/bin/env ruby

require 'rubygems'
require 'eventmachine'

module EchoServer
  def receive_data(data)
    puts "Server => #{data}"
    send_data("You said #{data}?")
  end
end

EM.run do
  EM.start_server "localhost", 8080, EchoServer
  puts "Started EchoServer.."
end
