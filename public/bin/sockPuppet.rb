#!/usr/bin/env ruby
# throws a number of 'A' chars at a remote socket to see what happens
require 'socket'

print "[U]DP, or [T]CP? (default: TCP) "
@ctyp = gets.chomp.downcase || 'tcp'

print "Host? (default: 127.0.0.1) "
@host = gets.chomp || '127.0.0.1'
print "Port? (default: 80) "
@port = gets.chomp.to_i || 80

print "number of A? (default: 10) "
@numa = gets.chomp.to_i || 10

def con(numa)
  # build the overflow string
  bof = ""
  numa.times do bof << 'A' end

  # stupid ruby socket and its lack of
  # consistency between UDP and TCP...
  case @ctyp
    when "tcp","t"
      sock = TCPSocket.new(@host, @port)
    when "udp","u"
      sock = UDPSocket.new()
      sock.connect(@host, @port)
    else
      print "unknown connection type. defaulting to TCP"
      sock = TCPSocket.new(@host, @port)
  end

  # print the overflow string to the socket
  #sock.print "#{bof}\n"
  sock.send "#{bof}\n", 0
  resp = sock.gets(nil)
  #p u1.recvfrom(10) #=> ["uuuu", ["AF_INET", 33230, "localhost", "127.0.0.1"]]
  sock.close

  # report on wtf we did
  print "Sent #{numa} 'A' chars\n"
  print "\nData returned:\n#{resp}\n"
end

# just doit!
for numa in 1..@numa
  con(numa)
end
