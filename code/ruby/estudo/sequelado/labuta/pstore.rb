#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.

class Person
  attr_accessor :name, :job, :gender, :age
end

jiggs = Person.new
jiggs.name = "Jiggs Jow"
jiggs.age = 33
jiggs.job = "FuXtor"

jigg = Person.new
jigg.name = "Jigg Mow"
jigg.age = 333
jigg.job = "FuXto2r"

tx = "oi oi oi"

require 'pstore'
store = PStore.new("var/pstorfile")
store.transaction do
  store[:ppl] ||= Array.new
  store[:ppl] << jiggs
  store[:ppl] << jigg
  store[:texto] ||= String.new
  store[:texto] << tx
end