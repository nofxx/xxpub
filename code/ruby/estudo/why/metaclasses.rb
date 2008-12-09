#/usr/bin/env ruby
#
#
RUBY_VERSION # => "1.8.6"
class Jogador
  attr_accessor :nome, :pontos
  attr_accessor :nasc
  
  def initialize(nome, pontos) 
    @nome, @pontos = nome, pontos # => ["Heber Santelo", 14000], ["bda", 5], ["rrra", 15], ["Sapao", 2000]
  end
  
  def method_missing( id, *args)
    puts "#{id} --- #{args.inspect}"
  end
end


p j = Jogador.new("Heber Santelo", 14000)
p j.class


class DeTenis < Jogador
  attr_reader :r_notextmate
  attr_writer :w_notextmate
  attr_accessor :rw_notextmate
  
  def initialize(nome, pontos, quadra)
    super(nome, pontos) # => ["bda", 5], ["rrra", 15]
    @quadra = quadra
  end
end

brod = DeTenis.new("bda", 5, "saibro") # => #<DeTenis:0x22600 @pontos=5, @quadra="saibro", @nome="bda">
brol = DeTenis.new("rrra", 15, "grama") # => #<DeTenis:0x21cb4 @pontos=15, @quadra="grama", @nome="rrra">
cls = Jogador # => Jogador

novo = cls.new("Sapao", 2000) # => #<Jogador:0x20e04 @pontos=2000, @nome="Sapao">

novo.nasc = 1980 # => 1980
novo # => #<Jogador:0x20e04 @nasc=1980, @pontos=2000, @nome="Sapao">
novo.class # => Jogador
novo.nasc # => 1980

# >> #<Jogador:0x22a4c @pontos=14000, @nome="Heber Santelo">
# >> Jogador

brol.fock :a, :b 
