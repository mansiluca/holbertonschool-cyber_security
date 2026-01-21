# Network Security - Active Reconnaissance

This project covers the concepts and methodologies of active reconnaissance in network security. It focuses on using various tools and techniques to actively probe and gather information about target systems.

## Learning Objectives

By the end of this project, you should be able to explain to anyone, without the help of Google:

*   Does active reconnaissance get you into trouble?
*   How to use `nmap` for scanning?
*   What is a `SYN` scan?
*   What is a `NULL` scan?
*   What is a `XMAS` scan?
*   What is a `FIN` scan?
*   What is a `ACK` scan?
*   What is a `UDP` scan?
*   What are the risks associated with active reconnaissance?

## Requirements

*   Allowed editors: `vi`, `vim`, `emacs`
*   All your files will be interpreted on Ubuntu 20.04 LTS
*   All your Bash scripts should be exactly two lines long (`#!/bin/bash` + one command)
*   All your files should end with a new line
*    The first line of all your bash scripts should be exactly `#!/bin/bash`
*   A `README.md` file, at the root of the folder of the project, is mandatory

## Resources

Read or watch:

*   [Nmap Reference Guide](https://nmap.org/book/man.html)
*   [Types of Nmap Scans](https://nmap.org/book/man-port-scanning-techniques.html)
*   [Active Reconnaissance vs Passive Reconnaissance](https://www.geeksforgeeks.org/active-and-passive-reconnaissance-in-ethical-hacking/)

## Tasks

### 0. nmap scanning
Write a bash script that performs a scan on a given IP address.

### 1. SYN scan
Write a bash script that performs a SYN scan on a given IP address.

### 2. UDP scan
Write a bash script that performs a UDP scan on a given IP address.

### 3. Version detection
Write a bash script that performs a scan and attempts to detect the version of the services running.

### 4. OS detection
Write a bash script that performs a scan and attempts to detect the Operating System of the target.