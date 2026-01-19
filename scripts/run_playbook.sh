#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <inventory-host> <playbook.yml> [extra ansible-playbook args...]" >&2
  exit 2
fi

HOST="$1"; shift
PLAYBOOK="$1"; shift

cd "$(dirname "$0")/../ansible"

ansible-playbook -l "$HOST" "$PLAYBOOK" --ask-vault-pass "$@"
