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

## Changer la clé d'API

Si vous avez besoin de changer la clé, plusieurs options :

**Variable d'environnement** (recommandé) — relancez le terminal puis :

```bash
export ANTHROPIC_API_KEY="nouvelle-cle"
```

**Via le menu de configuration** — dans Claude Code, tapez `/config`.

**Via `~/.claude/settings.json`** :

```json
{
  "env": {
    "ANTHROPIC_API_KEY": "nouvelle-cle"
  }
}
```
