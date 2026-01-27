# Read-Only Mode (Hard Safety Lock)

## Purpose

This document defines **Read-Only Mode**, a hard safety mechanism used during
critical infrastructure, deployment, or review work to **prevent any file
modifications**, including:

- Accidental human edits
- AI assistant edits (Codex, Copilot, etc.)
- Editor auto-fixes
- Mis-clicked “Apply” or “Fix” actions

When enabled, **the repository becomes physically read-only at the filesystem level**.

---

## When to Use Read-Only Mode

Enable Read-Only Mode when:

- Reviewing files from an external source
- Inspecting AI-generated files
- Debugging why something failed
- Working while exhausted or time-constrained
- Performing production-critical validation
- You explicitly want **inspection only**, not edits

If you are unsure whether edits are safe — **enable it**.

---

## Enable Read-Only Mode

```bash
chmod -R a-w .
```

## Disable Read-Only Mode

```bash
chmod -R u+w .
```

---

## Summary

If something *must not change*, enable Read-Only Mode.
