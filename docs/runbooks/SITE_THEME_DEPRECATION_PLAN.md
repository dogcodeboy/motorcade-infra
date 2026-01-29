# 🗑️ SITE THEME DEPRECATION PLAN (Runbook)

Purpose: keep repos session-friendly and prevent “zip upload” churn.

---

## 1) Problem class
- Large theme archives and duplicate assets cause:
  - slow session loads
  - failed uploads
  - confusion over canonical source

---

## 2) Approved approach (no history destruction)
- Do not delete history
- Move bulk out of active working paths into an **archive area**
- Record:
  - original path
  - new path
  - checksums
  - restore steps

---

## 3) Current drift to address
- Duplicate theme trees:
  - `motorcade.vip/ansible/files/themes/motorcade-trust/`
  - `motorcade.vip/ansible/playbooks/files/themes/motorcade-trust/`

This must be consolidated via a governed `site_20` step.

---

## 4) Acceptance criteria
- Active theme paths remain minimal
- Archives are recoverable (checksum + restore notes)
- Repo zip size is bounded and stable across sessions
