class Pessoa
  def initialize(nome, sobrenome)
    @nome = nome
    @sobrenome = sobrenome
  end
  
  def nome
    return @nome
  end
  
  def sobrenome
    return @sobrenome
  end
end

class Dev < Pessoa
  def nome
    "Dr. " + super
  end
end

xed = Dev.new("RoR", "Maf")

puts xed.nome + xed.sobrenome

ENV.each do |e|
  puts e.join(': ')
end
