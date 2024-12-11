#!/bin/bash
set -e

# Esperar a que el servidor principal esté disponible
until psql -h postgres-primary -U admin -c '\q'; do
  >&2 echo "Esperando al servidor principal..."
  sleep 3
done

# Obtener la lista de bases de datos del servidor principal
DATABASES=$(psql -h postgres-primary -U admin -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;" | xargs)

# Crear las bases de datos en la réplica si no existen
for DB in $DATABASES; do
  if [[ "$DB" != "postgres" ]]; then
    echo "Creando base de datos: $DB en la réplica..."
    psql -U admin -c "CREATE DATABASE $DB;" || echo "La base de datos $DB ya existe."
  fi
done

echo "Inicialización de réplicas completa."
