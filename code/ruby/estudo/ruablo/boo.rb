#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-09-24.
#  Copyright (c) 2007. All rights reserved.
# 1. # These will return the stdout output as a string.
## 2. %x(./myscript.sh)
# 3. `./myscript.sh`
# 4.  
# 5. # This will send stdout to the real stdout, and return
# 6. # true or false, depending on exit status.
# 7. system "./myscript.sh"
# 8.  
# 9. # This will pass control to the script, and Ruby will
#10. # no longer be running after execution of the script
#11. # is complete.
#12. exec "./myscript.sh"


puts "XX BOO"

blue_crystal = 1
leaf_tender = 5

boo = 0
real = nil
casa = true

if boo
  puts "boo vale"
end

unless boo
  puts "boo n vale"
end

puts "vale mesmo" if boo
puts "vale nada" unless boo

puts "vale com real baixo" if boo unless real

email = if casa
            addr = "nofxx"
            addr << "@nofxx"
            addr << ".com"
            addr += "ou"
        end
        
puts "hua hua hua digita:"
pega = gets.reverse
pega = pega.upcase

puts pega
        