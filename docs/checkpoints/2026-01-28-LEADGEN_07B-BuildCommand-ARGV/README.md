# LEADGEN_07B — Build step parse fix (command argv)

Purpose
- Fix Ansible YAML/Jinja argument-splitting error in the "Build | rebuild LeadGen API image (no-cache)" task.
- Replace a multiline `shell:` block with `command: argv:` + `args: chdir:` for parse-stability.

Change summary
- The build task now uses:
  - `ansible.builtin.command` with `argv` list to avoid quoting/splitting issues.
  - `args: chdir: "{{ build_context_dir }}"`.

Scope
- No other functional behavior changes intended.
