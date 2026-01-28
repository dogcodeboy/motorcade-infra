SESSION HANDOFF NOTE (delta)
- Fixed LEADGEN_07B build task parsing by switching to `command: argv` with `chdir`.
- If persistence still fails (0 rows), proceed with queue/worker + DB target diagnostics (health queue mode, env vars, logs).
