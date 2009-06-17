#!/usr/bin/env ruby
#
#

broco = lambda{ |x| p x }
broco.call("rock and roll")

broco = lambda{ |x,y| x - y + x }
p broco.call(3,2)

procnovo = Proc.new{ |x,y| x - y }
p procnovo.call(20,67,67,98)


def chama
  p "1"
  yield(2)
  p "2"
  yield(1)
end
chama { |x| puts "oi #{x}" }

puts '-=-=-=-=-==-=-=-==-=-=-=-=-=-=-=-=-=-=-='

def mchama(n) #, &broc)
  raise ArgumentError.new("Voce nao mandou um broco") unless block_given?
  n.times { yield }
end
mchama(5) { p "oieee" }


def foo(*args, &block)
  #yield
  block.call
end
foo { puts "Hey"}

def dance
  p "Chamando"
  r1 = yield("primeiro")
  p "Resultado #{r1}"

  p "Chamando denovo"
  r2 = yield("segundo")
  p "Resultado #{r2}"
end

dance do |x|
  p "chamando #{x} vezes"
  x == "primeiro" ? 1 : 2
end

def retornaproc
  a = Proc.new { return "returrn" }
  a.call
  "Ultima"
end

p retornaproc


calc = lambda{ |x| p "rox #{x}"}

(1..8).collect(&calc)

(1..8).collect do |x|
  p x
end

8.times { |x| p x+10 }


def caluer(&block)
  raise unless block_given?
end
