# User Preferences (Authoritative)

This document captures **explicit user preferences** that govern how this project is built,
how sessions are conducted, and how deliverables are produced.

⚠️ **This document must be reviewed at the start of every session and updated at the end of every session**
to reflect new or refined preferences.

---
## Delivery & Workflow Preferences

- Always prefer **industry-standard, boring, production-stable solutions**.
- Platform must remain **portable** and easily transferable to new servers as demand increases.
- Prefer **containerized services** with minimal host coupling.
- Use **rootful Podman**, installed manually (non-dnf). Do not assume package-manager awareness.
- If a dependency is missing, stop and surface it; do not auto-install silently.
- If a freeze blocks progress, explicitly call it out and request a scoped override.

---
## Ansible & Infrastructure Preferences

- No checkpoints are created until a playbook runs successfully.
- Failed playbooks are **replaced**, not checkpointed.
- Append-only discipline: do not delete or rewrite historical work.
- systemd-first lifecycle management.
- Services should default to **installed but disabled** during foundation phase.
- Avoid complex Jinja logic; prefer explicit, readable assertions.

---
## Documentation Preferences

- RUNBOOK.md is the authoritative operational document and must never lose content.
- Updates to RUNBOOK.md must preserve structure and append new state clearly.
- Session handoff text is provided **in chat** for copy/paste.
- Additionally, when a playbook is updated (even if the run fails), include a small repo-tracked session note in a folder like:
  - motorcade-infra/docs/session_updates/<YYYY-MM-DD>_<PLAYBOOK_ID>/SESSION_HANDOFF.md
  - Include the playbook name, what changed, current failure state (if any), and the next exact command(s) to run.
- Repo updates (docs/playbooks) are delivered as **merge-safe ZIPs**.

---
## Session Conduct Preferences

- Minimal explanation in chat; detailed rationale belongs in documentation.
- When a fix is requested, send the fix + commands directly.
- Always respect freezes and declared constraints.
- Treat stated preferences as standing instructions unless explicitly revoked.

---
## Maintenance Rule

This document must be updated whenever:
- A preference is added, changed, or clarified
- Workflow expectations evolve
- Delivery format requirements change
