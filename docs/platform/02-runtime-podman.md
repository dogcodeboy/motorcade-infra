<!--
LIVING DOCUMENT — MAY UPDATE (CITE SOURCES)
Rules:
- You MAY update this file as decisions evolve.
- Always cite where the decision came from (verbatim excerpts or checkpoints).
- Do not contradict frozen checkpoints.
-->

# Runtime: Podman (Production)

- Production container runtime is **Podman**.
- Services should be managed via **systemd** (Quadlet preferred) for restart-on-boot and journald logging.

## Session Handoff Protocol (Mandatory)

Every session handoff MUST include:

1. References to the authoritative docs used in the session (link the exact paths).
2. A clean, compressed ZIP of the current repo state at handoff time.
3. A brief status summary that clearly states:
   - What is frozen
   - What is active
   - What must not be touched in the next session

If a topic is frozen by a checkpoint, future sessions MUST NOT modify it outside a dedicated polish phase.

