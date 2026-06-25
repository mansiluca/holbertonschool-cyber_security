# 0x06. Nmap Advanced Port Scans

## Project Description

Ce répertoire contient des scripts Bash illustrant les techniques avancées de scan de ports avec **Nmap**.
Les scans avancés sont utiles pour contourner les pare-feu stateless, les IDS/IPS basiques ou obtenir des informations sur des ports filtrés lorsqu'un SYN classique est bloqué ou ne retourne pas assez d'informations.

---

## Files

| File | Scan Type | Description |
|------|-----------|-------------|
| `0-null_scan.sh` | **NULL scan** (`-sN`) | Envoie un segment TCP sans aucun flag. Ports ouverts/filtrés : pas de réponse. Ports fermés : RST/ACK. |
| `1-fin_scan.sh` | **FIN scan** (`-sF`) | Envoie un segment TCP avec le flag FIN. Comportement identique au NULL scan. |
| `2-xmas_scan.sh` | **Xmas scan** (`-sX`) | Envoie FIN, PSH et URG simultanément ("allumé comme un sapin de Noël"). Trace de paquets et raison incluses. |
| `3-maimon_scan.sh` | **Maimon scan** (`-sM`) | Envoie FIN/ACK. Peut différencier certains états sur des piles TCP spécifiques. |
| `4-ask_scan.sh` | **ACK scan** (`-sA`) | Détermine si les ports sont filtrés ou non-filtrés en analysant les règles firewall, pas l'état du service. |
| `5-window_scan.sh` | **Window scan** (`-sW`) | Variante de l'ACK scan utilisant le champ Window pour deviner l'état du port sur certaines implémentations. |
| `6-custom_scan.sh` | **Custom TCP flags** (`--scanflags`) | Scan avec des flags TCP personnalisés, résultat sauvegardé dans `custom_scan.txt`. |

---

## Usage

```bash
./<script>.sh <target> [additional-args]
```

**Example:**

```bash
./0-null_scan.sh 192.168.1.1
./4-ask_scan.sh 192.168.1.1 80
./5-window_scan.sh 192.168.1.1 80 22
```

> Nécessite généralement `sudo` car ces scans manipulent des paquets TCP bruts.

---

## Requirements

- `nmap` installé
- Privilèges suffisants (`sudo`) pour les scans raw
- Cible autorisée (scope défini)

---

## Author

Luca — Holberton School Cyber Security
