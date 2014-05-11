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

USE `fieldteaminfo`;

--
-- Loading data for table `teamaccounts`
--

INSERT INTO `teamaccounts` (`accountId`, `username`, `firstName`, `lastName`, `displayName`, `userRole`, `password`) VALUES
(1, 'Admin', 'Admin', 'User', 'Admin', 'unspecified', NULL),
(2, 'Default', 'Default', 'User', 'Default', 'unspecified', NULL);

--
-- Loading data for table `teammessageroutes`
--

INSERT INTO `teammessageroutes` (`messageRouteId`, `messageId`, `messageFromId`, `messageToId`, `messageSubject`, `messageRouteDate`, `messageReadDate`, `messageReplyDate`) VALUES
(1, 1, 1, 2, 'This is a test message - 1', NOW(), NULL, NULL),
(2, 2, 1, 2, 'This is a test message - 2', NOW(), NULL, NULL),
(3, 3, 1, 2, 'This is a test message - 3', NOW(), NULL, NULL),
(4, 4, 1, 2, 'This is a test message - 4', NOW(), NULL, NULL),
(5, 5, 2, 1, 'This is a test message back atacha - 1', NOW(), NULL, NULL),
(6, 6, 2, 1, 'This is a test message back atacha - 2', NOW(), NULL, NULL),
(7, 7, 2, 1, 'This is a test message back atacha - 3', NOW(), NULL, NULL),
(8, 8, 2, 1, 'This is a test message back atacha - 4', NOW(), NULL, NULL),
(9, 9, 2, 1, 'This is a test message back atacha - 5', NOW(), NULL, NULL);

--
-- Loading data for table `teammessages`
--

INSERT INTO `teammessages` (`messageId`, `creatorFromId`, `messageType`, `messageSubject`, `messageBody`, `messageDate`) VALUES
(1, 1, 'text', 'This is a test message - 1', 'This is the first message (1) in the message system to use for testing', NOW()),
(2, 1, 'text', 'This is a test message - 2', 'This is the first message (2) in the message system to use for testing', NOW()),
(3, 1, 'text', 'This is a test message - 3', 'This is the first message (3) in the message system to use for testing', NOW()),
(4, 1, 'text', 'This is a test message - 4', 'This is the first message (4) in the message system to use for testing', NOW()),
(5, 2, 'text', 'This is a test message back atacha - 1', 'This is the second message (1) in the message system to use for testing', NOW()),
(6, 2, 'text', 'This is a test message back atacha - 2', 'This is the second message (2) in the message system to use for testing', NOW()),
(7, 2, 'text', 'This is a test message back atacha - 3', 'This is the second message (3) in the message system to use for testing', NOW()),
(8, 2, 'text', 'This is a test message back atacha - 4', 'This is the second message (4) in the message system to use for testing', NOW()),
(9, 2, 'text', 'This is a test message back atacha - 5', 'This is the second message (5) in the message system to use for testing', NOW());
