#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.

$KCODE = 'u'

cxfile = File.join('var','csv.txt')

require 'csv'
CSV.open(cxfile, 'r') do |p|
  p p
  # puts p[2]
end

ppl = CSV.read(cxfile)
procuris = ppl.find{ |p| p[0] =~ /Joanil/ }
procuris[0] = 100 if procuris

CSV.open(cxfile, 'w') do |csv|
  ppl.each do |p|
    csv << p
  end 
end

idades = ppl.find_all do |p|
  p[2].to_i.between?(20,40)
end

p idades

p procuris
