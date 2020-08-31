#!/bin/bash
# parse port output from masscan and feed into nmap
# Created by Droogy 
# AutoEnum v.1
echo 'Target IP:'
read target
sudo masscan -p1-65535 --rate=3000 $target -oL /tmp/just_ports.txt &&\

# for some reason masscan adds comments to -oL file so grep gets rid of them
# cut reads us out ports on newlines
# tr replaces every newline with a comma

grep -v '^#' /tmp/just_ports.txt | cut -d ' ' -f 3 | tr '\n' ,\
> ports_commas.txt
# read contents of file into variable
nmapPorts=$(<ports_commas.txt)

sudo nmap -T4 -A -p$nmapPorts -v $target
