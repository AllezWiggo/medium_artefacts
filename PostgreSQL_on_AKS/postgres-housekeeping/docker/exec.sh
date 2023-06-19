#!/bin/bash
export PGPASSWORD=$POSTGRES_PASSWORD
psql -h $POSTGRES_HOST -p $POSTGRES_PORT -d $POSTGRES_DB -w --no-password -f /scripts/postgres.sql