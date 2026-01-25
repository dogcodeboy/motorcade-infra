## Next
1. Merge this checkpoint into the motorcade-infra repo root and commit.
2. Run the authoritative playbook:
   ```bash
   cd ~/Repos/motorcade-infra/ansible
   ansible-playbook -i inventories/prod/hosts.ini \
     playbooks/PLAT_08C_redis_bringup_health_gate.yml \
     --ask-vault-pass
   ```
3. Verify:
   ```bash
   ssh motorcade
   sudo systemctl status motorcade-redis --no-pager
   sudo /usr/local/bin/podman ps --filter name=motorcade-redis
   sudo /usr/local/bin/podman exec motorcade-redis redis-cli ping
   ```
