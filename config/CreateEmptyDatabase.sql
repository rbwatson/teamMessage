-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 10, 2014 at 04:09 PM
-- Server version: 5.5.28-log
-- PHP Version: 5.4.7
--
--
--	This script creates empty tables. 
--  Run testdata.sql to load the test data into the tables
--

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
DELIMITER ;

--
-- Database: `ihsclinicinfo`
--
USE ihsclinicinfo;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `GetMessagesToUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMessagesToUser`(IN `pUserId` BIGINT, IN `pUnreadOnly` BOOLEAN)
    NO SQL
SELECT 
a.`displayName` AS 'fromName',
r.`messageRouteDate` AS 'sentDate',
r.`messageReadDate` AS 'readDate',
r.`messageSubject` AS 'subject'
  FROM `ihsmessageroutes` AS r 
    JOIN `ihsaccounts` AS a ON a.`accountId` = r.`messageFromId`
  WHERE r.`messageToId` = pUserId AND
    (r.messageReadDate IS NULL OR NOT pUnreadOnly)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ihsaccounts`
--

DROP TABLE IF EXISTS `ihsaccounts`;
CREATE TABLE IF NOT EXISTS `ihsaccounts` (
  `accountId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'unique ID of this user',
  `firstName` varchar(256) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL COMMENT 'User''s first name',
  `lastName` varchar(256) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s last name',
  `displayName` varchar(512) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name to display in messages',
  `userRole` enum('doctor','dentist','nurse','pharmacy','translator','radio','helper','teamLead','unspecified') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unspecified' COMMENT 'User''s team role',
  `password` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Account password',
  PRIMARY KEY (`accountId`),
  UNIQUE KEY `accountId` (`accountId`),
  KEY `userRole` (`userRole`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ihsmessageroutes`
--

DROP TABLE IF EXISTS `ihsmessageroutes`;
CREATE TABLE IF NOT EXISTS `ihsmessageroutes` (
  `messageRouteId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of routing record',
  `messageId` bigint(20) NOT NULL COMMENT 'Message ID',
  `messageFromId` bigint(20) NOT NULL COMMENT 'User ID of message sender',
  `messageToId` bigint(20) NOT NULL COMMENT 'User ID of message recipient',
  `messageSubject` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'message heading',
  `messageRouteDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date/time the route record was written',
  `messageReadDate` datetime DEFAULT NULL COMMENT 'date/time the message was opened for the first time',
  `messageReplyDate` datetime DEFAULT NULL COMMENT 'date/time the message was replied to',
  PRIMARY KEY (`messageRouteId`),
  UNIQUE KEY `messageRouteId` (`messageRouteId`),
  KEY `messageId` (`messageId`),
  KEY `messageFromId` (`messageFromId`),
  KEY `messageToId` (`messageToId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ihsmessages`
--

DROP TABLE IF EXISTS `ihsmessages`;
CREATE TABLE IF NOT EXISTS `ihsmessages` (
  `messageId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this message',
  `creatorId` bigint(20) NOT NULL COMMENT 'ID of the user who created the message',
  `messageType` enum('text','radio','group') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `messageSubject` varchar(1024) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Message subject line that appears in summary feed lists',
  `messageBody` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'message body text',
  `messageDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date/time the message was received for processing',
  PRIMARY KEY (`messageId`),
  UNIQUE KEY `messageId` (`messageId`),
  KEY `creatorId` (`creatorId`),
  KEY `messageType` (`messageType`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Message database' AUTO_INCREMENT=1 ;
