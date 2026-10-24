-- Role dibuat oleh init/01-init.sh; password disuplai dari .env.
-- Script ini dijalankan hanya saat volume database pertama kali dibuat.
CREATE ROLE backend_dev LOGIN PASSWORD :'backend_password';
CREATE ROLE bi_dev LOGIN PASSWORD :'bi_password';
CREATE ROLE data_engineer LOGIN PASSWORD :'engineer_password';
