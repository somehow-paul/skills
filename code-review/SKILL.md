---
name: code-review
description: Comprehensive security and quality review of uncommitted changes with strict blocking policy.
metadata:
  origin: custom
---

# Code Review

Comprehensive security and quality review of uncommitted changes.

## 1) Scope

1. Get changed files:
   `git diff --name-only HEAD`
2. If no changed files, output:
   `无待审查改动`
3. Review every changed file in the scope.

## 2) Required Checks

For each changed file, perform all checks below.

### Security Issues (CRITICAL)

- Hardcoded credentials, API keys, tokens
- SQL injection vulnerabilities
- XSS vulnerabilities
- Missing input validation
- Insecure dependencies
- Path traversal risks

### Code Quality (HIGH)

- Functions over 50 lines
- Files over 800 lines
- Nesting depth over 4 levels
- Missing error handling
- `console.log` statements
- `TODO` or `FIXME` comments
- Missing JSDoc for public APIs

### Best Practices (MEDIUM)

- Mutation patterns (prefer immutable patterns)
- Emoji usage in code or comments
- Missing tests for new code
- Accessibility issues (a11y)

## 3) Report Format (Mandatory)

Generate a structured report including:

1. Severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
2. File location and line numbers
3. Issue description
4. Suggested fix

If no issues found, explicitly state:

- `Findings: None`
- `Final Verdict: PASS`

## 4) Blocking Policy (Strict)

1. Block commit if any `CRITICAL` issue exists.
2. Block commit if any `HIGH` issue exists.
3. Only allow `PASS` when no `CRITICAL` or `HIGH` issues are present.

Final verdict must be one of:

- `PASS`
- `BLOCK`

Never approve code with security vulnerabilities.
