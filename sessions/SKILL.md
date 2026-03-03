---
name: sessions
description: 管理会话历史与别名，支持检索、加载、统计与维护。
metadata:
  origin: custom
---

# Sessions

Manage Codex session archives and aliases.

## When to Activate

- Need to find historical session context quickly
- Need stable aliases for frequently referenced sessions
- Need lightweight session statistics for triage

## Default Paths

- Sessions directory: `$CODEX_HOME/sessions/`
- Alias file: `$CODEX_HOME/session-aliases.json`

## Core Operations

### List Sessions

```bash
ls -lt "$CODEX_HOME/sessions" | head -n 30
```

### Search Sessions

```bash
rg -n "<keyword>" "$CODEX_HOME/sessions"
```

### Load Session Summary

```bash
sed -n '1,120p' "$CODEX_HOME/sessions/<session-file>.md"
```

### Create/Update Alias

Store aliases in JSON format:

```json
{
  "today-work": "2026-03-01-session-a1b2.md"
}
```

## Output Expectations

When responding, include:

1. matched sessions
2. why each match is relevant
3. recommended alias updates (if needed)
