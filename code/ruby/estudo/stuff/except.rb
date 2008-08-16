#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-21.
#  Copyright (c) 2007. All rights reserved.
# ==Exception Tester
#Muy legal indeed.....

class BadData < RuntimeError
end

class Pote
  def initialize(n)
    raise BadData, "Nao pois nome..." if n.empty?
  end
end

#fred = Pote.new("oi")
#juk = Pote.new('')
# uk = Pote.new


begin
  puts 10/2
  x = 19
  raise BadData if x == 14
rescue ZeroDivisionError
  puts "Vc dividiu por zero animal"
rescue BadData
  puts "Nao gosto de 19"
rescue => e
  puts "PROB #{e.class}"
end

catch(:finish) do
  100.times do
    x = rand(1000)
    throw :finish if x == 123
  end
  puts "hey"
end

def geno10
  x = rand(1000)
  throw :cut if x == 10
end

catch(:cut) do
  1000.times { geno10 }
  puts "Ok..sem 10!"
end

# begin
#   
# rescue Exception => e
#   
# end

