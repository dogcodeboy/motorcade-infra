# Operations — LEADGEN_07C

Queue depth:
SELECT count(*) FROM app.intake_jobs WHERE status='queued';

Worker heartbeat:
SELECT max(updated_at) FROM app.intake_jobs WHERE status='done';
