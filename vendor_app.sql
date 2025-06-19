-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2025 at 06:34 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vendor_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategoris`
--

CREATE TABLE `kategoris` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama_kategori` varchar(100) DEFAULT NULL,
  `input_fields` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`input_fields`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategoris`
--

INSERT INTO `kategoris` (`id`, `nama_kategori`, `input_fields`, `created_at`, `updated_at`) VALUES
(1, 'ATK', '[\"nama_barang\", \"jumlah\", \"satuan\", \"ukuran\"]', '2025-05-28 13:46:00', '2025-05-29 10:10:21'),
(2, 'Kartu Nama', '[\"nama\", \"jabatan\", \"jumlah\", \"upload_gambar\"]', '2025-05-28 13:46:00', '2025-05-29 13:07:46'),
(3, 'Cleaning Service', '[\"jenis_layanan\", \"durasi\", \"catatan\"]', '2025-05-28 13:46:00', '2025-05-29 13:14:01'),
(4, 'Elektrikal', '[\"nama_peralatan\", \"jumlah\", \"lokasi_pemasangan\"]', '2025-05-28 13:46:00', '2025-05-29 13:14:26'),
(5, 'Furniture', '[\"nama_barang\", \"ukuran\", \"jumlah\", \"upload_gambar\"]', '2025-05-28 13:46:00', '2025-05-29 13:14:44'),
(6, 'Laptop', '[\"merk\", \"tipe\", \"jumlah\", \"spesifikasi\"]', '2025-05-28 13:46:00', '2025-05-29 10:10:46'),
(7, 'Printer', '[\"jenis_printer\", \"tipe\", \"jumlah\", \"metode_pengadaan\", \"upload_gambar\"]', '2025-05-28 13:46:00', '2025-05-29 10:29:26'),
(8, 'Kertas KOP', '[\"nama_perusahaan\", \"jumlah\", \"upload_gambar\"]', '2025-05-28 13:46:00', '2025-05-29 13:15:34'),
(9, 'Merchandise', '[\"nama_item\", \"jumlah\", \"warna\", \"upload_gambar\"]', '2025-05-28 13:46:00', '2025-05-29 13:15:57');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pemesanans`
--

CREATE TABLE `pemesanans` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `vendor_id` int(10) UNSIGNED NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`items`)),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemesanans`
--

INSERT INTO `pemesanans` (`id`, `user_id`, `vendor_id`, `items`, `created_at`, `updated_at`) VALUES
(11, 3, 8, '[{\"jenis_printer\":\"ApeosPort V\",\"tipe\":\"C3320\",\"jumlah\":\"1\",\"metode_pengadaan\":\"sewa\",\"upload_gambar\":[\"uploads\\/Q1xrF9nqva5In0jeUnAuMxV7JgAu4VHudrSL2Gr2.png\"]}]', '2025-06-17 19:16:10', '2025-06-17 19:16:10'),
(12, 4, 8, '[{\"jenis_printer\":\"Apeos\",\"tipe\":\"213123\",\"jumlah\":\"1\",\"metode_pengadaan\":\"sewa\",\"upload_gambar\":[\"uploads\\/BfKSAm2nGyIuCMn5BP6Jj5hD1vqcG5S1skHyOner.png\"]}]', '2025-06-17 19:24:24', '2025-06-17 19:24:24'),
(13, 3, 11, '[{\"merk\":\"Lenovo Idea Pad\",\"tipe\":\"V14\",\"jumlah\":\"2\",\"spesifikasi\":\"Ram 16GB\",\"upload_gambar\":[]}]', '2025-06-18 13:10:02', '2025-06-18 13:10:02'),
(14, 3, 11, '[{\"merk\":\"Lenovo Idea Pad\",\"tipe\":\"V14\",\"jumlah\":\"2\",\"spesifikasi\":\"Ram 16GB\",\"upload_gambar\":[]}]', '2025-06-18 13:10:35', '2025-06-18 13:10:35'),
(15, 3, 11, '[{\"merk\":\"Lenovo Idea Pad\",\"tipe\":\"V14\",\"jumlah\":\"2\",\"spesifikasi\":\"Ram 16GB\",\"upload_gambar\":[]}]', '2025-06-18 13:13:59', '2025-06-18 13:13:59'),
(16, 3, 11, '[{\"merk\":\"Lenovo Idea Pad\",\"tipe\":\"V14\",\"jumlah\":\"2\",\"spesifikasi\":\"Ram 16GB\",\"upload_gambar\":[]}]', '2025-06-18 13:14:50', '2025-06-18 13:14:50'),
(17, 3, 11, '[{\"merk\":\"Lenovo Idea Pad\",\"tipe\":\"V14\",\"jumlah\":\"2\",\"spesifikasi\":\"Ram 16GB\",\"upload_gambar\":[]}]', '2025-06-18 13:18:22', '2025-06-18 13:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksis`
--

