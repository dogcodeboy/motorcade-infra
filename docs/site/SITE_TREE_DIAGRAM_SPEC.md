# Diagram Spec — Site Build Tree (single continuous diagram)

## Purpose
We want a visual tree document later without re-deriving structure.

## Source of truth
- docs/site/SITE_BUILD_TREE.md

## Requirements
- Single continuous diagram (no splitting into multiple diagrams)
- Emoji labels preserved
- Readable on mobile and at 1080p
- Supports future export to SVG/PDF

## Suggested formats
- Mermaid flowchart (for GitHub rendering)
- Graphviz DOT (for CI render/export)
- Optional: JSON representation (for future UI)

## Acceptance criteria
- Diagram can be generated from the tree file without manual edits

---

## Appendix — Gate Checks
- Must align with `docs/site/RUNBOOK.md` and `docs/site/DELTA_AUDIT_REPORT.md`
- Must not contradict locked decisions (`site_01`–`site_05`)
- Must remain portability-friendly (WordPress is temporary)

## Appendix — Stop Conditions
- If a future session proposes CF7 for intake, stop and use the custom bridge plugin path
- If copy implies goods/cargo/property transport, stop and correct per Services Canon
- If a page spec references missing assets, stop and complete Assets step first

## Appendix — Change Log (Append-only)
- 2026-01-29: Expanded to meet governance minimum-content gate and prevent drift

