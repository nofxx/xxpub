#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-28.
#  Copyright (c) 2007. All rights reserved.

puts "Falae balu!!! xD"
if RUBY_PLATFORM =~ /win32/ 
puts "We're in Windows!" 
elsif RUBY_PLATFORM =~ /linux/ 
puts "We're in Linux!" 
elsif RUBY_PLATFORM =~ /darwin/ 
puts "We're in Mac OS X!" 
elsif RUBY_PLATFORM =~ /freebsd/ 
puts "We're in FreeBSD!" 
else 
puts "We're running under an unknown operating system." 
end

ENV.each { |e| puts "\n" + e.join(' :  ')  }

# loop do
#   palavra = gets.chomp
#   exit if palavra == 'sai'
#   puts palavra  
# end