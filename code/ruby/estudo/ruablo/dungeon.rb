#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-20.
#  Copyright (c) 2007. All rights reserved.
# 
# 
# 
require '../xout.rb'
dout = Xout.new('../m.xml')

class Dungeon
  attr_accessor :jogador
  
  def initialize(nome_jogador)
    @jogador = Jogador.new(nome_jogador)
    @rooms = []
  end
  
  def add_room(ref, nome, desc, conn)
    @rooms << Room.new(ref, nome, desc, conn)
  end
  
  def start(local)
    @jogador.local = local
    show_current_desc
  end
  
  def show_current_desc
    puts find_room_in_dungeon(@jogador.local).full_desc
  end
  
  def find_room_in_dungeon(ref)
    @rooms.detect { |r| r.ref == ref }
  end
  
  def find_room_in_direction(dir)
    find_room_in_dungeon(@jogador.local).conn[dir]
  end
  
  def go(dir)
    puts "Indo pra " + dir.to_s
    @jogador.local = find_room_in_direction(dir)
    show_current_desc if @jogador.local
    puts "Local nao existe" unless @jogador.local
  end

  class Jogador 
    attr_accessor :nome, :local
    
    def initialize(nome)
      @nome = nome
    end
  end
  
  class Room 
    attr_accessor :ref, :nome, :desc, :conn
    def initialize(ref, nome, desc, conn)
      @ref = ref
      @nome = nome
      @desc = desc
      @conn = conn
    end
    def full_desc
      @nome + "\nVc esta em " + @desc
    end
  end
end

marioland = Dungeon.new('nofxx')

marioland.add_room(:cave, "Caverna do Dragão", "Ja falei caverna do dragao",
{:east => :forest})
marioland.add_room(:forest, "Floresta Negra", "Floresta dos elfos doidos",
{:west => :cave})

marioland.start(:cave)
marioland.go(:east)
marioland.go(:south)


puts dout.lelinhas
Xout.x


=begin

class Dungeon
  attr_accessor :jogador
  
  def initialize(nome_jogador)
    @jogador = Player.new(nome_jogador)
    @rooms = []
  end
  
  Jogador = Struct.new(:nome, :local)
  Room = Struct.new(:ref, :nome, :desc, :conn)
  
=end

