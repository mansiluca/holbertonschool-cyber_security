# Rapport de Reconnaissance Shodan - holbertonschool.com

**Date:** 20 janvier 2026  
**Outil principal:** Shodan CLI  
**Méthodes complémentaires:** DNS reconnaissance, HTTP headers analysis

---

## Résumé Exécutif

Ce rapport présente les résultats de la reconnaissance effectuée sur le domaine holbertonschool.com en utilisant Shodan et d'autres techniques de collecte d'informations. L'analyse révèle une infrastructure principalement hébergée sur AWS (Amazon Web Services) avec l'utilisation de plusieurs services cloud tiers.

**Limitations rencontrées:**
- Le compte API Shodan utilisé dispose de 0 crédits de requête restants
- Plusieurs requêtes ont retourné des erreurs "403 Forbidden"
- Seules quelques IP ont pu être analysées via Shodan

---

## 1. Adresses IP et Plages Réseau

### 1.1 Domaine Principal (holbertonschool.com)

| Domaine | Adresses IP | Organisation | Localisation |
|---------|-------------|--------------|--------------|
| holbertonschool.com | 99.83.190.102 | Amazon.com, Inc. | Seattle, WA, USA |
| holbertonschool.com | 75.2.70.75 | Amazon.com, Inc. | Seattle, WA, USA |

**Hostname associé:** `aacb0a264e514dd48.awsglobalaccelerator.com`

**Services détectés par Shodan:**
- Port 80/tcp: nginx (HTTP title: 301 Moved Permanently)
- Port 443/tcp: HTTPS

**Dernière mise à jour Shodan:**
- 99.83.190.102: 2026-01-20T10:57:45
- 75.2.70.75: 2026-01-20T08:39:02

### 1.2 Subdomains Découverts

#### www.holbertonschool.com
- **Service:** Webflow (proxy-ssl.webflow.com)
- **IP finale:** 15.160.106.203
- **Informations Shodan (15.161.34.42):**
  - Organisation: Amazon Data Services Italy
  - Localisation: Milan, Italie
  - Hostname: ec2-15-161-34-42.eu-south-1.compute.amazonaws.com
  - Port 80/tcp: nginx (301 Moved Permanently)
  - Dernière MAJ: 2026-01-20T10:20:50

#### blog.holbertonschool.com
- **IP:** 192.0.78.131, 192.0.78.230
- **Service:** WordPress/WordPress VIP (basé sur headers)
- **Serveur:** nginx
- **Note:** Hébergé sur l'infrastructure Automattic (WordPress.com)

#### apply.holbertonschool.com
- **Service:** AWS Elastic Beanstalk
- **Hostname:** hbtn-website-prod.eu-west-3.elasticbeanstalk.com
- **IPs:** 51.44.150.14, 35.181.90.16
- **Région:** EU-West-3 (Paris)
- **Serveur:** nginx/1.20.0

#### mail.holbertonschool.com
- **Service:** AWS CloudFront
- **Distribution:** d2dclf02a1rpk.cloudfront.net
- **IPs:** 13.32.220.111, 13.32.220.59

#### assets.holbertonschool.com
- **Service:** AWS CloudFront
- **Distribution:** d15pj990prg69j.cloudfront.net
- **IPs:** 3.165.255.110, 3.165.255.32

#### support.holbertonschool.com
- **Service:** Zendesk
- **CNAME:** holbertonschool.zendesk.com
- **IPs:** 216.198.53.2, 216.198.54.2

#### v2.holbertonschool.com
- **IP:** 34.203.198.145
- **Région estimée:** US-East-1 (basé sur le range IP AWS)

#### v3.holbertonschool.com
- **IP:** 54.89.246.137
- **Région estimée:** US-East-1 (basé sur le range IP AWS)

### 1.3 Plages IP Identifiées

**AWS Global Accelerator:**
- 99.83.190.0/24 (approximatif)
- 75.2.70.0/24 (approximatif)

**AWS EC2 EU-South-1 (Milan):**
- 15.161.0.0/16

**AWS EC2 EU-West-3 (Paris):**
- 51.44.0.0/16
- 35.181.0.0/16

**AWS EC2 US-East-1 (Virginie):**
- 34.203.0.0/16
- 54.89.0.0/16

**AWS CloudFront:**
- 13.32.0.0/15
- 3.165.0.0/16

**Automattic/WordPress.com:**
- 192.0.78.0/24

**Zendesk:**
- 216.198.53.0/24
- 216.198.54.0/24

---

## 2. Technologies et Frameworks Détectés

### 2.1 Serveurs Web

| Subdomain | Serveur Web | Version |
|-----------|-------------|---------|
| holbertonschool.com | nginx | Non spécifié |
| www.holbertonschool.com | cloudflare | Via proxy |
| blog.holbertonschool.com | nginx | Non spécifié |
| apply.holbertonschool.com | nginx | 1.20.0 |

