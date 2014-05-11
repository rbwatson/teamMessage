-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 11, 2014 at 01:49 PM
-- Server version: 5.5.28-log
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `fieldteaminfo`
--
DROP DATABASE `fieldteaminfo`;
CREATE DATABASE `fieldteaminfo` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `fieldteaminfo`;

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
  FROM `teammessageroutes` AS r 
    JOIN `teamaccounts` AS a ON a.`accountId` = r.`messageFromId`
  WHERE r.`messageToId` = pUserId AND
    (r.messageReadDate IS NULL OR NOT pUnreadOnly)$$

DROP PROCEDURE IF EXISTS `GetUserWithNoPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserWithNoPassword`(IN `pUsername` VARCHAR(64))
    NO SQL
SELECT `accountId`,`username`,
	`firstName`,`lastName`,
        `displayName`,`userRole` 
   FROM `teamaccounts` 
   WHERE `username` = pUsername 
   	AND `password` IS NULL$$

DROP PROCEDURE IF EXISTS `GetUserWithPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserWithPassword`(IN `pUsername` VARCHAR(64), IN `pPassword` VARCHAR(64))
    NO SQL
SELECT `accountId`,`username`,
	`firstName`,`lastName`,
        `displayName`,`userRole` 
   FROM `teamaccounts` 
   WHERE `username` = pUsername 
   	AND `password` = pPassword$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `CreateNewSessionForUserAndGetToken`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `CreateNewSessionForUserAndGetToken`(pUserId bigint) RETURNS varchar(64) CHARSET utf8 COLLATE utf8_unicode_ci
    DETERMINISTIC
BEGIN
	DECLARE myToken VARCHAR(64);
	SELECT `sessionToken` INTO myToken FROM `teamsessions` WHERE `userId` = pUserId AND `sessionExpireTime` > NOW() ORDER BY `sessionOpenTime` DESC LIMIT 0,1;
	IF  myToken IS NOT NULL THEN
		DELETE FROM `teamsessions` WHERE `userId` = pUserId;
	END IF;
	SET myToken = UNIX_TIMESTAMP();
	INSERT INTO `teamsessions`(`sessionToken`, `userId`, `sessionOpenTime`, `sessionExpireTime`) VALUES  (myToken, pUserId, CURRENT_TIMESTAMP, DATE_ADD(NOW(), INTERVAL 4 HOUR));
	RETURN (myToken);
END$$

DROP FUNCTION IF EXISTS `IsUserLoggedIn`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `IsUserLoggedIn`(`pUserId` BIGINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE myToken VARCHAR(64);
        DECLARE answer BOOLEAN;
	SELECT `sessionToken` INTO myToken FROM `teamsessions` WHERE `userId` = pUserId AND `sessionExpireTime` > NOW() ORDER BY `sessionOpenTime` DESC LIMIT 0,1;
	IF  myToken IS NULL THEN
		SET answer = FALSE;
        ELSE
        	SET answer = TRUE;
	END IF;
	RETURN (answer);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `teamaccounts`
--

DROP TABLE IF EXISTS `teamaccounts`;
CREATE TABLE IF NOT EXISTS `teamaccounts` (
  `accountId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'unique ID of this user',
  `username` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'the username used to sign in',
  `firstName` varchar(256) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s first name',
  `lastName` varchar(256) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s last name',
  `displayName` varchar(512) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name to display in messages',
  `userRole` enum('doctor','dentist','nurse','pharmacy','translator','radio','helper','teamLead','unspecified') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unspecified' COMMENT 'User''s team role',
  `password` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Account password',
  PRIMARY KEY (`accountId`),
  UNIQUE KEY `accountId` (`accountId`),
  KEY `username` (`username`),
  KEY `userRole` (`userRole`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `teammessageroutes`
--

DROP TABLE IF EXISTS `teammessageroutes`;
CREATE TABLE IF NOT EXISTS `teammessageroutes` (
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
-- Table structure for table `teammessages`
--

DROP TABLE IF EXISTS `teammessages`;
CREATE TABLE IF NOT EXISTS `teammessages` (
  `messageId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this message',
  `creatorFromId` bigint(20) NOT NULL COMMENT 'ID of the user who created the message',
  `messageType` enum('text','radio','group') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `messageSubject` varchar(1024) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Message subject line that appears in summary feed lists',
  `messageBody` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'message body text',
  `messageDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date/time the message was received for processing',
  PRIMARY KEY (`messageId`),
  UNIQUE KEY `messageId` (`messageId`),
  KEY `creatorFromId` (`creatorFromId`),
  KEY `messageType` (`messageType`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Message database' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `teamsessions`
--

DROP TABLE IF EXISTS `teamsessions`;
CREATE TABLE IF NOT EXISTS `teamsessions` (
  `sessionId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this session',
  `sessionToken` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'session token',
  `userId` bigint(20) NOT NULL COMMENT 'User ID of this session',
  `sessionOpenTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the session started',
  `sessionExpireTime` datetime DEFAULT NULL COMMENT 'time the session expires',
  PRIMARY KEY (`sessionToken`),
  UNIQUE KEY `sessionId` (`sessionId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
