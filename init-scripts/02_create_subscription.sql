-- Crear la suscripción para replicar los datos desde master_a
CREATE SUBSCRIPTION capriccio_sub
CONNECTION 'dbname=capriccio_db host=postgres_master_a user=replicator password=replicator_password port=5433'
PUBLICATION capriccio_pub;
