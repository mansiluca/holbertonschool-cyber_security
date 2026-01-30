# Nmap - Live Hosts Discovery

This project introduces network discovery techniques using **Nmap**, focusing on identifying live hosts within a network. You will explore various scanning methodologies to map out active systems effectively.

## Resources

**Read or watch:**

*   [Nmap Reference Guide](https://nmap.org/book/man.html)
*   [Chapter 15. Nmap Network Scanning](https://nmap.org/book/man-host-discovery.html) (Host Discovery)
*   [Nmap Host Discovery](https://nmap.org/book/host-discovery-controls.html)
*   [Subnet Mask Cheat Sheet](https://www.aelius.com/njh/subnet_sheet.html)

## Learning Objectives

By the end of this project, you should be able to explain to anyone, without the help of Google:

*   Does Nmap require root privileges for all types of scans?
*   What is an ARP scan?
*   What is an ICMP scan?
*   What is a TCP/UDP scan?
*   How to define target ranges using CIDR notation.
*   The difference between various discovery flags (e.g., `-sn`, `-PR`, `-PE`, `-PS`).

## Requirements

*   Allowed editors: `vi`, `vim`, `emacs`.
*   All your files will be interpreted/compiled on Ubuntu 20.04 LTS.
*   All your files should end with a new line.
*   A `README.md` file, at the root of the folder of the project, is mandatory.
*   For text files, just write the answer (no shebang, no header).
*   For script files, the first line should be `#!/bin/bash`.

## Tasks

### 0. ARP Scan
Write a bash script that performs an ARP scan on the local network.
*   **Target:** Local subnetwork.
*   **Flag:** Use the flag specifically designed for ARP ping.

### 1. ICMP Echo Scan
Write a bash script that performs an ICMP Echo request scan.
*   **Target:** `192.168.1.0/24` (Example range).
*   **Requirement:** Disable port scanning to only list live hosts.

### 2. TCP SYN Ping
Write a bash script that uses TCP SYN packets to discover hosts.
*   **Flags:** Use `-PS`.
*   **Ports:** Target port 80 and 443.

### 3. UDP Ping
Write a bash script that uses UDP packets to discover hosts.
*   **Flags:** Use `-PU`.
*   **Ports:** Target port 40125.

### 4. No Ping
Write a bash script that skips the discovery stage entirely and treats all target hosts as online.
*   **Flag:** Use `-Pn`.

## Repo

*   **GitHub repository:** `holbertonschool-cyber_security`
*   **Directory:** `network_security/0x04_nmap_live_hosts_discovery`