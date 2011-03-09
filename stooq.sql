-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: autch
-- ------------------------------------------------------
-- Server version	5.1.49-3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `stooq`
--

DROP TABLE IF EXISTS `stooq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stooq` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` enum('USDKRW','KOSPI') NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `opening` decimal(10,2) NOT NULL,
  `minimum` decimal(10,2) NOT NULL,
  `maximum` decimal(10,2) NOT NULL,
  `current` decimal(10,2) NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `symbol` (`symbol`,`date`,`time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stooq_summary`
--

DROP TABLE IF EXISTS `stooq_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stooq_summary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` enum('USDKRW','KOSPI') DEFAULT NULL,
  `date` date NOT NULL,
  `opening` decimal(10,2) NOT NULL,
  `minimum` decimal(10,2) NOT NULL,
  `maximum` decimal(10,2) NOT NULL,
  `closing` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `symbol` (`symbol`,`date`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-03-09 18:07:39
