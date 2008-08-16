
#
#  Created by nofxx on 2007-10-04.
#  Copyright (c) 2007. All rights reserved.
# 
#
#                                                            RUBY x1
#                                                
#
=begin
BEGIN Code, enclosed in { and }, to run before the program runs.
END Code, enclosed in { and }, to run when the program ends.
alias Creates an alias for an existing method, operator, or global variable.
and Logical operator; same as && except and has lower precedence. 
(Compare with or.)
begin Begins a code block or group of statements; closes with end.
break Terminates a while or until loop or a method inside a block.
\case Compares an expression with a matching when clause; closes with end. 
(See when.)
class Defines a class; closes with end.
def Defines a method; closes with end.
defined? A special operator that determines if a variable, method, super
 method, 
or block exists.
do Begins a block and executes code in that block; closes with end.
else Executes following code if previous conditional, in if, elsif, unless, 
  or when, 
  is not true.
elsif Executes following code if previous conditional, in if or elsif, 
  is not true.
# end Ends a code block (group of statements) starting with begin, def, 
do, if, etc.
ensure Always executes at block termination; use after last rescue.
false Logical or Boolean false, instance of FalseClass. (See true.)
# for Begins a for loop; used with in.
# if Executes code block if conditional statement is true. 
Closes with end. (Compare with unless, until.)
in Used with for loop. (See for.)
module Defines a module; closes with end.
next Jumps before a loop’s conditional. (Compare with redo.)
nil Empty, uninitialized variable, or invalid, but not the same as zero; 
object of NilClass.
not Logical operator; same as !.
or Logical operator; same as || except or has lower precedence. 
(Compare with and.)
redo Jumps after a loop’s conditional. (Compare with next.)
rescue Evaluates an expression after an exception is raised; used before ensure.
retry Repeats a method call outside of rescue; jumps to top of blck INTERATOR
 (begin) if inside rescue.
return Returns a value from a method or block. May be omitted.
self Current object (invoked by a method).
super Calls method of the same name in the superclass. 
The superclass is the parent 
of this class.
then A continuation for if, unless, and when. May be omitted.
true Logical or Boolean true, instance of TrueClass. (See false.)
undef Makes a method in current class undefined.
# unless Executes code block if conditional statement is false. 
(Compare with if, until.)
# until Executes code block while conditional statement is false. 
(Compare with if, unless.)
# when Starts a clause (one or more) under case.
# while Executes code while the conditional statement is true.
yield Executes the block passed to the method.
__FILE__ Name of current source file.
__LINE__ Number of current line in the current source file.
=end
require 'profile'
require 'xout'
require 'xlibs/pitagoras'


Profiler__::start_profile
#Xout.x('oi')
mout = Xout.new("assets/m.xml")

$KCODE = 'u'

def putis(w)
  puts w
end
Profiler__::stop_profile



# # # # # # 
#
#                                                            BLOCKS
#                                                
# => {}

def oi
  yield
end

def vogais(&code_block)
%w{a e i o u}.each { |v| code_block.call(v) }
end
vogais { |v| puts "vogal" + v }

def each_vowel
%w{a e i o u}.each { |v| yield v }
end
each_vowel { |vo| puts vo }

oi { puts "megaoi" }

code_to_txt = lambda { |x| puts x }

code_to_txt.call("d"+"hd")
vogais { |x| puts x }

def repetidor(r)
  while r > 0
    yield
    r -= 1
  end
end

repetidor(3) { puts "oi" }

#Xout.x()




# # # # # # 
#
#                                                            PROC
#                                                
#
#=Rodar procedures
#Interessante...
def run(p)
  puts "Iniciando processo...."
  p.call
  puts "Processo OK"
end


xproc = lambda { |n| puts "Oi lambda " + n}

xproc.call "one" # => xproc.call(x)

quux = proc {
  puts "Sou um proc quux!"
}

trap "SIGINT", proc{ puts "^C was pressed." }

puts quux.class
puts quux.inspect

quux.call

run quux

trace_var :$x, proc { puts "$x mudou...pra #{$x}"}
$x = 5


# SET SCOPE.....
bar = nil

p1 = proc{|n| bar=n }
p2 = proc{bar}

puts p1.call(5)
puts bar
puts p2.call

# => http://www.rubyist.net/~slagell/ruby/localvars.html
def box
  c = nil
  get = proc{ c }
  set = proc{ |n| c = n }
  return get, set
end

le, creve = box


Xout.x(le.call, creve.call(2), le.call)


# # # # # # 
#
#                                                            CLASSES
#                                                
# 

class XxMain
  def teste
    'oi'
  end
end

xxmem = XxMain.new
puts xxmem.teste


