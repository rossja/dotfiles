#!/bin/bash
# -------------------------------------------------------------
# script to initialize a blind network scan by pulling
# a list of hosts with DNS entries out of the provided range
# -------------------------------------------------------------
targets=$1   # file with list of nmap targets
output=$2    # output file name (saves to all 3 formats)

# DNS discovery
nmap -vvvv -sL -iL ${targets} -oA ${output}

