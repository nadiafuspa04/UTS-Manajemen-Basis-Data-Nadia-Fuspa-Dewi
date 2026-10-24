-- Jalankan sebagai postgres atau backend_dev di Query Tool.
-- SELECT: harus menampilkan data contoh.
SELECT * FROM SALAM.mahasiswas ORDER BY mahasiswa_id;

-- INSERT valid: harus berhasil.
INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan, ipk, program_studi)
VALUES ('2026146999', 'Uji Valid', 'uji.valid@example.test', 2026, 3.50, 'Informatika');

-- UPDATE dan DELETE: harus berhasil untuk backend_dev.
UPDATE SALAM.mahasiswas SET ipk = 3.60 WHERE nim = '2026146999';
DELETE FROM SALAM.mahasiswas WHERE nim = '2026146999';
