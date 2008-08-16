#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-25.
#  Copyright (c) 2007. All rights reserved.
#
#== Ruby Fatorial
#Testando a parada....heheh
#=Certo
#
#
#Fact n! = n * (n-1) 
#

require 'benchmark'

class Fixnum
  #Envie o numero...(0=1, n<0=*-1, n>0 = n! )
  #Funcao retorna o fatorial
  def fato(n=self)
    n *= -1 if n < 0
    return 1 if n == 0
    n * fato(n-1)
  end
  
  def fato2(n=self)
    r = 0
    r += n*(n-1)
    n -= 1
    n *= -1 if n < 0
    while n > 2
      r *= n-1
      n -= 1
    end
    return r
  end
  #TODO
  #Como faz as !....
  #def fato!
   # Fixnum.self = fato
  #end
end

if __FILE__ == 1
  puts fato(ARGV[0].to_i)
end
x = 2000
#puts x.fato!

Benchmark.bm do |bm|
  bm.report {  x.fato }
  bm.report {  x.fato2 }
end