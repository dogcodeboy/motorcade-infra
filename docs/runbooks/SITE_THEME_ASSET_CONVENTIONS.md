# 🧱 SITE THEME ASSET CONVENTIONS

**Goal:** eliminate “spec references assets that never exist” failures.

---

## 1) Canonical asset roots (current repo reality)

Theme root (canonical):
- `motorcade.vip/ansible/files/themes/motorcade-trust/`

Assets under theme:
- `motorcade.vip/ansible/files/themes/motorcade-trust/assets/`
- `motorcade.vip/ansible/files/themes/motorcade-trust/assets/img/`
- `motorcade.vip/ansible/files/themes/motorcade-trust/assets/img/services/`
- `motorcade.vip/ansible/files/themes/motorcade-trust/assets/css/`

Observed Services assets include:
- `services-hero.png`
- `services-cta.png`
- service cards (armed security, executive protection, rapid response, etc.)

---

## 2) Naming rules (locked for stability)

- Use lowercase, hyphen-separated: `services-hero.webp`
- Prefer **semantic** names over “final2”
- Keep page-scoped subfolders: `assets/img/services/…`
- Avoid embedding dates in filenames unless it is a legal/audit artifact

---

## 3) Format standards (performance + zip stability)

- Photos / large images: **WebP** preferred (PNG allowed only if transparency required)
- Icons/logos: **SVG** preferred
- Keep hero images with explicit target sizes:
  - desktop ~1600–2200px wide
  - mobile crop ~900–1200px wide

---

## 4) Source-of-truth rule

If two copies of an asset exist in different trees (dup theme directories):
- treat the canonical theme tree as truth
- record drift in `SITE_THEME_DELTA_AUDIT.md`
- fix via `site_20` (consolidation) rather than ad-hoc copying

---

## 5) Acceptance criteria
- Every render spec references only files in the canonical asset root
- Assets are optimized and bounded in size
- No orphan assets are introduced without being referenced by a render spec
