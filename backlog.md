# Le backlog

## Bugs

1. La page d'accueil plante pour les utilisateurs ayant déjà visité l'application.
2. L'inscription échoue si les champs sont pré-remplis par le navigateur.
3. Le nom d'utilisateur s'affiche en double dans la barre de navigation.

![Double affichage du nom d'utilisateur dans la nav](backlog-screenshots/nav-double-username.png)

## Features

Vous n'aurez pas le temps de tout faire. C'est normal : le backlog est plus long
que le créneau. Prenez les items dans l'ordre que vous voulez, abattez-en un
maximum.

1. Brouillons : sauver un article sans le publier, retrouver ses brouillons, le
   publier quand il est prêt.
2. Articles épinglés : un auteur peut épingler un de ses articles en haut de son
   profil.
3. Compteur de vues : afficher le nombre de vues d'un article.
4. Signalement : permettre de signaler un article avec un motif.
5. Édition de commentaire : un auteur peut modifier son commentaire après coup.
6. Recherche : chercher des articles par mot-clé.
7. Articles réservés aux abonnés : un auteur peut limiter un article à ses
   abonnés.
8. Archivage : retirer un article de la circulation sans le supprimer.
9. Tags suggérés : proposer des tags pendant la rédaction.
10. Notifications : prévenir quand un auteur suivi publie.
11. Renommer un article : changer le titre d'un article déjà publié.
12. Export : permettre à un auteur d'exporter ses articles.
13. Republier : un bouton qui remet un article en haut du feed.
14. Blocage : un utilisateur peut en bloquer un autre.

Chaque item tient en une phrase. C'est volontaire : à vous d'en faire une
version qui tient la route.

## Mise en route

Le setup (back, front, Claude Code) est décrit dans `SETUP.md` à la racine.
Lancez l'agent depuis `app/` pour qu'il voie le front et le back :

```bash
cd app
claude
```

## Contrainte de temps

Le facilitateur annonce le créneau. Visez le maximum d'items démontrables.

## Rendu

À la fin, vous montrez ce qui marche.
