# Web Application Forensics

Scripts to investigate logs from a compromised web application server and extract actionable forensic intelligence.

All scripts default to the standard log file used by the task but accept a different file as first argument.

---

## 0-service.sh

Identifies the service targeted by the attackers by scanning `auth.log` for authentication-related entries.

### Usage

```bash
./0-service.sh [auth.log]
```

### Example output

```
34806 pam_unix(sshd:auth):
20339 Failed
14478 Invalid
...
```

---

## 1-operating.sh

Extracts the operating system version from a `dmesg` log.

### Usage

```bash
./1-operating.sh [dmesg]
```

### Example output

```
[ 0.000000] Linux version 2.6.24-26-server (buildd@crested) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu3)) #1 SMP Tue Dec 1 18:26:43 UTC 2009 (Ubuntu 2.6.24-26.64-server)
```

---

## 2-accounts.sh

Finds the most likely compromised account by analyzing recent authentication logs. It looks for an account that had multiple failed login attempts followed by a successful login.

### Usage

```bash
./2-accounts.sh [auth.log] [number_of_lines]
```

Defaults: `auth.log`, last `1000` lines.

### Example output

```
root
```

---

## 3-ips.sh

Counts how many distinct attacker IP addresses successfully gained access to the system.

### Usage

```bash
./3-ips.sh [auth.log]
```

### Example output

```
18
```

---

## 4-firewall.sh

Counts how many firewall-related rule entries appear in the log.

### Usage

```bash
./4-firewall.sh [auth.log]
```

### Example output

```
6
```

---

## 5-users.sh

Lists user accounts that were created on the system, as recorded in the log.

### Usage

```bash
./5-users.sh [auth.log]
```

### Example output

```
Aphelios,Debian-exim,Fido,Jax,Nidalee,Senna,dhg,messagebus,mysql,packet,sshd
```

---

## Log format

Scripts expect standard Linux authentication logs (`auth.log`) and kernel ring buffer (`dmesg`) formats.
