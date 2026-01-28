# NEXT_STEPS (no scope creep)

## A) Make TX-only configurable (forward compatible)

Today, LeadGen is effectively TX-only via request.location.state validation.
Future admin console should drive service area without code edits.

Recommended implementation direction (later, not in this checkpoint):

- Add `SERVICE_AREA_STATES=TX` (comma-separated) to `/etc/motorcade/leadgen.env`
- Schema validation: allow only states from that env list
- Keep default `TX` for Wave 1

## B) Pin a release tag (preferred) after merging

To avoid always passing a commit SHA:

- Merge the LeadGen fix to `main` when ready
- Tag a release (e.g., `leadgen-wave1-2026-01-28`)
- Update LEADGEN_07B playbook default `leadgen_git_ref` to the tag
- Keep RUNBOOK pinned to the tag

## C) Add an additional DB verify (optional)

Add a playbook step to select the inserted row and confirm:

- `payload` is valid JSON and non-null
- `service_type` denormalized column matches request

(Do not add until after current Wave 1 is stable.)
