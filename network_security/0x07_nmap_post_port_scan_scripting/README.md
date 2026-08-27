# 0x07. Nmap Post Port Scan Scripting

This directory contains Bash scripts that use the Nmap Scripting Engine (NSE) to perform post-port-scan tasks such as vulnerability detection, service enumeration, and SSL/TLS analysis.

## Files

| File | Description |
|------|-------------|
| `0-nmap_default.sh` | Runs the default NSE scripts against a target host. |
| `1-nmap_vulners.sh` | Runs the `vulners` NSE script on ports 80 and 443. |
| `2-vuln_scan.sh` | Uses `http-vuln-cve2017-5638` to check for Apache Struts 2 CVE-2017-5638 and saves output to `vuln_scan_results.txt`. |
| `3-comprehensive_scan.sh` | Runs `http-vuln-cve2017-5638`, `ssl-enum-ciphers`, and `ftp-anon` sequentially, saving output to `comprehensive_scan_results.txt`. |
| `4-vulnerability_scan.sh` | Detects vulnerabilities across web, MySQL, FTP, and SMTP services using wildcard NSE scripts, saving output to `vulnerability_scan_results.txt`. |
| `5-service_enumeration.sh` | Performs comprehensive service/version/OS detection with banner grabbing, SSL cipher enumeration, default scripts, and SMB domain enumeration, saving output to `service_enumeration_results.txt`. |

## Usage

All scripts accept a target host as the first argument:

```bash
sudo ./0-nmap_default.sh scanme.nmap.org
sudo ./1-nmap_vulners.sh scanme.nmap.org
sudo ./2-vuln_scan.sh scanme.nmap.org
sudo ./3-comprehensive_scan.sh scanme.nmap.org
sudo ./4-vulnerability_scan.sh scanme.nmap.org
sudo ./5-service_enumeration.sh scanme.nmap.org
```

## Requirements

- Nmap installed
- Sudo privileges (some NSE scripts require root)
