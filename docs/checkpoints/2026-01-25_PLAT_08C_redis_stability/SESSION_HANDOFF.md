SESSION HANDOFF — motorcade-infra

Status:
- PLAT_08B complete and verified (Redis foundation).
- PLAT_08C attempted; Redis bring-up became stuck due to container start failure + readiness gate hang.
- Host name confirmed: motorcade-web-01.
- Podman path: /usr/local/bin/podman (static/manual install).
- Nginx stack remains frozen/verified.

Observed Root Cause:
- Podman/conmon build does NOT support journald logging.
- Redis systemd unit uses --log-driver journald, causing container start failures.
- readiness gate waits forever because container never reaches running state.

Rules reaffirmed:
- No inline edits on server for fixes.
- All changes must be done via playbook to remain replicatable.

Next:
- Replace PLAT_08C with a stable, one-shot Redis bring-up that avoids journald log driver
  and uses bounded verification (fail-fast).
