#!/usr/bin/env bash

set -euo pipefail

BASE_REF="${1:-${SESSION_REVIEW_BASE:-${REVIEW_BASE:-}}}"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: not a git repository" >&2
  exit 1
fi

collect_uncommitted() {
  git diff --name-only --cached || true
  git diff --name-only || true
}

if [ -n "$BASE_REF" ]; then
  if ! git rev-parse --verify "$BASE_REF^{commit}" >/dev/null 2>&1; then
    echo "ERROR: invalid base ref: $BASE_REF" >&2
    exit 1
  fi

  {
    git diff --name-only "$BASE_REF"...HEAD || true
    collect_uncommitted
  } | awk 'NF' | sort -u | {
    echo "SCOPE_MODE=base-ref"
    echo "SCOPE_BASE=$BASE_REF"
    cat
  }
else
  {
    collect_uncommitted
  } | awk 'NF' | sort -u | {
    echo "SCOPE_MODE=uncommitted-only"
    echo "SCOPE_BASE="
    cat
  }
fi
