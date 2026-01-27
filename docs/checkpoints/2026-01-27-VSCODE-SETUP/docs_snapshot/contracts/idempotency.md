# Idempotency

All create endpoints should support an `Idempotency-Key` header.

- If the same key is received within the retention window, return the original result.
- Store request hash + response metadata for replay safety.
