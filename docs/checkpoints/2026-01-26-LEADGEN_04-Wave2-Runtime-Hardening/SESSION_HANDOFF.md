# SESSION HANDOFF — motorcade-infra

Checkpoint: 2026-01-26-LEADGEN_04-Wave2-Runtime-Hardening

Status:
- LEADGEN Wave 2 runtime hardening prepared.
- New playbook: ansible/playbooks/LEADGEN_04_wave2_runtime_hardening.yml
- Hardened systemd unit written at: /etc/systemd/system/motorcade-leadgen-api.service
- Watchdog installed + enabled: motorcade-leadgen-watchdog.timer

Do NOT:
- Expose LeadGen directly to the internet (keep 127.0.0.1:8000).
- Change inventory groups (no motorcade_web).
- Move vault.yml location.

Next step:
- Run LEADGEN_04 on motorcade-web-01 and verify using docs/checkpoints/2026-01-26-LEADGEN_04-Wave2-Runtime-Hardening/VERIFY.md
