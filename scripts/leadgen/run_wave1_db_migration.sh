#!/usr/bin/env bash
set -euo pipefail

# Run LeadGen Wave 1 DB migration from your LOCAL workstation (recommended)
# Assumes: you're in ~/Repos/motorcade-infra/ansible
#
# Usage:
#   ./scripts/leadgen/run_wave1_db_migration.sh

cd "$(dirname "$0")/../../ansible"

ansible-playbook -i inventories/prod/hosts.ini   playbooks/LEADGEN_01_wave1_db_schema.yml   --ask-vault-pass
