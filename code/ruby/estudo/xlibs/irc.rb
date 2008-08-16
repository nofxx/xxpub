#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-11-07.
#  Copyright (c) 2007. __XxX__ All rights reserved.

require 'socket'
require 'readline'

server, port  = 'irc.freenode.net', 6667
channel       = '#ubuntu-br'
nick = name   = 'nofxx_bot'

socket = TCPSocket.new server, port

[
  "NICK #{nick}",
  "USER #{name} 0 * :microirc user",
  "JOIN #{channel}"
].each do |msg|
  socket.puts msg
end

listen =
  Thread.new do
  while line = socket.gets.strip
    if line =~ /PRIVMSG/
      text = line.scan(/:.*?:(.*?)$/).to_s
      puts text
    else
      puts line
    end
  end
end

talk =
Thread.new do
  while line = Readline.readline('> ', history = true)
    socket.puts(line)
  end
end

[listen, talk].each{ |t| t.join }