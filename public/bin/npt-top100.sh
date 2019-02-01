#!/bin/bash
targets=$1
output=$2

nmap -Pn --top-ports 100 -sT -T4 --min-hostgroup 12 --reason \
  -O --osscan-limit -sV --version-light -vvvv \
  -oA ${output} -iL ${targets}
