# Web Application Fast Incident Response

Quick scripts to triage common web application incidents like DoS, brute-force, or automated attacks.

All scripts default to reading `logs.txt` but accept a different log file as the first argument.

---

## 0-attack_ip.sh

Finds the IP address that hit your logs the most. Useful to spot the source of a DoS or brute-force attack.

### Usage

```bash
./0-attack_ip.sh [logfile]
```

### Output

Only the IP address, e.g.:

```
192.168.1.42
```

---

## 1-endpoint.sh

Finds the endpoint (URL path) that received the most requests. This is usually the main target of the attack.

### Usage

```bash
./1-endpoint.sh [logfile]
```

### Output

Only the endpoint path, e.g.:

```
/
```

---

## 2-count_attack.sh

Counts how many requests came from the most active IP — the presumed attacker.

### Usage

```bash
./2-count_attack.sh [logfile]
```

### Output

Only the request count, e.g.:

```
5000
```

---

## 3-library.sh

Identifies the tool or library used by the attacker by extracting the most common User-Agent string from the attacker's requests.

### Usage

```bash
./3-library.sh [logfile]
```

### Output

Only the User-Agent string, e.g.:

```
python-requests/2.31.0
```

---

## Log format

Scripts expect a standard combined/nginx-style access log:

```
<IP> - - [<date>] "<METHOD> <URL> <PROTOCOL>" <status> <size> "<referer>" "<User-Agent>"
```
