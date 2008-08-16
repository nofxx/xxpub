#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-29.
#  Copyright (c) 2007. All rights reserved.

require 'xmlrpc/server'

server = XMLRPC::Server.new(1234)
server.add_handler("teste.math") do |a,b|
  { "soma" => a.to_i + b.to_i, 
    "diff" => a.to_i - b.to_i }
  end
  
  trap("INT") { server.shutdown }
  server.serve