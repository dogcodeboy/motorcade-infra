# NOTES — Repo Slimdown Reality Check (size drivers)

## Why repo is still ~191MB after slimming
- Large tracked artifacts are now removed from active repo paths (working-tree size reduced).
- `.git/objects/pack/*.pack` stores historical blobs reachable from commits. `git gc` repacks/prunes but does not remove reachable history without rewrite.
- True historical slimming would require a separately governed step (e.g., `site_01c`) using `git filter-repo`/BFG plus force-push and clone-reset guidance.

## Remaining large file discovery (run as needed)
```bash
cd ~/Repos/motorcade.vip
find . -type f -size +10M -printf "%s\t%p\n" 2>/dev/null | sort -n | tail -n 50
```
