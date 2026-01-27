# Lead Intake API Contract (v1)

**Status:** Draft → Lock after review  
**Repo scope:** LeadGen (application contract)  
**Infra consumer:** `motorcade-infra` PLAT_04 (`PLAT_04_lead_intake_api.yml`)  
**Goal:** Provide a strict, deterministic intake contract that is safe to run internally (non-public) and compatible with future AI enrichment.

---

## 1. Design Principles (Non-Negotiable)

1. **Deterministic intake is authoritative.** Schema + doctrine constraints define accept/reject.
2. **Queue-first.** Intake returns **202 Accepted** after validation + enqueue. No DB writes required for PLAT_04.
3. **AI is non-authoritative.** AI may annotate/summarize/coach internally, but never accepts/rejects/prices/schedules.
4. **Internal-first exposure.** No direct internet exposure of service ports (e.g., 8000). Public access comes later via reverse proxy.

---

## 2. Authentication & Headers

### 2.1 Required Headers
- `X-API-Key: <shared secret>` (**required** for all endpoints except `GET /lead/health`)
- `Content-Type: application/json` (for POST requests)

### 2.2 Recommended Headers
- `Idempotency-Key: <uuid-or-random>` (**strongly recommended** for `POST /lead/intake`)
- `X-Request-Id: <uuid>` (optional; server generates if missing)

### 2.3 Source Identification
- `X-Lead-Source: motorcade.vip|partner|manual|watcher` (optional; if absent, server infers `unknown`)

---

## 3. Endpoints (v1)

### 3.1 Health
**GET** `/lead/health`  
**Auth:** none  
**Purpose:** liveness/readiness check for reverse proxy + ops.

**200 Response**
```json
{
  "status": "ok",
  "service": "lead-intake-api",
  "version": "v1",
  "queue": "ok",
  "db_readonly_check": "optional",
  "time_utc": "2026-01-21T05:30:00Z"
}
```

Notes:
- `queue` must be checked (connectivity/ping).
- `db_readonly_check` is optional for v1; if implemented, it must use the existing **read-only** role and perform a simple SELECT.

---

### 3.2 Intake
**POST** `/lead/intake`  
**Auth:** `X-API-Key` required  
**Idempotency:** Supported via `Idempotency-Key` header

**Behavior**
1. Validate schema.
2. Apply doctrine constraints (minimal v1 rules).
3. If valid: enqueue message + return **202** with `intake_id`.
4. If invalid: return **4xx** with structured error payload.
5. If queue unavailable: return **503**.

**202 Response**
```json
{
  "status": "accepted",
  "intake_id": "li_01J2ABCDEF1234567890",
  "request_id": "req_01J2ABCDEF1234567890",
  "received_at_utc": "2026-01-21T05:30:00Z"
}
```

**Idempotency Rule**
- If `Idempotency-Key` is repeated with the **same** normalized payload, return the **same** `intake_id` and `request_id`.
- If `Idempotency-Key` is repeated with a **different** payload, return **409 Conflict**.

---

## 4. Request Schema (LeadIntakeRequest v1)

### 4.1 Canonical Shape
```json
{
  "contact": {
    "full_name": "Jane Doe",
    "company": "Acme Logistics",
    "email": "jane@example.com",
    "phone": "+1-713-555-0199",
    "preferred_contact_method": "call"
  },
  "request": {
    "service_type": "armed_security",
    "timeline": {
      "start_local": "2026-02-01T08:00:00-06:00",
      "end_local": "2026-02-01T18:00:00-06:00"
    },
    "location": {
      "street": "123 Main St",
      "city": "Houston",
      "state": "TX",
      "postal_code": "77002"
    },
    "site_type": "commercial",
    "notes": "We need overnight coverage for a construction site.",
    "expected_hours": 10,
    "recurrence": "one_time"
  },
  "context": {
    "lead_source": "motorcade.vip",
    "referrer_url": "https://motorcade.vip/services/armed-security",
    "utm": {
      "source": "google",
      "medium": "cpc",
      "campaign": "houston_security"
    }
  }
}
```

### 4.2 Field Requirements (v1)
**contact**
- `full_name` required
- At least one of `email` or `phone` required
- `preferred_contact_method` enum: `call|text|email`

**request**
- `service_type` required (enum below)
- `location.state` must be `TX` for v1 (Texas-first launch)
- `timeline.start_local` required; `end_local` optional
- `recurrence` enum: `one_time|recurring|ongoing_24_7`

**context**
- optional, but recommended

### 4.3 Enumerations
`service_type` (v1):
- `armed_security`
- `executive_protection`
- `rapid_response_support`
- `armed_escort_driver`
- `armed_delivery`
- `event_security`

`site_type` (v1):
- `residential`
- `commercial`
- `industrial`
- `event`
- `other`

---

## 5. Error Model (Standard)

All errors return:
```json
{
  "status": "error",
  "request_id": "req_...",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable summary",
    "details": [
      {"field": "contact.email", "issue": "invalid_format"}
    ]
  }
}
```

### 5.1 Common Status Codes
- **400** `BAD_REQUEST` (malformed JSON, missing required structure)
- **401** `UNAUTHORIZED` (missing/invalid `X-API-Key`)
- **409** `IDEMPOTENCY_CONFLICT` (same idempotency key, different payload)
- **422** `VALIDATION_ERROR` (schema/doctrine constraints)
- **429** `RATE_LIMITED` (optional; future)
- **503** `QUEUE_UNAVAILABLE` (cannot enqueue)

---

## 6. Minimal Doctrine Constraints (v1)

These are intentionally conservative for launch and can expand later:

1. **Texas-only**: `location.state == "TX"`
2. **Service type must be recognized** (enum)
3. **Minimum scheduling guidance**: if `expected_hours` present and `< 10`, do **not** reject; accept but add a deterministic flag (for downstream workflow).
   - This preserves intake while enforcing policy later.

Deterministic flags are returned only internally (not part of v1 public response).

---

## 7. AI Compatibility (Non-Authoritative)

The following optional fields MAY exist later (not required in v1 requests) and must be ignored if unknown:
- `ai_summary` (string)
- `ai_flags` (array of strings)
- `ai_followup_questions` (array of strings)
- `sales_briefing` (object; internal-only)

**Rule:** Deterministic rules override AI suggestions. AI cannot accept/reject/prices/schedules.

---

## 8. Observability (Logging)

Minimum structured log fields per request:
- `request_id`
- `path`, `method`, `status_code`, `latency_ms`
- `lead_source` (from header or body)
- `idempotency_key_present` (boolean)

For `POST /lead/intake` success:
- `intake_id`

---

## 9. Queue Contract (Implementation Notes for PLAT_04)

v1 requires “enqueue” semantics but does not lock a specific technology. For PLAT_04 we will choose a standard queue (e.g., Redis lists/streams) and define:
- enqueue key/stream name: `lead_intake_v1`
- message payload: normalized LeadIntakeRequest + metadata (`request_id`, `intake_id`, timestamps)

The worker (future container) will consume from queue and handle persistence/enrichment.

---

## 10. Change Control

- v1 is locked after approval.
- Breaking changes require `v2` doc and versioned routing (e.g., `/v2/lead/intake`).
- Additive fields are allowed under v1 if optional and backwards compatible.
