#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-20.
#  Copyright (c) 2007. All rights reserved.

class Xout
  Xtime = Time.now
  def initialize(arq)
    @arq = arq
  end
  
  def lelinhas(x=false)
    meut = File::open(@arq, 'a') do |f|
       f << "\nxxxmark."
     end
    le = File::readlines(@arq)
    lines = File.readlines(@arq)
    line_count = lines.size
    text = lines.join
    word_count = text.split.length
    character_count = text.length
    character_count_nospaces = text.gsub(/\s+/, '').length
    paragraph_count = text.split(/\n\n/).length
    sentence_count = text.split(/\.|\?|!/).length
    if x
      puts "#{line_count} lines"
      puts "#{character_count} characters"
      puts "#{character_count_nospaces} characters excluding spaces"
      puts "#{word_count} words"
      puts "#{paragraph_count} paragraphs"
      puts "#{sentence_count} sentences"
      puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
      puts "#{word_count / sentence_count} words per sentence (average)"
    end
    c = 0
    le.each do |l|
      c +=1 unless l == "\n"
    end
    puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxX\n\n"
    c
  end
  
  def self.x( *w ) 
    w.each do |arg| 
      # if arg.kind_of?(Array) 
      if arg.respond_to?(:each) 
        arg.each do |n| 
          puts "XOUT> #{n}" 
        end 
      end 
      puts "\n........\n#{arg}\n......\n\n" 
    end
    puts "\n........\n.....\n..\n\n" 
    puts "Tempo total #{ Time.now - Xtime}"
    # puts "Total de builts #{lelinhas+100}"
    exit 
  end
  
 
end

t = 'ls'

`#{t}`