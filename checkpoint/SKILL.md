---
name: checkpoint
description: 创建和校验开发检查点，用于阶段性回溯与质量对比。
metadata:
  origin: custom
---

# Checkpoint

Create and verify workflow checkpoints during implementation.

## When to Activate

- Before risky edits
- After completing a major milestone
- Before/after refactor or dependency updates

## Log Location

Use `.codex/checkpoints.log`:

```bash
YYYY-MM-DD-HH:MM | <checkpoint-name> | <git-sha>
```

## Create Checkpoint

1. Run a quick quality gate (build + type check).
2. Commit or stash current state.
3. Append checkpoint record.

```bash
mkdir -p .codex
echo "$(date +%Y-%m-%d-%H:%M) | $CHECKPOINT_NAME | $(git rev-parse --short HEAD)" >> .codex/checkpoints.log
```

## Verify Checkpoint

Compare current state with checkpoint:

- files changed
- test status delta
- coverage delta
- build status

## Report Template

```text
CHECKPOINT COMPARISON: <name>
============================
Files changed: X
Tests: +Y passed / -Z failed
Coverage: +A% / -B%
Build: PASS|FAIL
```
