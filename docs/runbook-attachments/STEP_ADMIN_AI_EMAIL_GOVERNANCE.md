# Admin AI Email Governance (Motorcade)

## Hosting
- Email is self-hosted on Motorcade-controlled infrastructure (e.g., Mailcow-class stack).
- Calendaring (CalDAV) is included for automated assessment scheduling.

## Access Model
- Employees access email only via:
  - Motorcade Employee Portal (full mailbox UI)
  - Approved desktop/mobile mail clients (protocol sync)
- No direct access to mail server UI for employees.

## Addressing
- Employee emails: firstname.lastname@motorcade.vip
- Exception: patrick@motorcade.vip (OWNER)

## Service Mailboxes
Baseline set:
legal@, compliance@, billing@, finance@, hr@, recruiting@, ops@, dispatch@, security@, it@, contracts@, vendors@motorcade.vip

## Permissions
- Permission tiers: View / Reply / Send-as
- Role-based defaults with per-user downward limits
- Owners: full control over all employee inboxes
- HR: visibility to all except OWNER inboxes

## Retention & Forensics
- Deleted emails retained beyond trash empty
- Retained data accessible to OWNER, HR, Legal
- Exports include full content, headers, timestamps, deletion attempts
- Export supported for law enforcement
- Retention details not disclosed to employees