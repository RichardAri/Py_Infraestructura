-- Establecer wal_level a logical
ALTER SYSTEM SET wal_level = 'logical';

-- Recargar la configuracion
SELECT pg_reload_conf();

-- Crear la publicacion para replicacion
CREATE PUBLICATION capriccio_pub FOR ALL TABLES;

-- Crear usuario de replicacion (si no existe)
DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'replicator') THEN
        CREATE USER replicator WITH REPLICATION SUPERUSER ENCRYPTED PASSWORD 'replicator_password';
    END IF;
END
$$;

-- Crear base de datos si no existe
DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'capriccio_db') THEN
        CREATE DATABASE capriccio_db;
    END IF;
END
$$;
