#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-01.
#  Copyright (c) 2007. All rights reserved.



out = %x(./runned.sh)
#`./runned.sh`

out += "ei ei eicharlie bili bili \n billi"

if out.include? "ei"
  puts "sim"
end

puts out

p SOME_ENV if defined?(SOME_ENV)
p ENV["FOO"]
p ARGV
#foi = system("./runned.sh")
#puts foi # true

#exec "./runned.sh"

