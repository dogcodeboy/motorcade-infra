<!--
LIVING DOCUMENT — MAY UPDATE (CITE SOURCES)
-->

# LeadGen Synthesis (Current)

- Conversion path: Lead → Assessment → Proposal → Contract → Execution.
- Phase 1 captures short intake only; phase 2 detailed questionnaire comes later.
- Geography starts Houston-first; other metros staged.

## LeadGen Scope and Authority Boundaries (LOCK THIS INTENT)

LeadGen is a **gatekeeper and qualifier** — not dispatch, not scheduling, not quoting, and not contract execution.

### Deterministic Control Layer (Authoritative)
Lead validity and routing are governed by **deterministic rules** (schema validation + doctrine constraints). This layer must be:
- Replayable and auditable
- Consistent across runs
- The source of truth for “accepted vs rejected” intake status

### AI Augmentation Layer (Non‑Authoritative)
OpenAI/LLM features are permitted **only** as an overlay that may:
- Summarize leads for humans
- Annotate missing info / ambiguity
- Suggest follow‑up questions
- Draft internal briefings and proposal language
- Generate sales training material and lead-specific coaching

AI must **not**:
- Accept or reject leads (no go/no-go authority)
- Set pricing, discounts, or minimums
- Commit resources (guards, vehicles, schedules)
- Make legal interpretations or contractual promises

### Sales Enablement (Internal‑Only)
AI-generated sales guidance is **internal-only** and must be derived from Motorcade-approved doctrine. It is informational and non-binding; humans retain full decision authority.

### API Compatibility Note (v1)
Lead Intake API v1 is **AI‑agnostic but AI‑compatible**:
- AI fields (annotations, summaries, flags) are optional and ignorable
- Deterministic rules always override AI suggestions
- Breaking changes require a versioned contract update (v2)


## Session Handoff Protocol (Mandatory)

Every session handoff MUST include:

1. References to the authoritative docs used in the session (link the exact paths).
2. A clean, compressed ZIP of the current repo state at handoff time.
3. A brief status summary that clearly states:
   - What is frozen
   - What is active
   - What must not be touched in the next session

If a topic is frozen by a checkpoint, future sessions MUST NOT modify it outside a dedicated polish phase.

