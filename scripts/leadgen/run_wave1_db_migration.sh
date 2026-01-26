#!/usr/bin/env bash
set -euo pipefail

PG_CONTAINER_NAME=${PG_CONTAINER_NAME:-motorcade-postgres}
DB_NAME=${DB_NAME:-motorcade}
DB_SCHEMA=${DB_SCHEMA:-app}
MIGRATION_VERSION=${MIGRATION_VERSION:-20260126_01_wave1_leads}

# Resolve repo root from this script location: motorcade-infra/scripts/leadgen/
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MIGRATION_FILE="$REPO_ROOT/ansible/files/leadgen/migrations/${MIGRATION_VERSION}.sql"

BACKUP_ROOT=${BACKUP_ROOT:-/var/backups/motorcade/postgres/schema}
TS=$(date -u +%Y%m%dT%H%M%SZ)
BACKUP_FILE="$BACKUP_ROOT/${DB_SCHEMA}.schema_only.${TS}.sql"

echo "[wave1-db] Using container: $PG_CONTAINER_NAME"
echo "[wave1-db] Migration: $MIGRATION_VERSION"
echo "[wave1-db] Migration file: $MIGRATION_FILE"

if [[ ! -f "$MIGRATION_FILE" ]]; then
  echo "ERROR: migration file not found: $MIGRATION_FILE" >&2
  exit 1
fi

# Backup-first (schema-only) — matches RUNBOOK rule for state changes
sudo mkdir -p "$BACKUP_ROOT"
echo "[wave1-db] Creating schema-only backup -> $BACKUP_FILE"
sudo podman exec "$PG_CONTAINER_NAME" pg_dump -U postgres -d "$DB_NAME" --schema="$DB_SCHEMA" --schema-only > "$BACKUP_FILE"
echo "[wave1-db] Backup written: $BACKUP_FILE"

# Apply migration
echo "[wave1-db] Applying migration via psql (ON_ERROR_STOP=1)"
cat "$MIGRATION_FILE" | sudo podman exec -i "$PG_CONTAINER_NAME" psql -U postgres -d "$DB_NAME" -v ON_ERROR_STOP=1

# Verification
echo "[wave1-db] Verifying table + migration ledger"
sudo podman exec "$PG_CONTAINER_NAME" psql -U postgres -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "\dt+ ${DB_SCHEMA}.leads"
sudo podman exec "$PG_CONTAINER_NAME" psql -U postgres -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "SELECT version, applied_at FROM ${DB_SCHEMA}.schema_migrations WHERE version='${MIGRATION_VERSION}';"

echo "[wave1-db] DONE"
