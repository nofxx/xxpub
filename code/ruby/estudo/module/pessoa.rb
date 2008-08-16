require 'falador'
require 'testavel'

class Animal
  include Testavel
end

class Pessoa < Animal
  include Falador
#  include Testavel => inheritance ! ! 
end



foo = Pessoa.new
foo.fala
foo.test

bar = Animal.new
bar.test

