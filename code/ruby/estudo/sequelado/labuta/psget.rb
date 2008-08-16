#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.

class Person
  attr_accessor :name, :job, :gender, :age
end
require 'pstore'
store = PStore.new('var/pstorfile')
ppl = []
ptx = ''
store.transaction do
  ppl = store[:ppl]
  ptx = store[:texto]
end


ppl.each do |p|
  p p
end

puts ptx
