# DESIGN INTENT (Authoritative) — SITE_06 — Services overlap + hero wave blend checkpoint

This checkpoint locks the intended visual behavior for the **Hero → Services overlap** section in `docs/site/site_06/`.

## Canonical reference
The intended layout is the user-provided reference mock (screenshot) showing:

- Hero image with a *subtle* left-to-right blue gradient (not a heavy blue wash).
- A **light wave** at the bottom of the hero that blends into the next section.
- The **Services** title ("Experienced Protection Services") appearing in the *lower third of the hero* region, sitting on a lightened/whitened band created by the wave + soft overlay.
- Three service cards aligned in a row, *floating* within the same blended overlap area (not dropped fully into a plain white section below).
- The next section ("Who We Secure") begins below the cards, on a clean background, and is not affected by hero overlap layers.

## Non-goals (do not do)
- Do not redesign typography, palette, spacing system, or overall page structure.
- Do not add new UI elements, animations, or JS.
- Do not change global header/footer modules.
- Keep changes scoped to SITE_06.

## Visual constraints (hard)
1. **Hero overlay must not flood the entire hero**
   - The left gradient exists for text contrast only.
   - The image must remain readable and not appear uniformly tinted.

2. **Services overlap is a single composed stack**
   - Wave + light lift + services title/lead + cards should feel like one continuous composition.

3. **Services title must be readable**
   - Must not sit on dark hero areas.
   - Must not be pushed down into a separate “flat” services band.

4. **Cards must sit inside the overlap**
   - Must not appear detached or too low.

5. **Audience section must start below and be unaffected**
   - No spillover overlays, haze, or opacity bands into Audience.

## Definition of Done (DoD)
Desktop (>= 1200px):
- Hero photo is not blue-washed; right side looks close to original colors.
- Left gradient fades out by ~70–80% width.
- Services title/lead and 3 cards appear integrated in the hero’s lower-third overlap region.
- No hard band line where hero meets services.
- Audience begins below cards with no overlay contamination.

Mobile (<= 760px):
- Services flows naturally after hero (no collisions / weird gaps).
- Readable, clean stacking.
