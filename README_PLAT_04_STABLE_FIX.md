PLAT_04 — Stable Fix (Build Context Sync)

What this fixes
- Eliminates the hard-coded /opt/motorcade-leadgen build-context assumption failing with:
  "Error: context must be a directory: '/opt/motorcade-leadgen'"
- Copies (tarballs) your local LeadGen repo to the server under /opt/motorcade-leadgen each run.
- Avoids rsync dependency (important due to earlier manual Podman installation constraints).
- Builds the container from that deterministic remote context.
- Runs API bound to 127.0.0.1:8000 (loopback-only).
- Waits for /lead/health to return HTTP 200.

Apply (from repo root)
1) Unzip into motorcade-infra (overwrite the playbook)
2) Run:
   ./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_04_lead_intake_api.yml

If your LeadGen repo is NOT located at ~/Repos/motorcade-leadgen, override:
   ./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_04_lead_intake_api.yml -e leadgen_src_local_path=/path/to/motorcade-leadgen