### 2.2 Plateformes et Services Cloud

1. **AWS (Amazon Web Services)** - Infrastructure principale
   - AWS Global Accelerator (domaine principal)
   - AWS EC2 (instances dans plusieurs régions)
   - AWS CloudFront (CDN pour assets et mail)
   - AWS Elastic Beanstalk (application apply)

2. **Webflow** - www.holbertonschool.com
   - Plateforme de création de sites web no-code
   - Hébergement géré

3. **WordPress/Automattic** - blog.holbertonschool.com
   - Probablement WordPress VIP (basé sur headers a8c)
   - Headers détectés: `x-hacker: Want root? Visit join.a8c.com`

4. **Zendesk** - support.holbertonschool.com
   - Plateforme de support client

5. **Cloudflare** - Protection et CDN
   - Utilisé pour www.holbertonschool.com

### 2.3 Frameworks Frontend

**www.holbertonschool.com:**
- **React** - Framework JavaScript principal détecté dans le code source

### 2.4 Sécurité et Headers

**www.holbertonschool.com:**
```
server: cloudflare
x-frame-options: SAMEORIGIN
```

**blog.holbertonschool.com:**
```
server: nginx
x-hacker: Want root? Visit join.a8c.com and mention this header.
server-timing: a8c-cdn, dc;desc=mxp, cache;desc=MISS;dur=748.0
```

**apply.holbertonschool.com:**
```
server: nginx/1.20.0
x-frame-options: SAMEORIGIN
x-content-type-options: nosniff
```

### 2.5 Technologies Backend (Inférées)

Basé sur l'infrastructure:
- **Node.js / Python / Ruby** - Probable pour les applications Elastic Beanstalk
- **WordPress/PHP** - Blog (confirmé)
- **Nginx** - Reverse proxy et serveur web principal

---

## 3. Architecture Réseau

### 3.1 Répartition Géographique

```
┌─────────────────────────────────────────┐
│        AWS Global Accelerator           │
│     (99.83.190.102, 75.2.70.75)        │
│         Seattle, WA, USA                │
└──────────────┬──────────────────────────┘
               │
       ┌───────┴────────┐
       │                │
       ▼                ▼
┌─────────────┐  ┌──────────────┐
│  EU-South-1 │  │  EU-West-3   │
│   (Milan)   │  │   (Paris)    │
│             │  │              │
│ www proxy   │  │ apply webapp │
└─────────────┘  └──────────────┘
       │
       ▼
┌──────────────────┐
│   US-East-1      │
│  (Virginie)      │
│                  │
│  v2, v3 servers  │
└──────────────────┘
```

### 3.2 Services Tiers

- **Webflow** - Hébergement du site principal
- **WordPress VIP/Automattic** - Hébergement du blog
- **Zendesk** - Support client
- **Cloudflare** - CDN et protection DDoS
- **AWS CloudFront** - CDN pour assets statiques

---

## 4. Ports et Services Ouverts

### Ports identifiés via Shodan:

**99.83.190.102 et 75.2.70.75:**
- **Port 80/tcp** - nginx (HTTP)
- **Port 443/tcp** - HTTPS

**15.161.34.42 (www proxy):**
- **Port 80/tcp** - nginx (HTTP)

**Note:** La majorité des serveurs n'exposent que les ports HTTP/HTTPS standards, ce qui indique une bonne posture de sécurité.

---

## 6. Méthodologie

### Outils Utilisés

1. **Shodan CLI** (v1.31.0)
   - Commandes: `shodan host <IP>`
   - Limitations: 0 crédits de requête disponibles

2. **DNS Reconnaissance**
   - Outil: `dig`
   - Méthode: Résolution de subdomains communs

3. **HTTP Headers Analysis**
   - Outil: `curl`
   - Analyse des headers de réponse HTTP/HTTPS

4. **Pattern Matching**
   - Détection de frameworks dans le code source HTML

### Subdomains Testés

```
www, api, intranet, yriry-old, auth-dev, auth, blog, staging, 
dev, admin, mail, ftp, assets, cdn, support, status, docs, 
portal, app, m, mobile, levels, apply, intranet-projects-files, 
yriry, v2, v3
```

**Subdomains actifs identifiés:** www, blog, mail, assets, support, apply, v2, v3

---

### 7 Partenaires Technologiques Identifiés

- Amazon Web Services (AWS)
- Cloudflare
- Webflow
- WordPress VIP / Automattic
- Zendesk

---

### 8 Annexe: Commandes Shodan Utilisées

```bash
# Recherche d'hôtes
shodan host 99.83.190.102
shodan host 75.2.70.75
shodan host 15.161.34.42

# Tentatives de recherche par domaine (échec - nécessite crédits)
shodan domain holbertonschool.com
shodan search hostname:holbertonschool.com
```

---

**Fin du rapport**
