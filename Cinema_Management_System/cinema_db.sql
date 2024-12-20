-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2024 at 05:59 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinema_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts_tbl`
--

CREATE TABLE `accounts_tbl` (
  `id` int(11) NOT NULL,
  `userid` varchar(15) DEFAULT NULL,
  `username` varchar(500) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts_tbl`
--

INSERT INTO `accounts_tbl` (`id`, `userid`, `username`, `password`, `token`) VALUES
(2, '25', 'testusername', '12345', NULL),
(3, '26', 'Lawrencebicol', 'abc123', NULL),
(5, '1000', 'testrich', '$2y$10$MWFiNTIxYmIyOWI1MzBlZ.6cn6XoTTNo881XUf5/CTLoXwi9OGIc.', 'YmQ3NWY4MjZkMjExMTMyYTI0MzhlYTE5ZmU0NWI5YjNlMmY3YTNmZWY3MjFkYjBiYWVjYmVmNTdkZThiM2RlMA=='),
(6, '1234', 'Squidward', '$2y$10$MDIwZmUxNzNiMjk0N2ViMu9O3Q4mt0Vr2/Mx3A94pO.srqGMv1L4q', 'OTMwMTU1NDkzMGE1MWYxOGJmNDNkNjkyZWE4NzNmZWEzMTJhZjE3NmIyNmMyODE5YzU5ZjE5MzBkYzg5OWI1Zg=='),
(7, NULL, 'testusername2', '$2y$10$NWMxOThjNmQ3YzkwZTNlZOS0SI02svGnUwjaFOA1paPoBNKnnBfu2', 'MjAzMWYzMTM3NDllMDIyZTQ2NmY4ODQ2OGQ2OGQyZTcxY2ViYzc2YTdjM2FmYzU1MzlkZGIzYmU4MzA4NGQ1ZQ=='),
(8, NULL, 'Lebron', '$2y$10$MmQ1YzRmOWIzYmVhNDkzM.6NU9yalJRS.y9.rRfl9va5c11Y/wNk2', NULL),
(10, NULL, 'lance', '$2y$10$NmUwNmU1YWY1OWRkYWQwNep9M0TMYrRMWNxNMt6m3KiIgu6T0OQ/m', NULL),
(13, NULL, 'chrysler', '$2y$10$ZWQwNjhhZWViMTdiMzdmO.FYjSQ8W/NFmG8NVp/db0DJMzpuK9LUG', 'Y2VjMjU0YzNiMzA3YjVjZDYxNmQzMTBlYjhhMjczYTIxNmJiOThlMGExODhiMDYyMzU2MmQ3MjM2ZjBjM2E4Zg=='),
(14, NULL, 'TESTUSER', '$2y$10$MmM4OWRlM2U4MWUzM2UwYe5ynz3YSLR0locVqkhSuRvPpigHxVbRi', 'YTE5NTlmNmYyZTZiNDk4Mzc0NzVhM2QyMDU2MTU4ZDU2NzU3ZmY4NzA3NTRhMzNhZWU1MjA0Y2ZmOWUwZmU2Mg==');

-- --------------------------------------------------------

--
-- Table structure for table `movies_tbl`
--

