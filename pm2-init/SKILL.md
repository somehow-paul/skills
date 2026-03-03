---
name: pm2-init
description: 自动识别服务并初始化 PM2 运行配置与常用运维命令模板。
metadata:
  origin: custom
---

# PM2 Init

Auto-detect services and generate PM2 runtime configuration.

## When to Activate

- Repository contains multiple local services
- Need repeatable start/stop/restart/log workflows
- Need a shared process manager setup for team use

## Service Detection

| Type | Detection | Default Port |
|------|-----------|--------------|
| Vite | vite.config.* | 5173 |
| Next.js | next.config.* | 3000 |
| Nuxt | nuxt.config.* | 3000 |
| Express/Node | server/backend/api + package.json | 3000 |
| FastAPI/Flask | requirements.txt / pyproject.toml | 8000 |
| Go | go.mod / main.go | 8080 |

Port priority: user input > `.env` > config > script args > default.

## Generated Artifacts

- `ecosystem.config.cjs`
- optional backend wrapper (for Python)
- `.codex/commands/pm2-*.md` helper command docs
- `.codex/scripts/` helper scripts (if needed)

## Key Rules

1. Use `ecosystem.config.cjs` (not `.js`).
2. Keep process names stable and environment-specific.
3. Ensure each service has deterministic `cwd`, `script`, and `args`.
4. Provide both "all services" and "single service" operations.

## Validation

After generation, run:

```bash
pm2 start ecosystem.config.cjs
pm2 status
pm2 logs --lines 50
```

If valid, persist with `pm2 save`.
