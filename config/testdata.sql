-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 10, 2014 at 04:11 PM
-- Server version: 5.5.28-log
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `ihsclinicinfo`
--

--
-- Dumping data for table `ihsaccounts`
--

INSERT INTO `ihsaccounts` (`accountId`, `firstName`, `lastName`, `displayName`, `userRole`, `password`) VALUES
(1, 'Bob', 'Watson', 'Admin', 'unspecified', NULL),
(2, 'Default', 'User', 'Default', 'unspecified', NULL);

--
-- Dumping data for table `ihsmessageroutes`
--

INSERT INTO `ihsmessageroutes` (`messageRouteId`, `messageId`, `messageFromId`, `messageToId`, `messageSubject`, `messageRouteDate`, `messageReadDate`, `messageReplyDate`) VALUES
(1, 1, 1, 2, 'This is a test message', NOW(), NULL, NULL),
(2, 2, 2, 1, 'This is a test message back atacha', NOW(), NULL, NULL);
--
-- Dumping data for table `ihsmessages`
--

INSERT INTO `ihsmessages` (`messageId`, `creatorId`, `messageType`, `messageSubject`, `messageBody`, `messageDate`) VALUES
(1, 1, 'text', 'This is a test message', 'This is the first message in the message system to use for testing', NOW()),
(2, 2, 'text', 'This is a test message back atacha', 'This is the second message in the message system to use for testing', NOW());
