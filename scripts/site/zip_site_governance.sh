#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-$(pwd)}"
if [[ ! -d "${REPO}/.git" ]]; then
  echo "ERROR: not a git repo: ${REPO}" >&2
  exit 1
fi

BASE="${REPO}/docs/site"
if [[ ! -d "${BASE}" ]]; then
  echo "ERROR: missing docs/site: ${BASE}" >&2
  exit 1
fi

# Thresholds (line-count is a blunt tool; keep it practical)
MIN_LONG="${MIN_LONG:-30}"
MIN_MED="${MIN_MED:-18}"
MIN_SHORT="${MIN_SHORT:-8}"

declare -A THRESH
THRESH["RUNBOOK.md"]="$MIN_LONG"
THRESH["SITE_BUILD_TREE.md"]="$MIN_LONG"
THRESH["CHECKLIST.md"]="$MIN_LONG"
THRESH["DELTA_AUDIT_REPORT.md"]="$MIN_LONG"
THRESH["README.md"]="$MIN_MED"
THRESH["SERVICES_CANON.md"]="$MIN_MED"
THRESH["DESIGN_INTENT_LOCK.md"]="$MIN_MED"
THRESH["ADMIN_PORTABILITY.md"]="$MIN_MED"
THRESH["DEPRECATION_PLAN.md"]="$MIN_MED"
THRESH["site_05_header_footer_contract_portable.md"]="$MIN_MED"
THRESH["site_20_asset_consolidation_and_freeze.md"]="$MIN_MED"
THRESH["site_21_compression_and_image_slimdown.md"]="$MIN_MED"
THRESH["site_22_wordpress_leadgen_bridge.md"]="$MIN_MED"
THRESH["LINK_INTO_MAIN_RUNBOOK.md"]="$MIN_SHORT"
THRESH["SITE_TREE_DIAGRAM_SPEC.md"]="$MIN_SHORT"
THRESH["SESSION_HANDOFF.md"]="$MIN_SHORT"

FILES=(
  RUNBOOK.md
  SITE_BUILD_TREE.md
  CHECKLIST.md
  DELTA_AUDIT_REPORT.md
  README.md
  SERVICES_CANON.md
  DESIGN_INTENT_LOCK.md
  ADMIN_PORTABILITY.md
  DEPRECATION_PLAN.md
  LINK_INTO_MAIN_RUNBOOK.md
  SITE_TREE_DIAGRAM_SPEC.md
  SESSION_HANDOFF.md
  site_05_header_footer_contract_portable.md
  site_20_asset_consolidation_and_freeze.md
  site_21_compression_and_image_slimdown.md
  site_22_wordpress_leadgen_bridge.md
)

fail=0
echo "Validating docs/site (per-file thresholds)..."
for f in "${FILES[@]}"; do
  p="${BASE}/${f}"
  if [[ ! -f "$p" ]]; then
    echo "FAIL: missing $p" >&2
    fail=1
    continue
  fi
  need="${THRESH[$f]:-$MIN_LONG}"
  lines="$(wc -l < "$p" | tr -d ' ')"
  if [[ "$lines" -lt "$need" ]]; then
    echo "FAIL: $p has $lines lines (need >= $need)" >&2
    fail=1
  fi
  if ! grep -qE '^\s*#' "$p"; then
    echo "FAIL: $p has no markdown heading" >&2
    fail=1
  fi
done

if [[ "$fail" -ne 0 ]]; then
  echo "ERROR: docs/site validation failed; not creating zip." >&2
  exit 2
fi

OUT="${OUT_ZIP:-$(dirname "$REPO")/motorcade_docs-site_governance_$(date +%F).zip}"
rm -f "$OUT"
( cd "$REPO" && zip -r "$OUT" docs/site scripts/site/zip_site_governance.sh >/dev/null )

echo "OK: $OUT"
