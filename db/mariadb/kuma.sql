/*
 Navicat Premium Data Transfer

 Source Server         : MariaDB Docker
 Source Server Type    : MariaDB
 Source Server Version : 100701
 Source Host           : localhost:3306
 Source Schema         : kuma

 Target Server Type    : MariaDB
 Target Server Version : 100701
 File Encoding         : 65001

 Date: 15/02/2022 16:29:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `created_date` longblob NOT NULL,
  `public` longblob NOT NULL,
  `active` longblob NOT NULL,
  `weight` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for incident
-- ----------------------------
DROP TABLE IF EXISTS `incident`;
CREATE TABLE `incident` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `content` longtext NOT NULL,
  `style` longtext NOT NULL,
  `created_date` longblob NOT NULL,
  `last_updated_date` longblob DEFAULT NULL,
  `pin` longblob NOT NULL,
  `active` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for monitor
-- ----------------------------
DROP TABLE IF EXISTS `monitor`;
CREATE TABLE `monitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `active` longblob NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `interval` int(11) NOT NULL,
  `url` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `hostname` longtext DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `created_date` longblob NOT NULL,
  `keyword` longtext DEFAULT NULL,
  `maxretries` int(11) NOT NULL,
  `ignore_tls` longblob NOT NULL,
  `upside_down` longblob NOT NULL,
  `maxredirects` int(11) NOT NULL,
  `accepted_statuscodes_json` longtext NOT NULL,
  `dns_resolve_type` longtext DEFAULT NULL,
  `dns_resolve_server` longtext DEFAULT NULL,
  `dns_last_result` longtext DEFAULT NULL,
  `retry_interval` int(11) NOT NULL,
  `push_token` longtext DEFAULT NULL,
  `method` longtext NOT NULL,
  `body` longtext DEFAULT NULL,
  `headers` longtext DEFAULT NULL,
  `basic_auth_user` longtext DEFAULT NULL,
  `basic_auth_pass` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `monitor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for monitor_group
-- ----------------------------
DROP TABLE IF EXISTS `monitor_group`;
CREATE TABLE `monitor_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monitor_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `weight` longblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk` (`monitor_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `monitor_group_ibfk_1` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monitor_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for monitor_notification
-- ----------------------------
DROP TABLE IF EXISTS `monitor_notification`;
CREATE TABLE `monitor_notification` (
  `id` int(11) NOT NULL,
  `monitor_id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `monitor_notification_index` (`monitor_id`,`notification_id`),
  KEY `notification_id` (`notification_id`),
  CONSTRAINT `monitor_notification_ibfk_1` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monitor_notification_ibfk_2` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for monitor_tag
-- ----------------------------
DROP TABLE IF EXISTS `monitor_tag`;
CREATE TABLE `monitor_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monitor_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `value` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `monitor_tag_monitor_id_index` (`monitor_id`),
  KEY `monitor_tag_tag_id_index` (`tag_id`),
  CONSTRAINT `FK_monitor` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for monitor_tls_info
-- ----------------------------
DROP TABLE IF EXISTS `monitor_tls_info`;
CREATE TABLE `monitor_tls_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monitor_id` int(11) NOT NULL,
  `info_json` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `config` longtext DEFAULT NULL,
  `active` longblob NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_default` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` longtext NOT NULL,
  `value` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS `sqlite_sequence`;
CREATE TABLE `sqlite_sequence` (
  `name` longblob DEFAULT NULL,
  `seq` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `color` longtext NOT NULL,
  `created_date` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` longtext NOT NULL,
  `password` longtext DEFAULT NULL,
  `active` longblob NOT NULL,
  `timezone` longtext DEFAULT NULL,
  `twofa_secret` longtext DEFAULT NULL,
  `twofa_status` longblob NOT NULL,
  `twofa_last_token` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `heartbeat`  (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `important` longblob NOT NULL,
                              `monitor_id` int NOT NULL,
                              `status` int NOT NULL,
                              `msg` longtext NULL,
                              `time` longblob NOT NULL,
                              `ping` int NULL,
                              `duration` int NOT NULL,
                              PRIMARY KEY (`id`),
                              INDEX `important`(`important`),
                              INDEX `monitor_id`(`monitor_id`),
                              INDEX `monitor_important_time_index`(`monitor_id`, `important`, `time`),
                              INDEX `monitor_time_index`(`monitor_id`, `time`),
                              FOREIGN KEY (`monitor_id`) REFERENCES `kuma`.`monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `notification_sent_history`  (
                                              `id` int NOT NULL AUTO_INCREMENT,
                                              `type` longtext NOT NULL,
                                              `monitor_id` int NOT NULL,
                                              `days` int NOT NULL,
                                              PRIMARY KEY (`id`),
                                              INDEX `good_index`(`type`, `monitor_id`, `days`)
);

SET FOREIGN_KEY_CHECKS = 1;
