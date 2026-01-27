#!/usr/bin/env bash
set -euo pipefail

# Drift guard: ensure we don't have multiple ansible.cfg files inside the repo.
# Bounded and fast: search only within repo root, maxdepth 6.

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${here}/.." && pwd)"

cd "${repo_root}"

cfgs="$(find . -maxdepth 6 -type f -name ansible.cfg -print 2>/dev/null || true)"
count="$(printf "%s
" "${cfgs}" | sed '/^$/d' | wc -l | tr -d ' ')"

if [[ "${count}" -gt 1 ]]; then
  echo "WARN: Multiple ansible.cfg files detected inside repo (drift risk):"
  printf "%s
" "${cfgs}"
  exit 1
fi

echo "OK: ansible.cfg drift guard passed (${count} found)"
