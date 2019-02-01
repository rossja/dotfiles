#!/usr/bin/env ruby
require 'socket'

@host = '127.0.0.1'
@port = 80

# interactive socket picker
print "[U]DP, or [T]CP? "
@ctyp = gets.chomp.downcase

# interactive overflow  builder
#print "number of A? "
#@numa = gets.chomp.to_i
@numa = 10

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
