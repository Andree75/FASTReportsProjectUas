-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 22 Jan 2026 pada 11.00
-- Versi server: 10.11.13-MariaDB-0ubuntu0.24.04.1
-- Versi PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fast_reports_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `full_name`) VALUES
(1, 'admin', 'admin123', 'Super Admin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `metadata` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `urgency` varchar(20) NOT NULL DEFAULT 'Biasa',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('Pending','Diproses','Ditindak Lanjuti','Selesai','Ditolak','Ditangguhkan') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reports`
--

INSERT INTO `reports` (`id`, `user_id`, `category`, `title`, `description`, `metadata`, `image_path`, `latitude`, `longitude`, `urgency`, `created_at`, `status`) VALUES
(21, 1, 'Lainnya', 'Bencana Banjir besar', '1. pembalakan hutan liar\n2. curah hujan tinggi penyebab banjir bandang datang', '{\"jenis bahaya\":\"Banjir Bandang\",\"lokasi patokan\":\"Aceh tengah\",\"bantuan diperlukan\":\"Satgas Medis, TNI, dan Dewan Pusat\"}', 'uploads/1767868634_b0c328a0-d1ae-11f0-83cd-5b415fb0080a.jpg', 0, 0, 'Tinggi', '2026-01-08 10:37:14', 'Pending'),
(26, 1, 'Kekerasan Fisik', 'Pemukulan sepihak', 'YTTA', '{\"nama_korban\":\"Udin, Ofin, Arie\",\"jenis luka : \":\"Lebam, Memar sedang\"}', 'uploads/1767983497_linux_cam_1767983435484.jpg', 0, 0, 'Sedang', '2026-01-09 18:31:37', 'Ditindak Lanjuti'),
(27, 1, 'Judol', 'Judol Gresik', 'Parah anjay', '{\"link situs : \":\"zeusmax88\",\"rekening bandar : \":\"tidak tahu\",\"platform : \":\"Situs Judi\"}', 'uploads/1768212964_linux_cam_1768212911673.jpg', 0, 0, 'Sedang', '2026-01-12 10:16:04', 'Pending'),
(28, 1, 'Judol', 'JUDI GRESIK PART 2', 'TOLONG JANGAN TELFON POLISI YA :))))', '{\"link situs : \":\"ZUESMAXWINN88\",\"rekening bandar : \":\"098780998909\",\"platform : \":\"SITUS JUDI HARAM\"}', 'uploads/1768377673_linux_cam_1768377474814.jpg', 0, 0, 'Sedang', '2026-01-14 08:01:13', 'Ditolak'),
(31, 1, 'Pelecehan', 'Pelecehan jalan kebomas', '1.\n2.\n3.', '{\"ciri pelaku : \":\"tinggi 180, bertindi\",\"saksi\":\"tidak\"}', 'uploads/1768965254_L.jpg', 0, 0, 'DARURAT', '2026-01-21 03:14:14', 'Ditangguhkan'),
(32, 1, 'Narkoba', 'efvDSfvs', 'egfdsfvdsf', '{\"jenis obat : \":\"efefesf\",\"lokasi transaksi : \":\"eafeafeaf\"}', 'uploads/1768965336_linux_cam_1768965330942.jpg', 0, 0, 'Tinggi', '2026-01-21 03:15:36', 'Selesai'),
(33, 1, 'Judol', 'rfvreav', 'debrebr', '{\"link situs : \":\"wevrvgerv\",\"rekening bandar : \":\"reveraver\",\"platform : \":\"vdevervf\"}', 'uploads/1769008313_linux_cam_1769008302731.jpg', 0, 0, 'Sedang', '2026-01-21 15:11:53', 'Diproses');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `full_name`, `username`, `password`, `created_at`) VALUES
(1, 'andre darmawan', 'andre', '$2y$10$eYjLA9Ixr6qDAg.g2W.LNO9plfCkTRv4gKx4NCEF1aWbHa1Fw7JHS', '2026-01-08 03:26:53'),
(3, 'Steven Watanabe', 'steven1', '$2y$10$/xoYg0csmGUeuVIGg/.7E.XHrMtChfoaR82mfmenpd.S.2sC1RobC', '2026-01-20 10:01:17'),
(4, 'andri D', 'andriii', '$2y$10$a3wpjYXBoHmllclPWtiNz.QJbz7db0HmAVc4q1SwbFjEbqPOKGGOq', '2026-01-21 03:18:53');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_report` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_user_report` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
