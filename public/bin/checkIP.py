#!/usr/bin/env python
# checks a given IP address in the dshield database
import sys
import urllib
from xml.etree import ElementTree as ET

#ip = '37.220.18.233'
if len(sys.argv) < 2:
    sys.exit('Example: %s 74.125.228.7' % sys.argv[0])

ip = sys.argv[1]

dat = urllib.urlopen('http://dshield.org/api/ip/' + ip)

def main():
#   tree = ET.XML('<root><child val="a1">one</child><child val="a2" >two</child></root>')
    tree = ET.parse(dat)
#    root = tree.getroot()
    attacks = tree.find('attacks').text
    asn_id = tree.find('as').text
    asn_txt = tree.find('asname').text
    print '+ %-15s - %-8s - %-8s - %-30s +' % ('-'*15, '-'*8, '-'*8, '-'*30)
    print '| %-15s | %-8s | %-8s | %-30s |' % ('IP', 'ATTACKS', 'ASN', 'DESCRIPTION')
    print '+ %-15s - %-8s - %-8s - %-30s +' % ('-'*15, '-'*8, '-'*8, '-'*30)
    print '| %-15s | %-8s | %-8s | %-30s |' % (ip, attacks, asn_id, asn_txt)
    print '+ %-15s - %-8s - %-8s - %-30s +' % ('-'*15, '-'*8, '-'*8, '-'*30)
#    print str(ip) + '|' + str(attacks) + '|' + str(asn_id) + '|' + str(asn_txt)
#    for node in root:
#        print str(node.tag) + ": " + str(node.text)

if __name__ == "__main__":
    main()
