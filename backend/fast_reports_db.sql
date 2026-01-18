-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 18, 2026 at 03:57 PM
-- Server version: 10.11.13-MariaDB-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

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
-- Table structure for table `reports`
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
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `user_id`, `category`, `title`, `description`, `metadata`, `image_path`, `latitude`, `longitude`, `urgency`, `created_at`) VALUES
(21, 1, 'Lainnya', 'Bencana Banjir besar', '1. pembalakan hutan liar\n2. curah hujan tinggi penyebab banjir bandang datang', '{\"jenis bahaya\":\"Banjir Bandang\",\"lokasi patokan\":\"Aceh tengah\",\"bantuan diperlukan\":\"Satgas Medis, TNI, dan Dewan Pusat\"}', 'uploads/1767868634_b0c328a0-d1ae-11f0-83cd-5b415fb0080a.jpg', 0, 0, 'Tinggi', '2026-01-08 10:37:14'),
(22, 1, 'Lainnya', 'pembunuhan misterius', 'dsvawegvwrgvrwe', '{\"jenis bahaya\":\"pembunuhan\",\"lokasi patokan\":\"Kebommas\",\"bantuan diperlukan\":\"Satgas Medis\"}', 'uploads/1767949131_logo-uisi.jpg', 0, 0, 'DARURAT', '2026-01-09 08:58:51'),
(26, 1, 'Kekerasan Fisik', 'Pemukulan sepihak', 'YTTA', '{\"nama_korban\":\"Udin, Ofin, Arie\",\"jenis luka : \":\"Lebam, Memar sedang\"}', 'uploads/1767983497_linux_cam_1767983435484.jpg', 0, 0, 'Sedang', '2026-01-09 18:31:37'),
(27, 1, 'Judol', 'Judol Gresik', 'Parah anjay', '{\"link situs : \":\"zeusmax88\",\"rekening bandar : \":\"tidak tahu\",\"platform : \":\"Situs Judi\"}', 'uploads/1768212964_linux_cam_1768212911673.jpg', 0, 0, 'Sedang', '2026-01-12 10:16:04'),
(28, 1, 'Judol', 'JUDI GRESIK PART 2', 'TOLONG JANGAN TELFON POLISI YA :))))', '{\"link situs : \":\"ZUESMAXWINN88\",\"rekening bandar : \":\"098780998909\",\"platform : \":\"SITUS JUDI HARAM\"}', 'uploads/1768377673_linux_cam_1768377474814.jpg', 0, 0, 'Sedang', '2026-01-14 08:01:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `username`, `password`, `created_at`) VALUES
(1, 'andre darmawan', 'andre', '$2y$10$eYjLA9Ixr6qDAg.g2W.LNO9plfCkTRv4gKx4NCEF1aWbHa1Fw7JHS', '2026-01-08 03:26:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_report` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_user_report` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
