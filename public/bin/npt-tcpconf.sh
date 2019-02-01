#!/bin/bash
# -------------------------------------------
# tweaks network settings to reduce time
# these settings will need to be adjusted
# to the network you are scanning
# -------------------------------------------
sysctl -w net.ipv4.tcp_syn_retries=5
sysctl -w net.ipv4.tcp_fin_timeout=30
sysctl -w net.ipv4.tcp_keepalive_time=1800
sysctl -w net.ipv4.tcp_window_scaling=0
sysctl -w net.ipv4.tcp_sack=0
sysctl -w net.ipv4.tcp_timestamps=0
service networking restart
