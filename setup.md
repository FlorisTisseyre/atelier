# Setup de l'atelier

Ce guide vous met en place de zéro : récupérer le code, lancer le back et le
front en local, puis installer Claude Code.

Comptez deux onglets de terminal : un pour le back, un pour le front.

## 0. Prérequis

- git
- Java 21 (pour le back) — vérifier : `java -version`
- Node 18+ et npm (pour le front) — vérifier : `node -v`


## 2. Installer en une commande (optionnel)

Les deux apps sont déjà dans le repo, sous `app/` (sources clonées). Un
script prépare tout — deps du front + vérification que le back compile :

```bash
./install.sh
```

À la fin de ce script, vous aurez les instructions exactes pour lancer back et front.
Sinon, faites les étapes 3 et 4 à la main.

## 3. Lancer le back (onglet 1)

Le back tourne en Java 21 (Spring Boot 3.2, Gradle 8.7). Vérifiez que
`java -version` affiche bien un 21.

```bash
cd app/backend
./gradlew bootRun
```

Vérifier que ça tourne : ouvrir http://localhost:8080/tags dans un navigateur,
vous devez voir du JSON.

## 4. Lancer le front (onglet 2)

Rien à câbler : le front pointe déjà sur http://localhost:8080, et `npm start`
gère le port 4100 et le flag OpenSSL legacy.

```bash
cd app/frontend
npm install
npm start
```

Le front s'ouvre sur http://localhost:4100


## Dépannage

- Le front plante au démarrage avec une erreur OpenSSL / `digital envelope`
  → `npm start` inclut déjà `NODE_OPTIONS=--openssl-legacy-provider`. L'erreur
    n'arrive que si vous lancez `react-scripts` sans passer par `npm start`.

- `./gradlew` : permission refusée
  → `chmod +x gradlew` puis relancer.

- Mauvaise version de Java
  → le back exige Java 21. Vérifiez avec `java -version` et ajustez votre JDK
    (ex. `sdk install java 21.0.3-tem`).

- Le front s'affiche mais aucune donnée / erreurs réseau
  → vérifiez que le back tourne (http://localhost:8080/tags) et que `API_ROOT`
    dans `src/agent.js` pointe bien sur http://localhost:8080

- Port déjà utilisé (8080 ou 4100)
  → fermez le process qui l'occupe, ou changez le port (back :
    `application.properties` ; front : variable `PORT`).
