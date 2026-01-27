# Artifacts & Zip Deliverables

## Zips produced in this session
- `LEADGEN_CONTAINER_BUILD_ZIP.zip`
  - Adds Containerfile, .containerignore, docs/19-api/BUILD.md
- `LEADGEN_CONTAINER_BUILD_FIX_ZIP.zip`
  - Fixes Containerfile to copy requirements from `app/api/requirements.txt`
  - Adds `app/__init__.py` and `app/api/__init__.py`
- `LEADGEN_EMAIL_VALIDATOR_FIX.zip`
  - Adds `email-validator==2.2.0` to `motorcade-leadgen/app/api/requirements.txt`
  - Updates BUILD.md troubleshooting

## Outcome
- LeadGen container build definition is now correct.
- Runtime validation is deferred to EC2 deployment (PLAT_04).
