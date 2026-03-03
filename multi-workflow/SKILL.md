---
name: multi-workflow
description: 使用多阶段协作流程完成复杂开发任务，强调研究、规划、执行与复审闭环。
metadata:
  origin: custom
---

# Multi-Workflow

Structured multi-agent development workflow for complex tasks.

## When to Activate

- Cross-module or fullstack tasks with non-trivial risk
- Work requiring explicit checkpoints before coding
- Tasks that benefit from parallel exploration and implementation

## Core Protocols

1. Keep user communication concise and explicit at each phase boundary.
2. Use parallel work where independent tasks exist.
3. Assign clear ownership when using worker agents.
4. Keep implementation scope minimal and requirement-bound.
5. No silent phase skipping unless user explicitly asks.

## Recommended Phases

### Phase 1: Research

- Clarify requirement and constraints.
- Inspect codebase with fast search first (`rg`, `rg --files`).
- If helpful, spawn `explorer` agents for specific subsystems.

### Phase 2: Ideation

- Produce at least 2 implementation approaches.
- Compare tradeoffs: complexity, risk, rollout cost, testability.
- Ask user to confirm preferred direction for significant tasks.

### Phase 3: Plan

- Convert chosen approach into executable steps.
- Define target files and expected changes.
- Define verification plan (build/type/lint/test).
- Save plan to `.codex/plan/<task-name>.md` when appropriate.

### Phase 4: Execute

- Implement step-by-step.
- Use worker agents for isolated chunks with explicit ownership.
- Merge changes incrementally and re-check correctness.

### Phase 5: Optimize

- Run focused quality pass: security, performance, readability.
- Remove unnecessary complexity and dead branches.

### Phase 6: Review

- Verify against plan and requirements.
- Report findings first, then summary.
- Provide concrete next steps if any risk remains.

## Parallelism Rules

Use parallel agents for independent work only:

- `explorer`: codebase investigation and fact gathering
- `worker`: scoped implementation tasks with file ownership

Wait for completion and synthesize results before moving phases.

## Output Contract

Deliver:

1. What was decided and why
2. What changed (files + behavior)
3. Validation results
4. Remaining risks / follow-ups
