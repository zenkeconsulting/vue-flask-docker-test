#!/usr/bin/env bash

echo "Waiting for postgres..."

while ! nc -z db 5432; do
  sleep 0.1
done

echo "PostgreSQL started"

service nginx start
uwsgi --ini uwsgi.ini