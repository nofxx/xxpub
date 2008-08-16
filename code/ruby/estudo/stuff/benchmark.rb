#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.
# 
# 
# 
# 
# 
# 
# 
# => USER CPU / SYSTEM CPU / TOTAL CPU ( TIME )   
#   
#   
require 'benchmark'

#puts Benchmark.measure{ 1000000.times{ |i| x = "oi #{i.to_s*200} oi"}}
#puts Benchmark.measure{ 1000000.times{ |i| x = "oi"+ i.to_s*200 + "oi"}}


puts
it = 1_000_000
x=1
# puts Benchmark.measure{ it.times{ |i| x = x + i }}
# puts Benchmark.measure{ it.times{ |i| x = x * i }}
# puts Benchmark.measure{ it.times{ |i| x = x / (i+1) }}
# puts Benchmark.measure{ it.times{ |i| x = x - i }}


# c = Benchmark.measure do 
#   for i in 1..it do 
#       x = i 
#   end 
# end
# 
# b = Benchmark.measure do
#   it.times do |i|
#     x = i
#   end
# end
# puts c, b

Benchmark.bm do |bm| 
  bm.report("for  ") do 
    for i in 1..it do 
      x = i 
    end 
  end 
  bm.report("times") do 
    it.times do |i| 
      x = i 
    end 
  end 
end

