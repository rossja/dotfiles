require 'jwt'

rsa_private = OpenSSL::PKey::RSA.generate 2048
rsa_public = rsa_private.public_key

puts rsa_private
puts rsa_public

payload = {
  :kid => 'security-testing',
  :exp => '1500084109',
  :iat => '1468548109',
  :iss => 'n/a',
  :nbf => '1468548109',
  :resources => '["*"]',
  :sub => 'security-testing'
}

token = JWT.encode payload, nil, 'none'
#token = JWT.encode payload, rsa_private, 'RS256'
puts token

decoded_token = JWT.decode token, rsa_public, true, { :algorithm => 'RS256' }
puts decoded_token
