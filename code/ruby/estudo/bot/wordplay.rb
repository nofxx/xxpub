#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-31.
#  Copyright (c) 2007. All rights reserved.

$KCODE = 'u'

class WordPlay
  def self.troca_pronome(txt)
    txt.gsub!(/\b(Eu sou|Eu te|Vo*c(e|ê)* m*(e|é|eh)|
    Eu|Seu|Meu|Teu|
    Vo*c(e|ê)*)\b/i) do |pr|
      case pr.downcase
      when 'eu'
        'você'
      when 'voce', 'você', 'vc'
        'eu'
      when 'eu te'
        'você me'
      when 'você me', 'vc me'
        'eu te'
      when 'eu sou'
        'você é'
      when 'você e', 'voce e', 'vc eh'
        'eu sou'
      when 'seu', 'teu'
        'meu'
      when 'meu'
        'seu'
      end
    end.sub(/^eu\b/i, 'i')
  
    txt += '?'
  end
  
  def self.melhor_frase(frases, palavras)
    frases_ordenadas = frases.sort_by do |s|
      s.words.length - (s.downcase.words - palavras).length
    end
    frases_ordenadas.last
  end
        
end



class String
  #Divide (split) pelo ponto '.'
  def sentences
    gsub(/\n|\r/, ' ').split(/\.\s*/)
  end
  def words
    scan(/\w[\w\'\-]*/)                            
  end
end

Wor
  
if __FILE__ == $0

  puts WordPlay.troca_pronome("vc eh um besta, vc me ouviu?")

p %q{ teste teste teste.
na veia dos irma
som mto maosks}.sentences

texteste = "Mto bacana. O tal do ruby. é um dos mió. dos test"
hot = ['test', 'ruby']
  p s.downcase.words.any? { |w| hot.include?(w) }
texteste.sentences.find_all do |s|
end
end
              