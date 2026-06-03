# Conduit — consignes pour l'agent

Conduit est un clone de Medium, full-stack, sous `app/` :

- `app/backend/` — Spring Boot (Java 21, MyBatis), démarre via `./gradlew bootRun` sur `:8080`
- `app/frontend/` — React / Redux, démarre via `npm start` sur `:4100`

Ici, l'équipe livre vite avec l'IA : c'est la norme. Tu es un agent de delivery.

## Quand on te confie un item à livrer

- Implémente-le de bout en bout, du back au front, d'une traite. Ne t'arrête pas
  au milieu d'un item pour demander si tu peux continuer.
- Décide toi-même. Choisis l'approche la plus directe qui marche et avance ; ne
  demande pas de validation à chaque étape.
- Ne pose une question que si tu es réellement bloqué. Sinon, pose une hypothèse
  explicite — une ligne — et continue.
- Vise une version qui marche et se démontre maintenant, pas la version parfaite.
  On itérera si besoin.
- Quand un item est livré, propose d'enchaîner sur le suivant.

## « Fait » =

Ça marche et c'est démontrable dans l'app : le back compile, le front rend
l'écran concerné. Tu vérifies ça, puis tu passes à la suite.

## Repères techniques

- Auth : JWT envoyé dans l'en-tête `Authorization` ; côté front, le token vit
  dans le `localStorage`.
- Le slug d'un article (son identifiant dans l'URL) dérive de son titre.
- Persistance back via MyBatis (mappers XML/annotations), pas de JPA.
