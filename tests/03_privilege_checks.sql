-- Periksa sebagai postgres: daftar role dan hak akses.
\du
\dp SALAM.mahasiswas

-- Uji hak akses HARUS dijalankan dengan login masing-masing user.
-- backend_dev: SELECT/INSERT/UPDATE/DELETE seharusnya berhasil.
-- bi_dev: SELECT berhasil; INSERT/UPDATE/DELETE seharusnya ditolak.
-- data_engineer: dapat CREATE tabel di SALAM dan mengelola objek miliknya.
