PLAT_04 Context Autodetect Fix

This patch updates:
  - ansible/playbooks/PLAT_04_lead_intake_api.yml

What it fixes:
  - Stops hard-failing when /opt/motorcade-leadgen is missing by auto-detecting the
    first existing LeadGen build context directory on the target host.
  - Keeps LeadGen API bound to 127.0.0.1:8000 (loopback-only).
  - Leaves NGINX (PLAT_05) unchanged.

Apply:
  cd ~/Repos/motorcade-infra
  unzip -o ~/Downloads/motorcade-infra_PLAT_04_CONTEXT_AUTODETECT_FIX.zip
  ./scripts/run_playbook.sh motorcade-web-01 playbooks/PLAT_04_lead_intake_api.yml

If it fails:
  The failure message will list all searched directories. Put the repo on the server
  in one of those paths or add your real path to the candidates list in the playbook.
