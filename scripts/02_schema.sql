-- Database awal: postgres. Objek tugas berada di schema SALAM.
CREATE SCHEMA SALAM AUTHORIZATION data_engineer;

CREATE TABLE SALAM.mahasiswas (
    mahasiswa_id BIGINT GENERATED ALWAYS AS IDENTITY,
    nim          VARCHAR(20) NOT NULL,
    nama          VARCHAR(100) NOT NULL,
    email         VARCHAR(150) NOT NULL,
    angkatan      SMALLINT NOT NULL,
    ipk           NUMERIC(3,2) NOT NULL,
    program_studi VARCHAR(80) NOT NULL,
    CONSTRAINT pk_mahasiswas PRIMARY KEY (mahasiswa_id),
    CONSTRAINT uq_mahasiswas_nim UNIQUE (nim),
    CONSTRAINT uq_mahasiswas_email UNIQUE (email),
    CONSTRAINT chk_mahasiswas_angkatan CHECK (angkatan BETWEEN 2000 AND 2100),
    CONSTRAINT chk_mahasiswas_ipk CHECK (ipk BETWEEN 0.00 AND 4.00),
    CONSTRAINT chk_mahasiswas_nama CHECK (length(trim(nama)) >= 2)
);

ALTER TABLE SALAM.mahasiswas OWNER TO data_engineer;
ALTER SCHEMA SALAM OWNER TO data_engineer;

-- backend_dev: CRUD pada tabel saat ini dan tabel yang dibuat kemudian oleh data_engineer.
GRANT CONNECT ON DATABASE postgres TO backend_dev, bi_dev, data_engineer;
GRANT USAGE ON SCHEMA SALAM TO backend_dev, bi_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA SALAM TO backend_dev;

-- bi_dev: hanya membaca tabel/view; tidak diberi hak tulis.
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;

-- data_engineer: kelola objek dalam schema SALAM dan CRUD.
GRANT USAGE, CREATE ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA SALAM TO data_engineer;

-- Hak default untuk objek baru yang dibuat oleh data_engineer.
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA SALAM
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA SALAM
  GRANT SELECT ON TABLES TO bi_dev;
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA SALAM
  GRANT USAGE, SELECT ON SEQUENCES TO backend_dev;

-- Contoh data awal yang valid (data contoh, bukan data pribadi).
INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan, ipk, program_studi) VALUES
('2026146001', 'Alya Putri', 'alya.putri@example.test', 2026, 3.75, 'Informatika'),
('2026146002', 'Raka Pratama', 'raka.pratama@example.test', 2026, 3.42, 'Sistem Informasi'),
('2025146003', 'Dini Maharani', 'dini.maharani@example.test', 2025, 3.88, 'Informatika');
