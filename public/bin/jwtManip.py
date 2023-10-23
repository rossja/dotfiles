#!/usr/bin/env python
# -------------------------------------------------------------
# A Burp extension to handle encoding/decoding JSON web tokens
# -------------------------------------------------------------
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# ----------------------------------------------------
# Copyright 2015 Jason Ross <algorythm /at/ gmail /dot/ com>
# ----------------------------------------------------
# version: 0.1
# ----------------------------------------------------

from __future__ import print_function;
import sys
import base64
import json
import jwt

# getopts is cooler
method = sys.argv[1]
indata = sys.argv[2]

options = {
   'verify_signature': False,
   'verify_exp': False,
   'verify_nbf': False,
   'verify_iat': False,
   'verify_aud': False,
   'require_exp': False,
   'require_iat': False,
   'require_nbf': False
}

# sample JSON Web Token
jwtString = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjU2MDM2ZThjMTg1YTlhMDQyMjM5YmVjYiIsInVzZXJuYW1lIjoidGVzdHVzZXIiLCJwYXNzd29yZCI6InVzcnBhc3MiLCJpYXQiOjE0NDMyMTMwNjksImV4cCI6MTQ0MzIxNjY2OX0.ZuFs0pb37pQ98--IKlxj-4F3voM9wRFj-2HoZK4NqYU'

# sample JSON strings to convert to JWT
jsonPayload = '{ "id": "56036e8c185a9a042239becb", "username": "testuser", "password": "usrpass", "iat": 1443213069, "exp": 1443216669 }'

# takes in a JSON string, dumps it in pretty format
def formatJson(jsonData):
    return json.dumps(jsonData, sort_keys=True, indent=4, ensure_ascii=False)

# takes in a Json string and converts it to JWT
def createToken(jsonData, jwtSecret, algorithm):
    #return jwt.encode({'some': 'data'}, jwtSecret, algorithm=algorithm)
    return jwt.encode(json.loads(jsonData), jwtSecret, algorithm=algorithm)

# takes in a JWT as string, reutrns the claims as JSON data
def getClaims(token):
    return jwt.decode(token, options=options)

# takes in a JWT as string, reutrns the headers as JSON data
def getHeaders(token):
    # TODO figure out how to get at the header data!
    return jwt.decode(token, options=options)


def main(argv):
    if method == 'encode':
        # take the JSON data and convert it to JWT
        print("\nToken:\n" + createToken(indata, 'secret', 'HS256') )

    elif method == 'decode':
        claims = getClaims(indata)
        print("\nJSON Claims:\n" + formatJson(claims) )

if __name__ == "__main__":
    #main([method, indata])
    main(sys.argv[1:])
