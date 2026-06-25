#!/bin/bash
sudo nmap -p http,https,ftp,ssh,telnet -vv -sM $1
