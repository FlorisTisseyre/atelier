Si vous n'avez pas déjà une config LLM opérationnel et si vous n'avez pas trouvé de binôme qui en avait une,
je peux vous fournir une clé d'API anthropic utilisable dans claude-code.

```bash
npm install -g @anthropic-ai/claude-code
```

Configurez la clé d'API qui vous sera remise le jour de l'atelier. Ne la collez
jamais dans un fichier du repo.

```bash
export ANTHROPIC_API_KEY="la-cle-qui-vous-sera-remise"
```

Lancez Claude Code depuis `app/` pour qu'il voie le front et le back :

```bash
cd app
claude
```
