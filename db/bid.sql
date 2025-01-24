-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 24, 2025 at 12:32 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bid`
--

-- --------------------------------------------------------

--
-- Table structure for table `bidsub`
--

CREATE TABLE `bidsub` (
  `id` int(11) NOT NULL,
  `job_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `bid_amount` double DEFAULT NULL,
  `bid_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `message` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `timeline` varchar(255) DEFAULT NULL,
  `job_ends_before` date DEFAULT NULL,
  `max_cost` decimal(10,2) DEFAULT NULL,
  `min_cost` decimal(10,2) DEFAULT NULL,
  `bid_end_on` date DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `assigned_on` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_on` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('open','assigned','closed','in_progress','hold') NOT NULL DEFAULT 'open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`id`, `created_by`, `job_title`, `description`, `duration`, `timeline`, `job_ends_before`, `max_cost`, `min_cost`, `bid_end_on`, `picture`, `location`, `assigned_on`, `created_at`, `updated_on`, `status`) VALUES
(1, 2, 'Building Matrimonial Site', 'professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, disc', '6 months', '2024-11-27', '2024-11-25', '8000.00', '7000.00', '2024-11-25', NULL, 'Kolkata', '2024-10-27 10:41:00', '2024-10-27 05:11:00', '2024-10-27 10:41:00', 'open'),
(2, 3, 'Catering service for small occation', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature,', '7 days', '2024-11-06', '2024-11-06', '10000.00', '8000.00', '2024-10-30', NULL, 'Barrackpore', '2024-10-27 11:14:27', '2024-10-27 05:44:27', '2024-10-27 11:14:27', 'assigned'),
(3, 1, 'learning fourwheeler', 'On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment,', '3 months', '2024-12-27', '2025-01-31', '7600.00', '6900.00', '2024-11-15', NULL, 'Barasat', '2024-10-27 11:20:26', '2024-10-27 05:50:26', '2024-10-27 11:20:26', 'hold'),
(4, 1, 'pandal for durga puja', 'need a pandal which can accomodate thousand people and with gorgeous decoration and a stage for cultural function', '5 days', '2024-12-16', '2024-12-28', '100000.00', '90000.00', '2024-12-10', NULL, 'Kolkata', '2024-12-07 13:51:39', '2024-12-07 08:21:39', '2024-12-07 13:51:39', 'open'),
(5, 1, 'test', 'making question set ', '5days', '2024-12-10', '2024-12-09', '2000.00', '1800.00', '2024-12-08', NULL, 'Kolkata', '2024-12-07 18:28:16', '2024-12-07 12:58:16', '2024-12-07 18:28:16', 'open'),
(6, 1, 'test', 'making question set ', '5days', '2024-12-10', '2024-12-09', '2000.00', '1800.00', '2024-12-08', NULL, 'Kolkata', '2024-12-07 18:28:59', '2024-12-07 12:58:59', '2024-12-07 18:28:59', 'open'),
(7, 1, 'tgfyf', 'iuihkuh', '6 months', '2024-12-11', '2024-12-18', '1000.00', '76767.00', '2024-12-20', NULL, 'hgy', '2024-12-07 18:33:41', '2024-12-07 13:03:41', '2024-12-07 18:33:41', 'open'),
(8, 1, 'test new', 'set answers', '2 months', '2025-02-02', '2025-02-01', '5000.00', '4000.00', '2025-01-11', NULL, 'kolkata', '2024-12-30 13:27:41', '2024-12-30 07:57:41', '2024-12-30 13:27:41', 'open'),
(9, 1, 'painting', 'A painting is a two-dimensional artwork that uses paint to capture a painter\'s ideas and emotions. The medium is applied to a solid surface, or \"matrix\", with a brush, knife, sponge, or airbrush. Some common types of paint include acrylic, oil, watercolor, gouache, and encaustic. ', '5 Month', '2025-02-01', '2025-06-01', '10000.00', '8000.00', '2025-01-25', NULL, 'Barasat', '2025-01-04 15:35:29', '2025-01-04 10:05:29', '2025-01-04 15:35:29', 'open'),
(10, 1, 'Question bank ', 'The Question bank allows a teacher to create, preview and edit questions in a database and use them in the Quiz ', '6 months', '2025-02-28', '2025-02-27', '5466.00', '5000.00', '2025-01-31', NULL, 'barasat', '2025-01-14 17:09:57', '2025-01-14 11:39:57', '2025-01-14 17:09:57', 'open');

-- --------------------------------------------------------

--
-- Table structure for table `job_bid`
--

CREATE TABLE `job_bid` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `bid_amount` double NOT NULL,
  `added_on` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_on` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` enum('1','0') NOT NULL DEFAULT '1',
  `message` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_bid`
--

INSERT INTO `job_bid` (`id`, `user_id`, `job_id`, `bid_amount`, `added_on`, `updated_on`, `is_active`, `message`) VALUES
(1, 1, 1, 8700, '2024-10-28 15:32:16', '2024-10-28 15:32:16', '1', ' professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words,'),
(2, 1, 1, 699, '2024-11-13 12:40:27', '2024-11-13 12:40:27', '1', 'yyrtydtyfghyu'),
(3, 1, 1, 699, '2024-12-30 13:32:17', '2024-12-30 13:32:17', '1', 'okay'),
(4, 1, 1, 699, '2024-12-30 13:58:32', '2024-12-30 13:58:32', '1', 'yess'),
(5, 1, 1, 699, '2024-12-30 13:59:49', '2024-12-30 13:59:49', '1', 'yess'),
(6, 1, 1, 699, '2024-12-30 14:00:42', '2024-12-30 14:00:42', '1', 'yess'),
(7, 1, 2, 877, '2024-12-30 14:15:00', '2024-12-30 14:15:00', '1', 'ok'),
(8, 1, 1, 7500, '2025-01-04 12:49:54', '2025-01-04 12:49:54', '1', 'okkk'),
(9, 1, 2, 7888, '2025-01-04 15:29:22', '2025-01-04 15:29:22', '1', 'yess');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `user_name`, `email`, `password`) VALUES
(1, 'Sreyasi Dev', 'sreyasi', 'sreyasidev@gmail.com', 'dev'),
(2, 'Joy Ghosh', 'Joy Ghosh', 'joy@gmail.com', 'dev'),
(3, 'Sovan Sen', 'Sovan Sen ', 'sovan@gmail.com', 'sen'),
(4, 'Sreyasi Dev', 'sreyasi', 'sreyasidev@gmail.com', 'dev'),
(5, 'Swastika Dev', 'swastika', 'Swastika@gmail.com', 'dev'),
(6, 'Swastika Dev', 'swastika', 'Swastika@gmail.com', 'dev'),
(7, 'Sonali Dev', 'Sonali', 'sonali@gmail.com', 'sonali'),
(8, 'Anindita Gain', 'Anindita', 'anindita@gmail.com', 'gain');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bidsub`
--
ALTER TABLE `bidsub`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_bid`
--
ALTER TABLE `job_bid`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bidsub`
--
ALTER TABLE `bidsub`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `job_bid`
--
ALTER TABLE `job_bid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bidsub`
--
ALTER TABLE `bidsub`
  ADD CONSTRAINT `bidsub_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `bidsub_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `job_bid`
--
ALTER TABLE `job_bid`
  ADD CONSTRAINT `job_bid_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `job_bid_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
