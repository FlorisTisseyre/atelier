# F1 — Brouillons

Sauver un article sans le publier, retrouver ses brouillons, le publier quand il est prêt.

## Backend

1. **Migration V2** — ajouter colonne `published BOOLEAN NOT NULL DEFAULT 1` à `articles` (1 = publié pour les données existantes)
2. **Article.java** — ajouter champ `published`, constructeur avec paramètre (défaut `false` = brouillon), méthode `publish()`
3. **ArticleMapper.xml** — mettre à jour `insert`, `update` ; ajouter statement `publishArticle`
4. **ArticleReadService.xml** — filtrer `published = true` dans les requêtes publiques (feed, liste, par tag…)
5. **Nouveau endpoint** `PUT /articles/{slug}/publish` — publie un brouillon (auteur authentifié uniquement)
6. **Nouveau endpoint** `GET /articles/drafts` — liste les brouillons de l'utilisateur courant (auth requise)
7. **ArticleCommandService** — `createArticle()` accepte un paramètre `published` ; ajouter `publishDraft()`

## Frontend

1. **Editor.js** — ajouter bouton "Save as Draft" à côté de "Publish Article" ; envoyer `published: false` ou `true`
2. **agent.js** — `Articles.create(article, published)` ou méthode dédiée `saveDraft()`
3. **Nouvelle page Drafts** — composant `Drafts/index.js`, route `/@:username/drafts`
4. **Header.js** — ajouter lien "Drafts" dans `LoggedInView`
5. **reducers/editor.js** — ajouter champ `published` dans l'état
6. **ArticleData** (DTO backend) — exposer champ `published`

## Règles métier

- Les brouillons n'apparaissent pas dans les feeds publics
- Un utilisateur ne voit que ses propres brouillons
- "Publier" = passer `published` à `true` (irréversible pour l'instant)
- Les articles existants sont tous considérés publiés (`DEFAULT 1`)

## Approche test (test-first)

- Backend : écrire un test `DraftsApiTest` (`@SpringBootTest`) qui vérifie que
  - un brouillon n'apparaît pas dans `GET /articles`
  - il apparaît dans `GET /articles/drafts`
  - `PUT /articles/{slug}/publish` le rend visible publiquement
- Frontend : tester le reducer editor pour les deux actions (save draft / publish)
