# 🧾 SITE THEME RENDER INDEX (What exists + what’s missing)

This index is the operator-friendly pointer from governance steps to actual template files in `motorcade.vip`.

---

## 1) Canonical theme templates (observed)

Theme root:
- `motorcade.vip/ansible/files/themes/motorcade-trust`

Core templates observed:
- `header.php`
- `footer.php`
- `index.php`
- `page.php`
- `single.php`
- `page-services.php`

---

## 2) Page mapping (current known state)

### Services overview (site_07)
- Template: `page-services.php`
- CSS: `assets/css/services.css`
- Images: `assets/img/services/*`

### Other pages (site_06, site_08–site_19)
Current repo snapshot suggests:
- Many pages are likely using generic `page.php` until dedicated templates are added.
- This is acceptable early, but should be recorded per-page as the program advances.

---

## 3) Render spec rule (Option A)
Before implementing a page:
- write `site_XX.A` assets list
- then write `site_XX.B` render spec
- only then modify templates/CSS

---

## 4) TODO queue (to eliminate “stubs”)
If a page does not have a dedicated template, the render spec should state:
- which WP page slug it applies to
- what CSS hooks/classes are required
- whether it is implemented via:
  - dedicated `page-<slug>.php`, OR
  - content + block editor with theme styles (temporary)

---

## 5) Acceptance criteria
- Each public page has a clear implementation plan mapped to templates/CSS
- No render spec references non-existent templates or assets
