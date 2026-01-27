# Webhooks

Define events emitted by services.

- lead.created
- lead.updated
- applicant.created
- applicant.status_changed

Each event payload must include:
- event_id
- event_type
- occurred_at
- tenant/company_id
- object_id
