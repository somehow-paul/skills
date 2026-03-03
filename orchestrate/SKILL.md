---
name: orchestrate
description: 按预定义代理链路串行或并行编排复杂任务，并生成交接与汇总报告。
metadata:
  origin: custom
---

# Orchestrate

Sequential/parallel agent orchestration for complex tasks.

## When to Activate

- A task naturally decomposes into specialized stages
- You need traceable handoffs between stages
- You need one consolidated report from multiple agents

## Workflow Presets

### feature

`planner -> implementer -> reviewer -> security-reviewer`

### bugfix

`investigator -> implementer -> reviewer`

### refactor

`architect -> implementer -> reviewer`

### security

`security-reviewer -> implementer -> reviewer`

## Execution Pattern

1. Spawn next agent with required context.
2. Wait for completion and capture outputs.
3. Write a compact handoff.
4. Pass handoff into next stage.
5. Aggregate all stage outputs in final report.

## Handoff Template

```markdown
## HANDOFF: <from> -> <to>

### Context

### Findings

### Files Touched

### Open Questions

### Next Actions
```

## Parallel Phase

Use parallel execution only for independent concerns:

- quality review
- security review
- performance review

Then merge findings into one prioritized issue list.

## Final Report

Include:

- Workflow used
- Stage-by-stage outcomes
- Files changed
- Validation status
- Ship recommendation (`SHIP` / `NEEDS WORK` / `BLOCKED`)
