x = 1


def m
  puts self
end

puts self


class S
  puts 'Iniciando S'
  puts self
  puts
  module M
    puts 'Nested S::M'
    puts self
    puts
  end
  def d
    puts 'dentro do def'
    puts self
    puts
  end
  def S.x
    puts 'class method:'
    puts self
    puts
  end
  puts 'back....'
  puts self
  puts
end


s = S.new
s.d
S.x

o = Object.new
def o.show
  puts 'Objeto:'
  puts 'Singleton.. self'
  puts self
  puts
end
o.show
puts 'Agora de fora:'
puts o