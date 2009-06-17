#!/usr/bin/env ruby
#
#
#

require 'ping' #from core classes
@ip_prefix='172.16.1.'

def ping_ip(i)
  puts "Found #{@ip_prefix + i.to_s}" if Ping.pingecho(@ip_prefix+i.to_s,1)
end

p50 = Thread.new{(1..50).each{|i| ping_ip(i) };puts 'p50-finished'}
p100 = Thread.new{(51..100).each{|i| ping_ip(i) };puts 'p100-finished'}
p150 = Thread.new{(101..150).each{|i| ping_ip(i) }; puts 'p150-finished'}
p200 = Thread.new{(151..200).each{|i| ping_ip(i) }; puts 'p200-finished'}
p254 = Thread.new{(201..254).each{|i| ping_ip(i) }; puts 'p254-finished'}
puts 'oi'

fib = Fiber.new do
  x, y = 0, 1
  loop do
    Fiber.yield y
    x,y = y,x+y
  end
end

20.times { puts fib.resume }
