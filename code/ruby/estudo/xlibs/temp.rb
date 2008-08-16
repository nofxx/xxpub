#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-11-01.
#  Copyright (c) 2007. All rights reserved.

# module Temperatura
  
puts "Temperatura (34 C, 87 F):"
str = gets.chomp
exit if str.nil? or str.empty?

temp, scale = str.split(' ')

abort "#{temp} nao eh valido." if temp !~ /-?\d+/ # => -? opcional digito -65
if scale !~ /(f|c|F|C)/
  until scale == 'f' || scale == 'c'
    scale = gets.chomp.downcase
  end
end

temp = temp.to_f
case scale
when 'c'
  f = 1.8*temp+32
when 'f'
  c = (5.0/9.0)*(temp-32)
else
  abort "Nao falou C ou F"
end

if f.nil?
  puts "#{c} graus C"
else
  puts "#{f} graus F"
end