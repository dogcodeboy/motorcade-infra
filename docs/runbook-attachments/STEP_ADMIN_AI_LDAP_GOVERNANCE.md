# Admin AI LDAP Governance (Motorcade)

## Authority
- Admin AI is authoritative controller of LDAP.
- LDAP governs employees and company-managed devices.

## Devices
- Includes computers, phones, body cams, radios, GPS, and other endpoints.

## Account State Model
- Single persistent identity with capability flags.
- States include:
  - Active
  - Reduced Suspension (evidence-preservation)
  - Full Suspension

## Suspension Rules
- Suspension required before termination.
- Termination requires step-up auth.
- Authorized: Admin, HR, OWNER.

## Reduced Suspension
- Evidence systems continue uploading.
- Deletion disabled.
- Calls recorded with device notice.
- Texts/messages retained, deletion disabled.