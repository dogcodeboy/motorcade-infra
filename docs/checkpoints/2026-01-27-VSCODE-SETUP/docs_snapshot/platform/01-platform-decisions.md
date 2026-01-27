<!--
LIVING DOCUMENT — MAY UPDATE (CITE SOURCES)
-->

# Platform Decisions (Current)

- WordPress is **marketing + intake shell**; platform services are the **system of record**.
- Lead Intake should be API-first and store structured leads (assessment-first, no public pricing).
- Containerized services are deployed to the platform host (AL2023) using Podman.

## Session Handoff Protocol (Mandatory)

Every session handoff MUST include:

1. References to the authoritative docs used in the session (link the exact paths).
2. A clean, compressed ZIP of the current repo state at handoff time.
3. A brief status summary that clearly states:
   - What is frozen
   - What is active
   - What must not be touched in the next session

If a topic is frozen by a checkpoint, future sessions MUST NOT modify it outside a dedicated polish phase.

