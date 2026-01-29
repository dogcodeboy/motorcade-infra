# Audit & Delta Lock — Site Theme Program (Anti-Churn)

This document exists to prevent rework and “session drift.”  
When anything conflicts, resolution priority is:

1) Checkpoints (if applicable)
2) docs/site (this folder)
3) Main RUNBOOK
4) Chat history

## A. Locked decisions (do not revisit)

### A1) Program structure
- Site theme work is tracked as `site_XX` steps (not PLAT_XX).
- Each page deliverable MUST have:
  - `site_XX.A` Assets (required before render)
  - `site_XX.B` Render Spec (Option A; structured spec, not “final copy”)
- “Assets first” exists to prevent the common failure where a page spec references images that never get produced.

### A2) WordPress is temporary; theme must be portable
- The theme’s header/footer/layout contract must be implementable as pure HTML/CSS later.
- We will not design ourselves into WP-only corner cases.
- Wherever WordPress adds constraints, we document them explicitly but do not treat them as long-term architecture.

### A3) The 09B bridge is a custom plugin (not CF7)
- The WP↔LeadGen bridge will use a custom Motorcade intake plugin.
- It must be built so the submit handler can later target the LeadGen container without rework.
- Any session proposing CF7 is **automatically non-authoritative**.

### A4) Language decisions
- Remove “tactical” language from public positioning.
- Prefer “Request a Security Assessment” over “Quote” wording.

### A5) Licensing-safe service canon
We must not accidentally advertise what we aren’t licensed to do.

**Executive Protection family**
- EP Core (primary)
- EP Transport (People Only)
- EP Escort (Vehicle Escort)

**Rapid Response**
- EP add-on only (available across all three EP pages)
- Not a standalone service category.

**Explicit exclusions**
- Do not mention transporting cargo, goods, property, or “asset transportation.”
- We can transport people.
- We can escort cargo vehicles (as escort/security), but we do not transport goods.

### A6) Navigation & responsive behavior
- Desktop: Services must be a dropdown with EP subpages grouped properly.
- Mobile: a second navigation action (hamburger/dropdown) is required when the menu can’t fit.
- “Login” can be a single top-nav entry routing to Auth Entry.

## B. Drift sources observed (to avoid)
- Reopening site_01–05 as “not done”
- Mixing implementation edits with design governance
- Replacing the bridge approach (CF7 or similar)
- Adding services that create licensing ambiguity
- Copy changes that reintroduce “tactical” or mention goods/cargo transport

## C. Change record policy (append-only)
Any time a locked decision changes:
- Add a dated change record to the relevant lock doc
- Add a dated entry here summarizing the delta
- Do not rewrite earlier history
