-- Jalankan satu per satu. Setiap INSERT berikut diharapkan GAGAL.
-- A. Primary key: identity dibuat otomatis; uji PK dengan ID yang sudah ada:
INSERT INTO SALAM.mahasiswas
(mahasiswa_id, nim, nama, email, angkatan, ipk, program_studi)
OVERRIDING SYSTEM VALUE
VALUES (1, 'PK-TEST', 'Tes Primary Key', 'pk@example.test', 2026, 3.00, 'Informatika');

-- B. UNIQUE nim duplikat (gunakan NIM yang sudah ada):
INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan, ipk, program_studi)
VALUES ('2026146001', 'Tes Duplikat', 'duplikat@example.test', 2026, 3.00, 'Informatika');

-- C. CHECK IPK di luar rentang 0.00 sampai 4.00:
INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan, ipk, program_studi)
VALUES ('CHECK-IPK', 'Tes IPK', 'check.ipk@example.test', 2026, 4.50, 'Informatika');

-- D. CHECK angkatan di luar rentang:
INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan, ipk, program_studi)
VALUES ('CHECK-ANGKATAN', 'Tes Angkatan', 'check.angkatan@example.test', 2200, 3.00, 'Informatika');