class Pessoa
  attr_accessor :sexo
  attr_reader  :greet # => , :idade
  attr_writer  :bio
  
  def initialize(nome, idade)
  # defined?(@@npessoas) ? @@npessoas += 1 : @@npessoas = 1
    @@npessoas = defined?(@@npessoas) ? @@npessoas += 1 : 1
    @greet = 'alou alou'
    @idade = idade
    set_nome(nome)
  end
  def self.conta
    @@npessoas
  end
  def conta
    @@npessoas.to_s * 2 + " fi!"
  end
  def nome
    @first_nome + ' ' + @last_nome
  end
  def nome=(nome)
    set_nome(nome)
  end
  def idade # => protected
    @idade
  end
  def diferenciado(outro)
    (self.idade - outro.idade).abs # => abs -11 = 11
  end
    
  private
  
  def set_nome(nome)
    nome += " zehninguem" unless nome.include?(' ')
    first_nome, last_nome = nome.split(/\s+/)
    set_first_nome(first_nome)
    set_last_nome(last_nome)
  end
  def set_first_nome(nome)
    @first_nome = nome
  end
  def set_last_nome(nome)
    @last_nome = nome
  end
  
  public
  
  def rock
    @rock = true
  end
  def rock?
    @rock == true ? "sim" : "nao"
  end
  def pintar(x, cor)
    x.times { puts cor }
  end
  def secar (x)
    x.times { puts 'secando'}
  end
  
  protected :idade
end

nofxx = Pessoa.new("Marcos Augusto", 22)
nofxx.nome = 'Orx'
nofxx.sexo = 1


puts "nofxx greet eh: #{nofxx.greet}"
puts nofxx.nome

m = nofxx.rock # => true
m = nofxx.rock? # => sim

nofxx.pintar(5, :vermelho)#.secar(10)
nofxx.secar(10)

nof = Pessoa::new("Jose Antonio", 55)
nov = Pessoa.new("Jao", 44)
nor = Pessoa::new("Maria", 11)

marcos = Pessoa.new("Marcos", 55)

#Xout.x(marcos.conta , Pessoa.conta)


class Amigo
  attr_accessor :nome
  attr_reader :situacao
  attr_writer :apologia
  
  def initialize(nome = "Mundo")
    @nome = nome
  end
  def diz_oi
    puts "oi oi oi #{@nome}!"
  end
  def diz_bye
    puts "bye bye"
  end
end

puts "Metodos de um objeto \n\n #{Amigo.instance_methods.inspect} \n\n"
puts "Metodos fake \n\n #{Amigo.instance_methods(false)} \n\n"

joao = Amigo.new("jao")

puts joao.respond_to?("apologia=") # TRUE
puts joao.respond_to?("apologia")  # FALSE

joao.diz_oi


class SuperAmigo
  attr_accessor :nomes
  @@ideia = "amizade"
  
  def initialize(nomes = "mundo")
    @nomes = nomes
  end
  
  def dizer_oi
    if @nomes.nil?
      puts "..."
    elsif @nomes.respond_to?("each")
      @nomes.each do |n| 
        puts "Oi #{n}" 
      end
    else
      puts "Ola #{nomes}"
    end
  end

  def dizer_bye
    if @nomes.nil?
      puts "..."
    elsif @nomes.respond_to?("join")
      # Join the list elements with commas
      puts "Goodbye #{@nomes.join(", ")}.  Come back soon!"
    else
      puts "Goodbye #{@nomes}.  Come back soon!"
    end
  end

end
  
if __FILE__ == $0
  
  nux = SuperAmigo.new(%w{rup rup rup rup rupa})

  nux.nomes = ["oia", "muiia", "buia", "puia"]
  puts nux.dizer_oi
  puts nux.dizer_bye

  nux = 1
  puts nux.kind_of?(Integer)
  puts nux.class

    
end


class Pet
  attr_accessor :sexo, :cor
  def initialize(nome)
    @nome = nome
  end
  def nome
    @nome
  end
end

class Dog < Pet
  Dog_const = 20
  def nome
    "Cao " + super
  end
  def bark
    puts "WOOF!"
  end
  def multibark(n)
    n.times { print "Woof! "}
  end
  def show
    "#{Dog_const}"
  end
end

class Domestico < Dog
  attr_accessor :casa
  def bark
    puts "Mulf!"
  end
  def multibark
    super(10)
  end
  
end

novocao = Dog.new("rex")
novocao.cor = 56
novocao.sexo = 0
novocao.bark

puts novocao.class
puts 'a'.sum + 2

puts novocao.instance_variables.inspect

bomcao = Domestico.new("Totó")
bomcao.multibark

