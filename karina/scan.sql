-- Membuat database scan
CREATE DATABASE IF NOT EXISTS scan;
USE scan;

-- Membuat tabel siswa
CREATE TABLE IF NOT EXISTS siswa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nis VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(100) NOT NULL,
    tplahir VARCHAR(50) NOT NULL,
    tglahir DATE NOT NULL,
    kelamin VARCHAR(10) NOT NULL,
    agama VARCHAR(20) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);
