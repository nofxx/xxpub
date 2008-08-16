#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-19.
#  Copyright (c) 2007. All rights reserved.

require 'net/http'
require 'ping'

class Xhttpero
  attr_accessor :cont
  def initialize(url)
    puts "URL OK" if Ping.pingecho(url,5,80)
    @url = URI.parse(url)
    puts "Xhttpero on"
    @cont = ''
    rex
  end
  def rex
    #puts "Buscando #{w} e #{p}"
    # Net::HTTP.get_print(w, p)
    # mevar = Net::HTTP.get(w, p)
    # Net::HTTP.start(w,80) do |http|
    #       pg = (http.get(p).body)
    #     end
    begin
      response = Net::HTTP.start(@url.host, @url.port) do |h|
        h.get(@url.path)
      end
      @cont = response.body
    rescue ArgumentError
      puts "Poe os argumentos certos animal do mato"
    rescue => e
      puts "PROB #{e.class}"
    end
  end  
end


#xp = Xhttpero::new
# gp = xp.rex('www.google.com', '/search?q=poingnat')
#gp = Xhttpero.new('http://www.google.com/')

gp = Ping.pingecho('10.1.1.1', 5)#, "http")
gp = Xhttpero.new("http://wiki.zemsis.net")
puts gp.cont
puts "---------------------"
puts gp.inspect
puts " ------------------ "
#puts gp.length
puts gp.class