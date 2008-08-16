#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-26.
#  Copyright (c) 2007. All rights reserved.

# Requires an ANSI terminal!

st = "\033[7m"
en = "\033[m"
#st = "*"
#en = "-"

puts "Enter an empty string at any time to exit."

while true
  print "str> "; STDOUT.flush; str = gets.chop # => STDOUT
  break if str.empty?
  print "pat> "; STDOUT.flush; pat = gets.chop
  break if pat.empty?
  re = Regexp.new(pat)
  puts str.gsub(re,"#{st}\\&#{en}")
end