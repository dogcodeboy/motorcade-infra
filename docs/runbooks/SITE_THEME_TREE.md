# 🌳 SITE THEME TREE (Continuous)

This is the **continuous step tree** used to execute the Motorcade public site program without churn.
It mirrors `docs/site/SITE_BUILD_TREE.md` but is kept here as a runbook artifact so operators can follow it from
`docs/runbooks/` when doing deploy work.

Legend:
- 🟦 LOCKED foundation
- 🟨 Page deliverable
- 🟧 Assets first → Render Spec
- 🟩 Gates (repo hygiene + bridge)
- 🟥 Stop condition

---

## 🟦 Foundation (LOCKED)
- site_01 — Platform & governance lock
- site_02 — Design intent & visual language lock
- site_03 — Services canon & licensing lock
- site_04 — Navigation/IA & responsive rules lock
- site_05 — Header & footer contract (portable) lock

## 🟨 Public pages (Option A)
- site_06 — Home
- site_07 — Services overview
- site_08 — Executive Protection (Core)
- site_09 — EP Transport (People Only)
- site_10 — EP Escort (Vehicle Escort)
- site_11 — Rapid Response (EP add-on only; not standalone)
- site_12 — Security Assessment (primary CTA / intake entry)
- site_13 — About
- site_14 — Contact
- site_15 — Careers
- site_16 — Auth entry (employee/client)
- site_17 — WP login/admin skin (portable direction)
- site_18 — Terms of Service
- site_19 — Custom 404

For each page:
- site_XX.A — Assets (required)
- site_XX.B — Render spec (references only existing assets)

## 🟩 Gates (must be done before bridge)
- site_20 — Asset consolidation & freeze (repo hygiene)
- site_21 — Compression & image slimdown

## 🟩 Bridge (after gates)
- site_22 — WordPress ↔ LeadGen bridge (custom plugin, NOT CF7)

---

## 🟥 Stop conditions (anti-churn)
- If render spec references an asset that does not exist → STOP, complete Assets first.
- If any copy implies goods/cargo/property transport → STOP, fix per Services Canon.
- If any plan proposes CF7 for intake → STOP, reject and follow site_22 custom plugin requirement.
