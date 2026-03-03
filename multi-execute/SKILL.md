---
name: multi-execute
description: 基于已确认计划执行实现并完成审计收敛，输出可交付变更。
metadata:
  origin: custom
---

# Multi-Execute

Execution workflow based on an approved plan.

## When to Activate

- Plan has been approved by user
- Task requires disciplined, phase-based implementation

## Inputs

- Preferred: `.codex/plan/<task-name>.md`
- Alternative: direct task description with clear constraints

## Workflow

### Step 1: Parse Plan

- Confirm scope, files, and acceptance criteria.
- Identify dependencies and sequencing.

### Step 2: Prepare Context

- Read target files and nearby call chains.
- Detect conflicts with ongoing local changes.

### Step 3: Implement

- Apply minimal, requirement-scoped edits.
- Use worker agents for independent chunks.
- Keep each chunk verifiable.

### Step 4: Verify

- Run relevant build/type/lint/test commands.
- Fix regressions before moving forward.

### Step 5: Audit

- Run review pass for security/performance/maintainability.
- If major findings exist, patch and re-verify.

### Step 6: Deliver

Report:

- Files changed
- Behavior changes
- Verification results
- Known limitations

## Worker Ownership Pattern

When spawning workers, explicitly assign file ownership and state:

- They are not alone in the codebase.
- They must ignore unrelated edits made by others.
- They should not touch files outside assigned scope.
