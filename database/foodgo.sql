/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : foodgo

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2020-01-05 22:46:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customerId` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` char(20) NOT NULL,
  `lastName` char(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `addresses` json NOT NULL,
  `password` varchar(64) NOT NULL,
  `fav_food` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customers
-- ----------------------------

-- ----------------------------
-- Table structure for ingredients
-- ----------------------------
DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `ingredientId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `mealId` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ingredientId`),
  KEY `FK_MEAL` (`mealId`),
  CONSTRAINT `FK_MEAL` FOREIGN KEY (`mealId`) REFERENCES `meals` (`mealId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ingredients
-- ----------------------------

-- ----------------------------
-- Table structure for meals
-- ----------------------------
DROP TABLE IF EXISTS `meals`;
CREATE TABLE `meals` (
  `mealId` int(11) NOT NULL AUTO_INCREMENT,
  `mealName` varchar(100) DEFAULT NULL,
  `mealCategory` varchar(20) DEFAULT NULL,
  `mealImagePath` varchar(255) DEFAULT NULL,
  `meal_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mealId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of meals
-- ----------------------------

-- ----------------------------
-- Table structure for meals_restaurants
-- ----------------------------
DROP TABLE IF EXISTS `meals_restaurants`;
CREATE TABLE `meals_restaurants` (
  `mealId` int(11) NOT NULL,
  `restaurantId` int(4) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`mealId`,`restaurantId`),
  KEY `FK_RESTAURANT2` (`restaurantId`),
  CONSTRAINT `FK_MEAL2` FOREIGN KEY (`mealId`) REFERENCES `meals` (`mealId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RESTAURANT2` FOREIGN KEY (`restaurantId`) REFERENCES `restaurants` (`restaurantId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of meals_restaurants
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NOT NULL,
  `restaurantId` int(4) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `meals_ids` varchar(255) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `status` set('finished','in progress','canceled') NOT NULL DEFAULT 'in progress',
  `meal_count` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `mark` set('1','2','3','4','5') DEFAULT '3',
  PRIMARY KEY (`orderId`),
  KEY `FK_CUSTOMER` (`customerId`),
  KEY `FK_RESTAURANT` (`restaurantId`),
  CONSTRAINT `FK_CUSTOMER` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RESTAURANT` FOREIGN KEY (`restaurantId`) REFERENCES `restaurants` (`restaurantId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for restaurants
-- ----------------------------
DROP TABLE IF EXISTS `restaurants`;
CREATE TABLE `restaurants` (
  `restaurantId` int(4) NOT NULL AUTO_INCREMENT,
  `restaurantName` varchar(50) NOT NULL,
  `restaurantCategory` char(255) DEFAULT NULL,
  `address` varchar(60) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `work_time` varchar(15) DEFAULT NULL,
  `average_mark` decimal(3,2) DEFAULT NULL,
  `restaurantImagePath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`restaurantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of restaurants
-- ----------------------------