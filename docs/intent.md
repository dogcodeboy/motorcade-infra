# INTENT (Authoritative)

This document is the **canonical intent anchor** for the **Admin-AI** control plane and its worker-plane orchestration model.
It is written to be **merge-safe**, **implementation-agnostic**, and **non-stub**.

## Relationship to Governance (Frozen)

Admin-AI governance is **complete and frozen** under **ADMINAI_01–ADMINAI_08**.
This intent document **does not** reinterpret or weaken governance; it **extends operational intent** in areas not previously made explicit.

Authoritative governance artifacts (do not summarize or re-litigate):
- `docs/runbook-attachments/ADMIN_AI_GOVERNANCE_COMPLETE.md`
- `docs/checkpoints/2026-01-30_ADMIN_AI_GOVERNANCE_COMPLETE/`

## Definitions

- **Control Plane (Admin-AI Core):** The authoritative, licensed system that evaluates facts, applies intent, enforces invariants, and executes privileged operations.
- **Worker Plane (Workers):** Licensed, lower-cost servers provisioned and managed by Admin-AI to run workloads (containers) for scale and load balancing.
- **Privileged Operation:** Any action that mutates infrastructure, identity, routing, security policy, platform runtime, or workload admission.
- **Advisory:** A warning or recommendation that **never** changes execution authority or behavior unless explicitly adopted.

## Purpose

Admin-AI exists to:
- Provide an authoritative, browser-accessible control plane to build and operate platforms.
- Install and orchestrate portable, containerized services wherever possible.
- Scale capacity up/down automatically to maintain service health and control cost.
- Preserve governance invariants: auditability, refusal semantics, and separation of Facts / Memory / Intent.

## Deployment Modes

Admin-AI must support both:

### Adoption Mode (Brownfield)

Admin-AI may be introduced into an existing environment (not a fresh server) and must be able to:
- discover current state (Facts),
- reconcile to declared intent (Intent),
- preserve history (Memory),
- and refuse/halt on ambiguity or invariant violations.

### Greenfield Mode

Admin-AI may be installed into a clean environment and asked to build an entire platform end-to-end.
Greenfield mode is a packaging/distribution option and does not alter governance invariants.

## Control Plane and Worker Plane

Admin-AI is the licensed control plane.

Admin-AI may manage additional worker servers that do **not** run Admin-AI. Worker servers are runtime hosts whose purpose is to run platform workloads under Admin-AI orchestration.

Key invariants:
- Admin-AI retains **exclusive authority** for orchestration, privileged operations, and platform mutation (provisioning, deprovisioning, identity, routing, upgrades, policy enforcement).
- Worker nodes provide **execution capacity only** and must not become independent control planes.
- Admin-AI may provision, configure, validate, and deprovision worker nodes to load balance and reduce cost.
- Provider mechanisms may vary (cloud marketplace or on-prem), but the control-plane/worker-plane separation does not.

## Licensing as a Core Invariant

Admin-AI Core is a licensed control plane.

Licensing enforcement is a mandatory, continuous precondition for execution and is enforced below all extension and feature boundaries.

Key invariants:
- Admin-AI Core must verify valid execution rights before startup and continuously at runtime.
- All privileged actions must pass through the licensed core executor.
- Customer-added features/modules may extend functionality but must never bypass, replace, weaken, or disable licensing enforcement.
- Licensing enforcement is independent of any specific marketplace or deployment model.
- The source of licensing authority may vary (marketplace, vendor license service, on-prem/offline authority), but the requirement to validate execution rights does not.
- Loss or invalidation of licensing authority results in deterministic refusal or halt behavior; no silent degradation.

### Licensing Reachability Grace (TTL)

If a licensing authority is temporarily unreachable, Admin-AI may continue operating **only within a previously validated TTL**:
- No expansion of scope
- No upgrades
- No new privileged capabilities
- Must revalidate before TTL expiry or halt deterministically

## Worker AMI and Licensing Model

