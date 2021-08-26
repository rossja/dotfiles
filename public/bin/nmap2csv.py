#!/usr/bin/env python
# converts an nmap XML output file to a CSV
# basic args parsing
import sys
if  len(sys.argv) < 3 :
    print "need to supply an input.xml and output.csv file"
    print "example: nmap2csv.py nmapscan.xml nmapscan.csv"
    exit()
else:
    infile = sys.argv[1]
    outfile = sys.argv[2]


#import easy to use xml parser called minidom:
import datetime, re
from xml.dom.minidom import parse, parseString

# start output file
output = open(outfile, 'a')
output.write('\n<----started at: ')

#get current time and put in output file
now = datetime.datetime.now()
print ""
output.write(now.strftime("%Y-%m-%d %H:%M"))
output.write(' ----->\n')
output.write(',,,,,,,,,\n')
output.write('IP Address,Host Name,All Ports Filtered,Open Ports,')
output.write('State (O/C),Service,Version,Device Type,Running,OS Details\n')

#setup variables
dom = parse(infile)
nmapvars = {}
hostname = ''
os = ''
difficulty = ''
args = ''
date = ''
port = []
name = []
protocol = []
product = []
product = []
version = []
extrainfo = []
portstate = []
goodXML = []

scaninfo = dom.getElementsByTagName('nmaprun')[0]
date = scaninfo.getAttribute("startstr")
args = scaninfo.getAttribute('args')

#define translateXml
def translateXml(node):

    if node.nodeName == 'hostname':

        hostname = node.getAttribute('name')
        output.write(node.getAttribute('name'))
        output.write(',')

    elif node.nodeName == 'address':

        if 'ip' in node.getAttribute('addrtype'):

            output.write('\n')
            #output.write(',')
            ipaddr = node.getAttribute('addr')
            output.write(node.getAttribute('addr'))
            output.write(',')

    elif node.nodeName == "port":

        #protocol.append(node.getAttribute("protocol"))
        #output.write(node.getAttribute("protocol"))
        #output.write(',')

        output.write('\n')
        output.write(',')
        output.write(',')
        output.write(',')
        port.append(node.getAttribute("portid"))
        #output.write(addr)
        output.write(node.getAttribute("portid"))
        output.write(',')

    elif node.nodeName == "state":

        portstate.append(node.getAttribute('state'))
        output.write(node.getAttribute('state'))
        output.write(',')

    elif node.nodeName == "service":

        name.append(node.getAttribute("name"))
        output.write(node.getAttribute('name'))
        output.write(',')
        product.append(node.getAttribute("product"))
        output.write(node.getAttribute('product'))
        output.write(',')
        version.append(node.getAttribute("version"))
        output.write(node.getAttribute('version'))
        output.write(',')
        extrainfo.append(node.getAttribute("extrainfo"))
        output.write(node.getAttribute('extrainfo'))
        output.write(',')

    elif node.nodeName == 'osmatch':

        os = node.getAttribute('name')
        output.write(node.getAttribute('name'))
        output.write(',')

    elif node.nodeName == 'tcpsequence':

        difficulty = node.getAttribute('difficulty')

#break down xml to get details
for node in dom.getElementsByTagName('host'):

    #second level within host tag
    for subnode in node.childNodes: #go through each subnode of

        if subnode.attributes is not None: #if the subnode has attributes parse them

            translateXml(subnode) #send the attribute to translateXml
            if len(subnode.childNodes) > 0: #if there are childnodes then dig deeper

                #third level
                for subsubnode in subnode.childNodes: #loop through childnodes

                    if subsubnode.attributes is not None: #if the susubnode has attributes parse them

                        translateXml(subsubnode) #send the attribute to translateXml

                        if len(subsubnode.childNodes) > 0:

                            #fourth level
                            for subsubsubnode in subsubnode.childNodes:

                                if subsubsubnode.attributes is not None:

                                    translateXml(subsubsubnode) #translate the xml

print hostname
dom.unlink()
output.close()
