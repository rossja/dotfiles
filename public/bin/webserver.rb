# generic web server -- serves up whatever content is stored in the directory ./www
require 'webrick'
include WEBrick
# Create server
server = HTTPServer.new(
  :Port=> 8080,
  :DocumentRoot=> "./www"
)
trap("INT"){ server.shutdown }
server.start
