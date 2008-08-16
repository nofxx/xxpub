#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.


require 'yaml'
require 'yaml/store'

class Person
  attr_accessor :nome, :idade
end

nofx = Person.new
nofx.nome = "Marcos"
nofx.idade = 34

juvenal = Person.new
juvenal.nome = "juvenal porra"
juvenal.idade = 93

data = [nofx, juvenal]

puts YAML::dump(data)

puts ["cjdhd", 24, 444].to_yaml

puts( { 'dog' => 'canine', 
        'cat' => 'feline', 
        'badger' => 'malign' }.to_yaml )
        
        #p YAML.methods
        
l = YAML::load(File.open('var/yamltemp'))       
p l
y = YAML::Store.new('var/yamltemp', :Indent => 2 )
y.transaction do
   y['nomes'] = ['Adalbertina', 'Piricomélia']
   y['seila'] = ['hi' => 'gringo', 'oi' => 'brazuqueis']
end
        
