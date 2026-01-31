# SESSION HANDOFF — SITE_06 — Services overlap + hero wave blend checkpoint

Date: 2026-01-31
Repo: motorcade-infra
Branch: main
Checkpoint: `docs/checkpoints/2026-01-31_SITE_06_SERVICES_OVERLAP_CHECKPOINT/`
Status: WORK IN PROGRESS — layout mismatch vs intended reference

Authority:
- `DESIGN_INTENT.md` is canonical.

Problem:
Services overlap composition is not matching intended design:
- hero overlay too strong (blue wash)
- services title/cards detached into a flat band
- overlap CSS has duplicated/conflicting declarations

Next actions (strict order):
1) Pick ONE overlap model and delete conflicting CSS.
2) Fix hero media sizing (likely `object-fit: cover`) with correct focal point.
3) Reduce/reshape hero gradient so it fades earlier and does not tint entire hero.
4) Place Services title/lead + cards inside the overlap lift region like reference.
5) Verify desktop/tablet/mobile using `VERIFY.md`.

Working files:
- `docs/site/site_06/index.html`
- `docs/site/site_06/css/styles.css`
