# SESSION HANDOFF — Motorcade Site Program (SITE_06)

Status:
- Governance recovery complete
- PLAT_09A verified
- SITE_MINI_RUNBOOK.md verified
- site_01 through site_05 CLOSED
- site_06 AUTHORIZED but NOT STARTED (assets-first)

What happened in the previous session:
- The session became degraded and repeatedly diverged from the approved UI mockup.
- Several static-site zips were generated, but **none match the approved mockup**.
- Do not merge any HTML/CSS from that session.

Authoritative reference:
- The user-provided approved mockup(s) in `docs/site/renders/approved/` remain the source of truth.

Hard constraints (non-negotiable):
- Pure HTML + CSS (exportable, container-ready)
- No Gutenberg blocks
- Images contain NO text (text overlays via HTML/CSS)
- Must render locally via opening `index.html` from Downloads (`file://...`) with correct relative paths
- Brand color palette is locked to the approved mockup
- No tactical/warzone visuals; avoid rifles; prefer EP + armed guard presentation consistent with prior approvals
- No governance edits, no renumbering, no reinterpretation of site_01–site_05

Asset export bundle (from prior session; optional raw material):
- session-images-part-01.zip
- session-images-part-02.zip
- session-images-part-03.zip
- session-images-part-04.zip
- session-images-part-05.zip

Next authorized action:
- Begin site_06.A — Assets (asset enumeration + selection/approval only)
- Do NOT start site_06.B render until assets are locked/approved

Instruction to the new session:
- Rebuild from scratch.
- Pixel-match the approved mockup exactly (no redesign).
- If generating images, generate them as individual full-resolution files (NOT collages).
