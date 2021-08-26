#!/usr/bin/ruby
# grabs header info from a remote web server
# also tries passing in a null char as the path
require 'socket'
method = ARGV[0]
$uri = ARGV[1]

if !ARGV[0]
   print "need to enter a method: #{$0} (head | null)"
   exit(1)
end

if !ARGV[1]
  puts "need to enter a uri"
  exit(1)
end

getHead(uri) if method eq "head"
tryNull(uri) if method eq "null"

def getHead
   webSock = TCPSocket.new( uri, 80 )
   webSock.print "HEAD / HTTP/1.0\n\n"
   head = webSock.gets(nil)
   webSock.close
   printf("\nHeader returned from '#{uri}':\n\n%s", head)
end

def tryNull  
   webSock = TCPSocket.new( uri, 80 )
   webSock.print "HEAD /\%00 HTTP/1.0\n\n"
   head = webSock.gets(nil)
   webSock.close
   printf("\nData returned from NullByte to '#{uri}':\n\n%s", head)
end
