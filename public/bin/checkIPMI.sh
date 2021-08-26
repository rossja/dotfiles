#!/bin/bash
# simple IMPI check
# see: http://fish2.com/ipmi/cipherzero.html

IP=$1

bmc-config -D LAN_2_0 -I 0 -v -u root -p pwnd -h ${IP} --checkout |grep -i cipher_suite_id_0
