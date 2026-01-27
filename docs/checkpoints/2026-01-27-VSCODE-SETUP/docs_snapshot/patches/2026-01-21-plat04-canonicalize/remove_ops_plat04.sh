#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT_DIR"

OLD="ops/ansible/playbooks/PLAT_04_lead_intake_api.yml"
if [ -f "$OLD" ]; then
  echo "Removing old ops-scoped playbook: $OLD"
  rm -f "$OLD"
else
  echo "Old ops-scoped playbook not found (ok): $OLD"
fi

# Remove empty directory if present
if [ -d "ops/ansible/playbooks" ] && [ -z "$(ls -A ops/ansible/playbooks 2>/dev/null || true)" ]; then
  rmdir ops/ansible/playbooks || true
fi

echo "Done."
