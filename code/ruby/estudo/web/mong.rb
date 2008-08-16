#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-29.
#  Copyright (c) 2007. All rights reserved.

require 'rubygems' rubygems' rubygems' rubygems' 
require 'mongrel' 
class BasicServer < Mongrel::HttpHandler 
  def process(request, response) 
    response.start(200) do |headers, output| 
    headers["Content-Type"] = 'text/html' 
    output.write('<html><body><h1>Hello!</h1></body></html>') 
    end 
  end 
end 
s = Mongrel::HttpServer.new("0.0.0.0", "1234", 15) #threadd 
s.register("/", BasicServer.new) 
s.run.join


