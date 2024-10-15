#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER keycloak with SUPERUSER PASSWORD 'keycloakpassword';
    CREATE DATABASE keycloak OWNER keycloak;
EOSQL
