# Next Steps

- LEADGEN_08 (deferred): async queue + worker only when scaling requires it (prefer AWS SQS).
- If/when async is introduced, preserve the contract:
  - acceptance must remain durable (queue durability + worker persistence).
