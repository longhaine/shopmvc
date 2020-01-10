-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2020 at 05:11 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopmvc2`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `email` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `password` varchar(5000) COLLATE utf8_vietnamese_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `address` varchar(1000) COLLATE utf8_vietnamese_ci DEFAULT '',
  `phone` varchar(100) COLLATE utf8_vietnamese_ci DEFAULT '',
  `role` int(11) DEFAULT '0',
  `verification` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `name`) VALUES
(1, 'Adidas'),
(2, 'Nike'),
(3, 'H&m');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `gender`) VALUES
(1, 'Jeans', 'both'),
(2, 'Skirts', 'women'),
(3, 'Shorts', 'both'),
(4, 'Shirts', 'men'),
(5, 'Hoodies', 'both'),
(6, 'Basics', 'both'),
(7, 'Jumpsuits', 'women'),
(8, 'Outerwear', 'both'),
(17, 'Dress', 'women');

-- --------------------------------------------------------

--
-- Table structure for table `forgot`
--

CREATE TABLE `forgot` (
  `email` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `pathinfo` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(56),
(56),
(56),
(56),
(56);

-- --------------------------------------------------------

--
-- Table structure for table `orders_detail`
--

CREATE TABLE `orders_detail` (
  `id` int(11) NOT NULL,
  `id_orders` int(11) NOT NULL,
  `id_products` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_account`
--

CREATE TABLE `order_account` (
  `id` int(11) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(1000) COLLATE utf8_vietnamese_ci NOT NULL,
  `price` float NOT NULL,
  `name` varchar(1000) COLLATE utf8_vietnamese_ci NOT NULL DEFAULT '',
  `address` varchar(5000) COLLATE utf8_vietnamese_ci NOT NULL DEFAULT '',
  `phone` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL DEFAULT '',
  `idsession` varchar(1000) COLLATE utf8_vietnamese_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `id_categories` int(11) NOT NULL,
  `price` float NOT NULL,
  `image` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8_vietnamese_ci NOT NULL,
  `id_brands` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `id_categories`, `price`, `image`, `gender`, `id_brands`) VALUES
(6, 'Jersey playsuit', 7, 18.77, 'img/h&m/Jersey playsuit', 'women', 3),
(7, 'Patterned playsuit', 7, 13.08, 'img/h&m/Patterned playsuit', 'women', 3),
(8, 'Ankle-length jumpsuit', 7, 21.83, 'img/h&m/Ankle-length jumpsuit', 'women', 3),
(9, 'Playsuit', 7, 18.77, 'img/h&m/Playsuit', 'women', 3),
(10, 'Playsuit2', 7, 13.08, 'img/h&m/Playsuit2', 'women', 3),
(11, 'Off-the-shoulder dress', 17, 13.08, 'img/h&m/Off-the-shoulder dress', 'women', 3),
(12, 'Crepe skirt', 2, 21.83, 'img/h&m/Crepe skirt', 'women', 3),
(13, 'Long wrapover skirt', 2, 18.77, 'img/h&m/Long wrapover skirt', 'women', 3),
(14, 'Skinny Regular Ankle Jeans', 1, 13.08, 'img/h&m/Skinny Regular Ankle Jeans', 'women', 3),
(15, 'Petite Fit Super Skinny Jeans', 1, 21.83, 'img/h&m/Petite Fit Super Skinny Jeans', 'women', 3),
(16, 'Modal-blend shorts', 3, 6.5, 'img/h&m/Modal-blend shorts', 'women', 3),
(17, 'Denim shorts', 3, 21.83, 'img/h&m/Denim shorts', 'women', 3),
(18, 'Sweatshirt shorts', 3, 10.87, 'img/h&m/Sweatshirt shorts', 'women', 3),
(19, 'Flannel shirt Regular Fit', 4, 30.45, 'img/h&m/Flannel shirt Regular Fit', 'men', 3),
(20, 'Short-sleeved shirt', 4, 17.15, 'img/h&m/Short-sleeved shirt', 'men', 3),
(21, 'Checked cotton flannel shirt', 4, 21.45, 'img/h&m/Checked cotton flannel shirt', 'men', 3),
(22, 'Oxford shirt Regular Fit', 4, 21.45, 'img/h&m/Oxford shirt Regular Fit', 'men', 3),
(23, 'Super Skinny Jeans', 1, 24.99, 'img/h&m/Super Skinny Jeans', 'men', 3),
(24, 'Slim Jeans', 1, 29.99, 'img/h&m/Slim Jeans', 'men', 3),
(25, 'Skinny Trashed Jeans', 1, 39.99, 'img/h&m/Skinny Trashed Jeans', 'men', 3),
(26, 'Printed Hooded Sweatshirt', 5, 29.99, 'img/h&m/Printed Hooded Sweatshirt', 'men', 3),
(27, 'Hooded Sports Shirt', 5, 39.99, 'img/h&m/Hooded Sports Shirt', 'men', 3),
(28, 'Chino Shorts', 3, 24.99, 'img/h&m/Chino Shorts', 'men', 3);

-- --------------------------------------------------------

--
-- Table structure for table `verification`
--

CREATE TABLE `verification` (
  `email` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `pathinfo` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forgot`
--
ALTER TABLE `forgot`
  ADD PRIMARY KEY (`pathinfo`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `orders_detail`
--
ALTER TABLE `orders_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_orders` (`id_orders`,`id_products`),
  ADD KEY `id_products` (`id_products`);

--
-- Indexes for table `order_account`
--
ALTER TABLE `order_account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`(255));

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_brands` (`id_brands`),
  ADD KEY `id_brands_2` (`id_brands`),
  ADD KEY `id_categories` (`id_categories`);
ALTER TABLE `product` ADD FULLTEXT KEY `name` (`name`);
ALTER TABLE `product` ADD FULLTEXT KEY `name_2` (`name`);
ALTER TABLE `product` ADD FULLTEXT KEY `name_3` (`name`);

--
-- Indexes for table `verification`
--
ALTER TABLE `verification`
  ADD PRIMARY KEY (`pathinfo`),
  ADD KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `orders_detail`
--
ALTER TABLE `orders_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `order_account`
--
ALTER TABLE `order_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `forgot`
--
ALTER TABLE `forgot`
  ADD CONSTRAINT `forgot_ibfk_1` FOREIGN KEY (`email`) REFERENCES `account` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders_detail`
--
ALTER TABLE `orders_detail`
  ADD CONSTRAINT `orders_detail_ibfk_1` FOREIGN KEY (`id_orders`) REFERENCES `order_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_detail_ibfk_2` FOREIGN KEY (`id_products`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`id_brands`) REFERENCES `brand` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`id_categories`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `verification`
--
ALTER TABLE `verification`
  ADD CONSTRAINT `verification_ibfk_1` FOREIGN KEY (`email`) REFERENCES `account` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
