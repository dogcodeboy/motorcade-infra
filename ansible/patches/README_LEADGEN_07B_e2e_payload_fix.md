# LEADGEN_07B E2E Payload Fix (422 -> accepted)

This patch updates the LEADGEN_07B Wave3 E2E payload to include required fields:
- `contact.full_name`
- `request` object

Apply from the `motorcade-infra` repo root:

```bash
cd ~/Repos/motorcade-infra
git apply --3way ansible/patches/LEADGEN_07B_e2e_payload_fix.patch
```

Then re-run the playbook as normal.
