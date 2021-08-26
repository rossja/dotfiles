#!/usr/bin/env python3
# snarfs data from open s3 buckets
import xml.etree.ElementTree as ET
import requests
import sys

url = sys.argv[1]

r = requests.get(url)     # get the s3 list if available
root = ET.fromstring(r.text)     # set the root element

# this doesn't work, not sure why since the
# ListBucketResult has this attribute...
# xmlns = root.attrib['xmlns']

# since the above doesn't work, but s3 xmlns is static
# we can just hardcode it here, but that sucks
xmlns = '{http://s3.amazonaws.com/doc/2006-03-01/}'
keys = xmlns + 'Key'

for key in root.iter(keys):
    theFile = url + key.text
    print(theFile)

#    r = requests.get(theFile, stream=True)
#    if r.status_code == 200:
#        with open(key.text, 'wb') as f:
#            for chunk in r.iter_content():
#                f.write(chunk)