CREATE TABLE `movies_tbl` (
  `id` int(11) NOT NULL,
  `name` varchar(500) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `classification` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `isdeleted` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_tbl`
--

INSERT INTO `movies_tbl` (`id`, `name`, `genre`, `classification`, `description`, `isdeleted`) VALUES
(1, 'Transformers ONE', 'Action/Comedy', 'PG', 'Optimus Prime and Megatron, as former friends, bonded like brothers. Their relationship ultimately changes Cybertron\'s fate forever.', 0),
(2, 'Jurassic World', 'Action ', 'PG', 'A new theme park, built on the original site of Jurassic Park, creates a genetically modified hybrid dinosaur, the Indominus Rex, which escapes containment and goes on a killing spree.', 0),
(3, 'Star Wars The last Jedi', 'Action/Drama', 'PG', 'A long time ago in a Galaxy far.. far away..', 1),
(5, 'Ang Egoy', 'Adventure', 'SPG', 'Ang Bicolanong egoy ay nawawala sa gubat.', 0),
(29, 'Saging ni Lawrence', 'Comedy', 'G', 'Lorem ipsum', 0),
(30, 'Muncher ni Richard', 'Action', 'PG', 'Lorem ipsum', 0),
(37, 'Indiano', 'Action', 'SPG', 'Lorem ipsum', 0);

--
-- Triggers `movies_tbl`
--
DELIMITER $$
CREATE TRIGGER `after_movie_insert` AFTER INSERT ON `movies_tbl` FOR EACH ROW BEGIN
    DECLARE seat_number INT DEFAULT 1;

    WHILE seat_number <= 50 DO
        INSERT INTO seats_tbl (movie_id, seat_number, isbooked)
        VALUES (NEW.id, seat_number, 0);
        SET seat_number = seat_number + 1;
    END WHILE;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `payments_tbl`
--

CREATE TABLE `payments_tbl` (
  `payment_id` int(11) NOT NULL,
  `movie_name` varchar(1000) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `amount_due` decimal(10,2) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `seat_number` int(11) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_status` enum('PAID') DEFAULT 'PAID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments_tbl`
--

INSERT INTO `payments_tbl` (`payment_id`, `movie_name`, `customer_name`, `amount_due`, `amount_paid`, `seat_number`, `payment_date`, `payment_status`) VALUES
(3, '', 'testrich', 500.00, 500.00, 0, '2024-12-10 01:31:23', 'PAID'),
(4, '', 'testrich', 400.00, 400.00, 0, '2024-12-10 01:33:56', 'PAID'),
(47, 'The tribal games', 'egoy', 400.00, 400.00, 0, '2024-12-10 03:53:46', 'PAID'),
(57, 'mac mahal mo na', 'Lawrence', 600.00, 600.00, 0, '2024-12-10 13:51:09', 'PAID'),
(58, 'mac mahal mo na', 'Lawrence', 600.00, 600.00, 0, '2024-12-10 13:51:14', 'PAID'),
(59, 'mac mahal mo na', 'Lawrence', 600.00, 600.00, 0, '2024-12-10 13:51:25', 'PAID'),
(60, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:07:20', 'PAID'),
(61, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:26:46', 'PAID'),
(62, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:29:08', 'PAID'),
(63, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:29:40', 'PAID'),
(64, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:31:01', 'PAID'),
(65, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:31:29', 'PAID'),
(66, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:33:00', 'PAID'),
(67, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:34:33', 'PAID'),
(68, 'Saging ni Lawrence', 'Lawrence', 400.00, 400.00, 0, '2024-12-13 02:36:22', 'PAID');

--
-- Triggers `payments_tbl`
--
DELIMITER $$
CREATE TRIGGER `revert_seat_booking` AFTER DELETE ON `payments_tbl` FOR EACH ROW BEGIN
    -- Update the isbooked status in seats_tbl to 0 when a payment is deleted
    UPDATE seats_tbl
    SET isbooked = 0
    WHERE seat_number = OLD.seat_number;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `prices_tbl`
--

CREATE TABLE `prices_tbl` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `available_seats` int(200) NOT NULL DEFAULT 50,
  `isdeleted` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prices_tbl`
--

INSERT INTO `prices_tbl` (`id`, `name`, `price`, `available_seats`, `isdeleted`) VALUES
(1, 'Transformers ONE', 600, 0, 0),
(2, 'Jurassic World', 600, 0, 0),
(3, 'Star Wars The last Jedi\r\n', 600, 0, 0),
(29, 'Saging ni Lawrence', 400, 42, 0),
(102, 'Muncher ni Richard', 600, 50, 0),
(103, 'Indiano', 700, 47, 0);

-- --------------------------------------------------------

--
-- Table structure for table `seats_tbl`
--

CREATE TABLE `seats_tbl` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `seat_number` int(11) NOT NULL,
  `isbooked` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seats_tbl`
--

INSERT INTO `seats_tbl` (`id`, `movie_id`, `seat_number`, `isbooked`) VALUES
(1, 29, 1, 1),
(2, 29, 2, 1),
(3, 29, 3, 1),
(4, 29, 4, 0),
(5, 29, 5, 1),
(6, 29, 6, 0),
(7, 29, 7, 0),
(8, 29, 8, 1),
(9, 29, 9, 1),
(10, 29, 10, 1),
(11, 29, 11, 0),
(12, 29, 12, 0),
(13, 29, 13, 0),
(14, 29, 14, 0),
(15, 29, 15, 1),
(16, 29, 16, 0),
(17, 29, 17, 0),
(18, 29, 18, 0),
(19, 29, 19, 0),
(20, 29, 20, 0),
(21, 29, 21, 0),
(22, 29, 22, 0),
(23, 29, 23, 0),
(24, 29, 24, 0),
(25, 29, 25, 0),
(26, 29, 26, 0),
(27, 29, 27, 0),
(28, 29, 28, 0),
(29, 29, 29, 1),
(30, 29, 30, 0),
(31, 29, 31, 0),
(32, 29, 32, 0),
(33, 29, 33, 0),
(34, 29, 34, 0),
(35, 29, 35, 0),
(36, 29, 36, 0),
(37, 29, 37, 0),
(38, 29, 38, 0),
(39, 29, 39, 0),
(40, 29, 40, 0),
(41, 29, 41, 0),
(42, 29, 42, 0),
(43, 29, 43, 0),
(44, 29, 44, 0),
(45, 29, 45, 0),
(46, 29, 46, 0),
(47, 29, 47, 0),
(48, 29, 48, 0),
(49, 29, 49, 0),
(50, 29, 50, 0),
(51, 30, 1, 0),
(52, 30, 2, 0),
(53, 30, 3, 0),
(54, 30, 4, 0),
(55, 30, 5, 0),
(56, 30, 6, 0),
(57, 30, 7, 0),
(58, 30, 8, 1),
(59, 30, 9, 1),
(60, 30, 10, 0),
(61, 30, 11, 0),
(62, 30, 12, 0),
(63, 30, 13, 0),
(64, 30, 14, 0),
(65, 30, 15, 0),
(66, 30, 16, 0),
(67, 30, 17, 0),
(68, 30, 18, 0),
(69, 30, 19, 0),
(70, 30, 20, 0),
(71, 30, 21, 0),
(72, 30, 22, 0),
(73, 30, 23, 0),
(74, 30, 24, 0),
(75, 30, 25, 0),
(76, 30, 26, 0),
(77, 30, 27, 0),
(78, 30, 28, 0),
(79, 30, 29, 0),
(80, 30, 30, 0),
(81, 30, 31, 0),
(82, 30, 32, 0),
(83, 30, 33, 0),
(84, 30, 34, 0),
(85, 30, 35, 0),
(86, 30, 36, 0),
(87, 30, 37, 0),
(88, 30, 38, 0),
(89, 30, 39, 0),
(90, 30, 40, 0),
(91, 30, 41, 0),
(92, 30, 42, 0),
(93, 30, 43, 0),
(94, 30, 44, 0),
(95, 30, 45, 0),
(96, 30, 46, 0),
(97, 30, 47, 0),
(98, 30, 48, 0),
(99, 30, 49, 0),
(100, 30, 50, 0),
(401, 37, 1, 0),
(402, 37, 2, 0),
(403, 37, 3, 0),
(404, 37, 4, 0),
(405, 37, 5, 0),
(406, 37, 6, 0),
(407, 37, 7, 0),
(408, 37, 8, 1),
(409, 37, 9, 1),
(410, 37, 10, 0),
(411, 37, 11, 0),
(412, 37, 12, 0),
(413, 37, 13, 0),
(414, 37, 14, 0),
(415, 37, 15, 0),
(416, 37, 16, 0),
(417, 37, 17, 0),
(418, 37, 18, 0),
(419, 37, 19, 0),
(420, 37, 20, 0),
(421, 37, 21, 0),
(422, 37, 22, 0),
(423, 37, 23, 0),
(424, 37, 24, 0),
(425, 37, 25, 0),
(426, 37, 26, 0),
(427, 37, 27, 0),
(428, 37, 28, 0),
(429, 37, 29, 0),
(430, 37, 30, 0),
(431, 37, 31, 0),
(432, 37, 32, 0),
(433, 37, 33, 0),
(434, 37, 34, 0),
(435, 37, 35, 0),
(436, 37, 36, 0),
(437, 37, 37, 0),
(438, 37, 38, 0),
(439, 37, 39, 0),
(440, 37, 40, 0),
(441, 37, 41, 0),
(442, 37, 42, 0),
(443, 37, 43, 0),
(444, 37, 44, 0),
(445, 37, 45, 0),
(446, 37, 46, 0),
(447, 37, 47, 0),
(448, 37, 48, 0),
(449, 37, 49, 0),
(450, 37, 50, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_tbl`
--
ALTER TABLE `accounts_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movies_tbl`
--
ALTER TABLE `movies_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments_tbl`
--
ALTER TABLE `payments_tbl`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `prices_tbl`
--
ALTER TABLE `prices_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seats_tbl`
--
ALTER TABLE `seats_tbl`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_tbl`
--
ALTER TABLE `accounts_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `movies_tbl`
--
ALTER TABLE `movies_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `payments_tbl`
--
ALTER TABLE `payments_tbl`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `prices_tbl`
--
ALTER TABLE `prices_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `seats_tbl`
--
ALTER TABLE `seats_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=451;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
