# OPEN PROBLEMS — SITE_06 — Services overlap + hero wave blend checkpoint

1. **Hero overlay too strong**
   - Needs reduced opacity and/or narrower fade so the photo is not uniformly tinted.

2. **Hero image fit mismatch**
   - `object-fit: contain` likely wrong; intended look is “full bleed”.
   - Expected: `object-fit: cover` + correct focal point.

3. **No single overlap source of truth**
   - Multiple overlap strategies are competing.
   - Needs one clean deterministic stacking model.

4. **Wave composition**
   - Must both lift to white and create continuity.
   - Current wave + services gradients can create a detached “band”.

5. **Responsive collapse**
   - Overlap must gracefully collapse on mobile (no collisions, no huge gaps).
