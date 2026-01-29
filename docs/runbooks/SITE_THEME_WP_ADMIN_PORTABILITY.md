# 🧱 WP ADMIN PORTABILITY (Runbook Notes)

This document captures **portable** choices for WP login/admin theming and future migration.

---

## 1) Principle
WordPress is a **temporary public site**. The admin/portal experience should not become a deep WP dependency.

---

## 2) What is acceptable in WordPress now
- Light branding on wp-login (logo/colors) is okay
- Minimal admin styling is okay

But:
- Avoid building “business backend” features as WP plugins unless they are deliberately temporary bridges.

---

## 3) Future admin backend context (preserved)
The audit referenced a future planning session that discussed:
- Guard portal branding vs minimal portal header
- Admin backend should be function-first; portals branded where it matters

Source of preserved context:
- `motorcade-infra/docs/_archives/motorcade-chatgpt-session.full.txt` (search for “Admin backend”)

---

## 4) Recommendation (no-churn)
- Public site header/footer contract remains portable HTML/CSS
- For portals (guard/client), prefer a minimal portal header to reduce distraction
- Record the final decision in governance when site_16/site_17 are executed

---

## 5) Acceptance criteria
- Any WP-admin styling work is documented as portable patterns
- No WP-only admin dependency is introduced without a deprecation plan
