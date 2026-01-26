# Servers and Resources (Authoritative)

This document exists to prevent recurring confusion about host group names, server roles, and where each service lives.

## Inventory source of truth

- Inventory file: `ansible/inventories/prod/hosts.ini`
- Any playbook host targeting must match group names defined there.

## Current known servers

### motorcade_platform

Primary Motorcade Platform host.

- Host alias: `motorcade` (SSH config alias)
- Instance private name example: `ip-172-31-40-46.us-east-2.compute.internal`
- Role:
  - Rootful Podman runtime (manual/static install assumed)
  - Postgres container: `motorcade-postgres`
  - Leadgen API container: `motorcade-leadgen-api`
  - Redis container (internal-only): `motorcade-redis`
  - Nginx reverse proxy stack (frozen)

## Host group naming policy

- **Do not use** `motorcade_web` or `motorcade-web` in playbooks. These groups do not exist in `hosts.ini`.
- Use `motorcade_platform` for the current all-in-one host.

## How to update this doc

When infrastructure changes (new EC2 instance, new role split, new region/VPC), update this file in the same PR/checkpoint as the playbook that introduced the change.
