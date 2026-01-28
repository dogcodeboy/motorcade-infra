# 2026-01-27-LEADGEN_07B-Wave3-DB-Persistence-Diagnostics

## What this checkpoint is for
LEADGEN_07B Wave3 playbook that fixes DB driver packaging (psycopg) and enforces the persistence contract.

## Current observed failure
`POST /lead/intake` returns 202 Accepted with `request_id`, but no row appears in `app.leads` within the poll window.

## What this update changes
- Uses Wave3 payload schema: `request.timeline` object + valid `request.service_type`.
- Sends Idempotency-Key header.
- Polls persistence by `request_id` first (preferred).
- Dumps diagnostics on persistence failure (latest leads, service status, journal tail, podman ps).