Worker nodes are provisioned from a separate, vendor-controlled runtime image (e.g., **LEMP + Podman**).

- Control-plane nodes (Admin-AI) are licensed at a premium hourly rate reflecting their authoritative role.
- Worker nodes are licensed independently at a substantially lower hourly rate reflecting their non-authoritative role.
- Licensing applies to both control-plane and worker nodes, but reflects **role and blast radius**, not raw compute.

## Worker Provisioning and Workload Admission

Admin-AI only spins up the vendor worker AMI and drops the appropriate container(s) with configuration.

Key invariants:
- Worker nodes are provisioned **exclusively** by Admin-AI from the vendor worker AMI.
- Admin-AI is solely responsible for deploying workloads to worker nodes (images, configuration, networking, routing, health admission).
- Worker nodes are not intended for general-purpose use and must not accept independent workload deployment outside Admin-AI orchestration.

## Worker Runtime and Bootstrap

Worker images should be as complete as practical to enable fast scale events. Bootstrap after launch is allowed, but must be fast and deterministic.

Bootstrap invariants:
- Bootstrap is time-bounded and suitable for load-balancing scale events.
- Bootstrap is intended primarily for wiring (configuration, registration, pinned artifact fetch, health readiness), not open-ended host provisioning.
- Bootstrap must be idempotent and auditable.
- If bootstrap fails or exceeds bounds, the node must not be admitted into service.

## Autoscaling and Cost Control

Admin-AI must know when to scale capacity up/down to maintain health and control cost.

Autoscaling invariants:
- Autoscaling decisions are deterministic and based on measured facts/telemetry; autoscaling must not require OpenAI/LLM calls.
- Provisioning/deprovisioning are privileged operations and must pass through the licensed core executor with full audit and refusal semantics.
- Autoscaling is bounded by non-disableable guardrails (resource caps, spend ceilings, cooldown windows, min node lifetimes, drain-before-terminate).
- Any failed scale event must be quarantined and auditable, not silently ignored.

### Autoscaling Modes (Customer-Selectable)

Admin-AI supports multiple autoscaling strategies per environment:

- **Warm Pool + Surge:** maintain a minimum number of ready worker nodes and scale aggressively during detected spikes.
- **Surge Only:** maintain no warm pool and scale aggressively only when spikes are detected.

Customer selection affects responsiveness and cost profile but must not affect safety. All autoscaling behavior remains bounded by guardrails and is fully auditable.

If a customer selects **Surge Only**, Admin-AI may emit advisory recommendations suggesting a warm pool if repeated spike patterns are observed. These recommendations are informational only and must not override customer-selected behavior.

## Advisory vs Enforcement

Admin-AI may observe deployment characteristics (including instance sizing) and emit advisory warnings or recommendations related to performance and scale.

Invariants:
- Advisories are informational only and must never affect execution authority, licensing enforcement, or system behavior unless explicitly adopted.
- Vendor/internal deployments are exempt from advisories by default (no noisy warnings on Motorcade/vendor environments).

## Capacity Intent vs Platform Authority

Customers may define **capacity and cost preferences** (capacity intent), including autoscaling mode, warm pool settings, caps, and budgets.

Customers may **not** modify platform authority:
- Admin-AI core behavior, licensing enforcement, governance rules, authority boundaries, or refusal semantics remain exclusively under Admin-AI control.

## Extreme Load Posture

Under unknown or extreme demand spikes:
- Admin-AI must preserve system integrity and governance invariants.
- Graceful degradation is acceptable and expected (queueing, throttling, rate-limiting, temporary rejection with clear signals).
- Admin-AI must not violate guardrails, audit invariants, or licensing requirements to “keep up.”

## One-Line Summary

Admin-AI is a licensed, authoritative control plane that orchestrates a licensed, lower-cost worker plane via deterministic telemetry-driven autoscaling, preserving frozen governance invariants while enabling fast, audited scale events and safe degradation under extreme load.
