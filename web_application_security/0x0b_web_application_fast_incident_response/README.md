# Web Application Fast Incident Response

Quick scripts and notes to triage and respond to common web application incidents.

## 0-attack_ip.sh

Finds the IP address that hit your logs the most. Useful to spot the source of a DoS or brute-force attack.

### Usage

```bash
./0-attack_ip.sh [logfile]
```

If no logfile is provided, it defaults to `logs.txt`.

### What it does

- Reads each line of the log file.
- Grabs the first field (usually the client IP).
- Counts how many times each IP appears.
- Prints the IP with the most requests.

### Example

```bash
./0-attack_ip.sh logs.txt
```

Output:

```
192.168.1.42
```
