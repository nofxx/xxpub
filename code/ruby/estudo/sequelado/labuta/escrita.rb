#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-02.
#  Copyright (c) 2007. All rights reserved.

require 'wordlist'
require 'FileUtils'


def ouvidor
  print "Speak: "
  idea = gets
  $codew.each do |real, code|
    idea.gsub!( real, code )
  end
  return idea
end

def arquiv
  print "File Encoded...Enter name: "
  iname = gets.strip
  return iname
end

def escrivao(nome, extensao, caminho="", modo ="w")
  # File::read rename delete ... w write , r read, a append
  #ouvidor
  File::open( caminho + nome + arquiv + extensao, modo ) do |a|
    a << ouvidor
    rp =  'afff'
    rp *= 6
    a << rp
  end
end

def leitor(nome, w="", ext="")
  lista = Dir[w + '/*' + nome + '*' + ext]
  puts 'Total arquivos: ', lista.length
  
    lista.each do |e|
      puts "Retornando: " + e
      leitor = File.read( e )
      puts leitor
      puts
    end
end
  
def dirmaster(w="")
  lista = Dir['idea*.txt']
  puts lista.length

    lista.each do |e|
      puts "Retornando" + e
      movedor = FileUtils.mv e , 'ideas/' + e
      puts movedor
    end
end

def dirmake(nome, w = '')
  novodir = FileUtils.mkdir w + nome, :mode => 0700
  puts novodir
end

txt = '.txt'

#escrivao('ideas--', txt)

foi = dirmaster()

puts foi
#dirmake('ideas')

leitor('ide', 'ideas')
