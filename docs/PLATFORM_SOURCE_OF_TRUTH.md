# PLATFORM SOURCE OF TRUTH (INDEX)

This file is an index and navigation aid only.

**Authority rules**
- Verbatim sources are append-only and must never be rewritten.
- Decision files may be updated, but must cite the verbatim sources/checkpoints that justify changes.

## Session Handoff Protocol (Mandatory)

Every session handoff MUST include:

1. References to the authoritative docs used in the session (link the exact paths).
2. A clean, compressed ZIP of the current repo state at handoff time.
3. A brief status summary that clearly states:
   - What is frozen
   - What is active
   - What must not be touched in the next session

If a topic is frozen by a checkpoint, future sessions MUST NOT modify it outside a dedicated polish phase.


## Where to start
- Doctrine (verbatim excerpts): `docs/doctrine/00-foundational-intent.md`
- LeadGen (verbatim excerpts): `docs/leadgen/00-leadgen-source-verbatim.md`
- Platform/containerization (verbatim excerpts): `docs/platform/00-containerization-source-verbatim.md`

## Full archives (lossless)
- `docs/_archives/motorcade-chatgpt-session.full.txt`
- `docs/_archives/leadgen-chatgpt-session.full.txt`
- `docs/_archives/containerization-chatgpt-session.full.txt`