puts "show",Dog.new("jorge").show
puts Dog::Dog_const

#Xout.x(Dog.new("jix").bark)


puts "..............."
puts Fixnum.ancestors
puts "..............."
puts Array.ancestors
puts "..............."
puts Object.ancestors
puts "..............."
puts Fixnum.included_modules


class XArray < Array
  
  def join( sep = $,, format = "%s")
    collect do |i|
      sprintf( format, i)
    end.join( sep )
  end
end
p "XArray.superclass = #{XArray.superclass}"

ar = [1,2,3]
p ar
ar = XArray.new
ar.push(4,5,6)
p ar.join(', ', "%d bed")

class Loteria
  NRANGE = 1..25
  attr_reader :picks, :purchs
  
  def initialize ( *picks )
    if picks.length != 3
      raise ArgumentError, "Me venha com 3 numberos"
    elsif picks.uniq.length != 3
      raise ArgumentError, "Me venha com 3 numberos differntes"
    elsif picks.detect { |p| not NRANGE === p }
      raise ArgumentError, "Me venha com 3 numberos entre 1 e 25 animal burro!"
    end
    @picks = picks
    @purchs = Time.now
  end
  
  def self.new_random
    new( rand(25) + 1, rand(25) + 1, rand(25) + 1 )
  rescue ArgumentError
    new_random # => redo ...nao funfa
  end

  def score(final)
    count = 0
    final.picks.each do |n|
      count +=1 if picks.include? n
    end
    count
  end
end

class LoteriaDraw
  @@tickets = {}
  def self.buy(c, *tickets)
    unless @@tickets.has_key?(c)
      @@tickets[c] = []
    end
    @@tickets[c] += tickets
  end
end
class << LoteriaDraw
  def play
    final = Loteria.new_random
    winners = {}
    @@tickets.each do |buyer, tl|
      tl.each do |t|
        score = t.score(final)
        next if score.zero?
        winners[buyer] ||= []
        winners[buyer] << [ t, score]
      end
    end
    @@tickets.clear
    winners
  end
end

LoteriaDraw.buy('Jao', Loteria.new_random, Loteria.new_random)
LoteriaDraw.buy('Maria', Loteria.new_random, Loteria.new_random)



tick = Loteria.new(1,2,3)
sorteio = Loteria.new(1,2,3)
# m = Loteria.new(1,2,3)
#tick = Loteria.new_random

puts tick.score(sorteio)

# LoteriaDraw.play.each do |w, t|
  # puts w + "ganhou" + t.length + "ticks"
# end

# # # # # # 
#
#                                                         SINGLETON
#                                                
# 
# => Método dado só a um objeto... instancia?

class SingletonTest
  def size
    25
  end
end

t1 = SingletonTest.new
t2 = SingletonTest.new

def t2.size # => SINGLETON METHOD
  10
end

#Xout.x("singleton", t1.size, t2.size)
 
# # # # # # 
#
#                                                            MODULES
#
#
# => No instance
# => No subclasses
# => module..end

puts Math.sqrt(2) # 1.4142135623731

puts Math::PI # 3.14159265358979
 
class MinhaMath
  include Math
  puts PI
  # puts sqrt(2) # => nao funfa
end

#Xout.x()

module Ferramentas
  class Alicate
    attr_accessor :forca
  end
  def aperta
    return "apertando..."
  end
end

module Aparatos
  class Alicate
    attr_accessor :modelo
  end
end

class Caixa
  include Ferramentas
end

c = Caixa.new
puts c.aperta
include Ferramentas
puts Ferramentas.aperta
a = Ferramentas::Alicate.new
a.forca = 10
b = Aparatos::Alicate.new
b.modelo = "hanz"

include Aparatos
a = Alicate.new
a.modelo = "Hafz"


class AllVogal
  include Enumerable
  
  @@vogal = %w{a e i o u}
  def each
    @@vogal.each { |v| yield v }
  end
end

x = AllVogal.new
x = x.collect { |i| i + 'x'}
x = x.detect { |i| i > 'j'}
x = x.max



class Song
  include Comparable
  attr_accessor :len
  def <=>(o)
    @len <=> o.len
  end
  
  def initialize(sname, len)
    @sname = sname
    @len = len
  end
end
a = Song.new('3 o\'clock blues', 150)
b = Song.new('Meu maracatu pesa', 1000)
c = Song.new('Afrociberdelia', 500)



# # # # # # 
#
#                                                            RESCUE
#                                                
#

def primera_linha(filename)
  begin
    file = open(filename)
    info = file.gets
    # file.close
    info
  rescue
    filename = gets
    retry
    # nil
  ensure
    file.close
  end
end


# puts primera_linha("oi")
#Xout.x()


