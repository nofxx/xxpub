require 'socket'

server = TCPServer.new("127.0.0.1", 8000)

loop do
  socket = server.accept
  message =  socket.gets.chop
  while socket.gets.chop.length > 0
  end
  socket.puts "HTTP/1.1 200 OK"
  socket.puts "Content-type: text/html"
  socket.puts ""
  socket.puts "<html><body><div>"
  socket.puts "<i>nofxx ftw! voce pediu por? #{message}?</i>"
  socket.puts "</div></body></html>"
  
  socket.close
end