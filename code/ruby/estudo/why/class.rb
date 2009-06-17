puts "Class.superclass   => #{Class.superclass}"
puts "Class.class        => #{Class.class}"
puts "Module.superclass  => #{Module.superclass}"
puts "Module.class       => #{Module.class}"
puts "Object.superclass  => #{Object.superclass}"
puts "Object.class       => #{Object.class}"

puts "Regexp       => #{/gsgsg/.class}"


class Veiculo
  attr_accessor :rodas
  def initialize(rodas)
    @rodas = rodas
  end
end

class Carro < Veiculo

  attr_reader :marca

  def initialize(rodas, marca = nil)
    @rodas, @marca = rodas, marca
  end

  def buzinar
    puts "eu buzino"
  end

  def desc
    puts "Class: #{self.class}, Superclass: #{self.inspect} Rodas: #{@rodas}"
  end

  def descold
    puts "Class: #{self.class}, Superclass: #{self.superclass} Rodas: #{@rodas}"
    rescue => e
      p e
  end

  class << self
    def buzinar
      puts "nos buzinamos"
    end
  end


end


limo = Carro.new(5, "limousine")
limo.buzinar # => nil
Carro.buzinar # => nil

limo.desc

class Wings
  def flap!
    puts "flap"
  end
  def self.flap!
    puts "flop"
  end
end

asa = Wings.new
asa.flap!


class Passaro
  def fly
    puts "batendo asa e voando!"
  end
end

class Pinguim < Passaro
  def fly
    fail "pinguim nao voa"
  end
end

ticotico = Passaro.new
ticotico.fly

tux = Pinguim.new
# tux.fly
# ~> -:43:in `fly': pinguim nao voa (RuntimeError)
# ~>    from -:51
# >> eu buzino
# >> nos buzinamos
# >> flap
# >> batendo asa e voando!
