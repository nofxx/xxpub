#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-21.
#  Copyright (c) 2007. All rights reserved.

require 'rubygems'
require 'sqlite3'

class Queridor
  
  def initialize(db,tb)
    @xcon = SQLite3::Database.new(db)# => breve... , 0644)
    @xcon.results_as_hash = true
    @query = ''
    @table = tb
  end
  
  def inseridor(nome, conta)
    @query = "INSERT INTO #{@table} 
      (nome, sexo, conta) VALUES 
      ('#{nome}', 1, #{conta})"
    executador(true)
  end
  
  def xeridor
    @query = "SELECT * FROM #{@table} WHERE name = ?", gets.chomp
    executador(false)
  end
  
  def executador(i)
    if i
      puts @xcon.execute(@query)
    else
      valor = 0.0
     result = @xcon.execute(@query) do |r|
       valor += r[3].to_f
        print "Numbero #{r[0]}, Voce eh #{'nome'}.... um cabra #{(r[2] == '1') ? 'macho' : 'fema'}\n"
        print "E o Sr. depositou #{r[3]} reauls na conta!!\n"
      end
      puts "O Sr. tem #{valor} na conta!"
    end
  end
  
  def cria
    @xcon.execute <<SQL

   CREATE TABLE xmax ( 
   id INTEGER PRIMARY KEY , 
   nome VARCHAR ( 100 ) , 
   sexo BOOLEAN , 
   conta FLOAT ) ; 
SQL
  end
  
  def disconecta
    @xcon.close
    puts "Bye"
    exit
  end
  private :executador
end

sequela = Queridor.new('var/xxx.db','xmax')
#sequela.inseridor('Marcos Rock', 2.77)
#sequela.xeridor
# sequela.cria


loop do
  puts %q{ Selecione a opção:
    
    1. Criar tabela
    
    2. Add pessoa
    
    3. Procura
     
    4. Fecha}
    
  case gets.chomp
  when '1'
    cria
  when '2'
    sequela.inseridor(gets.chomp, gets.chomp)
  when '3'
    sequela.xeridor
  when '4'
    sequela.disconecta
  end
end
      




#rows = db.execute("select * from xma")

