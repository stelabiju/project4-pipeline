-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2023 at 06:28 AM
-- Server version: 10.1.24-MariaDB
-- PHP Version: 7.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `complaint_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-05-29 11:55:08.424839'),
(2, 'auth', '0001_initial', '2023-05-29 11:55:08.853574'),
(3, 'admin', '0001_initial', '2023-05-29 11:55:08.963612'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-05-29 11:55:08.970951'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-05-29 11:55:08.979457'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-05-29 11:55:09.063143'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-05-29 11:55:09.100005'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-05-29 11:55:09.146542'),
(9, 'auth', '0004_alter_user_username_opts', '2023-05-29 11:55:09.155272'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-05-29 11:55:09.185044'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-05-29 11:55:09.189786'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-05-29 11:55:09.196779'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-05-29 11:55:09.248843'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-05-29 11:55:09.289215'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-05-29 11:55:09.336898'),
(16, 'auth', '0011_update_proxy_permissions', '2023-05-29 11:55:09.359058'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-05-29 11:55:09.402265'),
(18, 'sessions', '0001_initial', '2023-05-29 11:55:09.445489');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('2l4616qncd2znp1mwfvrfwlhnpdq9r4w', 'e30:1q7oPv:hRrcptMj9dZQ9XdXml9SiFQm-rS73Jg_vrq47SDypww', '2023-06-24 02:33:27.059872'),
('4a0nucpe7t31pcn5wr08875ik0ly43f5', '.eJyrVsrJT8_MK0lJLUnMzFGyUkpMyc3Mc0jPBfL0kvNzlXQgIjAZpVoAy3IRew:1q9LrT:GPIFUGWUicU6Ot3Upk0M2erdqAOtysL50GLtQklwIEI', '2023-06-28 08:28:15.926844'),
('6wc0g1tpxdnar551htpxi2oo9j4jbwoj', '.eJyrVirNTFGyMtJRKs1LzE1VslJKLMkozVEoSsxS0lFKzU3MzIGJAYXyDC0tLR3SQaJ6yfm5QBWlxalFQAVgqhYAxvQZKA:1q6RvF:qbGroYJE8UnSeyVpkLQGpPsYme5t-RXQ6JQhFtfid8c', '2023-06-20 08:20:09.063789'),
('85v6epicbrczqqyhbcb9s09rw9zjyzsk', 'e30:1q3ykK:UrdK2Xx2pJ7unF-9wujzm1IuVXRcP5OdKmtlJN02tDg', '2023-06-13 12:46:40.321315'),
('a523fowflk0kvs6qkaihduydgmag1fch', '.eJyrVirNTFGyMtJRKs1LzE1VslJKLMkozVEoSsxS0lFKzU3MzIGJAYXyDC0tLR3SQaJ6yfm5QBWlxalFQAVgqhYAxvQZKA:1q9jem:HHuCssg3v6yp_gu3dMHfmDDLU8PfHxhGTazaQM36H94', '2023-06-29 09:52:44.203591'),
('fr5b581gbxtdorys478jgx8rb3u06g9n', '.eJyrVirNTFGyMtRRKs1LzE1VslJKLMkozVEoSsxS0lFKzU3MzIGJAYXyDC0tLR3SQaJ6yfm5QBWlxalFQAVgqhYAxq4ZJw:1q3cEM:TnhZY4mH9ZPrNyrqNNYmGtdIvD_3pwKPpJFm9aqBxNc', '2023-06-12 12:44:10.859427'),
('n97lxqms466s9panehlg7ev1qxki7nc7', '.eJyrVsrJT8_MK0lJLUnMzFGyUkpMyc3Mc0jPBfL0kvNzlXQgIjAZpVoAy3IRew:1q9jCj:2tjUJ1DuTFXgQXMDm5cJ-akTLGrEDEzFes9CzNDxo_Y', '2023-06-29 09:23:45.646052'),
('pjxil9qqcyr2b1arzlce7ec920bxoj2b', 'e30:1q9hW8:TcMdCDpmbo1jNiZ2BRBsGX8qA5l2NkFkQjeTbc5BP0o', '2023-06-29 07:35:40.056343'),
('r4kh0fp1u81h5oqa9c4796h6ppl35h30', '.eJyrVirNTFGyMtJRKs1LzE1VslJKLMkozVEoSsxS0lFKzU3MzIGJAYXyDC0tLR3SQaJ6yfm5QBWlxalFQAVgqhYAxvQZKA:1q4weP:a4lm1l2or2vzSsZUp01M26Td8gnYCvRW9iOqQdpls8E', '2023-06-16 04:44:33.251102'),
('ycywrs1wse6c54w8akmza8qce6qcroe4', '.eJyrVirNTFGyMtJRKs1LzE1VslJKLMkozVEoSsxS0lFKzU3MzIGJAYXyDC0tLR3SQaJ6yfm5QBWlxalFQAVgqhYAxvQZKA:1q6TU7:8BxlVRFCEsrJk4MTYH4sKItzp04kbcavB01AU943FVA', '2023-06-20 10:00:15.590288');

-- --------------------------------------------------------

--
-- Table structure for table `project4_complaintboxackadmfac`
--

CREATE TABLE `project4_complaintboxackadmfac` (
  `id` int(11) NOT NULL,
  `ackto` int(12) NOT NULL,
  `date` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `ackmesg` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project4_complaintboxackadmfac`
