# Auth Contract

## Phase 1 (startup)
- WordPress adapters authenticate to APIs using a **service credential** (HMAC or client credentials).
- Platform services validate requests and log request IDs.

## Phase 2 (SSO)
- Keycloak issues JWTs for human users and service accounts.
- APIs validate JWTs via JWKS.
- Roles: admin, dispatch, supervisor, recruiting, partner_admin, guard, client.

## Notes
- Prefer OIDC for apps; LDAP used for compatibility (mail, directory).
