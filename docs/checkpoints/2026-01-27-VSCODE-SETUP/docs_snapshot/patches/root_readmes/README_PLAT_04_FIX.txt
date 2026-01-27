PLAT_04 FIX (motorcade-infra)

What this fixes:
- Ansible 'command' module was given a YAML list under 'cmd:' which causes Ansible to try to execute a literal string like "[podman,".
- Replaced list-form 'cmd:' with 'argv:' for BOTH podman build and podman run tasks.

How to apply:
1) cd ~/Repos/motorcade-infra
2) unzip -o ~/Downloads/motorcade-infra_PLAT_04_cmd_argv_fix.zip
3) rerun:
   ./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_04_lead_intake_api.yml

Expected:
- podman build runs successfully from /opt/motorcade-leadgen
- container starts and health check passes at http://127.0.0.1:8000/lead/health
