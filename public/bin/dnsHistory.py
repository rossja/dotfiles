#!/usr/bin/env python3
# grabs the DNS record history for
# a specified domain name
import sys
import requests
import json
from html.parser import HTMLParser
from pprint import pprint

urlPrefix = 'https://securitytrails.com/domain/'
urlSuffix = '/history/a'
domain = sys.argv[1]

url = urlPrefix + domain + urlSuffix
verify = True;

#proxies = {
#  'http': '127.0.0.1:8080',
#  'https': '127.0.0.1:8080'
#}

headers = {
}

data = {
}

res = requests.get( url, headers=headers, data=data, verify=verify )
data = res.text
#pprint(data)

class MyHTMLParser(HTMLParser):
  def handle_data(self, data):
    if(data.find('PRELOADED_STATE') != -1):
      data = data.split('=', 1)[1]
      jsonData = json.loads(data);
      print(jsonData['domainInfo'])
      #print("Data: {0}".format(data))
    else:
      next
parser = MyHTMLParser()

parser.feed(res.text)
