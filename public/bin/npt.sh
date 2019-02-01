#!/bin/bash
targets=$1
output=$2

# DNS discovery
nmap -vvvv -sL -iL ${targets} -oA ${output}

