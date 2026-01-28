## Root Cause

E2E test payload uses:

service_type: "armed escort"

API schema requires one of:

- armed_security
- executive_protection
- rapid_response_support
- armed_escort_driver
- armed_delivery
- event_security

Mismatch causes expected 422.
