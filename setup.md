# Setup de l'atelier

Ce guide vous met en place de zéro : récupérer le code, lancer le back et le
front en local, puis installer Claude Code.

Comptez deux onglets de terminal : un pour le back, un pour le front.

## 0. Prérequis

- git
- Java 11 (pour le back) — vérifier : `java -version`
- Node 18+ et npm (pour le front) — vérifier : `node -v`

## 1. Récupérer le repo

```bash
git clone git@github-perso:FlorisTisseyre/atelier.git
cd atelier
```

Si vous n'avez pas configuré l'alias SSH `github-perso` (c'est très probable),
utilisez plutôt l'adresse HTTPS :

```bash
git clone https://github.com/FlorisTisseyre/atelier.git
cd atelier
```

## 2. Cloner les deux applications

Les deux apps vivent dans un sous-dossier `app/`. À copier-coller tel quel
depuis le dossier `atelier` :

```bash
mkdir -p app && cd app
git clone https://github.com/gothinkster/spring-boot-realworld-example-app.git
git clone https://github.com/gothinkster/react-redux-realworld-example-app.git
cd ..
```

## 3. Lancer le back (onglet 1)

```bash
cd app/spring-boot-realworld-example-app
./gradlew bootRun
```

Le premier lancement télécharge les dépendances, c'est normal que ce soit long.

Vérifier que ça tourne : ouvrir http://localhost:8080/tags dans un navigateur,
vous devez voir du JSON.

## 4. Câbler puis lancer le front (onglet 2)

```bash
cd app/react-redux-realworld-example-app
npm install
```

Par défaut le front tape sur une API publique. Pour le brancher sur VOTRE back
local, éditez `src/agent.js` et remplacez la valeur de `API_ROOT` par :

```
http://localhost:8080
```

Puis démarrez le serveur. Le projet utilise une vieille version de
react-scripts : sur un Node récent, il faut le flag OpenSSL legacy.

```bash
NODE_OPTIONS=--openssl-legacy-provider npm start
```

Le front s'ouvre sur http://localhost:4100


## Dépannage

- Le front plante au démarrage avec une erreur OpenSSL / `digital envelope`
  → vous avez oublié `NODE_OPTIONS=--openssl-legacy-provider` devant `npm start`.

- `./gradlew` : permission refusée
  → `chmod +x gradlew` puis relancer.

- Mauvaise version de Java
  → le back exige Java 11. Vérifiez avec `java -version` et ajustez votre JDK.

- Le front s'affiche mais aucune donnée / erreurs réseau
  → vérifiez que le back tourne (http://localhost:8080/tags) et que `API_ROOT`
    dans `src/agent.js` pointe bien sur http://localhost:8080

- Port déjà utilisé (8080 ou 4100)
  → fermez le process qui l'occupe, ou changez le port (back :
    `application.properties` ; front : variable `PORT`).
