# Verification

From repo root:

```bash
cd ~/Repos/motorcade-infra/ansible

ansible-playbook -i inventories/prod/hosts.ini   playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml   --ask-vault-pass
```

Pass conditions:
- Play completes with `failed=0`
- The “Show | intake result (safe)” task reports `intake_status=202`
- The DB poll task reports a count >= 1 for the generated email

If intake returns 422:
- Read the printed sanitized body snippet; it will state which field is missing/invalid.
- Update the payload schema in the playbook accordingly (Wave 3 schema is strict).
