# FIX_NOTES — YAML parse failure (unknown escape character)

## Symptom
Ansible failed before executing any tasks:

- `Syntax Error while loading YAML. found unknown escape character`
- Pointed at the regex patterns containing `\s` and `\b`.

## Root cause
The original `set_fact` values were YAML **double-quoted** scalars. In YAML, backslashes inside double quotes are treated as escape sequences; `\s` is not a valid YAML escape, so parsing fails.

## Fix applied
In `ansible/playbooks/LEADGEN_07B_wave3_psycopg_driver_fix_and_persistence_verify.yml`:

- Switched the `has_psycopg3/has_psycopg2` Jinja expressions to YAML **single-quoted** scalars.
- Escaped backslashes in the regex patterns (`\\s`, `\\b`, and `\\[binary\\]`).

This change is intended to make the playbook parse consistently and allow the run to proceed to the actual Wave3 DB persistence diagnostics.
