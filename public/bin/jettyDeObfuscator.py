#!/usr/bin/env python
# Jetty Deobfuscation Tool

import sys

def deobfuscate_jetty(ciphertext):
    plaintext = ""
    bytes = bytearray(len(ciphertext) / 4)
    i = 0
    for x in bytes:
        t = ciphertext[ i:i + 4 ]
        i0 = int(t, 36)
        i1 = i0 / 256
        i2 = i0 % 256
        x = (i1 + i2 - 254) / 2
        plaintext += chr(x)
        i += 4
    return plaintext

if __name__ == '__main__':
    if len(sys.argv) == 2:
        raw_ciphertext = sys.argv[1]
        print deobfuscate_jetty(raw_ciphertext)
    else:
        print "Jetty Deobfuscation Tool v1.0"
        print "%s <string>" % sys.argv[0]
        exit(1)
