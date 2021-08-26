// Extracts TOTP data from the Authy application
// Found someplace on the Internet, copyright info below
/* base32 / /
 Copyright (c) 2011, Chris Umbel
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

var charTable = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'
function quintetCount (buff) {
  var quintets = Math.floor(buff.length / 5)
  return buff.length % 5 === 0 ? quintets : quintets + 1
}

const encode = function (plain) {
  var i = 0
  var j = 0
  var shiftIndex = 0
  var digit = 0
  var encoded = new Array(quintetCount(plain) * 8)
  /* byte by byte isn't as pretty as quintet by quintet but tests a bit faster. will have to revisit. */
  while (i < plain.length) {
    var current = plain[i]; if (shiftIndex > 3) {
      digit = current & (0xff >> shiftIndex)
      shiftIndex = (shiftIndex + 5) % 8
      digit = (digit << shiftIndex) | ((i + 1 < plain.length) ? plain[i + 1] : 0) >> (8 - shiftIndex)
      i++
    } else {
      digit = (current >> (8 - (shiftIndex + 5))) & 0x1f
      shiftIndex = (shiftIndex + 5) % 8
      if (shiftIndex === 0) i++
    }
    encoded[j] = charTable.charCodeAt(digit); j++
  }
  for (i = j; i < encoded.length; i++) {
    encoded[i] = 0x3d // '='.charCodeAt(0)
  }
  return encoded.join('')
}
/* base32 end */

var hexToInt = function (str) {
  var result = []
  for (var i = 0; i < str.length; i += 2) {
    result.push(parseInt(str.substr(i, 2), 16))
  }
  return result
}
function hexToB32 (str) {
  return encode(hexToInt(str))
}

const getTotps = function () {
  var totps = []
  console.warn("Here's your Authy tokens:")
  appManager.getModel().forEach(function (i) {
    var secret = (i.markedForDeletion === false || !i.secretSeed) ? i.decryptedSeed : hexToB32(i.secretSeed)
    console.group(i.name)
    console.log('TOTP Secret: ' + secret)
    totps.push({
      name: i.name,
      secret: secret
    })
    console.groupEnd()
  })
  console.log(JSON.stringify(totps))
  return totps
}
getTotps()
