#!/usr/bin/env ruby
#
#  Created by nofn_arabicon_arabico on 2007-10-24.
#  Copyright (c) 2007. All rights reserved.
# 
# == Cria numeros romanos

#Definição


class Romans
  @@old_Romans = [
    [1000, 'M'], [500, 'D'],
    [100, 'C'], [50, 'L'],
    [10, 'X'], [5, 'V'],
    [1, 'I']
  ]
  @@romans = [
    [1000, 'M'], [900, 'CM'], [500, 'D'],  [400, 'CD'],
    [100, 'C'], [90, 'XC'], [50, 'L'], [40, 'XL'],
    [10, 'X'], [9, 'IX'], [5, 'V'], [4, 'IV'],
    [1, 'I']
  ]
  @@roman_values_assoc = %w(I IV V IX X XL L XC C CD D CM M).zip([1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000]).reverse
  @@roman_values = @@roman_values_assoc.inject({}) { |h, (r,a)| h[r] = a; h }
    
  def initialize(num)
    @num = num
  end

  def to_r(modo=false)
    n_romano = ''
    num = @num
    modo == true ? modo = @@romans : modo = @@old_Romans
    for v, n in modo
      while v <= num
       n_romano << n     
       num -= v
      end
    end
    return n_romano
  end

  def roman(roman=@num)
    last = roman[-1,1]
       roman.reverse.split('').inject(0) { | result, c |
         if @@roman_values[c] < @@roman_values[last]
           result -= @@roman_values[c]
         else
           last = c
           result += @@roman_values[c]
         end
       }
    end
end


r = Romans.new(107)

puts r.to_r

rr = Romans.new("CXIX")
puts rr.roman