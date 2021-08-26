#! /usr/bin/env python
# ------------------------------------------------
# asncheck:
# retrieves the current dshield watchlist for
# a given AS, returning just the IP addresses. 
# sample url:
# https://secure.dshield.org/asdetailsascii.html?as=123
# IPs returned are left padded with 0
# ------------------------------------------------
# written by:
# jason ross (algorythm@gmail.com)
# ------------------------------------------------
import sys

def main():
   # here beginneth the script
   opts = parmsdealer()

   if (opts.verbose == 1):
      print "\nRetrieving information for AS Number " + opts.asn + ":\n"
    
   if (opts.infile):
      try:
         filedata = open(opts.infile, 'rU')
      except IOError:
         print "unable to open input file \'" + opts.infile + "\'\n"
         sys.exit(1)
      except:
          print "Unexpected error:", sys.exc_info()[0]
          sys.exit(1)
      else:
         for line in filedata:
            print line
            asn = line.split(opts.delim, 3)[int(opts.col)]
    
   if (opts.asn):
      asn = opts.asn

   dshield(asn, opts.verbose)

   #print '{0}.{1}.{2}.{3}'.format(oct1.zfill(3),oct2.zfill(3),oct3.zfill(3),oct4.zfill(3))


def parmsdealer():
   import sys
   from optparse import OptionParser
   version="\nasncheck: version 0.1\nauthor: jason ross \n"
   usage="\n\n%prog [OPTIONS]\n"
   parser = OptionParser(usage=usage, version=version)
   
   # set up command line arguments
   parser.set_defaults(col=0)
   parser.set_defaults(delim="|")
   parser.set_defaults(verbose=0)
    
   parser.add_option("-v", "--verbose", dest="verbose",
                     action="store_true", help="turn on/off verbosity (default: off)")
   parser.add_option("-a", "--asn", dest="asn",
                     action="store", help="specify the AS to retrieve data for (just the number, or with 'AS' prepended)")
   parser.add_option("-f", "--infile", dest="infile",
                     action="store", help="get the AS from the specified file (can be a list)")
   parser.add_option("-c", "--col", dest="col",
                     action="store", help="[required with -f] specifies which column in an input file contains the AS (default is to use the first column: '0')")
   parser.add_option("-d", "--delim", dest="delim",
                     action="store", help="[required with -f] specifies the delimiter to use when parsing the input file (default is to use the ASCII pipe character (0x7c):  '|')")
                     
   # process command line arguments
   (options, args) = parser.parse_args()
   
   # exit if we're missing options
   if (not options.asn and not options.infile):
      print "\n" + sys.argv[0] + ": missing parameter(s)\n"
      parser.print_help()
      print "\n"
      sys.exit(1)
    
   # exit if we've got conflicting options
   if (options.asn and options.infile):
      print "\n" + sys.argv[0] + ": can't set both an asn and an input file (there can be only one!)\n"
      parser.print_help()
      print "\n"
      sys.exit(1)

   return options


def dshield(asn, verbose):
   import socket
   import urllib
   import urllib2
   import re
    
   # urllib2 calls socket, so we can set the timeout here
   timeout = 5
   socket.setdefaulttimeout(timeout)

   baseuri = 'https://secure.dshield.org/asdetailsascii.html'

   params = {}
   params['as'] = asn
   encparams = urllib.urlencode(params)

   requri = baseuri + '?' + encparams
   req = urllib2.Request(requri)

   if (verbose == 1):
      print "opening " + requri + "\n"

   try:
      res = urllib2.urlopen(req)
   except urllib2.URLError, e:
      if hasattr(e, "code"):
         print "site borked! HTTP error: " 
         print e.code
      elif hasattr(e, "reason"):
         print "server borked! reason: "
         print e.reason
   else:
      data = res.readlines()
      for line in data:
#          print line
         if ( re.match(r"[0-9]", line) ):
            ip = line.split()
            print ip[0]
      

if __name__ == "__main__":
   main()
