#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.
#
# => ruby -r debug
i = 1
j = 0
until i > 1000000
i *= 2
j += 1
end
puts "i = #{i}, j = #{j}"

class String
  def titleize
    # self.capitalize
    # self.gsub(/\b\w/){ |l| l.upcase }
    # self.gsub(/\s\w/){ |l| l.upcase }
    # self.gsub(/(\A|\s)\w/){ |l| l.upcase }
    self.gsub(/\s(\w)/){ |l| l.upcase }.gsub(/^\w/) do |l|
      l.upcase
    end
  end
end

puts "olá josué ma're".titleize

#raise "Falha 1" unless "this is a test".titleize == "This Is A Test"
#raise "Falha 2" unless "another test 1234".titleize == "Another Test 1234"
#raise "Falha 3" unless "We're testing 12".titleize == "We're Testing 12"

require 'test/unit'
def x
  4
end

class TestTitleize < Test::Unit::TestCase
  def test_basic
    assert_equal("This Is A Test", "this is a test".titleize, "um")
    assert_equal("Another One 123", "another one 123".titleize)
    assert_equal("We're Testing 12", "we're testing 12".titleize)
    assert(x*2==8)
  end
end