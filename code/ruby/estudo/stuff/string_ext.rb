#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-21.
#  Copyright (c) 2007. All rights reserved.
class String
  def vogal
    self.scan(/[aeiou]/) # => i?
  end
end

class ContaGiro
  def a
    puts "a"
  end
  def self.a
    puts "aa"
  end
end

class << ContaGiro
  def b
    puts "b"
  end
  def self.b
    puts "bb"
  end
end

cg = ContaGiro.new
cg.a
ContaGiro.a
ContaGiro.b
