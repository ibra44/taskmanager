# taskmanager
# Collection Postman - Tests de l'API

Ce dépôt contient la collection Postman complète ainsi que l'environnement de test associé, permettant de valider l'ensemble des endpoints de l'API (Authentification et Gestion des Tâches).

---

## 📥 Importation dans Postman

1. Clonez ce dépôt ou téléchargez les fichiers JSON.
2. Ouvrez Postman > cliquez sur le bouton **Import** (en haut à gauche).
3. Importez les fichiers suivants :
   - `Production.postman_environment.json` (la collection de tests)
   - `v1.postman_collection.json` (les variables d'environnement)
4. Une fois importés, sélectionnez l'environnement dans le menu déroulant en haut à droite de Postman.
5. Lancez les requêtes individuellement ou via le **Collection Runner** pour exécuter toute la suite de tests.

---

## 🗂️ Structure et détails des cas testés

### 1. Authentification (`/Authentication`)

Cette section couvre tout le cycle de vie de l'authentification (inscription, connexion, rafraîchissement des tokens et déconnexion).

| Méthode | Scénario testé | Description du test | Statut HTTP attendu |
| :--- | :--- | :--- | :--- |
| **POST** | Login - Success | Connexion réussie avec des identifiants valides. | `200 OK` |
| **POST** | Login - Invalid Password | Tentative de connexion avec un mot de passe incorrect. | `401 Unauthorized` |
| **POST** | register | Création d'un nouvel utilisateur avec des données valides. | `201 Created` |
| **POST** | refresh-200 | Renouvellement du token d'accès avec un refresh token valide. | `200 OK` |
| **POST** | refresh-tokenExpire-401 | Renouvellement avec un refresh token expiré. | `401 Unauthorized` |
| **POST** | refresh-invalidToken | Renouvellement avec un refresh token malformé ou invalide. | `401 Unauthorized` |
| **POST** | logout | Déconnexion de l'utilisateur et invalidation du token. | `200 OK` (ou `204 No Content`) |

---

### 2. Gestion des Tâches (`/Tasks`)

Cette section couvre les opérations CRUD, les vérifications de permissions, les erreurs de validation et les cas limites de pagination.

#### ➕ Création (POST)

| Scénario testé | Description du test | Statut HTTP attendu |
| :--- | :--- | :--- |
| CreateTask - Success - 201 | Création d'une tâche avec des données valides et un utilisateur authentifié. | `201 Created` |
| CreateTask-Unauthorized - 401 | Tentative de création sans fournir de token d'authentification. | `401 Unauthorized` |
| CreateTask-Invalid_Title | Envoi d'un titre vide ou ne respectant pas les règles de validation. | `400 Bad Request` |
| createTask-Badrequesttitlevideo-422 | Envoi de données invalides (ex : champ vidéo manquant ou mal formaté) provoquant une erreur de validation sémantique. | `422 Unprocessable Entity` |

---

#### 📖 Lecture (GET)

**Récupération de la liste (Pagination et limites) :**

| Scénario testé | Description du test | Statut HTTP attendu |
| :--- | :--- | :--- |
| GetALLTasks | Récupération de la liste complète des tâches (sans filtre de pagination). | `200 OK` |
| Get Tasks - Page 1 | Récupération de la première page des résultats. | `200 OK` |
| Get Tasks - Page 2 | Récupération de la deuxième page des résultats. | `200 OK` |
| Get Tasks - Limit 5 | Récupération des tâches en limitant le nombre de résultats à 5. | `200 OK` |
| Get Tasks - Limit 1 | Récupération des tâches en limitant le nombre de résultats à 1. | `200 OK` |
| Page invalide | Test du comportement de l'API lorsque le numéro de page demandé est négatif, nul ou hors limites. | `200 OK` ou `404 Not Found` (selon l'implémentation) |

**Récupération par ID :**

| Scénario testé | Description du test | Statut HTTP attendu |
| :--- | :--- | :--- |
| Get Task by id -200 | Récupération d'une tâche spécifique via son identifiant (ID existant). | `200 OK` |

---

#### ✏️ Mise à jour (PATCH)

| Scénario testé | Description du test | Statut HTTP attendu |
| :--- | :--- | :--- |
| UPDATE TASK | Mise à jour partielle d'une tâche existante (exemple : modification du titre ou du statut "terminée"). | `200 OK` |

---

#### 🗑️ Suppression (DELETE)

| Scénario testé | Description du test | Statut HTTP attendu |
| :--- | :--- | :--- |
| DELETE TASK | Suppression définitive d'une tâche existante via son ID. | `200 OK` (ou `204 No Content`) |

---

## 🔧 Variables d'environnement

L'environnement de test fourni contient les variables suivantes (à adapter selon votre backend) :

| Variable | Utilisation |
| :--- | :--- |
| `{{baseUrl}}` | L'URL de base de l'API (ex : `https://taskmanager.stl-training.fr/api`). |
| `{{accessToken}}` | Token JWT récupéré lors du `Login - Success` pour authentifier les requêtes. |
| `{{refreshToken}}` | Token utilisé pour renouveler l'`accessToken`. |
| `{{taskId}}` | ID de la tâche créée lors du test `CreateTask - Success - 201`, réutilisé pour les tests `GET by id`, `UPDATE` et `DELETE`. |
| `{{email}}` / `{{password}}` | Identifiants de test pré-remplis pour l'authentification. |

---

## 🚀 Exécuter les tests

- **Manuellement** : Ouvrez chaque requête dans Postman et cliquez sur **Send**.
- **Automatiquement (Collection Runner)** : Cliquez sur le nom de la collection > **Run** pour exécuter l'intégralité des requêtes en séquence et vérifier les assertions.
- **En ligne de commande (Newman)** : Si vous utilisez Newman (CLI Postman), vous pouvez lancer :
  ```bash
  newman run ma-collection.postman_collection.json -e mon-environnement.postman_environment.json
