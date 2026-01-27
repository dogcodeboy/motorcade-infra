# PURGE_CANDIDATES — motorcade-infra
Generated during cleanup. This does **not** delete anything.

Legend:
- KEEP: referenced/active
- DEPRECATE: move to deprecated/ + banner
- PURGE LATER: delete only after references removed + verified replacement

| Playbook | References | Suggested | Notes |
|---|---:|---|---|
| `plat_01_podman_base.yml` | 0 | DEPRECATE | legacy lowercase naming; 0 refs |
| `plat_01b_podman_repo_fix.yml` | 1 | KEEP | legacy lowercase naming |
| `plat_01b_podman_source_build.yml` | 1 | KEEP | legacy lowercase naming |
| `plat_01b_podman_static.yml` | 3 | KEEP | legacy lowercase naming |
| `PLAT_02A_networks_volumes_systemd_foundations.yml` | 5 | KEEP |  |
| `PLAT_02B_postgres_foundation.yml` | 7 | KEEP |  |
| `PLAT_02C_postgres_bringup.yml` | 6 | KEEP |  |
| `PLAT_03_postgres_schema_roles.yml` | 10 | KEEP |  |
| `PLAT_04_lead_intake_api.yml` | 36 | KEEP |  |
| `PLAT_04A_postgres_connectivity_ro.yml` | 4 | KEEP |  |
| `PLAT_05_nginx_reverse_proxy_leadgen_api.yml` | 9 | KEEP | nginx-related |
| `PLAT_05A_nginx_proxy_leadgen_into_motorcade_site.yml` | 2 | KEEP | nginx-related |
| `PLAT_05B_nginx_https_only_proxy_leadgen_into_ssl_vhost.yml` | 1 | KEEP | nginx-related |
| `PLAT_05C_https_only_nginx_cleanup.yml` | 1 | KEEP | nginx-related |
| `PLAT_05D_nginx_https_only_proxy_leadgen_into_ssl_vhost.yml` | 2 | KEEP | nginx-related |
| `PLAT_05E_fix_ssl_location_injection.yml` | 1 | KEEP |  |
| `PLAT_06_nginx_http80_canonical_redirect.yml` | 15 | KEEP | nginx-related |
| `PLAT_06A_nginx_http80_canonical_redirect.yml` | 12 | KEEP | nginx-related |
| `PLAT_07_nginx_http2_directive_modernize.yml` | 6 | KEEP | nginx-related |
| `PLAT_07A_nginx_http2_directive_modernize.yml` | 5 | KEEP | nginx-related |
