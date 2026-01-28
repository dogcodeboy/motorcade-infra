# Verification

Health:
curl http://127.0.0.1:8000/lead/health

Version:
curl http://127.0.0.1:8000/version

Expected:
{
  "service": "motorcade-leadgen-api",
  "version": "v1",
  "env": "prod",
  "git_sha": "94da1cdbfb22fb731a51944cc01a12f23e1740b7",
  "build_time": "2026-01-28T08:36:05Z"
}