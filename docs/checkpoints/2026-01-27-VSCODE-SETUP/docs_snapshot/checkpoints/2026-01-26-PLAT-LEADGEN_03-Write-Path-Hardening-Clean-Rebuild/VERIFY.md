# Verification (commands)

Run from your local machine (config + inventory + vault scope):

```bash
cd ~/Repos/motorcade-infra/ansible

ansible --version | sed -n '1,6p'
ansible-config dump --only-changed

ansible -i inventories/prod/hosts.ini motorcade \
  -m debug -a "var=group_names" --vault-id @prompt
```

Run the playbook:

```bash
ansible-playbook -i inventories/prod/hosts.ini \
  playbooks/LEADGEN_03_wave1_write_path_hardening.yml \
  --vault-id @prompt
```

Verify filesystem state on the server:

```bash
ssh -i <your-key.pem> ec2-user@motorcade-web-01

sudo stat -c "%A %a %U:%G %n" /opt/motorcade \
  /opt/motorcade/leadgen \
  /opt/motorcade/leadgen/config \
  /opt/motorcade/leadgen/data \
  /opt/motorcade/leadgen/logs \
  /opt/motorcade/leadgen/tmp
```
