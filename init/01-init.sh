#!/bin/bash
set -e

# The official PostgreSQL image runs this file only when the data volume is empty.
# Secrets are passed from .env by Docker Compose; passwords are not hardcoded here.
psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  -v backend_password="$BACKEND_DEV_PASSWORD" \
  -v bi_password="$BI_DEV_PASSWORD" \
  -v engineer_password="$DATA_ENGINEER_PASSWORD" \
  -f /scripts/01_roles.sql

psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  -f /scripts/02_schema.sql