--

INSERT INTO `project4_complaintboxackadmfac` (`id`, `ackto`, `date`, `name`, `email`, `ackmesg`) VALUES
(12, 2, '2023-06-15', 'anusree', 'anusree@gmail.com', 'verify student');

-- --------------------------------------------------------

--
-- Table structure for table `project4_complaintboxacknowledgement`
--

CREATE TABLE `project4_complaintboxacknowledgement` (
  `id` int(12) NOT NULL,
  `replyto` int(12) NOT NULL,
  `name` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `email` varchar(200) NOT NULL,
  `ackmesg` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project4_complaintboxacknowledgement`
--

INSERT INTO `project4_complaintboxacknowledgement` (`id`, `replyto`, `name`, `date`, `email`, `ackmesg`) VALUES
(7, 2, 'Ajay Anand', '2023-06-11', 'ajayanandk666@gmail.com', 'hgn'),
(10, 3, 'Ajay Anand', '2023-06-11', 'ajayanandk666@gmail.com', 'xth'),
(12, 3, 'amalchakkara', '2023-06-14', 'amal@gmail.com', 'hello');

-- --------------------------------------------------------

--
-- Table structure for table `project4_complaintboxcomplaint`
--

CREATE TABLE `project4_complaintboxcomplaint` (
  `id` int(12) NOT NULL,
  `userid` int(12) NOT NULL,
  `complaintto` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `complaintmesg` varchar(200) NOT NULL,
  `status` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project4_complaintboxcomplaint`
--

INSERT INTO `project4_complaintboxcomplaint` (`id`, `userid`, `complaintto`, `date`, `name`, `email`, `complaintmesg`, `status`) VALUES
(10, 3, '3', '2023-06-10', 'anusree', 'anusree@gmail.com', 'tyfyjf', 'viewed'),
(11, 2, '2', '2023-06-14', 'athul raj', 'athulrajn1999@gmail.com', 'hello', 'viewed'),
(12, 3, '2', '2023-06-14', 'anusree', 'anusree@gmail.com', 'hi\r\n', 'viewed');

-- --------------------------------------------------------

--
-- Table structure for table `project4_complaintboxfaculty`
--

CREATE TABLE `project4_complaintboxfaculty` (
  `id` int(12) NOT NULL,
  `designation` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project4_complaintboxfaculty`
--

INSERT INTO `project4_complaintboxfaculty` (`id`, `designation`, `name`, `email`, `password`) VALUES
(2, 'Trainer', 'amalchakkara', 'amal@gmail.com', '1234'),
(3, 'Hod computer', 'Ajay Anand', 'ajayanandk666@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `project4_complaintboxregister`
--

CREATE TABLE `project4_complaintboxregister` (
  `id` int(12) NOT NULL,
  `image` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project4_complaintboxregister`
--

INSERT INTO `project4_complaintboxregister` (`id`, `image`, `name`, `email`, `phone`, `password`) VALUES
(2, 'athul.jpg', 'athul raj', 'athulrajn1999@gmail.com', '09388026156', '1234'),
(3, 'wallpaperflare.com_wallpaper (1).jpg', 'anusree', 'anusree@gmail.com', '01234567810', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `project4_complaintboxackadmfac`
--
ALTER TABLE `project4_complaintboxackadmfac`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project4_complaintboxacknowledgement`
--
ALTER TABLE `project4_complaintboxacknowledgement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project4_complaintboxcomplaint`
--
ALTER TABLE `project4_complaintboxcomplaint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project4_complaintboxfaculty`
--
ALTER TABLE `project4_complaintboxfaculty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project4_complaintboxregister`
--
ALTER TABLE `project4_complaintboxregister`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `project4_complaintboxacknowledgement`
--
ALTER TABLE `project4_complaintboxacknowledgement`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `project4_complaintboxcomplaint`
--
ALTER TABLE `project4_complaintboxcomplaint`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `project4_complaintboxfaculty`
--
ALTER TABLE `project4_complaintboxfaculty`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `project4_complaintboxregister`
--
ALTER TABLE `project4_complaintboxregister`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
