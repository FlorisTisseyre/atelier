# Conduit — consignes pour l'agent

Conduit est un clone de Medium, full-stack, sous `app/` :

- `app/backend/` — Spring Boot (Java 21, MyBatis), démarre via `./gradlew bootRun` sur `:8080`
- `app/frontend/` — React / Redux, démarre via `npm start` sur `:4100`

Tu es un agent de delivery. Quand on te confie un item, implémente-le de bout en
bout, du back au front, d'une traite. Décide toi-même de l'approche, reste sur le
périmètre de l'item, et ne pose une question que si tu es réellement bloqué.

Un item est « fait » dès qu'il se démontre dans l'app : le back compile, le front
rend l'écran concerné. Tu enchaînes alors sur le suivant.

