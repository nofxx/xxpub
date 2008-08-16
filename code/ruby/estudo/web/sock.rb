require 'socket'
require 'thread' 
server = TCPserver.open(5050)

xFile = File.open("xxxx", "w")
xFile.write("oi")
while true do # (until Ctrl-C) 
  begin
  new_sock = server.accept 
  print new_sock, " conectado\n" 
  
  Thread.start do
    sock = new_sock 
    sock.each_line do |ln| 
      sock.print ln 
      #xFile.write(ln)
    end 
    sock.close 
    print sock, " desconexao\n" 
  end 
  
rescue SystemCallError
  puts "IO Fail: " + $!
  xFile.close
  File.delete(xFile)
  raise
end
end


# 
# require 'socket'
# 
# class Preforker 
#     attr_reader (:child_count)
#     
#     def initialize(prefork, max_clients_per_child, port, client_handler)
#         @prefork = prefork
#         @max_clients_per_child = max_clients_per_child
#         @port = port
#         @child_count = 0
#         
#         @reaper = proc {
#             trap('CHLD', @reaper)
#             pid = Process.wait
#             @child_count -= 1
#         }
#         
#         @huntsman = proc {
#             trap('CHLD', 'IGNORE')
#             trap('INT', 'IGNORE')
#             Process.kill('INT', 0)
#             exit
#         }
#         
#         @client_handler=client_handler
#     end
#     
#     def child_handler
#         trap('INT', 'EXIT')
#         @client_handler.setUp
#         # wish: sigprocmask UNblock SIGINT
#         @max_clients_per_child.times {
#             client = @server.accept or break
#             @client_handler.handle_request(client)
#             client.close
#         }
#         @client_handler.tearDown
#     end
#     
#     def make_new_child
#         # wish: sigprocmask block SIGINT
#         @child_count += 1
#         pid = fork do
#             child_handler
#         end
#         # wish: sigprocmask UNblock SIGINT
#     end
#     
#     def run
#         @server = TCPserver.open(@port)
#         trap('CHLD', @reaper)
#         trap('INT', @huntsman)
#         loop {
#             (@prefork - @child_count).times { |i|
#                 make_new_child
#             }
#             sleep .1
#         }
#     end
# end
# 
# #-----------------------------
# #!/usr/bin/ruby
# 
# require 'Preforker'
# 
# class ClientHandler
#     def setUp
#     end
#     
#     def tearDown
#     end
#     
#     def handle_request(client)
#         # do stuff
#     end
# end
# 
# server = Preforker.new(1, 100, 3102, ClientHandler.new)
# server.run