#!/usr/bin/env bash
set -euo pipefail

# tools/admin-ai/bootstrap_admin_ai_docs.sh
# Creates docs/Admin-AI/ and COPIES (does not move) relevant docs into references/.

ROOT="${1:-$(pwd)}"
test -d "$ROOT/docs" || { echo "ERROR: run from repo root (docs/ missing)"; exit 1; }

ADMIN_DIR="$ROOT/docs/Admin-AI"
ATTACH_DIR="$ROOT/docs/runbook-attachments"
CKPT_DIR="$ROOT/docs/checkpoints"

mkdir -p "$ADMIN_DIR"/{services,diagrams,references/{runbook-attachments,checkpoints}}

# Copy relevant runbook-attachments
if [[ -d "$ATTACH_DIR" ]]; then
  find "$ATTACH_DIR" -type f \( -iname '*admin*ai*' -o -iname '*ldap*' -o -iname '*email*' -o -iname '*dns*' -o -iname '*client*portal*' \) -print0   | while IFS= read -r -d '' f; do
      rel="${f#$ATTACH_DIR/}"
      mkdir -p "$ADMIN_DIR/references/runbook-attachments/$(dirname "$rel")"
      cp -a "$f" "$ADMIN_DIR/references/runbook-attachments/$rel"
    done
fi

# Copy relevant checkpoints
if [[ -d "$CKPT_DIR" ]]; then
  find "$CKPT_DIR" -type f \( -iname '*admin*ai*' -o -iname '*autoscaling*intent*' -o -iname '*step28*' \) -print0   | while IFS= read -r -d '' f; do
      rel="${f#$CKPT_DIR/}"
      mkdir -p "$ADMIN_DIR/references/checkpoints/$(dirname "$rel")"
      cp -a "$f" "$ADMIN_DIR/references/checkpoints/$rel"
    done
fi

echo "OK: ensured $ADMIN_DIR and copied references (sources unchanged)."
