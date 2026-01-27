PLAT_02C CLEAN PATCH
- Fixes verify task to avoid 'grep -E' (not supported in some environments) and prevent false failures.
- No behavioral changes to bring-up; Postgres remains running and healthy.