# # # # # # 
#
#                                                            REGEX
#                                                
#
#
# ^ LINE START
# $ LINE END
# \A string start
# \Z string end
# . Any character
# \w Letras, d1g1t0s e _underscore_ [0-9A-Za-z]
# \W Contrario do w !! n eh letra, n e _
# \d Any digit igual [0-9]
# \D Anything that \D doesnÕt match (non-digits)
# \s Whitespace (spaces, tabs, newlines,. [\t\n\r\f]
# \S Non-whitespace (any visible character)

# [...] Igual aos caracteres nas braquetas OU RANGE
# [^...] Nenhum dos caractes

# * Zero or more occurrences of the preceding character, many as possible.
# + One or more occurrences of the preceding character, many as possible.
# *? Zero or more occurrences of the preceding character, few as possible.
# +? One or more occurrences of the preceding character, few as possible.
# ? Nenhum ou só um!
# {x} x occurrences of the preceding character.
# {x,y} at least x occurrences and at most y occurrences.

# achar perl python   /Perl|Python/ .... ou ..... /P(erl|ython)/
# achar abc ... /abc/  
# abbbbc .... /ab+c/
# a com varios ou nenhum b, c  /ab*c/

# hora 12:23:22  .... /\d\d:\d\d:\d\d/
# Perl.*Python/ # Perl, zero or more other chars, then Python
# /Perl Python/ # Perl, a space, and Python
# /Perl *Python/ # Perl, zero or more spaces, and Python
# /Perl +Python/ # Perl, one or more spaces, and Python
# /Perl\s+Python/ # Perl, whitespace characters, then Python
# /Ruby (Perl|Python)/ # Ruby, a space, and either Perl or Python


abe = "Carrego pronde vou o peso do meu som lotando minha bagagem\n
Meu maracatu pesa uma tonelada de surdez e pede passagem!\n"
#abe = abe.grep(/[Mm]eu/)
#abe = abe.grep(/Meu|meu/)
#abe = abe.grep(/(M|m)eu/)

#abe = abe.grep(/^Carr/) # => ^ = \A
#abe = abe.grep(/gem!\Z/) # => $ = \Z

abe = abe =~ /pront?/

phone = "telefone eh (11)9292-9292"
pgex = /[\(\d{2}\)]?\d{4}-\d{4}/
#phone = phone.grep(/[\(\d\d\)]?\d\d\d\d-\d\d\d\d/)
phone = phone.grep(/[\(\d{2}\)]?\d{4}-\d{4}/)

linha = '12234,5'
meuregex = /\d+\,\d{2}/

#meuregex = /\d{2}/
if linha =~ meuregex
  puts 'terminando...'
  
else
  linha += '0'
  puts linha
  
end

frutas = ['pedro', 'verav', 'verao']

nova = frutas[1].sub('v', 't')
# sub = 1 soh
# gsub = todos
novva = frutas[1].gsub('v', 't')

puts nova, novva

frutas.each do |f|
  nv = f.gsub(/^../, 'cu')
  nv = nv.gsub(/..$/, 'sao')
  puts nv
end

"xyzwkuty".scan(/./) { |l| puts l }
"x yz wku ty".scan(/.../) { |l| puts l }
"xy zwk uty".scan(/\w\w/) { |l| puts l }

#scan for numbs

stt = "custo 10000 e depois 50"

stt.scan(/\d+/) do |x|
  puts x
end

stt.scan(/\d?/) do |x|
  puts x
end

stt.scan(/[aeiou]/) do |x|
  puts x
end

stt.scan(/[a-m]/) do |x|
  puts x
end

hamlet = "The slings and arrows of outrageous fortune"
puts hamlet.scan(/\w+/) # => ["The", "slings", "and",...

stt = "sem nenhum digito....."

puts "Sem digitos" unless stt =~ /[0-9]/

stt = stt.match(/(\w+) (\w+)/)

puts stt[0]
puts stt[1]
puts stt[4]

def hexa(s)
  puts(s =~ /<0(x|X)(\d|[a-f][A-F])+>/)
  #puts s
end

hexa("f<0xsfs<0x44>")

#Xout.x()


#p=n^n1
count = 0
arr = []
10.times do |i|
  arr[i] = Thread.new {
    sleep(rand(0)/10.0)
    Thread.current["mycount"] = count
    count += 1
  }
end
arr.each {|t| t.join; print t["mycount"], ", " }
puts "count = #{count}"


puts "Total de builts #{mout.lelinhas+100}"
#Xout.x("xxxxxxxxxxx", mout.lelinhas)
###########################################################################
# puts TextMate::methods
# puts TextMate::class_variables
# puts TextMate::constants


