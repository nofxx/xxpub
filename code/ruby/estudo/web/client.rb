# A basic TCP client connection
require 'socket'
begin
    t = TCPSocket.new('www.ruby-lang.org', 'www')
rescue
    puts "error: #{$!}"
else
    # ... do something with the socket
    t.print "GET / HTTP/1.0\n\n"
    answer = t.gets(nil)
    # and terminate the connection when we're done
    t.close
end

# Using the evil low level socket API
require 'socket'
# create a socket
s = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
# build the address of the remote machine
sockaddr_server = [Socket::AF_INET, 80,
    Socket.gethostbyname('www.ruby-lang.org')[3],
    0, 0].pack("snA4NN")
# connect
begin
    s.connect(sockaddr_server)
rescue
    puts "error: #{$!}"
else
    # ... do something with the socket
    s.print "GET / HTTP/1.0\n\n"
    # and terminate the connection when we're done
    s.close
end

# TCP connection with management of error (DNS)
require 'socket'
begin
    client = TCPSocket.new('does not exists', 'www')
rescue
    puts "error: #{$!}"
end

# TCP connection with a time out
require 'socket'
require 'timeout'
begin
    timeout(1) do #the server has one second to answer
        client = TCPSocket.new('www.host.com', 'www')
    end
rescue
    puts "error: #{$!}"
end