CREATE TABLE `transaksis` (
  `id` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `vendor_id` int(10) UNSIGNED NOT NULL,
  `kategori_id` int(10) UNSIGNED NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`items`)),
  `serial_number` varchar(100) DEFAULT NULL,
  `status` enum('in_progress','done') DEFAULT 'in_progress',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksis`
--

INSERT INTO `transaksis` (`id`, `user_id`, `vendor_id`, `kategori_id`, `items`, `serial_number`, `status`, `created_at`, `updated_at`) VALUES
(11, 3, 8, 7, '[{\"jenis_printer\":\"ApeosPort V\",\"tipe\":\"C3320\",\"jumlah\":\"1\",\"metode_pengadaan\":\"sewa\",\"upload_gambar\":[\"uploads\\/Q1xrF9nqva5In0jeUnAuMxV7JgAu4VHudrSL2Gr2.png\"]}]', NULL, 'done', '2025-06-17 19:16:10', '2025-06-18 04:06:23'),
(12, 4, 9, 7, '[{\"jenis_printer\":\"ApeosPort V\",\"tipe\":\"213123\",\"jumlah\":\"1\",\"metode_pengadaan\":\"sewa\",\"upload_gambar\":[\"uploads\\/BfKSAm2nGyIuCMn5BP6Jj5hD1vqcG5S1skHyOner.png\"]}]', NULL, 'in_progress', '2025-06-17 19:24:24', '2025-06-18 13:07:49'),
(13, 3, 11, 6, '[{\"merk\":\"Lenovo Idea Pad\",\"tipe\":\"V14\",\"jumlah\":\"2\",\"spesifikasi\":\"Ram 16GB\",\"upload_gambar\":[]}]', NULL, 'in_progress', '2025-06-18 13:14:50', '2025-06-18 13:14:50'),
(14, 3, 11, 6, '[{\"merk\":\"Lenovo Idea Pad\",\"tipe\":\"V14\",\"jumlah\":\"2\",\"spesifikasi\":\"Ram 16GB\",\"upload_gambar\":[]}]', NULL, 'in_progress', '2025-06-18 13:18:22', '2025-06-18 13:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `unit_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('admin','unit') DEFAULT 'unit',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `unit_name`, `phone`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', '$2y$12$DDjVxIfedoZT84mHG3pNpu9O3m8UKIQSXTnXQ4/G20ZReTw9mSWTG', NULL, NULL, 'admin', '2025-05-28 05:03:14', '2025-05-28 12:12:06'),
(3, 'Yafi Mahadika', 'yafi.mahadika@prodiginow.com', '$2y$12$LuM8a7cnOiD2yA24QJWXDeagfzp7Z2cFKqWROZRhn/pDw6hJoMX4G', 'Proteksi Digital', '081380278631', 'unit', '2025-05-28 05:48:10', '2025-05-28 22:51:43'),
(4, 'Dimas', 'dimas@staram.com', '$2y$12$lIFm9J3HwCMMf5oBATBCuOYI2s5IUi4bKdOhBVo6xmRVxOEsNVdPS', 'Star Asset Management', '089844433', 'unit', '2025-06-17 19:18:23', '2025-06-17 19:18:23');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama_vendor` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `kontak_whatsapp` varchar(20) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `kategori_id` int(10) UNSIGNED DEFAULT NULL,
  `katalog` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `input_fields` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`input_fields`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `nama_vendor`, `email`, `kontak_whatsapp`, `alamat`, `kategori_id`, `katalog`, `created_at`, `updated_at`, `input_fields`) VALUES
(8, 'Astragraphia', 'yafi.mahadika2@gmail.com', '081380278631', 'salemba', 7, '1750187149_permintaan_custom_design.pdf', '2025-06-17 19:05:49', '2025-06-17 19:05:49', NULL),
(9, 'Galva', 'yuristian@prodiginow.com', '082134402709', 'Gajah Mada', 7, '1750230177_4-removebg-preview.png', '2025-06-18 07:02:58', '2025-06-18 14:08:14', NULL),
(11, 'Bicom', 'mentaritari253@gmail.com', '089933393939', 'Pesing', 6, '1750252141_1750187149_permintaan_custom_design (3).pdf', '2025-06-18 13:09:01', '2025-06-18 13:09:01', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `kategoris`
--
ALTER TABLE `kategoris`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pemesanans_user` (`user_id`),
  ADD KEY `fk_pemesanans_vendor` (`vendor_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `transaksis`
--
ALTER TABLE `transaksis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `kategori_id` (`kategori_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kategori_id` (`kategori_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategoris`
--
ALTER TABLE `kategoris`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pemesanans`
--
ALTER TABLE `pemesanans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaksis`
--
ALTER TABLE `transaksis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD CONSTRAINT `fk_pemesanans_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pemesanans_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaksis`
--
ALTER TABLE `transaksis`
  ADD CONSTRAINT `transaksis_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaksis_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaksis_ibfk_3` FOREIGN KEY (`kategori_id`) REFERENCES `kategoris` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendors`
--
ALTER TABLE `vendors`
  ADD CONSTRAINT `vendors_ibfk_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategoris` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
