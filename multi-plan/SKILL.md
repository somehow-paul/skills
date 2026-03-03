---
name: multi-plan
description: 先完成多方分析与实施计划，再等待确认，避免直接改动生产代码。
metadata:
  origin: custom
---

# Multi-Plan

Planning-only workflow for complex development tasks.

## When to Activate

- User asks for planning before coding
- Multi-file or architecture-impacting changes
- Unclear requirements that need risk decomposition

## Hard Rules

1. Do not modify production code in this skill.
2. Collect enough context before finalizing plan.
3. Include explicit risk controls and verification strategy.
4. Wait for user confirmation before switching to execution.

## Workflow

### Step 1: Restate Requirements

- Rewrite goal in concrete engineering terms.
- Capture constraints: timeline, compatibility, performance, security.

### Step 2: Context Retrieval

- Identify key modules and ownership boundaries.
- Use `rg`/`rg --files` for rapid discovery.
- Use `explorer` agents for ambiguous subsystems.

### Step 3: Option Analysis

- Provide at least 2 viable approaches.
- Compare implementation cost and operational risk.

### Step 4: Final Plan

Produce plan with:

- Technical solution summary
- Ordered implementation steps
- Target file list
- Risk and mitigation table
- Verification checklist

### Step 5: Save Plan

Save to `.codex/plan/<task-name>.md`.

## Plan Template

```markdown
# Implementation Plan: <task-name>

## Scope
- In scope:
- Out of scope:

## Solution

## Steps
1. ...
2. ...

## Files
- path/to/file: change summary

## Risks
- Risk: ...
  - Mitigation: ...

## Verification
- Build:
- Types:
- Lint:
- Tests:
```

## Handoff

After delivering plan, ask user to:

- approve
- request modifications
- execute using `multi-execute`
