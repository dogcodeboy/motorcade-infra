# ROOT_CAUSE — Why LEADGEN_07B previously failed

Two independent issues were present during earlier retries:

## 1) Wrong endpoint in manual curl tests

- `/lead` returns 404 because the API exposes **POST `/lead/intake`**.
- This is confirmed in OpenAPI (`/openapi.json`).

## 2) psycopg dict-adaptation failure during insert (503)

Error:

`cannot adapt type 'dict' using placeholder '%s' (format: AUTO)`

Meaning:

- Application was passing a Python `dict` into a SQL placeholder without a JSON adapter.
- Resolution chosen: serialize payload to JSON string and **explicitly cast** to `jsonb` in SQL (`%s::jsonb`).

## 3) Schema mismatch for E2E payload (422)

OpenAPI requires:

- `contact` (required, with `full_name`)
- `request` (required, with `service_type`, `timeline`, `location`)

Earlier payloads omitted required nested fields and used a legacy `service_type` string.

Resolution:

- Playbook E2E payload updated to match OpenAPI schema.

## 4) “Why didn’t pushing to GitHub change server immediately?”

Server builds the container image from a **git ref** defined by the playbook (`leadgen_git_ref`).
If the playbook deploys `origin/main`, but the fix is on another branch/commit, you must override:

`-e leadgen_git_ref=<commit-or-tag>`
