# Platform Roadmap (Non-binding, Guardrailed)

This roadmap captures **intent and guardrails**, not commitments or timelines.  
It exists to prevent architectural drift and microservice sprawl while still supporting a full Motorcade application platform later.

## Core Principles (Locked)
1. **Ansible is the platform layer** — runtime behavior defined in `motorcade-infra`; no manual server mutations.
2. **Containers are execution units** — not architecture boundaries.
3. **Default = modular monolith** — start as internal modules; split only with justification.
4. **Internal-only by default** — no public ports unless explicitly promoted (443 proxy).
5. **AI is non-authoritative** — assistive only; deterministic + approvals remain authoritative.

## Phases (High-level)
- **Phase 0:** current foundation (infra + leadgen + site).
- **Phase 1:** LeadGen modular monolith (intake/enrichment/scoring/proposals/sales enablement).
- **Phase 2:** shared capabilities (auth, audit, notifications, storage, scheduling, observability).
- **Phase 3:** operations platform selective separation (ops-api, billing-api, intel-api).
- **Phase 4:** decomposition only when justified (scale/security/cadence/runtime).

## Disallowed Anti-patterns
- One feature = one container
- One idea = one repo
- Public ports without promotion
- Bypassing Ansible
- AI replacing deterministic logic
