# VERIFY — LEADGEN_07B

## Pass criteria
1) Ansible exits `failed=0`
2) `/lead/health` returns 200 and includes `db: configured`
3) `/lead/intake` returns **200/201/202/409** (NOT 422)
4) `app.leads` has **lead_rows >= 1** and `newest` is recent

## Known failure signature (expected until payload fixed)
- HTTP 422 with:
  `request.service_type` string_pattern_mismatch
