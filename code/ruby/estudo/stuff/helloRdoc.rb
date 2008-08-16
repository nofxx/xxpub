#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-01.
#  Copyright (c) 2007. All rights reserved.
# 
# 
#= XMAIN
#== XXMAIN
#* Super Item
# * Infra item
#== HEAD
# 
# Visit eueu.eu
#Visit eueu.eu
#  
#  Programa não faz *merda* nenhuma
#  So nus teste parcero!
#
#A _vida_ eh bela? sim.... +texto doido+
#Mto bom
#
#  class Teste
#    def ok
#    end
#  end
# 
#-- 
# Parte escondida -- ++
#++
# 
# 

##########
#
# 
# =>                                                  XXTESTE
# => Base 84 indispensavel
require 'base64'
require 'benchmark'
require 'ostruct'

#Usa ostruct!
coletero = OpenStruct.new
coletero.nome = "Ze"
coletero.ids = 22
coletero.ulti = "Ruela"
#exibe a merda
puts coletero.inspect


# Classe codificar base64
class Codador
  # Recebe S
  def initialize(s)
    @s = s
  end

  #Encode o trem recebe x
  def coda(x=@s)
    xb = Base64
    # => module
    enc = xb.encode64(x)
    # descodeia
    plain = xb.decode64(enc)
    # retorna
    return plain
  end
  # x=1
  # puts Benchmark.cs fizmeasure { puts x *= 1_00000000 }
  # testa bench
  def benca
    n = 5000
    Benchmark.bmbm do |x|
      x.report { for i in 1..n; coda(@s); end }
      x.report { n.times do   ; coda; end }
      x.report { 1.upto(n) do ; coda; end }
    end
  end
end

#class nao rdocada
class escondida #:nodoc: all
  #metodos...
  def teste #escondido ou nao?
  end
end