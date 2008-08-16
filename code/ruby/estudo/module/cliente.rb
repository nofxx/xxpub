require 'falador'

class Cliente
#  include Falador
end


foo = Cliente.new

# unica instancia ..singleton module !
foo.extend Falador
foo.fala