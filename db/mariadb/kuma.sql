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

CREATE DATABASE IF NOT EXISTS  kuma;
USE kuma;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`
(
    `id`           int(11)  NOT NULL AUTO_INCREMENT,
    `name`         varchar(255) NOT NULL,
    `created_date` datetime NOT NULL,
    `public`       boolean NOT NULL,
    `active`       boolean NOT NULL,
    `weight`       boolean NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for incident
-- ----------------------------
DROP TABLE IF EXISTS `incident`;
CREATE TABLE `incident`
(
    `id`                int(11)  NOT NULL AUTO_INCREMENT,
    `title`             varchar(255) NOT NULL,
    `content`           text NOT NULL,
    `style`             varchar(30) NOT NULL default 'warning',
    `created_date`      datetime NOT NULL default NOW(),
    `last_updated_date` datetime DEFAULT NULL,
    `pin`               boolean NOT NULL default true,
    `active`            boolean NOT NULL default true,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for monitor
-- ----------------------------
DROP TABLE IF EXISTS `monitor`;
CREATE TABLE `monitor`
(
    `id`                        int(11)  NOT NULL AUTO_INCREMENT,
    `name`                      varchar(150) DEFAULT NULL,
    `active`                    boolean NOT NULL default true,
    `user_id`                   int(11)  DEFAULT NULL,
    `interval`                  int(20)  NOT NULL,
    `url`                       text DEFAULT NULL,
    `type`                      varchar(20) DEFAULT NULL,
    `weight`                    int(11)  DEFAULT NULL default 2000,
    `hostname`                  varchar(255) DEFAULT NULL,
    `port`                      int(11)  DEFAULT NULL,
    `created_date`              datetime NOT NULL default NOW(),
    `keyword`                   varchar(255) DEFAULT NULL,
    `maxretries`                int(11)  NOT NULL default 0,
    `ignore_tls`                boolean NOT NULL default false,
    `upside_down`               boolean NOT NULL default false,
    `maxredirects`              int(11)  NOT NULL default 10,
    `accepted_statuscodes_json` text NOT NULL default '["200-299"]',
    `dns_resolve_type`          varchar(5) DEFAULT NULL,
    `dns_resolve_server`        varchar(255) DEFAULT NULL,
    `dns_last_result`           varchar(255) DEFAULT NULL,
    `retry_interval`            int(11)  NOT NULL default 0,
    `push_token`                varchar(20) DEFAULT NULL,
    `method`                    text NOT NULL default 'GET',
    `body`                      text DEFAULT NULL,
    `headers`                   text DEFAULT NULL,
    `basic_auth_user`           text DEFAULT NULL,
    `basic_auth_pass`           text DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`),
    CONSTRAINT `monitor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for monitor_group
-- ----------------------------
DROP TABLE IF EXISTS `monitor_group`;
CREATE TABLE `monitor_group`
(
    `id`         int(11)  NOT NULL AUTO_INCREMENT,
    `monitor_id` int(11)  NOT NULL,
    `group_id`   int(11)  NOT NULL,
    `weight`     longblob NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk` (`monitor_id`, `group_id`),
    KEY `group_id` (`group_id`),
    CONSTRAINT `monitor_group_ibfk_1` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `monitor_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for monitor_notification
-- ----------------------------
DROP TABLE IF EXISTS `monitor_notification`;
CREATE TABLE `monitor_notification`
(
    `id`              int(11) NOT NULL,
    `monitor_id`      int(11) NOT NULL,
    `notification_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `monitor_notification_index` (`monitor_id`, `notification_id`),
    KEY `notification_id` (`notification_id`),
    CONSTRAINT `monitor_notification_ibfk_1` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `monitor_notification_ibfk_2` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for monitor_tag
-- ----------------------------
DROP TABLE IF EXISTS `monitor_tag`;
CREATE TABLE `monitor_tag`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT,
    `monitor_id` int(11) NOT NULL,
    `tag_id`     int(11) NOT NULL,
    `value`      text DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `monitor_tag_monitor_id_index` (`monitor_id`),
    KEY `monitor_tag_tag_id_index` (`tag_id`),
    CONSTRAINT `FK_monitor` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for monitor_tls_info
-- ----------------------------
DROP TABLE IF EXISTS `monitor_tls_info`;
CREATE TABLE `monitor_tls_info`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT,
    `monitor_id` int(11) NOT NULL,
    `info_json`  longtext DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`
(
    `id`         int(11)  NOT NULL AUTO_INCREMENT,
    `name`       varchar(255) DEFAULT NULL,
    `config`     varchar(255) DEFAULT NULL,
    `active`     boolean NOT NULL default true,
    `user_id`    int(11)  NOT NULL,
    `is_default` boolean NOT NULL default false,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting`
(
    `id`    int(11)  NOT NULL AUTO_INCREMENT,
    `key`   varchar(200) NOT NULL,
    `value` text DEFAULT NULL,
    `type`  varchar(20) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS `sqlite_sequence`;
CREATE TABLE `sqlite_sequence`
(
    `name` longblob DEFAULT NULL,
    `seq`  longblob DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`
(
    `id`           int(11)  NOT NULL AUTO_INCREMENT,
    `name`         varchar(255) NOT NULL,
    `color`        varchar(255) NOT NULL,
    `created_date` datetime NOT NULL default NOW(),
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `id`               int(11)  NOT NULL AUTO_INCREMENT,
    `username`         varchar(255) NOT NULL,
    `password`         varchar(255) DEFAULT NULL,
    `active`           boolean NOT NULL default true,
    `timezone`         varchar(150) DEFAULT NULL,
    `twofa_secret`     varchar(64) DEFAULT NULL,
    `twofa_status`     boolean NOT NULL default false,
    `twofa_last_token` varchar(6) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE `heartbeat`
(
    `id`         int      NOT NULL AUTO_INCREMENT,
    `important`  boolean NOT NULL,
    `monitor_id` int      NOT NULL,
    `status`     smallint      NOT NULL,
    `msg`        longtext NULL,
    `time`       DATETIME NOT NULL,
    `ping`       int      NULL,
    `duration`   int      NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `important` (`important`),
    INDEX `monitor_id` (`monitor_id`),
    INDEX `monitor_important_time_index` (`monitor_id`, `important`, `time`),
    INDEX `monitor_time_index` (`monitor_id`, `time`),
    FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE `notification_sent_history`
(
    `id`         int      NOT NULL AUTO_INCREMENT,
    `type`       varchar(50) NOT NULL,
    `monitor_id` int      NOT NULL,
    `days`       int      NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `good_index` (`type`, `monitor_id`, `days`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
