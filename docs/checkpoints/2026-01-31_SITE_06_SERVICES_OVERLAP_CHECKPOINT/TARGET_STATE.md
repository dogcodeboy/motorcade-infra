# TARGET STATE — SITE_06 — Services overlap + hero wave blend checkpoint

This describes the intended outcome as behavior (not implementation).

## Desktop (>= 1200px)
1. Hero photo is **full-bleed** (no letterboxing).
2. Left gradient supports text legibility only:
   - strongest at far-left
   - fades smoothly toward center
   - near-transparent by ~70–80% width
3. Wave creates a soft **white lift** at hero bottom:
   - Services title + lead sit within the lifted region
   - Cards sit directly below title/lead, still within the lifted region
4. Transition feels like one composition (no hard band line).
5. Audience section begins below cards; not affected by hero/services overlays.

## Tablet (761–980px)
- Cards may become 2-column, but still feel part of the overlap composition.
- Title/lead not clipped.

## Mobile (<= 760px)
- Natural vertical flow (hero → services title → cards).
- No extreme negative margins causing collisions.
- Wave can be simpler, but must not create harsh banding.

## Placement targets (practical)
At 1440×900:
- Services title baseline should be in the **lower third** of hero, about 120–180px above the card row.
- Card row should visually sit in the lifted overlap region, not fully on plain white.
