# UTS Manajemen Basis Data — Proyek 1

Nama proyek: Nadia | Tiga digit NIM: 146 | OS: Windows + Docker Desktop

## Port dan container
- PostgreSQL 15: container `postgres_nadia`, host port `22146`, container port `5432`.
- pgAdmin 4: container `pgadmin_nadia`, host port `44146`, container port `80`.
- pgAdmin internal connect ke host `postgres` (nama service Compose), port `5432`.
- DBeaver dari Windows connect ke `localhost:22146`.

## Persiapan
1. Install Docker Desktop dan pastikan Docker Engine berjalan.
2. Salin `.env.example` menjadi `.env`. Di PowerShell pada folder proyek, jalankan `Copy-Item .env.example .env`.
3. Buka `.env` dengan Notepad, periksa nilai-nilainya, dan pertahankan password PostgreSQL `ifunggul` sesuai soal. Password role dan pgAdmin boleh disesuaikan.
4. Pastikan file `.env` tidak di-commit ke Git.
5. Buka PowerShell pada folder proyek, jalankan:
   ```powershell
   docker compose config
   docker compose up -d
   docker compose ps
   docker compose logs postgres
   ```
6. Tunggu PostgreSQL berstatus healthy dan pgAdmin berjalan.

## Penting tentang init script
Script `init/01-init.sh` hanya dijalankan saat volume `postgres_data` pertama kali dibuat. File SQL yang dipanggil script disimpan terpisah di folder `scripts/` supaya tidak dieksekusi otomatis dua kali oleh image PostgreSQL. Jika container pernah dijalankan dengan volume lama, script tidak otomatis diulang. Untuk reset database tugas (SEMUA DATA DI VOLUME AKAN HILANG), jalankan `docker compose down -v`, kemudian `docker compose up -d`. Jangan lakukan jika ada data yang perlu disimpan.

## Koneksi pgAdmin (internal Docker)
1. Buka http://localhost:44146
2. Login menggunakan `PGADMIN_DEFAULT_EMAIL` dan `PGADMIN_DEFAULT_PASSWORD` di `.env`.
3. Register Server:
   - General > Name: `PostgreSQL Nadia`
   - Connection > Host name/address: `postgres`
   - Port: `5432`
   - Maintenance database: `postgres`
   - Username: `postgres`
   - Password: `ifunggul`
   - Save.
4. Host harus `postgres`, bukan `localhost`, karena pgAdmin berada di container terpisah.

## Koneksi DBeaver (eksternal Docker)
- Host: `localhost`
- Port: `22146`
- Database: `postgres`
- Username: `postgres`
- Password: `ifunggul`
- Klik Test Connection lalu Finish.

## Schema dan constraint
- Schema: `SALAM`
- Table: `mahasiswas`
- PK: `pk_mahasiswas`
- UNIQUE: `uq_mahasiswas_nim`, `uq_mahasiswas_email`
- CHECK: `chk_mahasiswas_angkatan`, `chk_mahasiswas_ipk`, `chk_mahasiswas_nama`
- Contoh data awal dimasukkan otomatis.

Jalankan pengujian positif dari `tests/01_positive_tests.sql`. Untuk `tests/02_constraint_tests.sql`, jalankan setiap INSERT satu per satu karena setiap pernyataan memang diharapkan gagal; setelah error, lanjutkan ke pernyataan berikutnya.

## Role dan hak akses
- `backend_dev`: CRUD pada tabel dalam schema SALAM.
- `bi_dev`: SELECT saja.
- `data_engineer`: CREATE di schema SALAM, seluruh hak tabel/sequences, serta menjadi owner schema dan tabel awal sehingga dapat ALTER/DROP objek yang dimilikinya.
- Password role diambil dari `.env` saat init pertama kali.

Uji setiap role melalui koneksi baru dengan username/password masing-masing. Hak DROP/ALTER PostgreSQL berkaitan dengan kepemilikan objek: data_engineer dapat mengelola objek yang dimilikinya; untuk objek yang dibuat role lain, kepemilikan harus dialihkan secara eksplisit.

## Troubleshooting
- Port bentrok: ubah host port pada `.env` tetapi gunakan 22146 dan 44146 untuk memenuhi soal bila tersedia.
- Login pgAdmin gagal: cek email/password `.env`.
- Role atau schema tidak terbentuk: periksa `docker compose logs postgres`. Ingat init script hanya jalan saat volume kosong.
- DBeaver gagal: cek container healthy, host `localhost`, port `22146`, dan pastikan port tersebut tidak digunakan aplikasi lain.

## Bukti screenshot yang disarankan
1. Isi folder proyek dan `.env` (sensor password saat screenshot; jangan unggah `.env`).
2. `docker compose ps` menampilkan kedua container.
3. Docker Desktop menampilkan `postgres_nadia` dan `pgadmin_nadia` running.
4. pgAdmin server tersambung dan schema SALAM / tabel mahasiswas terlihat.
5. DBeaver Test Connection berhasil.
6. Hasil SELECT data mahasiswas.
7. Error PK, UNIQUE, dan CHECK sebagai bukti constraint bekerja.
8. Pengujian login `backend_dev`, `bi_dev`, dan `data_engineer` dengan operasi yang sesuai/ditolak.
9. Repository GitHub/GitLab berisi file konfigurasi dan SQL, tanpa `.env`.

## Git
```powershell
git init
git add .
git status
git commit -m "UTS Manajemen Basis Data Proyek 1"
git branch -M main
git remote add origin https://github.com/USERNAME/REPOSITORY.git
git push -u origin main
```
Ganti URL remote dengan URL repository milik sendiri. Pastikan `.env` tidak muncul pada `git status` sebagai file yang akan di-commit.

## Struktur laporan PDF
1. Sampul: mata kuliah, judul proyek, nama, NIM (sesuai format kampus).
2. Tujuan dan perangkat: Windows, Docker Desktop, PostgreSQL 15, pgAdmin 4, DBeaver.
3. Konfigurasi: jelaskan port dan nama container; lampirkan cuplikan Compose dan `.env` yang disensor.
4. Implementasi: bukti container aktif dan koneksi internal/eksternal.
5. Schema/tabel: jelaskan kolom dan tiap constraint, lampirkan hasil uji valid dan gagal.
6. Role: tabel ringkasan hak akses dan screenshot pengujian tiap user.
7. Repository: URL GitHub/GitLab.
8. Kesimpulan: simpulkan berdasarkan hasil yang benar-benar diperoleh.

Jangan mengarang screenshot atau menyatakan pengujian berhasil sebelum benar-benar dijalankan.
