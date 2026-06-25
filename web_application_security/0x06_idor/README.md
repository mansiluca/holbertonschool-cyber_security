# 0x06. IDOR (Insecure Direct Object Reference)

## Description

Ce répertoire couvre la vulnérabilité **IDOR** — un mécanisme d'autorisation défaillant permettant à un utilisateur d'accéder, modifier ou supprimer des objets (données, fichiers, ressources) appartenant à d'autres utilisateurs en manipulant directement une référence d'objet dans une requête.

IDOR est classé dans la catégorie **Broken Access Control** (Top 10 OWASP).

---

## Objectifs pédagogiques

- Identifier les paramètres vulnérables (`id`, `user_id`, `file_id`, `order_id`, etc.).
- Tester les variations d'identifiants numériques, UUID, chaînes prédictibles.
- Comprendre l'impact : fuite de données, modification non autorisée, suppression, élévation de privilèges.
- Savoir remonter un finding IDOR avec preuve d'impact.

---

## Cas classiques

| Type | Exemple | Impact |
|------|---------|--------|
| **ID numérique** | `GET /api/invoice?id=1338` → retourne la facture d'un autre | Fuite financière |
| **UUID / hash** | `GET /api/user/550e8400-e29b-41d4-a716-446655440000` | Fuite de profil si UUID devinable |
| **Fichiers** | `GET /uploads/invoice_1338.pdf` | Accès à des documents privés |
| **Action sur objet** | `POST /api/delete?id=42` | Suppression non autorisée |
| **Multi-tenant** | `company_id=2` au lieu de `company_id=1` | Élévation horizontale/verticale |

---

## Méthodologie de test

1. **Mapper les endpoints sensibles** qui acceptent un identifiant d'objet.
2. **Créer deux comptes** (attaquant + victime) dans le même scope.
3. **Noter les identifiants** associés à chaque objet.
4. **Remplacer l'identifiant** dans la requête par celui de la victime.
5. **Observer la réponse** : accès autorisé ou non ?
6. **Varier les techniques** :
   - Incrémentation/décrémentation d'IDs
   - UUID d'un autre utilisateur
   - Paramètre dans l'URL, le body, les headers, le path
   - Changement de méthode HTTP
   - Suppression du paramètre ou envoi d'un tableau
   - Encodage (`../`, JSON array, wildcard)

---

## Outils utiles

- **Burp Suite** — Repeater, Intruder, Match and Replace
- **OWASP ZAP** — Fuzzer, replays manuels
- **Browser DevTools** — modification de requêtes
- **mitmproxy** — scripting Python pour tests automatisés
- **curl** / scripts Python — tests rapides en CLI

---

## Exemple de PoC minimal

```http
GET /api/profile?id=2 HTTP/1.1
Host: target.example.com
Authorization: Bearer <token_attaquant>
```

Si le serveur retourne le profil de l'utilisateur `id=2` sans vérifier que l'attaquant en est le propriétaire, il s'agit d'un IDOR.

---

## Mitigations

- **Contrôles d'autorisation côté serveur** sur chaque accès à un objet.
- Ne jamais se fier à l'obscurité de l'ID (UUID ≠ sécurité).
- Utiliser des **indirect references** (hash, token) quand pertinent.
- **Logs et alertes** sur les accès anormaux entre comptes.
- Principes du **deny by default** et **least privilege**.

---

## Auteur

Luca — Holberton School Cyber Security
