SESSION HANDOFF — motorcade-infra — LEADGEN_07B — Build context fix

Status:
- Playbook previously failed at Podman build:
  `COPY requirements.txt ... stat: "/requirements.txt": no such file or directory`
- Root cause: build context was set to repo root; Containerfile is in `.../api/` and expects `requirements.txt` within that context.

What changed:
- build_context_dir is now `dirname(containerfile_path)` so `podman build` runs from the Containerfile directory.

Next:
- Re-run LEADGEN_07B and continue to Wave3 intake + queue/persistence gating.
