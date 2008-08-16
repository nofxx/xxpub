#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-29.
#  Copyright (c) 2007. All rights reserved.

require 'xmlrpc/client'

server = XMLRPC::Client.new2("http://localhost:1234")
#puts server.call("teste.math", 5, 3).inspect
puts server.call("teste.math",2,3).inspect

