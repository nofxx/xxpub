#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.

require 'profile'
class Calculator
  def self.count_large
    x=0
    10000.times { x += 1}
  end
  
  def self.count_small
    x=0
    100.times { x += 1 }
  end
end

Calculator.count_large
Calculator.count_small