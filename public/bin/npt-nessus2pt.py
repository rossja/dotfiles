#!/usr/bin/python

import optparse
import re
from bs4 import BeautifulSoup as bs
import ptlib
import pdb

#Parsing args stuff
parser = optparse.OptionParser()
parser.add_option("-t", "--title", action="store_true", dest="title_mode",\
        help="Print vuln titles. implcit")
parser.add_option("-f", "--file", action="store", dest="filename",\
        help="Filename. Required")
parser.add_option("-i", "--info", dest="info_mode", action="store_true",\
        help="Print full info.")
parser.add_option("-s", "--sort", action="store_true", dest="sort",\
        help="Sort the findings by severity. Defaults to true")

(options, args) = parser.parse_args()

def get_vulns_and_hosts(tag): pass

def main(opts):

    info = opts.info_mode
    sort = opts.sort

    with open(opts.filename, 'r') as fd:
        soup = bs(fd.read())
    vuln_host_list = soup.find_all(class_=ptlib.vuln_html_pattern)

    vulnlist = []
    current_vuln = None
    for item in vuln_host_list:
      ptobj = ptlib.get_ptobject(item)
      if ptobj == None: continue
      if type(ptobj) == ptlib.ptVuln and ptobj.sev == 0: continue
      print ptobj

    return
    pdb.set_trace()

    vulnlist = []
    current_vuln = None
    for line in textlist:
        if re.match(vuln_pattern, line):
            print current_vuln
            if current_vuln: print len(current_vuln)
            current_vuln = ptVuln(line)
            vulnlist.append(current_vuln)
        elif re.match(target_pattern, line):
            if current_vuln == None:
                print line + "\n"
                raise ValueError("Top-Level target")

            newtarget = ptTarget(line)
            current_vuln.targets.append(newtarget)

    if sort:
        vulnlist.sort(reverse=True)
    for vuln in vulnlist:
        #print sep.strip()
        if not len(vuln):
            continue
        if info:
            pass
            #print vuln.get_info()




if not options.filename:
    print "Filename is required"
else:
    main(options)

"""
FILE=vulns.pt

case "$1" in
  title)
    echo "Vuln List:"
    egrep ^"\# \\[" ${FILE} |sort -n
    echo;
  ;;
  info)
    echo "Unsorted, with host info:"
    egrep ^\# ${FILE}
    echo;
  ;;
  *)
    echo "usage: lsvulninfo [title | info]"
  ;;
esac
"""
