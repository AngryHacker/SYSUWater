-- MySQL dump 10.13  Distrib 5.6.26, for Win32 (x86)
--
-- Host: localhost    Database: sysuwater
-- ------------------------------------------------------
-- Server version	5.6.26-log

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
-- Table structure for table `comments`
--

drop database if exists `sysuwater`;

create database `sysuwater`
	default character set utf8
	default collate utf8_general_ci;

use sysuwater;


DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `com_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content` text NOT NULL COMMENT '评论内容',
  `create_time` int(11) NOT NULL COMMENT '评论时间',
  `author_id` int(11) NOT NULL COMMENT '评论者',
  `post_id` int(11) NOT NULL COMMENT '回复帖子ID',
  PRIMARY KEY (`com_id`),
  KEY `com_ibfk_1` (`author_id`),
  KEY `com_ibfk_2` (`post_id`),
  CONSTRAINT `com_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `com_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'啊啊啊 Din君忘了排版了',1443948524,2,1),(2,'自己顶！',1443948638,2,2),(3,'求不沉',1443948653,2,2),(4,'知情人请出来一叙',1443948758,2,3),(5,'不要沉不要沉',1443948921,3,4),(6,'。。。。广告者踢',1443948944,3,1),(7,'Din 之黑程序猿第二季',1443948987,3,2),(8,'Din 君莫非还是单身？',1443949010,3,3),(9,'我就问问 DIN 君跟我们什么仇什么怨',1443949236,4,2),(10,'联想 YY8800 二手，可以转给你',1443949267,4,2),(11,'方便面没调料包',1443949291,4,6),(12,'我就呵呵',1443949306,4,3),(13,'回去再练十年吧',1443949321,4,5),(14,'求踢',1443949334,4,1),(15,'还有人看这种剧，去看越狱吧',1443949369,4,4),(16,'水一发',1443949432,5,1),(17,'水一发',1443949439,5,4),(18,'水一发',1443949449,5,2),(19,'噢 忘了问谁是良辰',1443949460,5,2),(20,'水一发',1443949468,5,5),(21,'高数同济版第365页，不谢',1443949488,5,5),(22,'水一发',1443949497,5,3),(23,'方便面没调料包',1443949510,5,6),(24,'管理员在此',1443949792,1,1),(25,'呵呵',1443949803,1,4),(26,'好黑',1443949816,1,2),(27,'加精加精',1443949829,1,5),(28,'置顶',1443949839,1,3),(29,'方便面没调料包',1443949849,1,6);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plate`
--

DROP TABLE IF EXISTS `plate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plate` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pname` varchar(32) NOT NULL COMMENT '版块名称',
  `introduction` varchar(512) DEFAULT NULL COMMENT '版块介绍',
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='论坛版块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plate`
--

LOCK TABLES `plate` WRITE;
/*!40000 ALTER TABLE `plate` DISABLE KEYS */;
INSERT INTO `plate` VALUES (1,'校园社团','校园社团'),(2,'休闲娱乐','休闲娱乐'),(3,'电脑科技','电脑科技'),(4,'学术科学','学术科学'),(5,'谈天说地','谈天说地'),(6,'体育健身','体育健身');
/*!40000 ALTER TABLE `plate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(128) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '帖子内容',
  `visit` int(11) NOT NULL DEFAULT '0' COMMENT '访问数',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `author_id` int(11) NOT NULL COMMENT '作者',
  `is_delete` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `p_id` int(11) NOT NULL COMMENT '关联版块',
  PRIMARY KEY (`post_id`),
  KEY `post_ibfk_1` (`author_id`),
  KEY `post_ibfk_2` (`p_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `plate` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='帖子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'中大青年你知多少','    中大青年经历了从平面媒体到立体媒体的转变。\r\n    从杂志到报纸，再到网络，凝聚了一代代中青人的心血。1979年，《中大青年》杂志社成立，开始编辑岭南高校第一本校园刊物——《中大青年》杂志。杂志内容丰富，贴近岭南大学生的生活，受到广泛好评。\r\n    1999年5月，《中大青年》杂志改为《中大青年》报，同时，原校团委的喉舌媒体《中大团讯》编辑部并入《中大青年》。重新组建的《中大青年》报成为新的校团委机关报，中大青年报社也因此而多次获得校团委颁授的“十佳社团”称号。《中大青年》报是中山大学唯一获得广东省新闻出版局正式刊号的报纸，这在全省高校也是首屈一指的（目前刊号已作废）。合刊后的《中大青年》报每月出版一期，坚持“自由，多元，热烈，敏锐，深入”的宗旨，立足中大，放眼全球。既贴近学生生活，报道校园动态，也关注热点时事，点评社会焦点，一直受到中山大学师生的高度关注。经过多次改版，目前《中大青年》报为四开32版，风格灵活，分为主报，研究生副刊，INSIGHT副刊。\r\n2008年，随着中山大学校区布局的调整，《中大青年》报社的总部随着学校团委的搬迁，从南校区迁移至东校区。\r\n    2009年，人人网作为当时中国最成功的SNS网络，开始受到广泛关注。有见及此，中大青年在2009年9月正式在人人网上设立普通账户，传递校园资讯，报道校园新闻。同时，中大青年决定重新打造自己的网站。2009年11月，《中大青年》报社总社正式在采编部下设立网络小组，负责人人网平台的维护及网站的建设。2010年3月，《中大青年》报社总社进行架构调整，正式成立新媒体部，全面负责各个新媒体的开发和维护工作。2010年和《青年人大》等另外三家校园媒体被中国高校媒体联盟评为“全国五星校媒”。',25,1443948480,2,0,1),(2,'各位程序猿，求笔记本推荐','Din 君最近打算入手一台 3500 左右的笔记本，各位信科软院同学求推荐啊！！\r\n\r\n良辰必有重谢！',24,1443948612,2,0,3),(3,'中大竟出现宇宙草！','无图有真相！宇宙草出没在至善园 2 号，性别男，取向不明，房号不明....捂脸',55,1443948736,2,0,5),(4,'神盾局第三季开播，你猜到剧情了吗','表示没有国版好伤心。。。。求问最后西蒙斯怎么样了....谁看到的说下剧情呗',18,1443948911,3,0,2),(5,'HTTP 中 GET 和 POST 什么区别','网上资料乱七八糟，有木有全面一点的啊？POST 会更安全吗？',23,1443949078,3,0,4),(6,'一句话告诉你马甲线怎么练','没门',23,1443949133,3,0,6);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `sex` tinyint(4) NOT NULL COMMENT '性别',
  `nickname` varchar(128) DEFAULT NULL COMMENT '昵称',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `is_admin` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否管理员',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `signature` varchar(256) DEFAULT NULL COMMENT '签名',
  `login_time` int(11) NOT NULL COMMENT '最近登录时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'root',1,'江月宗主','202cb962ac5975b964b7152d234b70',1,'root@qq.com','',1443949757),(2,'test1',1,'中大 DIN','202cb962ac5975b964b7152d234b70',0,'test1@qq.com','null',1443948386),(3,'test2',1,'我叫萌萌哒','202cb962ac5975b964b7152d234b70',0,'test2@qq.com','null',1443948840),(4,'test3',1,'攻城师','202cb962ac5975b964b7152d234b70',0,'test3@qq.com','null',1443949205),(5,'test4',1,'莫非你才是水哥','202cb962ac5975b964b7152d234b70',0,'test4@qq.com','null',1443949419);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-04 17:27:39
