-- Crear la base de datos y algunas tablas de ejemplo
CREATE DATABASE capriccio_db;

\c capriccio_db

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO users (name, email) VALUES ('Juan', 'juan@capriccio.com');
INSERT INTO users (name, email) VALUES ('Maria', 'maria@capriccio.com');
