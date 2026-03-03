---
name: setup-pm
description: 检测并统一项目包管理器策略，支持全局和项目级配置。
metadata:
  origin: custom
---

# Setup Package Manager

Configure package manager preference for Codex workflows.

## When to Activate

- New repository bootstrap
- Inconsistent package manager usage in team
- CI and local command mismatch

## Priority Order

1. `CODEX_PACKAGE_MANAGER` environment variable
2. project config: `.codex/package-manager.json`
3. `package.json` `packageManager` field
4. lockfile detection
5. global config: `$CODEX_HOME/package-manager.json`
6. fallback: first available (`pnpm > bun > yarn > npm`)

## Recommended Config

### Global

```json
{
  "packageManager": "pnpm"
}
```

Path: `$CODEX_HOME/package-manager.json`

### Project

```json
{
  "packageManager": "bun"
}
```

Path: `.codex/package-manager.json`

## Detection Command

```bash
node scripts/setup-package-manager.js --detect
```

If script is absent, infer from lockfiles and `packageManager` field.
