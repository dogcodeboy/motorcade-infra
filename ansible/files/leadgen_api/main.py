"""Motorcade LeadGen API (Wave 1)

Queue is intentionally stubbed for Wave 1.
Durability contract: /lead/intake must persist synchronously to Postgres.

Implementation note (psycopg v3): passing a Python dict directly as a parameter
may raise "cannot adapt type 'dict'". We persist JSONB by json.dumps(payload)
with an explicit ::jsonb cast.
"""

from __future__ import annotations

import json
import os
from datetime import datetime, timezone
from typing import Any, Dict, Optional

from fastapi import FastAPI, Header, HTTPException, Request
from fastapi.responses import JSONResponse

import psycopg

APP_NAME = os.getenv("LEADGEN_SERVICE_NAME", "motorcade-leadgen-api")
APP_VERSION = os.getenv("LEADGEN_SERVICE_VERSION", "wave1")
ENV_NAME = os.getenv("LEADGEN_ENV", "prod")

# Auth (Wave 1 split)
INTAKE_KEY = os.getenv("LEADGEN_INTAKE_API_KEY") or os.getenv("LEADGEN_API_KEY")

# DB
DB_HOST = os.getenv("LEADGEN_DB_HOST")
DB_PORT = os.getenv("LEADGEN_DB_PORT", "5432")
DB_NAME = os.getenv("LEADGEN_DB_NAME")
DB_USER = os.getenv("LEADGEN_DB_USER")
DB_PASSWORD = os.getenv("LEADGEN_DB_PASSWORD")
DB_SSLMODE = os.getenv("LEADGEN_DB_SSLMODE", "disable")

QUEUE_MODE = "stub"  # queue-first; real queue wiring comes later (Wave 3/4)

app = FastAPI(title=APP_NAME)


def _utc_now_iso() -> str:
    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


def _db_conninfo() -> str:
    missing = [k for k, v in {
        "LEADGEN_DB_HOST": DB_HOST,
        "LEADGEN_DB_NAME": DB_NAME,
        "LEADGEN_DB_USER": DB_USER,
        "LEADGEN_DB_PASSWORD": DB_PASSWORD,
    }.items() if not v]
    if missing:
        raise RuntimeError(f"DB not configured; missing: {', '.join(missing)}")

    # psycopg v3 uses libpq-style conninfo
    return (
        f"host={DB_HOST} port={DB_PORT} dbname={DB_NAME} user={DB_USER} "
        f"password={DB_PASSWORD} sslmode={DB_SSLMODE}"
    )


def _persist_lead(payload: Dict[str, Any]) -> int:
    """Persist the lead payload into app.leads(payload jsonb).

    IMPORTANT: psycopg does not adapt a Python dict to json automatically.
    Send a JSON string and cast to jsonb.
    """
    conninfo = _db_conninfo()
    payload_json = json.dumps(payload, separators=(",", ":"), ensure_ascii=False)

    # Keep this explicit and boring (production stable).
    with psycopg.connect(conninfo) as conn:
        conn.autocommit = True
        with conn.cursor() as cur:
            cur.execute(
                "INSERT INTO app.leads (payload) VALUES (%s::jsonb) RETURNING id",
                (payload_json,),
            )
            row = cur.fetchone()
            if not row or row[0] is None:
                raise RuntimeError("Insert returned no id")
            return int(row[0])


def _auth_guard(x_api_key: Optional[str]) -> None:
    if not INTAKE_KEY:
        # If key isn't configured, fail closed.
        raise HTTPException(status_code=503, detail={
            "status": "error",
            "error": {"code": "AUTH_NOT_CONFIGURED", "message": "API key not configured"},
        })
    if not x_api_key or x_api_key != INTAKE_KEY:
        raise HTTPException(status_code=401, detail={
            "status": "error",
            "error": {"code": "UNAUTHORIZED", "message": "Invalid API key"},
        })


@app.get("/lead/health")
async def health() -> Dict[str, Any]:
    body: Dict[str, Any] = {
        "status": "ok",
        "service": APP_NAME,
        "version": "v1",
        "queue": QUEUE_MODE,
        "time_utc": _utc_now_iso(),
    }

    # Report whether DB env is present; avoid doing a DB query in health.
    try:
        _db_conninfo()
        body["db"] = "configured"
    except Exception:
        body["db_readonly_check"] = "optional"

    return body


@app.post("/lead/intake")
async def lead_intake(
    request: Request,
    x_api_key: Optional[str] = Header(default=None, convert_underscores=False),
    idempotency_key: Optional[str] = Header(default=None, convert_underscores=False),
) -> JSONResponse:
    _auth_guard(x_api_key)

    request_id = f"req_{os.urandom(8).hex()}"

    try:
        payload: Dict[str, Any] = await request.json()
        if not isinstance(payload, dict):
            raise ValueError("payload must be a JSON object")
    except Exception as e:
        raise HTTPException(status_code=422, detail={
            "status": "error",
            "request_id": request_id,
            "error": {"code": "VALIDATION_ERROR", "message": "Invalid JSON body", "details": str(e)},
        })

    # Basic schema expectations (Wave 3 TX-only payload); keep permissive.
    # We don't reject unknown keys; we just require an email string.
    email = str(payload.get("email") or "").strip()
    if not email:
        raise HTTPException(status_code=422, detail={
            "status": "error",
            "request_id": request_id,
            "error": {"code": "VALIDATION_ERROR", "message": "Missing email"},
        })

    # Persist first (durability), then (later) queue/worker.
    try:
        lead_id = _persist_lead(payload)
    except Exception as e:
        raise HTTPException(status_code=503, detail={
            "status": "error",
            "request_id": request_id,
            "error": {"code": "DB_ERROR", "message": "Failed to persist lead", "details": str(e)},
        })

    intake_id = f"li_{os.urandom(9).hex()}"

    return JSONResponse(
        status_code=202,
        content={
            "status": "accepted",
            "intake_id": intake_id,
            "request_id": request_id,
            "received_at_utc": _utc_now_iso(),
            "lead_id": lead_id,
            "idempotency_key_present": bool(idempotency_key),
            "queue": QUEUE_MODE,
        },
    )
