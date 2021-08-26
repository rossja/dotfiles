#!/usr/bin/env ruby
# generates a JSON web token from the data specified in the payload below
require 'jwt'
require 'Date'

rsa_private = OpenSSL::PKey::RSA.generate 2048
rsa_public = rsa_private.public_key

puts rsa_private
puts rsa_public

d = Date.today

payload = {
  :kid => 'security-testing',
  :iat => d.to_time.to_i,
  :nbf => (d-1).to_time.to_i,
  :exp => (d+1).to_time.to_i,
  :iss => 'roboJWT',
  :resources => '["*"]',
  :sub => 'security-testing'
}

#token = JWT.encode payload, nil, 'none'
token = JWT.encode payload, rsa_private, 'RS256'
puts token

decoded_token = JWT.decode token, rsa_public, true, { :algorithm => 'RS256' }
puts decoded_token
