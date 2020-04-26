SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE=NO_AUTO_VALUE_ON_ZERO */;


CREATE DATABASE /*!32312 IF NOT EXISTS*/ `redmoonoa`;
USE `redmoonoa`;
CREATE TABLE `account` (
  `name` varchar(20) NOT NULL default '',
  `userName` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`name`),
  KEY `Index_userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `address` (
  `ID` bigint(20) NOT NULL default '0',
  `PERSON` varchar(20) NOT NULL default '',
  `JOB` varchar(20) default NULL,
  `TEL` varchar(50) default NULL,
  `POSTALCODE` varchar(10) default NULL,
  `EMAIL` varchar(100) default NULL,
  `MOBILE` varchar(20) default NULL,
  `INTRODUCTION` varchar(200) default NULL,
  `ADDRESS` varchar(50) default NULL,
  `USERNAME` varchar(20) NOT NULL default '',
  `ADDDATE` datetime default NULL,
  `TYPE` bigint(20) default NULL,
  `FIRSTNAME` varchar(50) default NULL,
  `FAMILYNAME` varchar(50) default NULL,
  `MIDDLENAME` varchar(50) default NULL,
  `NICKNAME` varchar(50) default NULL,
  `STREET` varchar(50) default NULL,
  `CITY` varchar(50) default NULL,
  `PROVINCE` varchar(50) default NULL,
  `COUNTRY` varchar(50) default NULL,
  `FAX` varchar(50) default NULL,
  `COMPANYSTREET` varchar(50) default NULL,
  `COMPANYCITY` varchar(50) default NULL,
  `COMPANYPOSTCODE` varchar(50) default NULL,
  `COMPANYPROVICE` varchar(50) default NULL,
  `COMPANYCOUNTRY` varchar(50) default NULL,
  `OPERATIONWEB` varchar(50) default NULL,
  `OPERATIONPHONE` varchar(50) default NULL,
  `OPERATIONFAX` varchar(50) default NULL,
  `BEEPPAGER` varchar(50) default NULL,
  `COMPANY` varchar(50) default NULL,
  `DEPARTMENT` varchar(50) default NULL,
  `WEB` varchar(50) default NULL,
  `TYPEID` int(11) default NULL,
  `MSN` varchar(100) default NULL,
  `QQ` varchar(20) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `address_type` (
  `ID` bigint(20) NOT NULL default '0',
  `NAME` varchar(50) default NULL,
  `USER_NAME` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_assess` (
  `ID` bigint(20) NOT NULL default '0',
  `USERNAME` varchar(50) NOT NULL default '',
  `ASSESSYEAR` varchar(50) default NULL,
  `INFO` varchar(50) default NULL,
  `MYDATE` datetime default NULL,
  `RESULT` varchar(50) default NULL,
  `REMARK` varchar(50) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_assess_his` (
  `ID` bigint(20) NOT NULL default '0',
  `USERNAME` varchar(50) NOT NULL default '',
  `ASSESSYEAR` varchar(50) default NULL,
  `INFO` varchar(50) default NULL,
  `MYDATE` datetime default NULL,
  `RESULT` varchar(50) default NULL,
  `REMARK` varchar(50) default NULL,
  `OPERATOR` varchar(20) default NULL,
  `ADDDATE` datetime default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_duty` (
  `ID` bigint(20) NOT NULL default '0',
  `USERNAME` varchar(50) NOT NULL default '',
  `INFO` varchar(50) default NULL,
  `FILENUMBER` varchar(50) default NULL,
  `MYDATE` datetime default NULL,
  `DUTY` varchar(50) default NULL,
  `DEPOSAL` varchar(50) default NULL,
  `REMARK` varchar(250) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `archive_duty` (`ID`,`USERNAME`,`INFO`,`FILENUMBER`,`MYDATE`,`DUTY`,`DEPOSAL`,`REMARK`) VALUES (100,'11624617811255930823','sdfg','sdfg','2006-11-20 00:00:00','dsfg','','sdfgsdfg');
CREATE TABLE `archive_duty_his` (
  `ID` bigint(20) NOT NULL default '0',
  `USERNAME` varchar(50) NOT NULL default '',
  `INFO` varchar(50) default NULL,
  `FILENUMBER` varchar(50) default NULL,
  `MYDATE` datetime default NULL,
  `DUTY` varchar(50) default NULL,
  `DEPOSAL` varchar(50) default NULL,
  `REMARK` varchar(250) default NULL,
  `OPERATOR` varchar(20) default NULL,
  `ADDDATE` datetime default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `archive_duty_his` (`ID`,`USERNAME`,`INFO`,`FILENUMBER`,`MYDATE`,`DUTY`,`DEPOSAL`,`REMARK`,`OPERATOR`,`ADDDATE`,`OPERATETYPE`) VALUES (100,'11624617811255930823','sdfg','sdfg','2006-11-20 00:00:00','dsfg','','sdfgsdfg','admin','2006-11-02 18:08:55','创建');
CREATE TABLE `archive_family` (
  `ID` bigint(20) NOT NULL default '0',
  `APPELLATION` varchar(20) default NULL,
  `NAME` varchar(20) default NULL,
  `AGE` bigint(20) default NULL,
  `POLITIC` varchar(20) default NULL,
  `UNIT` varchar(100) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(20) default NULL,
  `ADDRESS` varchar(200) default NULL,
  `PHONE` varchar(20) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_family_his` (
  `ID` bigint(20) NOT NULL default '0',
  `APPELLATION` varchar(20) default NULL,
  `NAME` varchar(20) default NULL,
  `AGE` bigint(20) default NULL,
  `POLITIC` varchar(20) default NULL,
  `UNIT` varchar(100) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(20) default NULL,
  `ADDRESS` varchar(200) default NULL,
  `PHONE` varchar(20) default NULL,
  `OPERATOR` varchar(20) default NULL,
  `ADDDATE` datetime default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_field` (
  `ID` int(11) NOT NULL default '0',
  `FIELD_NAME` varchar(50) NOT NULL default '',
  `FIELD_CODE` varchar(50) NOT NULL default '',
  `TABLE_SHORT_CODE` varchar(50) NOT NULL default '',
  `FIELD_TYPE` varchar(50) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `archive_field` (`ID`,`FIELD_NAME`,`FIELD_CODE`,`TABLE_SHORT_CODE`,`FIELD_TYPE`) VALUES (16,'毕业院校','COLLEGE','AST','0'),(17,'毕业院校简称','SCOLLEGE','AST','0'),(18,'专业','SPECIALTY','AST','0'),(19,'专业简称','SSPECIALTY','AST','0'),(20,'是否在职','ISJOB','AST','1'),(21,'开始时间','BEGINDATE','AST','2'),(22,'结束时间','ENDDATE','AST','2'),(23,'学位','DEGREE','AST','1'),(24,'单位名称','COMPANY','ARES','0'),(25,'担任何种工作','JOB','ARES','0'),(26,'开始时间','BEGINDATE','ARES','2'),(27,'结束时间','ENDDATE','ARES','2'),(28,'离职原因','LEAVEREASON','ARES','0'),(29,'称谓','APPELLATION','AFA','1'),(30,'姓名','NAME','AFA','0'),(31,'年龄','AGE','AFA','0'),(32,'政治面貌','POLITIC','AFA','1'),(33,'工作单位','UNIT','AFA','0'),(34,'联系地址','ADDRESS','AFA','0'),(35,'联系电话','PHONE','AFA','0'),(36,'专业技术职务','PROFESSION','APR','1'),(37,'获取时间','MYDATE','APR','2'),(38,'证书编号','NUMBER','APR','0'),(39,'专长','SPECIAL','APR','0');
INSERT INTO `archive_field` (`ID`,`FIELD_NAME`,`FIELD_CODE`,`TABLE_SHORT_CODE`,`FIELD_TYPE`) VALUES (40,'证书名称','NAME','APR','0'),(41,'考核年度','ASSESSYEAR','AAS','0'),(42,'考核情况','INFO','AAS','0'),(43,'审批时间','MYDATE','AAS','2'),(44,'考核结果','RESULT','AAS','1'),(45,'何时','MYDATE','ARE','2'),(46,'何地','PLACE','ARE','0'),(47,'何种奖励','REWARDS','ARE','0'),(48,'主要事迹','REASON','ARE','0'),(49,'任免情况','INFO','ADU','0'),(50,'任职','duty','ADU','0'),(51,'免职','deposal','ADU','0'),(52,'任免时间','MYDATE','ADU','2'),(53,'任免文号','FILENUMBER','ADU','0'),(1,'真实姓名','REALNAME','AUS','0'),(2,'性别','SEX','AUS','1'),(3,'出生日期','BIRTHDAY','AUS','2'),(4,'籍贯','NATION','AUS','0'),(5,'出生地','BORN','AUS','0'),(6,'入党时间','JPARTYDATE','AUS','2'),(7,'参加工作时间','JWORKDATE','AUS','2'),(8,'健康状况','HEALTHSTATE','AUS','1'),(9,'文化程度','CULTURE','AUS','1'),(10,'后备干部级别','INSUPPORTCADRELEVEL','AUS','1'),(11,'定为后备干部的时间','INSUPPORTCADREDATE','AUS','2');
INSERT INTO `archive_field` (`ID`,`FIELD_NAME`,`FIELD_CODE`,`TABLE_SHORT_CODE`,`FIELD_TYPE`) VALUES (12,'政治面貌','POLITY','AUS','1'),(13,'其它党派加入时间','JOINCLANDATE','AUS','2'),(14,'编制情况','TYPEOFWORK','AUS','1'),(15,'学历','GRADE','AST','1'),(54,'编号','ACCOUNT','AUS','0'),(55,'在职情况','INACTIVESERVICE','AUS','1'),(56,'加入本单位时间','JDEPARTMENTDATE','AUS','2'),(57,'干部来源','CADRESSOURCE','AUS','1'),(58,'过渡时间','TRANSITIONDATE','AUS','2');
CREATE TABLE `archive_privilege` (
  `ID` int(11) NOT NULL default '0',
  `USERNAME` varchar(20) NOT NULL default '',
  `QUERY_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_profession` (
  `ID` bigint(20) NOT NULL default '0',
  `PROFESSION` varchar(50) default NULL,
  `MYDATE` datetime default NULL,
  `SPECIAL` varchar(50) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(50) NOT NULL default '',
  `NAME` varchar(50) default NULL,
  `CNUM` varchar(50) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_profession_his` (
  `ID` bigint(20) NOT NULL default '0',
  `PROFESSION` varchar(50) default NULL,
  `MYDATE` datetime default NULL,
  `SPECIAL` varchar(50) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(50) NOT NULL default '',
  `NAME` varchar(50) default NULL,
  `CNUM` varchar(50) default NULL,
  `OPERATOR` varchar(20) default NULL,
  `ADDDATE` datetime default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_query` (
  `ID` int(11) NOT NULL default '0',
  `TABLE_CODE` varchar(200) NOT NULL default '',
  `SHOW_FIELD_CODE` text NOT NULL,
  `ORDER_FIELD_CODE` varchar(200) default NULL,
  `QUERY_NAME` varchar(200) NOT NULL default '',
  `DEPT_CODE` text NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_query_condition` (
  `ID` int(11) NOT NULL default '0',
  `QUERY_ID` int(11) NOT NULL default '0',
  `CONDITION_FIELD_CODE` text NOT NULL,
  `CONDITION_SIGN` varchar(10) NOT NULL default '',
  `CONDITION_VALUE` text NOT NULL,
  `CONDITION_TYPE` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_resume` (
  `ID` bigint(20) NOT NULL default '0',
  `COMPANY` varchar(100) default NULL,
  `JOB` varchar(50) default NULL,
  `BEGINDATE` datetime default NULL,
  `ENDDATE` datetime default NULL,
  `LEAVEREASON` varchar(100) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(20) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_resume_his` (
  `ID` bigint(20) NOT NULL default '0',
  `COMPANY` varchar(100) default NULL,
  `JOB` varchar(50) default NULL,
  `BEGINDATE` datetime default NULL,
  `ENDDATE` datetime default NULL,
  `LEAVEREASON` varchar(100) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(20) default NULL,
  `OPERATOR` varchar(20) default NULL,
  `ADDDATE` datetime default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_rewards` (
  `ID` bigint(20) NOT NULL default '0',
  `MYDATE` datetime default NULL,
  `PLACE` varchar(50) default NULL,
  `REWARDS` varchar(50) default NULL,
  `REASON` varchar(50) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_rewards_his` (
  `ID` bigint(20) NOT NULL default '0',
  `MYDATE` datetime default NULL,
  `PLACE` varchar(50) default NULL,
  `REWARDS` varchar(50) default NULL,
  `REASON` varchar(50) default NULL,
  `REMARK` varchar(250) default NULL,
  `USERNAME` varchar(50) NOT NULL default '',
  `OPERATOR` varchar(20) default NULL,
  `ADDDATE` datetime default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_studyinfo` (
  `ID` bigint(20) NOT NULL default '0',
  `GRADE` varchar(50) default NULL,
  `COLLEGE` varchar(150) default NULL,
  `SCOLLEGE` varchar(50) default NULL,
  `ISJOB` varchar(10) default NULL,
  `REMARK` varchar(250) default NULL,
  `SPECIALTY` varchar(50) default NULL,
  `SSPECIALTY` varchar(50) default NULL,
  `BEGINDATE` datetime default NULL,
  `ENDDATE` datetime default NULL,
  `DEGREE` varchar(50) default NULL,
  `USERNAME` varchar(20) default NULL,
  `ISMOSTGRADE` char(1) default NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `ARCHIVE_STUDYINFO_INDEX` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_studyinfo_his` (
  `ID` bigint(20) NOT NULL default '0',
  `GRADE` varchar(50) default NULL,
  `COLLEGE` varchar(150) default NULL,
  `SCOLLEGE` varchar(50) default NULL,
  `ISJOB` varchar(10) default NULL,
  `REMARK` varchar(250) default NULL,
  `SPECIALTY` varchar(50) default NULL,
  `SSPECIALTY` varchar(50) default NULL,
  `BEGINDATE` datetime default NULL,
  `ENDDATE` datetime default NULL,
  `DEGREE` varchar(50) default NULL,
  `USERNAME` varchar(20) default NULL,
  `OPERATOR` varchar(20) default NULL,
  `ADDDATE` datetime default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `archive_table` (
  `TABLE_SHORT_CODE` varchar(50) NOT NULL default '',
  `TABLE_CODE` varchar(50) NOT NULL default '',
  `TABLE_DESCRIPTION` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`TABLE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `archive_table` (`TABLE_SHORT_CODE`,`TABLE_CODE`,`TABLE_DESCRIPTION`) VALUES ('AAS','ARCHIVE_ASSESS','考核'),('ADU','ARCHIVE_DUTY','任免'),('AFA','ARCHIVE_FAMILY','家庭'),('APR','ARCHIVE_PROFESSION','专业技能'),('ARES','ARCHIVE_RESUME','履历'),('ARE','ARCHIVE_REWARDS','奖励'),('AST','ARCHIVE_STUDYINFO','教育'),('AUS','ARCHIVE_USER','用户');
CREATE TABLE `archive_user` (
  `USERNAME` varchar(20) NOT NULL default '',
  `SEX` varchar(10) default 'NULL',
  `BIRTHDAY` datetime default NULL,
  `NATION` varchar(50) default 'NULL',
  `BORN` varchar(250) default 'NULL',
  `JPARTYDATE` datetime default NULL,
  `JWORKDATE` datetime default NULL,
  `HEALTHSTATE` varchar(50) default 'NULL',
  `REMARK` varchar(250) default 'NULL',
  `CULTURE` varchar(20) default 'NULL',
  `INSUPPORTCADRELEVEL` varchar(50) default 'NULL',
  `INSUPPORTCADREDATE` datetime default NULL,
  `POLITY` varchar(20) default 'NULL',
  `JOINCLANDATE` datetime default NULL,
  `TYPEOFWORK` varchar(50) default 'NULL',
  `REALNAME` varchar(20) default 'NULL',
  `IMAGE` varchar(250) default 'NULL',
  `JDEPARTMENTDATE` datetime default NULL,
  `INACTIVESERVICE` varchar(20) default 'NULL',
  `CADRESSOURCE` varchar(20) default 'NULL',
  `TRANSITIONDATE` datetime default NULL,
  `DEPTCODE` varchar(50) default 'NULL',
  `ACCOUNT` varchar(20) default 'NULL\\n',
  `PEOPLE` varchar(50) default NULL,
  `MOSTGRADE` varchar(50) default NULL,
  PRIMARY KEY  (`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `archive_user` (`USERNAME`,`SEX`,`BIRTHDAY`,`NATION`,`BORN`,`JPARTYDATE`,`JWORKDATE`,`HEALTHSTATE`,`REMARK`,`CULTURE`,`INSUPPORTCADRELEVEL`,`INSUPPORTCADREDATE`,`POLITY`,`JOINCLANDATE`,`TYPEOFWORK`,`REALNAME`,`IMAGE`,`JDEPARTMENTDATE`,`INACTIVESERVICE`,`CADRESSOURCE`,`TRANSITIONDATE`,`DEPTCODE`,`ACCOUNT`,`PEOPLE`,`MOSTGRADE`) VALUES ('11605225628431810865','男',NULL,'dd','dd',NULL,NULL,'亚健康','','小学','科长',NULL,'团员',NULL,'行政','dd','',NULL,'','招考',NULL,'2deputyzjl','dd',NULL,NULL),('11624617811255930823','男',NULL,'asdf','sadf',NULL,NULL,'','sadfsafd','小学','科长',NULL,'团员',NULL,'行政','sdfasdf','',NULL,'','招考',NULL,'2deputyzjl','0',NULL,'专科');
CREATE TABLE `archive_user_his` (
  `USERNAME` varchar(20) NOT NULL default '',
  `SEX` varchar(10) default NULL,
  `BIRTHDAY` datetime default NULL,
  `NATION` varchar(50) default NULL,
  `BORN` varchar(250) default NULL,
  `JPARTYDATE` datetime default NULL,
  `JWORKDATE` datetime default NULL,
  `HEALTHSTATE` varchar(50) default NULL,
  `REMARK` varchar(250) default NULL,
  `CULTURE` varchar(20) default NULL,
  `INSUPPORTCADRELEVEL` varchar(50) default NULL,
  `INSUPPORTCADREDATE` datetime default NULL,
  `POLITY` varchar(20) default NULL,
  `JOINCLANDATE` datetime default NULL,
  `TYPEOFWORK` varchar(50) default NULL,
  `REALNAME` varchar(20) default NULL,
  `IMAGE` varchar(250) default NULL,
  `JDEPARTMENTDATE` datetime default NULL,
  `INACTIVESERVICE` varchar(20) default NULL,
  `OPERATOR` varchar(20) NOT NULL default '',
  `ADDDATE` datetime NOT NULL default '0000-00-00 00:00:00',
  `ID` int(11) NOT NULL default '0',
  `CADRESSOURCE` varchar(20) default NULL,
  `TRANSITIONDATE` datetime default NULL,
  `DEPTCODE` varchar(50) default NULL,
  `ACCOUNT` varchar(20) default NULL,
  `OPERATETYPE` varchar(10) default NULL,
  `PEOPLE` varchar(50) default NULL,
  `MOSTGRADE` varchar(50) default NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `ARCHIVE_USER_HIS_INDEX` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `archive_user_his` (`USERNAME`,`SEX`,`BIRTHDAY`,`NATION`,`BORN`,`JPARTYDATE`,`JWORKDATE`,`HEALTHSTATE`,`REMARK`,`CULTURE`,`INSUPPORTCADRELEVEL`,`INSUPPORTCADREDATE`,`POLITY`,`JOINCLANDATE`,`TYPEOFWORK`,`REALNAME`,`IMAGE`,`JDEPARTMENTDATE`,`INACTIVESERVICE`,`OPERATOR`,`ADDDATE`,`ID`,`CADRESSOURCE`,`TRANSITIONDATE`,`DEPTCODE`,`ACCOUNT`,`OPERATETYPE`,`PEOPLE`,`MOSTGRADE`) VALUES ('11605225628431810865','男',NULL,'dd','dd',NULL,NULL,'亚健康','','小学','科长',NULL,'团员',NULL,'行政','dd',NULL,NULL,'','admin','2006-10-11 07:22:50',0,'招考',NULL,'2deputyzjl','dd','创建',NULL,NULL),('11624617811255930823','男',NULL,'asdf','sadf',NULL,NULL,'','sadfsafd','小学','科长',NULL,'团员',NULL,'行政','sdfasdf',NULL,NULL,'','admin','2006-11-02 18:07:50',100,'招考',NULL,'2deputyzjl','0','创建',NULL,'专科'),('11624617811255930823','男',NULL,'asdf','sadf',NULL,NULL,'','sadfsafd','小学','科长',NULL,'团员',NULL,'行政','sdfasdf',NULL,NULL,'','admin','2006-11-02 18:08:42',101,'招考',NULL,'2deputyzjl','0','修改',NULL,'专科');
CREATE TABLE `asset_info` (
  `Id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `type` varchar(50) default NULL,
  `number` varchar(11) default NULL,
  `typeId` int(11) default NULL,
  `addId` varchar(50) default NULL,
  `department` varchar(50) default NULL,
  `buyMan` varchar(50) default NULL,
  `buyDate` date default NULL,
  `keeper` varchar(50) default NULL,
  `startDate` date default NULL,
  `regDate` date default NULL,
  `abstracts` varchar(250) default NULL,
  `inputMan` varchar(50) default NULL,
  `price` double(20,2) default NULL,
  PRIMARY KEY  (`Id`),
  KEY `name` (`name`),
  KEY `typeId` (`typeId`),
  KEY `number` (`number`),
  KEY `name_number_typeId` (`name`,`number`,`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `asset_type_info` (
  `Id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `depreciationRate` varchar(50) default NULL,
  `depreciationYears` int(11) default NULL,
  `abstracts` varchar(250) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `basic_rank` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `basic_rank` (`code`,`name`,`orders`) VALUES ('11580656594533619880','科长',3),('11580659369536582571','总经理',1),('11580659437962752738','副总经理',2),('11580660647349840180','股长',4);
CREATE TABLE `blog` (
  `id` int(11) NOT NULL default '0',
  `blogCount` int(11) NOT NULL default '0',
  `newBlogUserName` varchar(20) default NULL,
  `topicCount` int(11) NOT NULL default '0',
  `postCount` int(11) NOT NULL default '0',
  `todayCount` int(11) NOT NULL default '0',
  `todayDate` varchar(15) NOT NULL default '0',
  `yestodayCount` int(11) NOT NULL default '0',
  `maxCount` int(11) NOT NULL default '0',
  `maxDate` varchar(15) NOT NULL default '0',
  `star` varchar(20) default NULL,
  `homeClasses` varchar(255) default NULL,
  `recommandBlogs` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `blog` (`id`,`blogCount`,`newBlogUserName`,`topicCount`,`postCount`,`todayCount`,`todayDate`,`yestodayCount`,`maxCount`,`maxDate`,`star`,`homeClasses`,`recommandBlogs`) VALUES (1,0,'',0,0,0,'0',0,0,'0','','wx,cx','');
CREATE TABLE `blog_directory` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '' COMMENT 'not used',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default '0',
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  `doc_id` int(11) default NULL,
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(50) NOT NULL default 'N''default''',
  `add_date` varchar(15) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `blog_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`add_date`) VALUES ('c','c语言',0,'','cx','root',1,0,NULL,2,3,NULL,-1,'default','0'),('cx','程序',0,'','root','root',2,2,NULL,0,2,0,-1,'default','0'),('java','JAVA语言',0,'','cx','root',2,0,NULL,2,3,0,-1,'default','0'),('root','全部目录',1,NULL,'-1','root',1,2,NULL,0,1,NULL,-1,'default','0'),('sg','诗歌',0,'','wx','root',3,0,NULL,2,3,NULL,-1,'N\'default\'','0'),('sw','散文',0,'','wx','root',2,0,NULL,2,3,NULL,-1,'N\'default\'','0'),('wx','文学',0,'','root','root',1,3,NULL,0,2,0,-1,'default','0'),('xiaoshuo','小说',0,'','wx','root',1,0,NULL,2,3,NULL,-1,'default','0');
CREATE TABLE `blog_user_config` (
  `userName` varchar(50) NOT NULL default '',
  `title` varchar(50) NOT NULL default '',
  `subtitle` varchar(50) default NULL,
  `penName` varchar(50) NOT NULL default '',
  `skin` varchar(50) NOT NULL default 'default',
  `notice` varchar(255) NOT NULL default '',
  `isValid` tinyint(1) NOT NULL default '1',
  `viewCount` int(11) NOT NULL default '0',
  `msgCount` int(11) NOT NULL default '0',
  `replyCount` int(11) NOT NULL default '0',
  `kind` varchar(50) NOT NULL default '',
  `addDate` varchar(15) NOT NULL default '0',
  PRIMARY KEY  (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blog_user_dir` (
  `code` varchar(50) NOT NULL default '',
  `userName` varchar(50) NOT NULL default '',
  `dirName` varchar(250) NOT NULL default '',
  `catalogCode` varchar(50) NOT NULL default 'N''default''',
  `sort` int(11) NOT NULL default '0',
  `color` varchar(20) default NULL,
  `addDate` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `boardroom` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL default '',
  `personNum` varchar(3) NOT NULL default '',
  `description` varchar(67) default NULL,
  `address` varchar(17) default NULL,
  `equipment` varchar(17) default NULL,
  `mydate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` USING BTREE (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `boardroom_used_status` (
  `Id` int(11) NOT NULL auto_increment,
  `boardroomId` int(11) NOT NULL default '0',
  `flowId` int(11) default NULL,
  `applyUserName` varchar(20) default NULL,
  `checkUserName` varchar(20) default NULL,
  `beginDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `endDate` datetime default NULL,
  `topic` varchar(250) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `book` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `deptCode` varchar(33) default NULL,
  `bookName` varchar(66) NOT NULL default '',
  `typeId` int(10) unsigned default NULL,
  `author` varchar(66) default NULL,
  `bookNum` varchar(66) NOT NULL default '',
  `pubHouse` varchar(66) default NULL,
  `pubDate` date NOT NULL default '0000-00-00',
  `keepSite` varchar(16) default NULL,
  `price` double(10,2) default NULL,
  `abstracts` varchar(66) default NULL,
  `borrowRange` varchar(66) default NULL,
  `borrowState` tinyint(1) default NULL,
  `brief` varchar(66) default NULL,
  `borrowPerson` varchar(66) default NULL,
  `beginDate` date default NULL,
  `endDate` date default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `book_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(150) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cms_comment` (
  `id` int(11) NOT NULL auto_increment,
  `content` text NOT NULL,
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `doc_id` int(11) NOT NULL default '0',
  `ip` varchar(15) NOT NULL default '',
  `nick` varchar(50) default NULL,
  `link` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `IX_comment` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cms_images` (
  `id` int(11) NOT NULL auto_increment,
  `path` varchar(200) NOT NULL default '',
  `mainkey` varchar(20) NOT NULL default '',
  `kind` varchar(20) NOT NULL default '',
  `subkey` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `IX_images` (`mainkey`),
  KEY `IX_images_1` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `cms_images` (`id`,`path`,`mainkey`,`kind`,`subkey`) VALUES (10,'upfile/webeditimg/2006/8/2357ddd8a4354a8b82292978ec6821f6.jpg','1','document',1),(11,'upfile/webeditimg/2006/8/528e140122ca4930a85d31ca942a0ab3.jpg','2','document',1),(12,'upfile/webeditimg/2006/8/96ede6606c104816bc9f7a6722929a9c.jpg','3','document',1);
CREATE TABLE `customer_share` (
  `Id` int(11) NOT NULL auto_increment,
  `customerId` int(11) default '0',
  `sharePerson` varchar(50) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `customer_share` (`Id`,`customerId`,`sharePerson`) VALUES (4,1,'张燕'),(5,2,'admin');
CREATE TABLE `department` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `description` varchar(255) default NULL,
  `parentCode` varchar(20) NOT NULL default '',
  `rootCode` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `childCount` int(11) NOT NULL default '0',
  `addDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `type` int(3) NOT NULL default '1',
  `layer` int(11) NOT NULL default '1',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
INSERT INTO `department` (`code`,`name`,`description`,`parentCode`,`rootCode`,`orders`,`childCount`,`addDate`,`type`,`layer`) VALUES ('2deputyzjl','第一副总经理室','','zjl','root',1,2,'2006-02-12 10:54:50',1,3),('admin','管理员','','root','root',2,0,'2006-02-26 17:27:27',1,2),('cjywb','国际业务部','','ggb','root',2,0,'2006-06-21 09:47:25',1,5),('cnywb','国内业务部','','ggb','root',3,0,'2006-06-21 09:47:42',1,5),('cwb','财务部','','cwzj','root',1,0,'2006-06-21 09:39:58',1,5),('cwzj','财务总监','','deputy','root',2,2,'2006-06-21 09:39:17',1,4),('deputy','第二副总经理室','','zjl','root',2,2,'2006-02-12 10:54:50',1,3),('ggb','市场总监','','2deputyzjl','root',3,4,'2006-02-12 10:54:50',1,4),('jsb','行政总监','','deputy','root',1,2,'2006-02-12 10:54:50',1,4),('jxfwb','技术服务部','','ggb','root',4,0,'2006-06-21 09:48:04',1,5),('rlzyb','人力资源部','','jsb','root',2,0,'2006-06-21 09:41:35',1,5),('root','全部',NULL,'-1','root',1,2,'2006-02-12 10:54:50',1,1),('scb','技术总监','','2deputyzjl','root',2,3,'2006-02-12 10:54:50',1,4);
INSERT INTO `department` (`code`,`name`,`description`,`parentCode`,`rootCode`,`orders`,`childCount`,`addDate`,`type`,`layer`) VALUES ('scb1','市场部','','ggb','root',1,0,'2006-06-21 09:47:04',1,5),('xzb','行政部','','jsb','root',1,0,'2006-06-21 09:41:17',1,5),('yfzx','研发中心','','scb','root',1,0,'2006-06-21 09:43:37',1,5),('zcb','证券部','','cwzj','root',2,0,'2006-06-21 09:40:25',1,5),('zjl','总经理室','','root','root',1,2,'2006-02-12 10:54:50',2,2),('zjzx','质检中心','','scb','root',2,0,'2006-06-21 09:44:17',1,5);
CREATE TABLE `dept_user` (
  `ID` int(11) NOT NULL default '0',
  `DEPT_CODE` varchar(20) NOT NULL default '',
  `USER_NAME` varchar(20) default NULL,
  `ORDERS` int(11) NOT NULL default '1',
  `RANK` varchar(20) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `dept_code` (`DEPT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `dept_user` (`ID`,`DEPT_CODE`,`USER_NAME`,`ORDERS`,`RANK`) VALUES (0,'admin','admin',0,NULL);
CREATE TABLE `dir_priv` (
  `id` int(11) NOT NULL auto_increment,
  `dir_code` varchar(50) NOT NULL default '',
  `see` tinyint(1) NOT NULL default '1',
  `append` tinyint(1) NOT NULL default '0',
  `del` tinyint(1) NOT NULL default '0',
  `modify` tinyint(1) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `priv_type` tinyint(1) NOT NULL default '0',
  `examine` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `IX_dir_priv` (`dir_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `directory` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(255) default NULL,
  `parent_code` varchar(50) NOT NULL default '',
  `root_code` varchar(50) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default NULL,
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '1',
  `doc_id` int(11) default NULL,
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(20) NOT NULL default 'default',
  `IS_SYSTEM` tinyint(1) NOT NULL default '0',
  `target` varchar(20) default NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`IS_SYSTEM`,`target`) VALUES ('a','a',1,'a','root','root',6,0,'2006-12-13 21:59:59',NULL,2,2,NULL,-1,'default',0,''),('aaa','aaa',1,'aaa.ppt','notice','root',3,1,'2007-01-15 12:44:58',NULL,3,3,NULL,-1,'default',0,''),('bbb','bbb',1,'bbb.ppt','aaa','root',1,0,'2007-01-15 12:45:18',NULL,3,4,NULL,-1,'default',0,''),('blog','博客',0,'','root','root',3,2,'2006-08-03 17:38:00',NULL,0,2,0,-1,'default',0,NULL),('blog_ad','广告',1,'','blog','root',2,4,'2006-08-03 17:38:49',NULL,0,3,0,-1,'default',1,NULL),('blog_ad1','公告旁的广告',1,'','blog_ad','root',1,0,'2006-08-03 17:39:23',NULL,1,4,1,-1,'default',0,NULL),('blog_ad2','首页中部横幅',0,'','blog_ad','root',2,0,'2006-08-03 17:39:42',NULL,1,4,2,-1,'default',0,NULL),('blog_ad3','首页底部横幅广告',1,'','blog_ad','root',3,0,'2006-08-03 17:40:00',NULL,1,4,3,-1,'default',0,NULL),('blog_ad4','右下友情链接',0,'','blog_ad','root',4,0,'2006-11-19 18:58:45',NULL,1,4,145,-1,'default',1,NULL);
INSERT INTO `directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`IS_SYSTEM`,`target`) VALUES ('blog_notice','博客通知',1,'','blog','root',1,0,'2006-08-03 17:38:35',NULL,2,3,0,-1,'default',1,NULL),('dd','dd',1,'http://www.sina.com.cn','news','root',1,0,'2006-11-24 10:28:32',NULL,3,3,NULL,-1,'default',0,''),('news','新闻',1,'','root','root',4,1,'2006-07-07 08:19:33',NULL,2,2,0,-1,'default',1,'_parent'),('news2','新闻2',1,'','root','root',5,0,'2006-11-24 09:02:23',NULL,2,2,NULL,-1,'default',0,NULL),('notice','公共通知',1,'','root','root',2,3,'2006-04-04 08:25:36',NULL,2,2,0,-1,'sms',1,NULL),('root','全部分类',1,'','-1','root',1,6,'2006-02-10 00:00:00',NULL,0,1,0,-1,'default',1,NULL),('ss','ss',1,'','notice','root',2,0,'2006-11-24 09:30:09',NULL,2,3,0,-1,'default',0,NULL),('template','模板',0,'','root','root',1,-1,'2006-02-15 13:32:53',NULL,0,2,NULL,-1,'default',1,NULL),('vvv','第一章',1,'1.ppt','notice','root',1,0,'2006-11-24 09:27:27',NULL,3,3,0,-1,'default',0,'');
CREATE TABLE `doc_content` (
  `doc_id` int(11) NOT NULL default '0',
  `content` longtext NOT NULL,
  `page_num` int(11) NOT NULL default '1',
  UNIQUE KEY `IX_doc_content_1` (`doc_id`,`page_num`),
  KEY `IX_doc_content` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `doc_content` (`doc_id`,`content`,`page_num`) VALUES (1,'<IMG height=150 src=\"upfile/webeditimg/2006/8/2357ddd8a4354a8b82292978ec6821f6.jpg\" width=554>',1),(2,'<IMG height=104 src=\"upfile/webeditimg/2006/8/528e140122ca4930a85d31ca942a0ab3.jpg\" width=879>',1),(3,'<IMG height=104 src=\"upfile/webeditimg/2006/8/96ede6606c104816bc9f7a6722929a9c.jpg\" width=879>',1);
CREATE TABLE `document` (
  `id` int(11) NOT NULL default '0',
  `keywords` varchar(50) default NULL,
  `isrelateshow` tinyint(1) default '1',
  `title` varchar(100) NOT NULL default '',
  `class1` varchar(50) NOT NULL default '',
  `author` varchar(100) default NULL,
  `modifiedDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `can_comment` tinyint(1) NOT NULL default '0',
  `summary` text,
  `isHome` tinyint(1) NOT NULL default '0',
  `voteoption` varchar(250) default NULL,
  `voteresult` varchar(50) default NULL,
  `type` tinyint(3) unsigned NOT NULL default '0',
  `examine` tinyint(3) unsigned NOT NULL default '0',
  `nick` varchar(50) default NULL,
  `hit` int(11) NOT NULL default '0',
  `template_id` int(11) NOT NULL default '-1',
  `page_count` int(11) NOT NULL default '1',
  `parent_code` varchar(20) default NULL,
  `isNew` tinyint(1) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '' COMMENT 'not used',
  `color` varchar(20) default NULL,
  `isBold` char(1) NOT NULL default '0',
  `expire_date` datetime default NULL,
  `orgAddr` varchar(15) default NULL,
  `createDate` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `IX_document` (`class1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `document` (`id`,`keywords`,`isrelateshow`,`title`,`class1`,`author`,`modifiedDate`,`can_comment`,`summary`,`isHome`,`voteoption`,`voteresult`,`type`,`examine`,`nick`,`hit`,`template_id`,`page_count`,`parent_code`,`isNew`,`flowTypeCode`,`color`,`isBold`,`expire_date`,`orgAddr`,`createDate`) VALUES (1,'ad',1,'公告旁的广告','blog_ad1','admin','2006-08-30 00:00:00',1,NULL,0,'','',0,0,'admin',23,-1,1,'blog_ad',0,'',NULL,'0',NULL,NULL,NULL),(2,'ad',1,'首页中部横幅','blog_ad2','admin','2006-08-30 00:00:00',1,NULL,0,'','',0,0,'admin',0,-1,1,'blog_ad',0,'',NULL,'0',NULL,NULL,NULL),(3,'',1,'首页底部横幅','blog_ad3','admin','2006-08-30 00:00:00',1,NULL,0,'','',0,0,'admin',0,-1,1,'blog_ad',0,'',NULL,'0',NULL,NULL,NULL);
CREATE TABLE `document_attach` (
  `id` int(11) NOT NULL default '0',
  `doc_id` int(11) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` varchar(255) NOT NULL default '',
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `page_num` int(11) NOT NULL default '1',
  `orders` int(11) NOT NULL default '0',
  `downloadCount` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `doc_id` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `email` (
  `id` int(11) NOT NULL default '0',
  `receiver` varchar(100) NOT NULL default '',
  `sender` varchar(100) NOT NULL default '',
  `subject` varchar(50) NOT NULL default '',
  `content` mediumtext,
  `mydate` datetime NOT NULL default '0000-00-00 00:00:00',
  `type` int(1) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `email_attach` (
  `id` int(11) NOT NULL auto_increment,
  `emailId` int(11) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` varchar(255) NOT NULL default '',
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `email_pop3` (
  `id` int(11) NOT NULL auto_increment,
  `userName` varchar(20) NOT NULL default '',
  `email` varchar(50) character set latin1 NOT NULL default '',
  `emailUser` varchar(50) default NULL,
  `emailPwd` varchar(50) character set latin1 default NULL,
  `server` varchar(50) character set latin1 NOT NULL default '',
  `port` int(11) NOT NULL default '0' COMMENT 'pop3 port',
  `smtpPort` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `name` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow` (
  `id` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `mydate` datetime NOT NULL default '0000-00-00 00:00:00',
  `type_code` varchar(20) NOT NULL default '',
  `flow_string` text,
  `doc_id` int(11) default NULL,
  `userName` varchar(20) NOT NULL default '',
  `jobCode` varchar(20) default NULL,
  `status` tinyint(1) NOT NULL default '0',
  `resultValue` int(11) NOT NULL default '-2',
  `checkUserName` varchar(20) default NULL COMMENT 'The last person who check this flow.',
  `remark` varchar(200) default NULL,
  `return_back` tinyint(1) NOT NULL default '1',
  `BEGIN_DATE` datetime default NULL,
  `END_DATE` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `mydate` (`mydate`),
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_action` (
  `id` int(11) NOT NULL default '0',
  `flow_id` int(11) NOT NULL default '0',
  `userName` varchar(255) default NULL,
  `userRealName` varchar(255) NOT NULL default '',
  `title` varchar(255) default NULL,
  `status` int(11) NOT NULL default '0',
  `reason` longtext,
  `isStart` tinyint(1) NOT NULL default '0',
  `internal_name` varchar(32) NOT NULL default '',
  `office_color_index` int(11) NOT NULL default '0',
  `mydate` datetime NOT NULL default '0000-00-00 00:00:00',
  `jobCode` varchar(255) default NULL,
  `jobName` varchar(255) default NULL,
  `proxyJobCode` varchar(20) default NULL,
  `proxyJobName` varchar(20) default NULL,
  `proxyUserName` varchar(20) default NULL,
  `proxyUserRealName` varchar(20) default NULL,
  `result` varchar(250) default NULL,
  `resultValue` int(11) NOT NULL default '-2',
  `checkDate` datetime default NULL,
  `checkUserName` varchar(11) default NULL COMMENT 'Person who check this action',
  `fieldWrite` text,
  `taskId` int(11) default NULL,
  `flag` varchar(50) default NULL,
  `dept` text,
  `nodeMode` tinyint(3) NOT NULL default '0',
  `strategy` varchar(200) default NULL,
  `item1` varchar(200) default NULL,
  PRIMARY KEY  (`id`),
  KEY `jobCode` (`jobCode`),
  KEY `proxyJobCode` (`proxyJobCode`),
  KEY `status` (`status`),
  KEY `proxyUserName` (`proxyUserName`),
  KEY `userName` (`userName`),
  KEY `flow_id_internal_name` (`flow_id`,`internal_name`),
  KEY `flow_id` (`flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_cms_images` (
  `id` int(11) NOT NULL auto_increment,
  `path` varchar(200) NOT NULL default '',
  `mainkey` varchar(20) NOT NULL default '',
  `kind` varchar(20) NOT NULL default '',
  `subkey` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `IX_images` (`mainkey`),
  KEY `IX_images_1` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_dir_priv` (
  `id` int(11) NOT NULL auto_increment,
  `dir_code` varchar(50) NOT NULL default '',
  `see` tinyint(1) NOT NULL default '1',
  `append` tinyint(1) NOT NULL default '0',
  `del` tinyint(1) NOT NULL default '0',
  `modify` tinyint(1) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `priv_type` tinyint(1) NOT NULL default '0',
  `examine` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `IX_dir_priv` (`dir_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `flow_dir_priv` (`id`,`dir_code`,`see`,`append`,`del`,`modify`,`name`,`priv_type`,`examine`) VALUES (3,'xz',1,1,1,1,'333',1,1),(7,'gongwen',1,0,0,0,'Administrators',0,0),(8,'xz',1,0,0,0,'111',1,0);
CREATE TABLE `flow_directory` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(255) default NULL,
  `parent_code` varchar(50) NOT NULL default '',
  `root_code` varchar(50) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default NULL,
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '1',
  `doc_id` int(11) default NULL,
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(20) NOT NULL default 'default',
  `formCode` varchar(20) default NULL,
  `dept` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `flow_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`formCode`,`dept`) VALUES ('bgypsnd','办公用品申领',0,'','xz','root',6,0,'2006-04-28 13:46:35',NULL,2,3,NULL,-1,'default','bgypsnd',''),('ccsqd','出差申请',0,'','hr','root',2,0,'2006-04-28 13:52:23',NULL,2,3,NULL,-1,'default','ccsqd',''),('cpxgsqs','产品修改申请书',0,'','sc','root',1,0,'2006-04-28 13:59:17',NULL,2,3,NULL,-1,'default','cpxgsqs',''),('cpznjcbg','产品质量检查报告',0,'','sc','root',2,0,'2006-04-28 13:59:35',NULL,2,3,NULL,-1,'default','cpznjcbg',''),('cw','财务',0,'','root','root',4,2,'2006-04-28 13:53:35',NULL,0,2,NULL,-1,'default','fw',''),('dcdbd','督查督办',1,'','xz','root',4,0,'2006-04-28 13:45:40',NULL,2,3,0,-1,'default','dcdbd',''),('fawen','发文',1,'','gongwen','root',2,0,'2006-03-11 18:45:58',NULL,2,3,0,-1,'default','gsfw',''),('fydjd','复印登记',0,'','xz','root',8,0,'2006-04-28 13:47:37',NULL,2,3,NULL,-1,'default','fydjd',''),('gongwen','公文',0,'','root','root',1,2,'2006-03-11 18:43:54',NULL,0,2,0,-1,'default',NULL,'');
INSERT INTO `flow_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`formCode`,`dept`) VALUES ('gzjbd','工作交办',0,'','xz','root',3,0,'2006-04-28 13:44:44',NULL,2,3,NULL,-1,'default','gzjbd',''),('hr','人事',1,'','root','root',3,4,'2006-04-28 13:50:21',NULL,0,2,0,-1,'default','fw',''),('hysqd','会议申请',0,'','xz','root',7,0,'2006-04-28 13:47:03',NULL,2,3,NULL,-1,'default','hysqd',''),('jbdjd','加班登记',0,'','hr','root',3,0,'2006-04-28 13:52:43',NULL,2,3,NULL,-1,'default','jbdjd',''),('jcna','奖惩拟案',0,'','hr','root',4,0,'2006-04-28 13:53:02',NULL,2,3,NULL,-1,'default','jcna',''),('khfkdjd','客户反馈登记',1,'','xs','root',3,0,'2006-04-28 14:01:02',NULL,2,3,0,-1,'default','khfkdjd',''),('lxsqb','立项申请',0,'','yf','root',1,0,'2006-04-28 13:58:17',NULL,2,3,NULL,-1,'default','lxsqb',''),('ncd','订单、生产、发货流程',0,'','xs','root',1,0,'2006-04-28 14:00:21',NULL,2,3,NULL,-1,'default','ncd',''),('pc','派车申请',1,'','xz','root',2,0,'2006-03-14 16:21:50',NULL,2,3,0,-1,'default','vehicle_apply','');
INSERT INTO `flow_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`formCode`,`dept`) VALUES ('qj','请假申请',1,'','xz','root',1,0,'2006-03-14 15:24:51',NULL,2,3,0,-1,'default','qjsqd',''),('qjsqd','请假申请',0,'','hr','root',1,0,'2006-04-28 13:52:06',NULL,2,3,NULL,-1,'default','qjsqd',''),('qksqd','请款(借支)申请',1,'','cw','root',1,0,'2006-04-28 13:56:43',NULL,2,3,0,-1,'default','qksqd',''),('qzkhdjd','潜在客户登记',0,'','xs','root',2,0,'2006-04-28 14:00:39',NULL,2,3,NULL,-1,'default','qzkhdjd',''),('rcszjrd','日常收支记录',0,'','cw','root',2,0,'2006-04-28 13:57:07',NULL,2,3,NULL,-1,'default','rcszjrd',''),('root','全部类别',1,NULL,'-1','root',1,7,'2006-03-11 00:00:00',0,NULL,1,NULL,-1,'default',NULL,''),('sc','生产',0,'','root','root',6,2,'2006-04-28 13:58:51',NULL,0,2,NULL,-1,'default','fw',''),('shouwen','收文',1,'','gongwen','root',1,0,'2006-03-11 18:45:45',NULL,2,3,0,-1,'default','shouwen',''),('xs','销售',1,'','root','root',7,3,'2006-04-28 13:59:58',NULL,0,2,0,-1,'default','','');
INSERT INTO `flow_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`formCode`,`dept`) VALUES ('xz','行政',0,'','root','root',2,8,'2006-03-14 15:23:47',NULL,0,2,NULL,-1,'default','fw',''),('yf','研发',0,'','root','root',5,1,'2006-04-28 13:57:48',NULL,0,2,NULL,-1,'default','fw',''),('zbdjd','值班登记',0,'','xz','root',5,0,'2006-04-28 13:46:08',NULL,2,3,NULL,-1,'default','zbdjd','');
CREATE TABLE `flow_doc_content` (
  `doc_id` int(11) NOT NULL default '0',
  `content` longtext NOT NULL,
  `page_num` int(11) NOT NULL default '1',
  UNIQUE KEY `IX_doc_content_1` (`doc_id`,`page_num`),
  KEY `IX_doc_content` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_document` (
  `id` int(11) NOT NULL default '0',
  `keywords` varchar(50) default NULL,
  `isrelateshow` tinyint(1) default '1',
  `title` varchar(100) NOT NULL default '',
  `class1` varchar(50) NOT NULL default '',
  `author` varchar(100) default NULL,
  `modifiedDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `can_comment` tinyint(1) NOT NULL default '0',
  `summary` text,
  `isHome` tinyint(1) NOT NULL default '0',
  `voteoption` varchar(250) default NULL,
  `voteresult` varchar(50) default NULL,
  `type` tinyint(3) unsigned NOT NULL default '0',
  `examine` tinyint(3) unsigned NOT NULL default '0',
  `nick` varchar(50) default NULL,
  `hit` int(11) NOT NULL default '0',
  `template_id` int(11) NOT NULL default '-1',
  `page_count` int(11) NOT NULL default '1',
  `parent_code` varchar(20) default NULL,
  `isNew` tinyint(1) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '' COMMENT 'not used',
  PRIMARY KEY  (`id`),
  KEY `IX_document` (`class1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_document_attach` (
  `id` int(11) NOT NULL auto_increment,
  `doc_id` int(11) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` varchar(255) NOT NULL default '',
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `page_num` int(11) NOT NULL default '1',
  `orders` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `doc_id` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_link` (
  `id` int(11) NOT NULL default '0',
  `flow_id` int(11) NOT NULL default '0',
  `action_from` varchar(32) NOT NULL default '',
  `action_to` varchar(32) NOT NULL default '',
  `speedup_date` datetime default NULL,
  `isSpeedup` tinyint(1) NOT NULL default '0',
  `title` varchar(250) default NULL,
  `type` int(11) NOT NULL default '0',
  `cond_desc` varchar(255) default NULL,
  `item1` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `action_from` (`action_from`),
  KEY `action_to` (`action_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_monitor` (
  `flowId` int(11) NOT NULL default '0',
  `userName` varchar(20) default NULL,
  `flowCreateDate` datetime default NULL,
  UNIQUE KEY `flowId_userName` (`flowId`,`userName`),
  KEY `flowId` (`flowId`),
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_my_action` (
  `id` bigint(20) NOT NULL default '0',
  `flow_id` bigint(20) NOT NULL default '0',
  `action_id` bigint(11) NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  `proxy` varchar(20) default NULL,
  `receive_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `check_date` datetime default NULL,
  `is_checked` tinyint(3) NOT NULL default '0',
  `action_status` int(11) NOT NULL default '2' COMMENT 'Doing',
  PRIMARY KEY  (`id`),
  KEY `userName` (`user_name`),
  KEY `receive_date` (`receive_date`),
  KEY `action_id` (`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_predefined` (
  `Id` int(11) NOT NULL auto_increment,
  `flowString` text NOT NULL,
  `typeCode` varchar(20) NOT NULL default '',
  `title` varchar(250) NOT NULL default '',
  `return_back` tinyint(1) NOT NULL default '1',
  `IS_DEFAULT_FLOW` tinyint(1) NOT NULL default '0',
  `dir_code` varchar(50) default NULL,
  `examine` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Id`),
  KEY `typeCode` (`typeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `flow_sequence` (
  `ID` int(11) NOT NULL auto_increment,
  `BEGIN_INDEX` bigint(15) NOT NULL default '1',
  `CUR_INDEX` bigint(15) NOT NULL default '1',
  `NAME` varchar(255) NOT NULL default '',
  `LENGTH` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(250) NOT NULL default '',
  `content` text COMMENT 'form''s content',
  `orders` int(11) NOT NULL default '1',
  `isSystem` tinyint(1) NOT NULL default '0',
  `isFlow` tinyint(1) NOT NULL default '1' COMMENT 'Is used by flow',
  `flowTypeCode` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('bgypsnd','办公用品申领单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times ?Times New Roman???>办公用品申领单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 62.55pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167.85pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请人 style=\"WIDTH: 142px; HEIGHT: 21px\" size=18 name=applyman></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 73.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=98>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 124.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=167>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请日期 name=applyDate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.15pt; mso-yfti-irow: 1; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 62.55pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167.85pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><INPUT title=部门 name=department></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 73.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=98>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门负责人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 124.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=167>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=部门负责人 name=departCharger></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 23.2pt; mso-yfti-irow: 2; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 62.55pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申领物品<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 491px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=申领物品 style=\"WIDTH: 102px; HEIGHT: 55px\" size=5 name=snwo><OPTION value=物品名称>物品名称</OPTION><OPTION value=数量>数量</OPTION><OPTION value=名称>名称</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\" selected></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 45.8pt; mso-yfti-irow: 3; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 62.55pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申领说明<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=申领说明 style=\"WIDTH: 455px; HEIGHT: 56px\" name=snsm rows=3 cols=55></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.55pt; mso-yfti-irow: 4; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 62.55pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.55pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批结果<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.55pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SELECT title=审批结果 name=spjg><OPTION value=同意 selected>同意</OPTION><OPTION value=不同意>不同意</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 45.8pt; mso-yfti-irow: 5; mso-yfti-lastrow: yes; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 62.55pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=Verdana><TEXTAREA title=审批意见 style=\"WIDTH: 457px; HEIGHT: 62px\" name=spyj rows=3 cols=55></TEXTAREA>&nbsp;</FONT></P></o:p></SPAN></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',47,0,1,''),('ccsqd','出差申请单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times Roman??? New ?Times></SPAN></B>&nbsp;</P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times Roman??? New ?Times>出差申请单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请人 name=applyman></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请日期 name=applydate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=部门 name=department></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">交通工具<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><SELECT title=交通工具 name=vehicle><OPTION value=火车 selected>火车</OPTION><OPTION value=汽车>汽车</OPTION><OPTION value=飞机>飞机</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">出差时间<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN style=\"mso-spacerun: yes\">\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN style=\"mso-spacerun: yes\"><INPUT title=出差开始时间 readOnly value=CURRENT name=cckssj kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"cckssj\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle>&nbsp;</SPAN></SPAN><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">至 <INPUT title=出差结束时间 readOnly value=CURRENT name=ccjssj kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"ccjssj\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></P></SPAN></SPAN></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 3\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">出差地点<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=ss style=\"WIDTH: 435px; HEIGHT: 21px\" size=57 name=ss></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 4\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">出差事由<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=出差事由 style=\"WIDTH: 436px; HEIGHT: 53px\" name=ccsy cols=53></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 5\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p>&nbsp;<INPUT title=审批人 name=checkman></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=审批日期 name=checkdate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 6\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批结果<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN lang=EN-US><o:p><SELECT title=审批结果 name=spjg><OPTION value=批准 selected>批准</OPTION><OPTION value=不批准>不批准</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 7; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=审批意见 style=\"WIDTH: 435px; HEIGHT: 56px\" name=spyj rows=3 cols=52></TEXTAREA></o:p></SPAN></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',49,0,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('cpxgsqs','产品修改申请书','<P align=center><FONT size=6><B><FONT size=4>产品修改申请书</FONT><BR></B></FONT><BR>\r\n<TABLE style=\"WIDTH: 575px; HEIGHT: 401px\" borderColor=black cellSpacing=0 cellPadding=5 width=575 align=center border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap colSpan=8><B>提案人&nbsp;<INPUT title=提案人 name=proposer></B>&nbsp;<B>申请日期 <INPUT title=申请日期 readOnly value=CURRENT name=applyDate kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"applyDate\",\"yyyy-mm-dd\")\' height=26 src=\"http://192.168.1.5:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></B></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=8><B>申请原因&nbsp;<SELECT title=申请原因 name=applicationReason><OPTION value=性能改良 selected>性能改良</OPTION><OPTION value=降低成本>降低成本</OPTION><OPTION value=加工困难>加工困难</OPTION><OPTION value=组织困难>组织困难</OPTION><OPTION value=服务困难>服务困难</OPTION><OPTION value=市场需要>市场需要</OPTION><OPTION value=创新>创新</OPTION><OPTION value=其他>其他</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 产品类型</B>&nbsp;<SELECT title=产品类型 name=outputClass><OPTION value=机种 selected>机种</OPTION><OPTION value=零件>零件</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></FONT></FONT></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=8>\r\n<P><B>申请内容<BR></B>&nbsp;<TEXTAREA title=申请内容 style=\"WIDTH: 543px; HEIGHT: 79px\" name=applicationContent rows=4 cols=66></TEXTAREA></P></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=8><B>审批与处理情况<BR><TEXTAREA title=审批与处理情况 style=\"WIDTH: 551px; HEIGHT: 68px\" name=examineDisposeS rows=3 cols=64></TEXTAREA></B></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=8><B>备注<BR><TEXTAREA title=备注 style=\"WIDTH: 551px; HEIGHT: 67px\" name=remark cols=65></TEXTAREA></B></TD></TR></TBODY></TABLE></P>',18,0,1,''),('cpznjcbg','产品质量检查报告','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN style=\"FONT-SIZE: 15pt; FONT-FAMILY: 黑体; mso-ascii-font-family: \" New Times Roman??>产品质量检查报告</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 15pt; mso-fareast-font-family: 黑体\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext; mso-table-layout-alt: fixed\" cellSpacing=0 cellPadding=0 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>产品名称</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 171pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=228>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"><INPUT title=产品名称 name=outputName>&nbsp;</FONT></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 54pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=72>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>检查日期</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 132.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=177>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 9pt\"><o:p><FONT face=\"Times New Roman\"><INPUT title=检查日期 name=checkDate>&nbsp;</FONT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 54.45pt; mso-yfti-irow: 1; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.45pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>检查方法</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.45pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"><TEXTAREA title=检查方法 style=\"WIDTH: 502px; HEIGHT: 74px\" name=checkMethod rows=4 cols=61></TEXTAREA></FONT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 54.55pt; mso-yfti-irow: 2; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.55pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>检　　查</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>质量标准</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.55pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=检查质量标准 style=\"WIDTH: 504px; HEIGHT: 76px\" name=checkQualityS rows=4 cols=61></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 83.9pt; mso-yfti-irow: 3; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 82px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>主　要</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>问　题</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 82px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=主要问题 style=\"WIDTH: 503px; HEIGHT: 81px\" name=mostlyProblem rows=4 cols=60></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 85pt; mso-yfti-irow: 4; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 82px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>处　理</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>意　见</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 82px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=处理意见 style=\"WIDTH: 501px; HEIGHT: 83px\" name=disposalIdea rows=4 cols=61></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 93.2pt; mso-yfti-irow: 5; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 41px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>准　备</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>采　取</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>的　对</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>策</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 41px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=准备采取的对策 style=\"WIDTH: 499px; HEIGHT: 72px\" name=prepareStage rows=4 cols=61></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 77.15pt; mso-yfti-irow: 6; page-break-inside: avoid; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 66px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>领导审核</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>审批</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 66px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=领导审核审批 style=\"WIDTH: 504px; HEIGHT: 66px\" name=leadCheckA rows=3 cols=61></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',19,0,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('dcdbd','督查督办单','<DIV class=title align=center>#[表单]</DIV>\r\n<TABLE class=Big width=500 align=center border=0>\r\n<TBODY>\r\n<TR align=right>\r\n<TD>文号：#[文号]<BR>#[时间] </TD></TR></TBODY></TABLE>\r\n<TABLE class=big borderColor=#000000 cellSpacing=0 cellPadding=3 width=500 align=center border=1>\r\n<TBODY>\r\n<TR>\r\n<TD colSpan=2><B>办结时间</B>：<INPUT title=办结时间 name=bjrq> </TD></TR>\r\n<TR>\r\n<TD colSpan=2><B>主办内容及要求</B>：<BR>\r\n<CENTER><TEXTAREA title=主办内容及要求 style=\"WIDTH: 379px; HEIGHT: 83px\" name=zbnryq rows=3 cols=45></TEXTAREA>&nbsp;</CENTER></TD></TR>\r\n<TR>\r\n<TD colSpan=2><B>主办单位办理情况</B>：<BR>\r\n<CENTER><TEXTAREA title=主办单位办理情况 style=\"WIDTH: 376px; HEIGHT: 82px\" name=blqk rows=3 cols=44></TEXTAREA>&nbsp;</CENTER></TD></TR>\r\n<TR>\r\n<TD colSpan=2><B>督办单位意见</B>：<BR>\r\n<CENTER><TEXTAREA title=督办单位意见 style=\"WIDTH: 374px; HEIGHT: 65px\" name=dbdwyj rows=3 cols=43></TEXTAREA>&nbsp;</CENTER></TD></TR></TBODY></TABLE>',5,0,1,''),('fw','发文单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 150%; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 26pt; LINE-HEIGHT: 150%; FONT-FAMILY: 宋体; LETTER-SPACING: 1pt; mso-bidi-font-size: 10.0pt; mso-hansi-font-family: \" ?Times New Roman???><FONT size=6>发文登记单</FONT></SPAN></B><BR><BR></P>\r\n<TABLE class=big style=\"WIDTH: 546px; HEIGHT: 168px\" borderColor=#000000 cellSpacing=0 cellPadding=3 width=546 align=center border=1>\r\n<TBODY>\r\n<TR>\r\n<TD colSpan=2><B>起草单位：<INPUT title=起草单位 style=\"WIDTH: 177px; HEIGHT: 21px\" size=23 value=宏控件：部门选择框 name=dept kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_dept_select\"></B></TD></TR>\r\n<TR>\r\n<TD style=\"HEIGHT: 92px\" colSpan=2><B>起草单位拟稿人：<INPUT title=拟搞人 style=\"WIDTH: 152px; HEIGHT: 21px\" name=ngr><BR>起草单位负责人：<INPUT title=负责人 style=\"WIDTH: 151px; HEIGHT: 21px\" size=19 name=fzren>&nbsp;<INPUT title=ccc readOnly value=CURRENT name=ccc kind=\"DATE_TIME\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"ccc\",\"yyyy-mm-dd\")\' height=26 src=\"http://localhost:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><INPUT style=\"WIDTH: 50px\" readOnly value=12:30:30 name=ccc_time>&nbsp;<IMG style=\"CURSOR: hand\" onclick=\'SelectDateTime(\"ccc\")\' src=\"http://localhost:8080/oa/images/form/clock.gif\" align=absMiddle><BR>秘书科初审人：<INPUT title=初审人 name=csren><INPUT title=dd readOnly name=dd kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"dd\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle name=dd_btnImg><BR>办公室核稿人：<INPUT title=核稿人 name=hgr></B></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=2><STRONG>公文标题：<INPUT title=标题 style=\"WIDTH: 276px; HEIGHT: 21px\" size=36 name=biaoti></STRONG></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=2>\r\n<P align=left><B>收文字号：<INPUT title=收文字号 style=\"WIDTH: 273px; HEIGHT: 21px\" size=35 name=swzh><BR>发文字号：<INPUT title=发文字号 style=\"WIDTH: 273px; HEIGHT: 21px\" size=34 name=fwzh><BR>主题词：　<INPUT title=主题词 style=\"WIDTH: 272px; HEIGHT: 21px\" size=35 name=ztci></B><BR><STRONG>主送机关：<INPUT title=主送机关 style=\"WIDTH: 271px; HEIGHT: 21px\" size=35 name=zsjg></STRONG><BR><STRONG>抄送机关：<INPUT title=抄送机关 style=\"WIDTH: 271px; HEIGHT: 21px\" size=35 name=csjg></STRONG></P></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=2>\r\n<P><STRONG>校对人：&nbsp;&nbsp;<INPUT title=校对人 name=jdren>&nbsp;印制份数：<INPUT title=印制份数 style=\"WIDTH: 105px; HEIGHT: 21px\" size=13 name=yzfs>份</STRONG></P></TD></TR></TBODY></TABLE>\r\n<P>&nbsp;</P>',0,0,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('fydjd','复印登记单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??? New ?Times ??Times mso-hansi-font-family: Roman??;>复印登记单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">签印人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=签印人 name=qyren></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">复印日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=复印日期 name=fyrq></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=部门 style=\"WIDTH: 98px\" name=department><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\" selected></OPTION></SELECT></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">纸型<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=纸型 style=\"WIDTH: 148px\" name=pagetyoe><OPTION value=A4 selected>A4</OPTION><OPTION value=B4>B4</OPTION><OPTION value=A5>A5</OPTION><OPTION value=B5>B5</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">文件名称<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=文件名称 style=\"WIDTH: 437px; HEIGHT: 21px\" size=55 name=filename></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 3\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">文件页数<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=文件页数 style=\"WIDTH: 124px; HEIGHT: 21px\" size=15 name=filenpage>&nbsp;页</o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">复印份数<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=复印份数 value=1 name=fyfs>&nbsp;份</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 4; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">总计页数<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p>&nbsp;<INPUT title=总计页数 style=\"WIDTH: 140px; HEIGHT: 21px\" size=18 value=文件页数*复印份数 name=conutpage>&nbsp;页</o:p></SPAN></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',10,0,1,''),('gsfw','公司发文','<P align=center>&nbsp; </P>\r\n<P align=center><FONT face=宋体 color=#ff0000 size=6><STRONG>云网软件公司发文</STRONG></FONT></P>\r\n<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 align=center borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR vAlign=top>\r\n<TD vAlign=center bgColor=#5a9ed6 colSpan=6><STRONG><FONT color=#ffffff>&nbsp;公司发文 #[title]</FONT></STRONG></TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center width=156>&nbsp;拟 稿 人</TD>\r\n<TD vAlign=center width=168 bgColor=#ffffff><INPUT title=拟稿人 value=宏控件：当前用户 name=ngr macroDefaultValue=\"\" macroType=\"macro_current_user\" kind=\"macro\"></TD>\r\n<TD vAlign=center width=67>&nbsp;拟稿时间</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=3><INPUT title=拟稿时间 readOnly value=CURRENT name=date_ng kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"date_ng\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle name=date_ng_btnImg>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;拟稿部门</TD>\r\n<TD vAlign=center bgColor=#ffffff><INPUT title=拟稿部门 value=宏控件：部门选择框 name=dept macroDefaultValue=\"\" macroType=\"macro_dept_select\" kind=\"macro\">&nbsp;</TD>\r\n<TD vAlign=center>&nbsp;公文类型</TD>\r\n<TD vAlign=center width=63 bgColor=#ffffff><SELECT title=公文类型 name=gwlx> <OPTION value=决定 selected>决定</OPTION> <OPTION value=决议>决议</OPTION> <OPTION value=通告>通告</OPTION> <OPTION value=通报>通报</OPTION> <OPTION value=通知>通知</OPTION> <OPTION value=报告>报告</OPTION> <OPTION value=请示>请示</OPTION> <OPTION value=公告>公告</OPTION> <OPTION value=批复>批复</OPTION></SELECT>&nbsp;</TD>\r\n<TD vAlign=center width=67 bgColor=#ffffff>&nbsp;公文去向</TD>\r\n<TD vAlign=center width=153 bgColor=#ffffff>&nbsp; <SELECT title=公文去向 name=gwqx> <OPTION value=上行文 selected>上行文</OPTION> <OPTION value=下行文、平级行文>下行文、平级行文</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;秘密等级</TD>\r\n<TD vAlign=center bgColor=#ffffff><SELECT title=秘密等级 name=dj> <OPTION value=一般 selected>一般</OPTION> <OPTION value=绝密>绝密</OPTION> <OPTION value=机密>机密</OPTION> <OPTION value=秘密>秘密</OPTION></SELECT>&nbsp;</TD>\r\n<TD vAlign=center>&nbsp;紧急程度</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=3><SELECT title=紧急程度 name=jjcd> <OPTION value=一般 selected>一般</OPTION> <OPTION value=特急>特急</OPTION> <OPTION value=急件>急件</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;发文字号</TD>\r\n<TD vAlign=center bgColor=#ffffff><SELECT title=发文字号 name=fwzh> <OPTION value=2006 selected>2006</OPTION> <OPTION value=2007>2007</OPTION> <OPTION value=2008>2008</OPTION></SELECT>&nbsp;</TD>\r\n<TD vAlign=center>&nbsp;分发日期</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=3>&nbsp;<INPUT title=分发日期 readOnly name=date_ff kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"date_ff\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle name=date_ff_btnImg></TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;标....题</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><INPUT title=标题 value=关于... name=mytitle>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;主 题 词</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><INPUT title=主题词 style=\"WIDTH: 431px; HEIGHT: 21px\" size=55 name=ztc>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;主....送</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><INPUT title=主送 style=\"WIDTH: 431px; HEIGHT: 21px\" size=55 name=zhusong>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;抄....送</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><INPUT title=抄送 style=\"WIDTH: 432px; HEIGHT: 21px\" size=55 name=chaosong>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;内....抄</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><INPUT title=内抄 style=\"WIDTH: 432px; HEIGHT: 21px\" size=55 name=nechao>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;部门领导审核意见</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><TEXTAREA title=部门领导审核意见 style=\"WIDTH: 433px; HEIGHT: 65px\" name=bmyj rows=1 cols=52></TEXTAREA>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;办公室领导核稿意见</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><TEXTAREA title=办公室领导核稿意见 style=\"WIDTH: 433px; HEIGHT: 69px\" name=bgsyj rows=1 cols=52></TEXTAREA>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;公司领导签发</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5><TEXTAREA title=公司领导签发 style=\"WIDTH: 431px; HEIGHT: 67px\" name=gsqf rows=1 cols=52></TEXTAREA>&nbsp;</TD></TR>\r\n<TR vAlign=top>\r\n<TD vAlign=center>&nbsp;正文</TD>\r\n<TD vAlign=center bgColor=#ffffff colSpan=5>&nbsp;<TEXTAREA title=正文 style=\"WIDTH: 428px; HEIGHT: 175px\" name=main_text cols=52></TEXTAREA></TD></TR></TBODY></TABLE>',25,0,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('gzjbd','工作交办单','<DIV class=title align=center><B><FONT size=6>#[表单]<BR></FONT></B></DIV>\r\n<TABLE class=Big width=500 align=center border=0>\r\n<TBODY>\r\n<TR align=right>\r\n<TD>文号：#[文号]<BR>#[时间] </TD></TR></TBODY></TABLE>\r\n<TABLE class=big style=\"WIDTH: 546px; HEIGHT: 441px\" borderColor=#000000 cellSpacing=0 cellPadding=3 width=546 align=center border=1>\r\n<TBODY>\r\n<TR>\r\n<TD colSpan=2><B>交办人</B>：<INPUT title=交办人 name=jbren>&nbsp; <B>承办人：<INPUT title=承办人 style=\"WIDTH: 161px; HEIGHT: 21px\" size=21 name=cbren></B></TD></TR>\r\n<TR>\r\n<TD colSpan=2><B>交办日期：<INPUT title=交办日期 style=\"WIDTH: 112px; HEIGHT: 21px\" readOnly size=13 value=CURRENT name=jbrq kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"jbrq\",\"yyyy-mm-dd\")\' height=26 src=\"http://192.168.1.5:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></B>&nbsp;<B>要求完成日期：<INPUT title=要求完成日期 style=\"WIDTH: 113px; HEIGHT: 21px\" readOnly size=14 value=CURRENT name=wcrq kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"wcrq\",\"yyyy-mm-dd\")\' height=26 src=\"http://192.168.1.5:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></B></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=2><B>承办人工作内容</B>：<BR><TEXTAREA title=承办人工作内容 style=\"WIDTH: 522px; HEIGHT: 89px\" name=gznr rows=3 cols=64></TEXTAREA>&nbsp;</TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=2>\r\n<P align=left><B>承办人工作完成情况</B>：<BR><TEXTAREA title=承办人工作完成情况 style=\"WIDTH: 521px; HEIGHT: 89px\" name=wcqk rows=4 cols=63></TEXTAREA>&nbsp;</P></TD></TR>\r\n<TR>\r\n<TD vAlign=top colSpan=2><B>交办人意见</B>：<BR>\r\n<DIV align=left><TEXTAREA title=交办人意见 style=\"WIDTH: 514px; HEIGHT: 90px\" name=jbryj rows=3 cols=63></TEXTAREA>&nbsp;<BR><BR><INPUT title=交办人签名 value=宏控件：签名框 name=jbr_sign kind=\"macro\" macroType=\"macro_sign\" macroDefaultValue=\"\"></DIV></TD></TR></TBODY></TABLE>',4,0,1,''),('hysqd','会议申请单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times ?Times New Roman???>会议申请申请单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167.85pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: left\" align=left><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请人 name=sqren></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 73.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=98>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 124.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=167>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请日期 readOnly value=CURRENT name=apply_date kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"apply_date\",\"yyyy-mm-dd\")\' height=26 src=\"http://localhost:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">会议名称</SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=会议名称 name=meeting_title>议题<INPUT title=议题 name=yt></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">开始时间<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\" align=left><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=会议时间 name=start_date kind=\"DATE_TIME\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"start_date\",\"yyyy-mm-dd\")\' height=26 src=\"http://localhost:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><INPUT style=\"WIDTH: 50px\" value=12:30:30 name=start_date_time>&nbsp;<IMG style=\"CURSOR: hand\" onclick=\'SelectDateTime(\"start_date\")\' src=\"http://localhost:8080/oa/images/form/clock.gif\" align=absMiddle></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">结束时间<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=结束时间 name=end_date kind=\"DATE_TIME\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"end_date\",\"yyyy-mm-dd\")\' height=26 src=\"http://localhost:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><INPUT style=\"WIDTH: 50px\" value=12:30:30 name=end_date_time>&nbsp;<IMG style=\"CURSOR: hand\" onclick=\'SelectDateTime(\"end_date\")\' src=\"http://localhost:8080/oa/images/form/clock.gif\" align=absMiddle></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.15pt; mso-yfti-irow: 2; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">参会人数<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167.85pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: left\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=参会人数 style=\"WIDTH: 150px; HEIGHT: 21px\" size=19 name=chrs></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 73.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=98>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">会议室<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 124.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=167>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=会议室 value=宏控件：会议室列表 name=hyshi kind=\"macro\" macroType=\"macro_boardroom_select\" macroDefaultValue=\"\">&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 23.2pt; mso-yfti-irow: 3; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">会议内容<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=会议内容 style=\"WIDTH: 410px; HEIGHT: 61px\" name=hycontent rows=3 cols=49></TEXTAREA></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 23.2pt; mso-yfti-irow: 4; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">参会人员<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=参会人员 style=\"WIDTH: 409px; HEIGHT: 63px\" name=chrenyuan rows=3 cols=50></TEXTAREA></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 45.8pt; mso-yfti-irow: 5; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">会场布置及物品准备要求<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=会场布置及物品准备要求 style=\"WIDTH: 409px; HEIGHT: 60px\" name=bzwpyq rows=3 cols=49></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 21.9pt; mso-yfti-irow: 6; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 21.9pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批结果<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 21.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times ?Times New Roman???><SELECT title=审批结果 name=result><OPTION value=是 selected>是</OPTION><OPTION value=否>否</OPTION></SELECT></SPAN></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.95pt; mso-yfti-irow: 7; page-break-inside: avoid; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 118px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.95pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.95pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=审批意见 style=\"WIDTH: 409px; HEIGHT: 52px\" name=spyjian cols=49></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',8,1,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('jbdjd','加班登记单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times ?Times New Roman???>加班登记单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">登记人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=登记人 name=booker></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">登记日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=登记日期 name=bookDate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=部门 name=department></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">加班地点<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=加班地点 name=overtimePlace><OPTION value=单位 selected>单位</OPTION><OPTION value=家里>家里</OPTION><OPTION value=用户单位>用户单位</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">加班时间<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN style=\"mso-spacerun: yes\">\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN style=\"mso-spacerun: yes\"><INPUT title=加班开始时间 readOnly value=CURRENT name=overtimeBeginTime kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"overtimeBeginTime\",\"yyyy-mm-dd\")\' height=26 src=\"http://192.168.1.5:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle>&nbsp;</SPAN></SPAN><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">至 <INPUT title=加班结束时间 readOnly value=CURRENT name=overtimeEndTime kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"overtimeEndTime\",\"yyyy-mm-dd\")\' height=26 src=\"http://192.168.1.5:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></P></SPAN></SPAN></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 3\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">加班内容<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=加班内容 style=\"WIDTH: 437px; HEIGHT: 49px\" name=overtimeContent cols=53></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 4\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">证明人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=证明人 name=testifyMan></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 5\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审核人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=审核人 name=checkPerson>&nbsp;</o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审核日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=审核日期 style=\"WIDTH: 136px; HEIGHT: 21px\" size=17 name=checkDate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 6\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审核结果<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=审核结果 name=checkResult><OPTION value=审核通过 selected>审核通过</OPTION><OPTION value=审核未通过>审核未通过</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 7; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审核意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=审核意见 style=\"WIDTH: 441px; HEIGHT: 62px\" name=checkIdea rows=3 cols=53></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<DIV align=center>&nbsp;</DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</P></FONT></o:p></SPAN>',48,0,1,''),('jcna','奖惩拟案','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??? New ?Times ??Times mso-hansi-font-family: Roman??;>奖惩拟案</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">分类<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=分类 name=assort><OPTION value=奖励 selected>奖励</OPTION><OPTION value=惩处>惩处</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">拟案日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=拟案日期 style=\"WIDTH: 146px; HEIGHT: 21px\" size=19 name=draftDate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">姓名<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p>&nbsp;<INPUT title=姓名 name=name></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=部门 name=department></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">具体事录<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=具体事录 style=\"WIDTH: 459px; HEIGHT: 78px\" name=jtsr rows=4 cols=56></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 3\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">提案内容<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=提案内容 style=\"WIDTH: 459px; HEIGHT: 68px\" name=overtureContent rows=3 cols=56></TEXTAREA></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 4\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">人事主管<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=人事主管 name=humanVictim>&nbsp;</o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">单位领导<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=单位领导 name=unitLead>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 5; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">备注<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=备注 style=\"WIDTH: 460px; HEIGHT: 63px\" name=remark rows=3 cols=56></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',14,0,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('khfkdjd','客户反馈登记单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 18pt; FONT-FAMILY: 宋体; mso-bidi-font-size: 12.0pt\">客户反馈登记单</SPAN></B></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.9pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 163px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">登记人<SPAN lang=EN-US><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 162pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=216>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=登记人 name=booker></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 63pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">登记日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 124.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=167>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=登记日期 name=bookDate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.9pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 163px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">客户名称<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 162pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=216>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=客户名称 name=userName></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 63pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">联系人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 124.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=167>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=联系人 name=linkman></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.9pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 163px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">电话<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 162pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=216>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=电话 name=phone></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 63pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">反馈方式<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 124.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=167>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=反馈方式 name=feedMode><OPTION value=来电 selected>来电</OPTION><OPTION value=来访>来访</OPTION><OPTION value=网络>网络</OPTION><OPTION value=信函>信函</OPTION><OPTION value=传真>传真</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 77.85pt; mso-yfti-irow: 3; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 163px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 76px; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">反馈内容<SPAN lang=EN-US style=\"mso-bidi-font-weight: bold\"><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 349.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 76px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=467 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=反馈内容 style=\"WIDTH: 420px; HEIGHT: 74px\" name=feedContent rows=4 cols=51></TEXTAREA></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 76.75pt; mso-yfti-irow: 4; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 163px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 80px; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">分析及处理<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 349.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 80px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=467 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=分析及处理 style=\"WIDTH: 418px; HEIGHT: 80px\" name=analyseDispose rows=4 cols=51></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 76.75pt; mso-yfti-irow: 5; page-break-inside: avoid; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 163px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 70px; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">主管意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 349.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 70px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=467 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=主管意见 style=\"WIDTH: 418px; HEIGHT: 71px\" name=chargeIdea rows=3 cols=51></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',22,0,1,'yf'),('lxsqb','立项申请表','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN style=\"FONT-SIZE: 15pt; FONT-FAMILY: 黑体; mso-ascii-font-family: \" New Times Roman??>立项申请表</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 15pt; mso-fareast-font-family: 黑体\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext; mso-table-layout-alt: fixed\" cellSpacing=0 cellPadding=0 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>项目名称</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 171pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=228>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;<INPUT title=项目名称 name=itemTitle></FONT></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 54pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=72>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>申请日期</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 132.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=177>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 9pt\"><o:p><FONT face=\"Times New Roman\"><INPUT title=申请日期 name=applyDate>&nbsp;</FONT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 54.45pt; mso-yfti-irow: 1; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.45pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>项目概述</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.45pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"><TEXTAREA title=项目概述 style=\"WIDTH: 491px; HEIGHT: 73px\" name=itemSummerse rows=4 cols=60></TEXTAREA></FONT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 54.55pt; mso-yfti-irow: 2; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.55pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>项目效益预期</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 54.55pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=项目效益预期 style=\"WIDTH: 493px; HEIGHT: 72px\" name=itemBenefitExcept rows=4 cols=59></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 83.9pt; mso-yfti-irow: 3; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 69px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>人员需求</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 69px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=人员需求 style=\"WIDTH: 494px; HEIGHT: 87px\" name=personalDemannd rows=4 cols=60></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 85pt; mso-yfti-irow: 4; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 63px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>项目进度</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 63px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"><TEXTAREA title=项目进度 style=\"WIDTH: 493px; HEIGHT: 79px\" rows=5 cols=66></TEXTAREA></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\">&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 93.2pt; mso-yfti-irow: 5; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 43px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>项目费用</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt 5.4pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>预算</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 43px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=项目费用预算 style=\"WIDTH: 494px; HEIGHT: 88px\" name=itemChargeBuget rows=4 cols=60></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 77.15pt; mso-yfti-irow: 6; page-break-inside: avoid; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 68.4pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 61px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=91>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>领导审核</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-FAMILY: 宋体; mso-ascii-font-family: \" New ?Times mso-hansi-font-family: Times Roman?? Roman?;>意见</SPAN><SPAN lang=EN-US><o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 357.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 61px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=477 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\"></FONT></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=领导审核意见 style=\"WIDTH: 492px; HEIGHT: 70px\" name=leadAuditing rows=3 cols=59></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',17,0,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('ncd','订单、生产、发货流程单','<DIV style=\"FONT-SIZE: 18pt\" align=center><B>订单—生产—发货</B></DIV><BR>\r\n<TABLE style=\"WIDTH: 502px; HEIGHT: 897px\" borderColor=#000000 cellSpacing=0 cellPadding=3 width=502 align=center border=1>\r\n<TBODY>\r\n<TR bgColor=#cccccc>\r\n<TD colSpan=2><B>业务订单 - 业务员填写</B></TD></TR>\r\n<TR>\r\n<TD colSpan=2>订单编号:<INPUT title=订单编号 style=\"WIDTH: 370px; HEIGHT: 21px\" size=48 name=orderformNum></TD></TR>\r\n<TR>\r\n<TD colSpan=2><B>客户要求 </B>注：如果没有成品编码请在下框详细填写<TEXTAREA title=客户要求 style=\"WIDTH: 436px; HEIGHT: 63px\" name=clientDemand rows=3 cols=53></TEXTAREA>&nbsp;</TD></TR>\r\n<TR>\r\n<TD width=360>业务员:<INPUT title=业务员 name=operation></TD>\r\n<TD width=360>订单日期:<INPUT title=订单日期 name=orderDate></TD></TR>\r\n<TR bgColor=#cccccc>\r\n<TD colSpan=2><B>完工反馈 - 生产部门填写</B></TD></TR>\r\n<TR>\r\n<TD colSpan=2><TEXTAREA title=完工反馈 style=\"WIDTH: 473px; HEIGHT: 65px\" name=completeBack rows=3 cols=58></TEXTAREA>&nbsp;</TD></TR>\r\n<TR>\r\n<TD width=360>反馈人:<INPUT title=反馈人 name=feedbackMan></TD>\r\n<TD width=360>完工反馈日期:<INPUT title=完工反馈日期 style=\"WIDTH: 125px; HEIGHT: 21px\" size=16 name=completeDate></TD></TR>\r\n<TR bgColor=#cccccc>\r\n<TD colSpan=2><B>业务发货信息 - 业务经理填写</B></TD></TR>\r\n<TR>\r\n<TD width=360 colSpan=2>发货单号:<INPUT title=发货单号 name=invoiceNum></TD></TR>\r\n<TR>\r\n<TD width=360>收货人:<INPUT title=收货人 name=consignee></TD>\r\n<TD width=360>联系电话:<INPUT title=联系电话 name=contactPhone></TD></TR>\r\n<TR>\r\n<TD colSpan=2>发货方式:<INPUT title=发货方式 name=consigntMode></TD></TR>\r\n<TR>\r\n<TD colSpan=2>公司名称:<INPUT title=公司名称 name=CoName></TD></TR>\r\n<TR>\r\n<TD colSpan=2>收货地址:<INPUT title=收货地址 name=acceptAddress></TD></TR>\r\n<TR>\r\n<TD colSpan=2>运费结算方式:<INPUT title=运费结算方式 name=freightMode></TD></TR>\r\n<TR>\r\n<TD width=240>业务经理:<INPUT title=业务经理 name=operationmanger></TD>\r\n<TD width=240>发货日期:<INPUT title=发货日期 name=consignmentDate></TD></TR>\r\n<TR bgColor=#cccccc>\r\n<TD colSpan=2><B>发货员发货信息 - 发货员填写</B></TD></TR>\r\n<TR>\r\n<TD colSpan=2><TEXTAREA title=发货员发货信息 style=\"WIDTH: 476px; HEIGHT: 61px\" name=consignmentMes rows=3 cols=57></TEXTAREA>&nbsp;</TD></TR>\r\n<TR>\r\n<TD colSpan=2>发货员:&nbsp;<INPUT title=发货员 name=consignment>&nbsp;发货确认日期:<INPUT title=发货确认日期 name=consignmentConfirm></TD></TR>\r\n<TR bgColor=#cccccc>\r\n<TD colSpan=2><B>业务反馈信息 - 业务员填写</B></TD></TR>\r\n<TR>\r\n<TD style=\"WIDTH: 705px\" colSpan=2>业务确认:<INPUT title=业务确认 style=\"WIDTH: 398px; HEIGHT: 21px\" size=52 name=operationAffirm></TD></TR>\r\n<TR>\r\n<TD width=360>反馈业务员:<INPUT title=反馈业务员 name=feedOperation></TD>\r\n<TD width=360>反馈日期:<INPUT title=反馈日期 name=feedDate></TD></TR></TBODY></TABLE>',20,0,1,''),('qjsqd','请假申请单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times ?Times New Roman???></SPAN></B>&nbsp;</P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??; mso-hansi-font-family: ??Times ?Times New Roman???>请假申请单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请人 name=applyman></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=申请日期 name=applydate></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=部门 name=department></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">假期类别<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=假期类别 name=jqlb><OPTION value=病假 selected>病假</OPTION><OPTION value=事假>事假</OPTION><OPTION value=有薪大假>有薪大假</OPTION><OPTION value=补休>补休</OPTION><OPTION value=产假>产假</OPTION><OPTION value=其它>其它</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">请假时间<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN style=\"mso-spacerun: yes\"><INPUT title=请假开始时间 readOnly value=CURRENT name=qjkssj kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"qjkssj\",\"yyyy-mm-dd\")\' height=26 src=\"http://192.168.1.5:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle>&nbsp;</SPAN></SPAN><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">至 <INPUT title=请假结束时间 readOnly value=CURRENT name=qjjssj kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"qjjssj\",\"yyyy-mm-dd\")\' height=26 src=\"http://192.168.1.5:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 3\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">扣假形式<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=扣假形式 name=kjxs><OPTION value=无 selected>无</OPTION><OPTION value=扣大假>扣大假</OPTION><OPTION value=扣薪>扣薪</OPTION><OPTION value=倒休>倒休</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">请假理由</SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=请假理由 name=qjly></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 4\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=审批人 name=spren></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=审批日期 name=sprq></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 5\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批结果<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><SPAN lang=EN-US><o:p><SELECT title=审批结果 name=spjg><OPTION value=批准 selected>批准</OPTION><OPTION value=不批准>不批准</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 6; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">审批意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=审批意见 style=\"WIDTH: 464px; HEIGHT: 60px\" name=spyj rows=3 cols=56></TEXTAREA></o:p></SPAN>&nbsp;</P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',11,0,1,'hr');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('qksqd','请款(借支)申请单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??? New ?Times ??Times mso-hansi-font-family: Roman??;>请款</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><FONT face=\"Times New Roman\">(</FONT></SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??? New ?Times ??Times mso-hansi-font-family: Roman??;>借支</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><FONT face=\"Times New Roman\">)</FONT></SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??? New ?Times ??Times mso-hansi-font-family: Roman??;>申请单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">申请人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p>&nbsp;<INPUT title=申请人 name=applyMan></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=部门 name=department>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">用途<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=用途 style=\"WIDTH: 461px; HEIGHT: 129px\" name=yong_tu rows=7 cols=56></TEXTAREA></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">款额<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=款额 style=\"WIDTH: 459px; HEIGHT: 21px\" size=60 name=fund></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 3\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">支付方式<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=支付方式 name=paymentMode><OPTION value=现金 selected>现金</OPTION><OPTION value=现金支票>现金支票</OPTION><OPTION value=汇票支付>汇票支付</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 4\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">部门主管<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p>&nbsp;<INPUT title=部门主管 name=departmentChief></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">财务主管<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=财务主管 name=financeCharge>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 5\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">总经理<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p>&nbsp;<INPUT title=总经理 style=\"WIDTH: 164px; HEIGHT: 21px\" size=21 name=generalManager></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 6; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 87.65pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">备注<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=备注 style=\"WIDTH: 457px; HEIGHT: 87px\" name=remark rows=4 cols=56></TEXTAREA></o:p></SPAN></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',15,0,1,''),('qzkhdjd','潜在客户登记单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 18pt; FONT-FAMILY: 宋体; mso-bidi-font-size: 12.0pt\">潜在客户登记单</SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 18pt; FONT-FAMILY: 宋体; mso-bidi-font-size: 12.0pt\"><SPAN lang=EN-US><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></SPAN></B>&nbsp;</P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.9pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 146px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">单位<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 171pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=228>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=单位 name=unit></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 63pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">姓名<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 150px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=姓名 name=name></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.9pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 146px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">电话<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 171pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=228>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=电话 name=phone></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 63pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">称谓<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 150px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=称谓 name=appellation></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.9pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 146px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">电子邮箱<SPAN lang=EN-US> <o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 171pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=228>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=电子邮箱 name=mailbox></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 63pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">QQ<o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 150px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=QQ name=QQ></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.75pt; mso-yfti-irow: 3; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 146px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.75pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">MSN<o:p></o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 349.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.75pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=467 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=MSN style=\"WIDTH: 418px; HEIGHT: 21px\" size=55 name=MSN></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.75pt; mso-yfti-irow: 4; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 146px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.75pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">地址<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 349.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.75pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=467 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=地址 style=\"WIDTH: 418px; HEIGHT: 21px\" size=55 name=address></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 77.85pt; mso-yfti-irow: 5; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 146px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 86px; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">用户需求<SPAN lang=EN-US style=\"mso-bidi-font-weight: bold\"><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 349.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 86px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=467 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=用户需求 style=\"WIDTH: 415px; HEIGHT: 84px\" name=userDemand rows=4 cols=50></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 76.75pt; mso-yfti-irow: 6; page-break-inside: avoid; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 146px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 88px; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=105>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">主管意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 349.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 88px; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=467 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=主管意见 style=\"WIDTH: 414px; HEIGHT: 85px\" name=chargeIdea rows=4 cols=50></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',21,0,1,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('rcszjrd','日常收支记录单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??? New ?Times ??Times mso-hansi-font-family: Roman??;>日常收支记录单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 112px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=日期 name=date>&nbsp;</o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">凭证编号<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=凭证编号 name=credenceNumber>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 112px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">摘要<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; SPAN: EN-US style=\" align=center FONT-SIZE: 12pt; FONT-FAMILY: 宋体?><o:p><INPUT title=摘要 style=\"WIDTH: 438px; HEIGHT: 21px\" size=57 name=abstact></o:p></P></SPAN></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 2\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 112px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">借方金额<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=借方金额 name=debtorMoney></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">贷方金额<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=贷方金额 name=lenderMoney>&nbsp;</o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 3\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 112px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">科目<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 142.75pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=190>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=科目 name=subject></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 82.25pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=110>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">领款人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 115.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=155>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=领款人 name=payee></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 4\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 112px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">批准人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=批准人 name=approvePerson></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 5; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 112px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=117>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">备注<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 340.95pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=455 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=备注 style=\"WIDTH: 460px; HEIGHT: 67px\" name=remark rows=3 cols=56></TEXTAREA></o:p></SPAN></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',16,0,1,''),('sales_contract','销售合同','<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#ffffff><STRONG>合同基本信息：</STRONG></FONT> </TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 客户名称： </TD>\r\n<TD>&nbsp;<INPUT title=客户名称 value=宏控件：客户选择窗体 name=customer kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_customer_list_win\">&nbsp; </TD>\r\n<TD noWrap>&nbsp; 合同编号： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=合同编号 name=contact_no></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 合同类型： </TD>\r\n<TD noWrap>&nbsp;<SELECT title=合同类型 name=contact_type1><OPTION value=产品销售合同 selected>产品销售合同</OPTION><OPTION value=售后服务合同>售后服务合同</OPTION><OPTION value=产品升级合同>产品升级合同</OPTION></SELECT></TD>\r\n<TD noWrap>&nbsp; 合同打印样式： </TD>\r\n<TD noWrap>&nbsp;<SELECT title=合同打印样式 name=contact_type><OPTION value=产品销售合同 selected>产品销售合同</OPTION><OPTION value=售后服务合同>售后服务合同</OPTION><OPTION value=产品升级合同>产品升级合同</OPTION><OPTION value=产品二次开发合同>产品二次开发合同</OPTION></SELECT></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 合同名称： </TD>\r\n<TD noWrap colSpan=3>&nbsp;<INPUT title=合同名称 style=\"WIDTH: 536px; HEIGHT: 21px\" size=70 name=contact_name></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 合同描述： </TD>\r\n<TD noWrap colSpan=3>&nbsp;<TEXTAREA title=合同描述 style=\"WIDTH: 535px; HEIGHT: 95px\" name=contact_desc rows=5 cols=63></TEXTAREA></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 合同条款： </TD>\r\n<TD noWrap colSpan=3>&nbsp;<TEXTAREA title=合同条款 style=\"WIDTH: 536px; HEIGHT: 143px\" name=contact_item rows=7 cols=64></TEXTAREA></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 合同内容： </TD>\r\n<TD noWrap colSpan=3>&nbsp;<TEXTAREA title=合同内容 style=\"WIDTH: 538px; HEIGHT: 355px\" name=contact_content rows=18 cols=65></TEXTAREA></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 生效日期： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=生效日期 readOnly name=begindate kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"begindate\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></TD>\r\n<TD noWrap>&nbsp; 终止日期： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=结束时间 readOnly name=enddate kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"enddate\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 签约人（买方）： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=签约人 name=linkman></TD>\r\n<TD noWrap>&nbsp; 签约人（卖方）： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=签约人 name=toname></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 创建日期： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=创建日期 readOnly value=CURRENT name=create_date kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"create_date\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></TD>\r\n<TD noWrap>&nbsp; 创建人： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=创建人 value=宏控件：当前用户 name=seller_name kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_current_user\"></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp; 备注： </TD>\r\n<TD noWrap colSpan=3>&nbsp;<TEXTAREA title=备注 style=\"WIDTH: 537px; HEIGHT: 36px\" name=demo cols=65></TEXTAREA></TD></TR></TBODY></TABLE>',40,0,0,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('sales_customer','客户','<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" bgColor=#ffffff borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#ffffff><STRONG>基本信息：</STRONG></FONT> </TD></TR>\r\n<TR>\r\n<TD noWrap>销售员：</TD>\r\n<TD noWrap colSpan=3><INPUT title=销售员 value=宏控件：当前用户 name=sales_person macroDefaultValue=\"\" macroType=\"macro_current_user\" kind=\"macro\"></TD></TR>\r\n<TR>\r\n<TD noWrap>客户名称： </TD>\r\n<TD noWrap colSpan=3><INPUT title=客户名称 name=customer></TD></TR>\r\n<TR>\r\n<TD noWrap>客户编码： </TD>\r\n<TD noWrap><INPUT title=客户编码 name=custom_num>&nbsp; </TD>\r\n<TD noWrap>客户简称： </TD>\r\n<TD noWrap><INPUT title=客户简称 name=custom_short>&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap>电话： </TD>\r\n<TD noWrap><INPUT title=电话 name=tel>&nbsp; </TD>\r\n<TD noWrap>传真： </TD>\r\n<TD noWrap><INPUT title=传真 name=fax>&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap>网址： </TD>\r\n<TD noWrap><INPUT title=网址 name=web>&nbsp; </TD>\r\n<TD noWrap>电子邮件： </TD>\r\n<TD noWrap><INPUT title=电子邮件 name=email>&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap>地区： </TD>\r\n<TD noWrap><SELECT title=地区 name=area><OPTION value=江西 selected>江西</OPTION><OPTION value=甘肃>甘肃</OPTION><OPTION value=新疆>新疆</OPTION><OPTION value=宁夏>宁夏</OPTION><OPTION value=青海>青海</OPTION><OPTION value=西藏>西藏</OPTION><OPTION value=云南>云南</OPTION><OPTION value=贵州>贵州</OPTION><OPTION value=四川>四川</OPTION><OPTION value=重庆>重庆</OPTION><OPTION value=海南>海南</OPTION><OPTION value=广西>广西</OPTION><OPTION value=广东>广东</OPTION><OPTION value=湖南>湖南</OPTION><OPTION value=湖北>湖北</OPTION><OPTION value=澳门>澳门</OPTION><OPTION value=香港>香港</OPTION><OPTION value=台湾>台湾</OPTION><OPTION value=河南>河南</OPTION><OPTION value=福建>福建</OPTION></SELECT>&nbsp;</TD>\r\n<TD noWrap>邮政编码： </TD>\r\n<TD noWrap><INPUT title=邮政编码 name=postcode>&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap>详细地址： </TD>\r\n<TD noWrap colSpan=3><TEXTAREA title=详细地址 style=\"WIDTH: 453px; HEIGHT: 36px\" name=constomerAdd cols=55></TEXTAREA>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#eeeeee><STRONG>客户类型：</STRONG></FONT> </TD></TR>\r\n<TR>\r\n<TD noWrap>客户来源： </TD>\r\n<TD noWrap colSpan=3><SELECT title=客户来源 name=source><OPTION value=新闻 selected>新闻</OPTION><OPTION value=报纸>报纸</OPTION><OPTION value=百度搜索>百度搜索</OPTION><OPTION value=搜狐网站>搜狐网站</OPTION><OPTION value=其它>其它</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>客户类别： </TD>\r\n<TD noWrap colSpan=3><SELECT title=客户类别 name=kind><OPTION value=潜在客户 selected>潜在客户</OPTION><OPTION value=重点客户>重点客户</OPTION><OPTION value=普通客户>普通客户</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>销售方式： </TD>\r\n<TD noWrap colSpan=3><SELECT title=销售方式 name=sellMode><OPTION value=零售 selected>零售</OPTION><OPTION value=经销商>经销商</OPTION><OPTION value=OEM>OEM</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#ffffff><STRONG>企业概况：</STRONG></FONT> </TD></TR>\r\n<TR>\r\n<TD noWrap>行业属性： </TD>\r\n<TD noWrap colSpan=3><SELECT title=行业属性 name=attribute><OPTION value=建筑行业 selected>建筑行业</OPTION><OPTION value=电子行业>电子行业</OPTION><OPTION value=科研单位>科研单位</OPTION><OPTION value=教育行业>教育行业</OPTION><OPTION value=媒体/广告/文化>媒体/广告/文化</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>企业性质： </TD>\r\n<TD noWrap colSpan=3><SELECT title=企业性质 name=enterType><OPTION value=国家事业单位 selected>国家事业单位</OPTION><OPTION value=合资企业>合资企业</OPTION><OPTION value=国有企业>国有企业</OPTION><OPTION value=民营企业>民营企业</OPTION><OPTION value=政府部门>政府部门</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>企业描述： </TD>\r\n<TD noWrap colSpan=3><TEXTAREA title=企业描述 style=\"WIDTH: 460px; HEIGHT: 36px\" name=enterMemo cols=56></TEXTAREA>&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap>备注 </TD>\r\n<TD noWrap colSpan=3><TEXTAREA title=备注 style=\"WIDTH: 460px; HEIGHT: 36px\" name=demo cols=56></TEXTAREA>&nbsp; </TD></TR></TBODY></TABLE>',46,0,0,''),('sales_customer_service','客户服务','<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#ffffff><STRONG>客户服务基本信息：</STRONG></FONT></TD></TR>\r\n<TR>\r\n<TD noWrap width=\"28%\">&nbsp;&nbsp;服务类型：</TD>\r\n<TD width=\"25%\">&nbsp; <SELECT title=服务类型 name=contact_type> <OPTION value=上门服务 selected>上门服务</OPTION> <OPTION value=解决客户投诉>解决客户投诉</OPTION> <OPTION value=客户培训>客户培训</OPTION></SELECT>&nbsp; </TD>\r\n<TD noWrap width=\"22%\">&nbsp;&nbsp;服务日期：</TD>\r\n<TD noWrap width=\"25%\">&nbsp;&nbsp;<INPUT title=服务日期 readOnly value=CURRENT name=contact_date kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"contact_date\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;客户名称：</TD>\r\n<TD>&nbsp;&nbsp;<INPUT title=客户名称 value=宏控件：客户选择窗体 name=customer kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_customer_list_win\"></TD>\r\n<TD noWrap>&nbsp;&nbsp;联系人：</TD>\r\n<TD noWrap>&nbsp;&nbsp;<INPUT title=联系人 value=宏控件：联系人选择窗体 name=lxr kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_linkman_list_win\">&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;服务预估成本：</TD>\r\n<TD>&nbsp; <INPUT title=服务预估成本 name=cost>元</TD>\r\n<TD noWrap>&nbsp;&nbsp;时间成本：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=时间成本 name=time_cost>小时</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;服务内容描述：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <TEXTAREA title=服务内容描述 style=\"WIDTH: 520px; HEIGHT: 67px\" name=contact_content rows=1 cols=63></TEXTAREA>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#ffffff><STRONG>客户反馈：</STRONG></FONT></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;客户满意度：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <SELECT title=客户满意度 name=satisfy> <OPTION value=很满意 selected>很满意</OPTION> <OPTION value=比较满意>比较满意</OPTION> <OPTION value=不满意>不满意</OPTION> <OPTION value=很不满意>很不满意</OPTION></SELECT>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;客户反馈意见：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <TEXTAREA title=客户反馈意见 style=\"WIDTH: 521px; HEIGHT: 77px\" name=feedback rows=1 cols=63></TEXTAREA>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap align=left>&nbsp;&nbsp;描述：</TD>\r\n<TD noWrap align=left colSpan=3>&nbsp;&nbsp;<TEXTAREA title=描述 style=\"WIDTH: 520px; HEIGHT: 70px\" name=description rows=3 cols=63></TEXTAREA></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;备注：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <TEXTAREA title=备注 style=\"WIDTH: 520px; HEIGHT: 72px\" name=memo rows=1 cols=63></TEXTAREA>&nbsp;</TD></TR></TBODY></TABLE>',41,0,0,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('sales_linkman','联系人','&nbsp; \r\n<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><STRONG><FONT color=#eeeeee>联系人基本信息</FONT></STRONG> </TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;客户单位： </TD>\r\n<TD width=350><INPUT title=客户单位 value=宏控件：客户选择窗体 name=customer kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_customer_list_win\"></TD>\r\n<TD noWrap width=137>&nbsp;&nbsp;联系人职位： </TD>\r\n<TD noWrap width=350><INPUT title=联系人职位 name=postPriv></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;姓名： </TD>\r\n<TD noWrap><INPUT title=姓名 name=linkmanName></TD>\r\n<TD noWrap>&nbsp;&nbsp;性别：</TD>\r\n<TD><SELECT title=性别 name=linkmanSex><OPTION value=男 selected>男</OPTION><OPTION value=女>女</OPTION></SELECT></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;生日： </TD>\r\n<TD noWrap>&nbsp; </TD>\r\n<TD noWrap>&nbsp;&nbsp;爱好： </TD>\r\n<TD noWrap>&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><STRONG><FONT color=#ffffff>联系方式</FONT></STRONG> </TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;家庭邮编： </TD>\r\n<TD noWrap colSpan=3><INPUT title=家庭邮编 name=postcodeHome></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;家庭住址： </TD>\r\n<TD noWrap colSpan=3><INPUT title=家庭住址 style=\"WIDTH: 453px; HEIGHT: 21px\" size=59 name=addHome></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;工作电话： </TD>\r\n<TD noWrap><INPUT title=工作电话 name=telNoWork></TD>\r\n<TD noWrap>&nbsp;&nbsp;家庭电话： </TD>\r\n<TD noWrap><INPUT title=家庭电话 name=telNoHome></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;手机： </TD>\r\n<TD noWrap><INPUT title=手机 name=mobile></TD>\r\n<TD noWrap>&nbsp;&nbsp;EMAIL： </TD>\r\n<TD noWrap><INPUT title=email name=EMAIL></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;QQ号码： </TD>\r\n<TD noWrap><INPUT title=oicq name=oicq></TD>\r\n<TD noWrap>&nbsp;&nbsp;MSN： </TD>\r\n<TD noWrap><INPUT title=msn name=msn></TD></TR>\r\n<TR>\r\n<TD noWrap width=120>&nbsp;&nbsp;备注：</TD>\r\n<TD noWrap colSpan=3><TEXTAREA title=备注 style=\"WIDTH: 453px; HEIGHT: 36px\" name=demo cols=55></TEXTAREA></TD></TR></TBODY></TABLE>',31,0,0,''),('sales_product_info','产品基本信息','<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><STRONG><FONT color=#ffffff>产品基本信息</FONT></STRONG> </TD></TR>\r\n<TR>\r\n<TD>&nbsp;供应商：</TD>\r\n<TD>&nbsp;&nbsp;<INPUT title=供应商 value=宏控件：供应商选择窗体 name=provider kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_provider_list_win\">&nbsp;</TD>\r\n<TD width=100>&nbsp;产品名称： </TD>\r\n<TD>&nbsp;&nbsp;<INPUT title=产品名称 name=product_name>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;产品型号：</TD>\r\n<TD noWrap>&nbsp;&nbsp;<INPUT title=产品型号 name=product_type>&nbsp;</TD>\r\n<TD noWrap>&nbsp;产品类别：</TD>\r\n<TD>&nbsp; <SELECT title=产品类别 name=product_mode><OPTION value=网络设备 selected>网络设备</OPTION><OPTION value=电脑硬件>电脑硬件</OPTION><OPTION value=办公用品>办公用品</OPTION><OPTION value=网络耗材>网络耗材</OPTION><OPTION value=电脑耗材>电脑耗材</OPTION></SELECT></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;计量单位：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=计量单位 name=measure_unit>&nbsp;</TD>\r\n<TD noWrap>&nbsp;成本价：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=成本价 name=cost_price>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;出售价： </TD>\r\n<TD noWrap colSpan=3>&nbsp; <INPUT title=出售价 name=standard_price>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;产品描述： </TD>\r\n<TD noWrap colSpan=3>&nbsp; <TEXTAREA title=产品描述 style=\"WIDTH: 430px; HEIGHT: 101px\" name=product_desc rows=4 cols=52></TEXTAREA></TD></TR>\r\n<TR>\r\n<TD noWrap width=100>&nbsp;备注：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <TEXTAREA title=备注 style=\"WIDTH: 430px; HEIGHT: 111px\" name=memo rows=6 cols=50></TEXTAREA></TD></TR></TBODY></TABLE>',39,0,0,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('sales_product_sell','产品销售记录','&nbsp; \r\n<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR id=PRO>\r\n<TD noWrap bgColor=#5a9ed6 colSpan=2><STRONG><FONT color=#ffffff>产品销售记录</FONT></STRONG></TD></TR>\r\n<TR id=PRO>\r\n<TD noWrap>&nbsp;&nbsp;产品：</TD>\r\n<TD>&nbsp;<INPUT title=产品名称 value=宏控件：产品选择窗体 name=product_name macroType=\"macro_product_list_win\" macroDefaultValue=\"\" kind=\"macro\"></TD></TR>\r\n<TR id=SER>\r\n<TD noWrap>&nbsp;&nbsp;服务：</TD>\r\n<TD>&nbsp;<INPUT title=服务 name=service_name></TD></TR>\r\n<TR id=PRI>\r\n<TD noWrap>&nbsp;&nbsp;单价：</TD>\r\n<TD>&nbsp;<INPUT title=单价 name=price></TD></TR>\r\n<TR id=QTY>\r\n<TD noWrap>&nbsp;&nbsp;数量：</TD>\r\n<TD>&nbsp;<INPUT title=数量 name=count></TD></TR>\r\n<TR id=TOTALPRICE>\r\n<TD noWrap>&nbsp;&nbsp;总价：</TD>\r\n<TD>&nbsp;<INPUT title=总价 name=total_price></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;客户名称： </TD>\r\n<TD>&nbsp;<INPUT title=客户名称 name=customer_name></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;售出日期：</TD>\r\n<TD>&nbsp;<INPUT title=记录日期 readOnly name=record_date kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"record_date\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;销售员：</TD>\r\n<TD>&nbsp;<INPUT title=销售员 value=宏控件：当前用户 name=sales_man macroType=\"macro_current_user\" macroDefaultValue=\"\" kind=\"macro\"></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;备注：</TD>\r\n<TD>&nbsp;<TEXTAREA title=备注 style=\"WIDTH: 390px; HEIGHT: 75px\" name=demo rows=4 cols=46></TEXTAREA></TD></TR></TBODY></TABLE>\r\n<P>&nbsp;</P>',44,0,0,''),('sales_product_service','服务型产品','<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><STRONG><FONT color=#ffffff>服务型产品基本信息</FONT></STRONG> </TD></TR>\r\n<TR>\r\n<TD>&nbsp;服务提供商：</TD>\r\n<TD>&nbsp; <INPUT title=服务提供商 value=宏控件：供应商选择窗体 name=provider kind=\"macro\" macroType=\"macro_provider_list_win\" macroDefaultValue=\"\"></TD>\r\n<TD width=100>&nbsp;服务名称： </TD>\r\n<TD>&nbsp; <INPUT title=服务名称 name=service_name></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;服务收费标准： </TD>\r\n<TD noWrap colSpan=3>&nbsp; <INPUT title=服务收费标准 name=standad_name></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;服务描述： </TD>\r\n<TD noWrap colSpan=3>&nbsp;&nbsp;<TEXTAREA title=服务描述 style=\"WIDTH: 530px; HEIGHT: 104px\" name=service_desc rows=5 cols=61></TEXTAREA></TD></TR>\r\n<TR>\r\n<TD noWrap width=100>&nbsp;备注：</TD>\r\n<TD noWrap colSpan=3>&nbsp;&nbsp;<TEXTAREA title=备注 style=\"WIDTH: 531px; HEIGHT: 111px\" name=demo rows=6 cols=62></TEXTAREA></TD></TR></TBODY></TABLE>',43,0,0,'-1');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('sales_product_service_sell','服务型产品销售记录','<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR id=PRO>\r\n<TD noWrap bgColor=#5a9ed6 colSpan=2><STRONG><FONT color=#ffffff>销售服务记录</FONT></STRONG></TD></TR>\r\n<TR id=PRO>\r\n<TD noWrap>&nbsp;&nbsp;产品：</TD>\r\n<TD>&nbsp;<INPUT title=服务型产品名称 value=宏控件：服务型产品选择窗体 name=product_name kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_product_service_list_win\"></TD></TR>\r\n<TR id=SER>\r\n<TD noWrap>&nbsp;&nbsp;服务：</TD>\r\n<TD>&nbsp;<INPUT title=服务 name=service></TD></TR>\r\n<TR id=PRI>\r\n<TD noWrap>&nbsp;&nbsp;单价：</TD>\r\n<TD>&nbsp;<INPUT title=单价 name=price></TD></TR>\r\n<TR id=QTY>\r\n<TD noWrap>&nbsp;&nbsp;数量：</TD>\r\n<TD>&nbsp;<INPUT title=数量 name=count></TD></TR>\r\n<TR id=TOTALPRICE>\r\n<TD noWrap>&nbsp;&nbsp;总价：</TD>\r\n<TD>&nbsp;<INPUT title=总价 name=total_count></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;客户名称： </TD>\r\n<TD>&nbsp;<INPUT title=客户名称 name=customer_name></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;记录日期：</TD>\r\n<TD>&nbsp;<INPUT title=记录日期 readOnly value=CURRENT name=record_date kind=\"DATE\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"record_date\",\"yyyy-mm-dd\")\' height=26 src=\"http://fserver2:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;销售员：</TD>\r\n<TD>&nbsp;<INPUT title=销售员 value=宏控件：当前用户 name=sales_man kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_current_user\"></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;&nbsp;备注：</TD>\r\n<TD>&nbsp;<TEXTAREA title=备注 style=\"WIDTH: 408px; HEIGHT: 67px\" name=demo rows=3 cols=48></TEXTAREA></TD></TR></TBODY></TABLE>',45,0,0,''),('sales_provider_info','供应商基本信息','<P>&nbsp; \r\n<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#ffffff><STRONG>基本信息：</STRONG></FONT></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;供应商名称：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <INPUT title=供应商名称 name=provide_name></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;供应商编码：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=供应商编码 name=provider_code></TD>\r\n<TD noWrap>&nbsp;供应商简称：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=供应商简称 name=provider_shot></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;电话：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=电话 name=tel></TD>\r\n<TD noWrap>&nbsp;传真：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=传真 name=fax></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;网址：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=网址 name=web></TD>\r\n<TD noWrap>&nbsp;电子邮件：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=电子邮件 name=email></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;地区：</TD>\r\n<TD noWrap>&nbsp; <SELECT title=地区 name=area> <OPTION value=江西 selected>江西</OPTION> <OPTION value=甘肃>甘肃</OPTION> <OPTION value=新疆>新疆</OPTION> <OPTION value=宁夏>宁夏</OPTION> <OPTION value=青海>青海</OPTION> <OPTION value=西藏>西藏</OPTION> <OPTION value=云南>云南</OPTION> <OPTION value=贵州>贵州</OPTION> <OPTION value=四川>四川</OPTION> <OPTION value=重庆>重庆</OPTION> <OPTION value=海南>海南</OPTION> <OPTION value=广西>广西</OPTION> <OPTION value=广东>广东</OPTION> <OPTION value=湖南>湖南</OPTION> <OPTION value=湖北>湖北</OPTION> <OPTION value=澳门>澳门</OPTION> <OPTION value=香港>香港</OPTION> <OPTION value=台湾>台湾</OPTION> <OPTION value=河南>河南</OPTION> <OPTION value=福建>福建</OPTION></SELECT></TD>\r\n<TD noWrap>&nbsp;邮政编码：</TD>\r\n<TD noWrap>&nbsp; <INPUT title=邮政编码 name=postcode></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;详细地址：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <INPUT title=详细地址 size=56 name=provider_add></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;备注：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <TEXTAREA title=备注 style=\"WIDTH: 405px; HEIGHT: 69px\" name=demo rows=3 cols=53></TEXTAREA></TD></TR>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><FONT color=#ffffff><STRONG>财务信息：</STRONG></FONT></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;开户行：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <INPUT title=开户行 size=56 name=bank></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;帐号：</TD>\r\n<TD noWrap colSpan=3>&nbsp; <INPUT title=帐号 size=56 name=account></TD></TR></TBODY></TABLE></P>',35,0,0,'');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('sales_provider_name','供应商联系人信息','&nbsp; \r\n<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=1 width=\"100%\" borderColorLight=#cccccc border=1>\r\n<TBODY>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><STRONG><FONT color=#ffffff>联系人基本信息</FONT></STRONG> </TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;供应商单位： </TD>\r\n<TD>&nbsp;<INPUT title=供应商单位 value=宏控件：供应商选择窗体 name=provider_company kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_provider_list_win\">&nbsp; </TD>\r\n<TD noWrap>&nbsp;联系人职位： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=联系人职位 name=post_priv>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;姓名： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=姓名 name=linkman_name>&nbsp; </TD>\r\n<TD noWrap>&nbsp;性别：</TD>\r\n<TD>&nbsp;<SELECT title=性别 name=sex><OPTION value=男 selected>男</OPTION><OPTION value=女>女</OPTION></SELECT></TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;生日： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=生日 name=birthday>&nbsp;&nbsp;</TD>\r\n<TD noWrap>&nbsp;爱好： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=爱好 name=hobby>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap align=left bgColor=#5a9ed6 colSpan=4><STRONG><FONT color=#ffffff>联系方式</FONT></STRONG> </TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;家庭邮编： </TD>\r\n<TD noWrap colSpan=3>&nbsp;<INPUT title=家庭邮编 name=postal_home>&nbsp; </TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;家庭住址： </TD>\r\n<TD noWrap colSpan=3>&nbsp;<INPUT title=家庭住址 style=\"WIDTH: 416px; HEIGHT: 21px\" size=54 name=add_home>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;工作电话： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=工作电话 name=tel_no_work>&nbsp;</TD>\r\n<TD noWrap>&nbsp;家庭电话：</TD>\r\n<TD noWrap>&nbsp;<INPUT title=家庭电话 name=tel_no_home>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;手机： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=手机 name=mobile>&nbsp;</TD>\r\n<TD noWrap>&nbsp;EMAIL：</TD>\r\n<TD noWrap>&nbsp;<INPUT title=email name=email>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap>&nbsp;QQ号码： </TD>\r\n<TD noWrap>&nbsp;<INPUT title=qq name=qq>&nbsp;</TD>\r\n<TD noWrap>&nbsp;MSN：</TD>\r\n<TD noWrap>&nbsp;<INPUT title=msn name=msn>&nbsp;</TD></TR>\r\n<TR>\r\n<TD noWrap width=120>&nbsp;备注</TD>\r\n<TD noWrap colSpan=3>&nbsp;<TEXTAREA title=备注 style=\"WIDTH: 416px; HEIGHT: 69px\" name=memo rows=3 cols=50></TEXTAREA>&nbsp;</TD></TR></TBODY></TABLE>',36,0,0,''),('shouwen','收文单','<DIV class=title align=center><STRONG><FONT size=6></FONT></STRONG>&nbsp;</DIV>\r\n<DIV class=title align=center><STRONG><FONT size=6>#[表单]</FONT></STRONG></DIV>\r\n<TABLE class=Big width=500 align=center border=0>\r\n<TBODY>\r\n<TR align=right>\r\n<TD>文号：#[文号]<BR>#[时间] </TD></TR></TBODY></TABLE>\r\n<TABLE class=big borderColor=#000000 cellSpacing=0 cellPadding=3 width=500 align=center border=1>\r\n<TBODY>\r\n<TR>\r\n<TD colSpan=2><STRONG>收文时间：<INPUT title=收文时间 name=swsj>&nbsp;密级：<SELECT title=密级 name=serct><OPTION value=普通 selected>普通</OPTION><OPTION value=秘密>秘密</OPTION><OPTION value=机密>机密</OPTION><OPTION value=绝密>绝密</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT><BR>来文单位：<INPUT title=来文单位 name=lwdw></STRONG></TD></TR>\r\n<TR>\r\n<TD colSpan=2>\r\n<P><STRONG>文件名：<INPUT title=文件名 style=\"WIDTH: 324px; HEIGHT: 21px\" size=42 name=wjm><BR><B>主题词：<INPUT title=主题词 style=\"WIDTH: 322px; HEIGHT: 21px\" size=42 name=topic></B> <BR><STRONG>页码：　<INPUT title=页码 style=\"WIDTH: 62px; HEIGHT: 21px\" size=7 name=page></STRONG></STRONG></P>\r\n<P>&nbsp;<INPUT title=意见 value=宏控件：意见框 name=idea kind=\"macro\" macroType=\"macro_idea\" macroDefaultValue=\"\"></P></TD></TR>\r\n<TR>\r\n<TD colSpan=2>\r\n<P><STRONG>摘要：<BR><TEXTAREA title=摘要 style=\"WIDTH: 477px; HEIGHT: 92px\" name=abstract rows=4 cols=58></TEXTAREA>&nbsp;</P></STRONG></TD></TR>\r\n<TR>\r\n<TD colSpan=2><STRONG>拟办意见：<BR></STRONG>\r\n<DIV align=left><TEXTAREA title=意见 style=\"WIDTH: 474px; HEIGHT: 96px\" name=attribute rows=5 cols=58></TEXTAREA>&nbsp;</DIV></TD></TR>\r\n<TR>\r\n<TD colSpan=2><STRONG>领导批阅意见：<BR></STRONG>\r\n<DIV align=left><TEXTAREA title=批阅意见 style=\"WIDTH: 475px; HEIGHT: 85px\" name=pyyj rows=3 cols=56></TEXTAREA>&nbsp;</DIV></TD></TR>\r\n<TR>\r\n<TD colSpan=2>\r\n<DIV align=left><STRONG>归档人：<INPUT title=归档人 style=\"WIDTH: 121px; HEIGHT: 21px\" size=15 name=gdren></STRONG></DIV></TD></TR></TBODY></TABLE>',3,0,1,'gongwen');
INSERT INTO `form` (`code`,`name`,`content`,`orders`,`isSystem`,`isFlow`,`flowTypeCode`) VALUES ('vehicle_apply','派车申请单','　 \r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\">　</P>\r\n<DIV align=center>\r\n<TABLE style=\"BORDER-RIGHT: black 0.75pt outset; BORDER-TOP: black 0.75pt outset; BORDER-LEFT: black 0.75pt outset; BORDER-BOTTOM: black 0.75pt outset; mso-padding-alt: 2.25pt 2.25pt 2.25pt 2.25pt; mso-cellspacing: 0cm\" cellSpacing=0 cellPadding=0 width=623 border=1>\r\n<TBODY>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">车 牌 号</SPAN></B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">：</SPAN><FONT face=\"Times New Roman\"><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333\"> </SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><?xml:namespace prefix = o /><o:p></o:p></SPAN></FONT></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><o:p><INPUT title=车辆牌照 value=宏控件：车辆牌照选择框 name=licenseNo kind=\"macro\" macroDefaultValue macroType=\"macro_vehicle_select\"></o:p> </SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=79>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 140%; TEXT-ALIGN: left\" align=left><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\">司&nbsp;&nbsp;&nbsp; 机：<SPAN lang=EN-US><o:p> </o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=243>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><INPUT title=司机 value=宏控件：司机选择框 name=driver kind=\"macro\" macroDefaultValue=\"\" macroType=\"macro_driver_select\"></P></TD></TR>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">用 车 人</SPAN></B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">：</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333\"><o:p> </o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><INPUT title=用车人 style=\"WIDTH: 125px; HEIGHT: 21px\" size=16 name=person> </SPAN></FONT></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=79>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%; TEXT-ALIGN: left\" align=left><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\">用车部门：<SPAN lang=EN-US><o:p> </o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=243>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><INPUT title=用车部门 value=宏控件：部门选择框 name=dept kind=\"macro\" macroDefaultValue macroType=\"macro_dept_select\">&nbsp;<SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><o:p> </o:p></SPAN></FONT></P></TD></TR>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">起始时间：</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333\"><o:p> </o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><INPUT title=起始时间 style=\"WIDTH: 102px; HEIGHT: 21px\" size=13 value=CURRENT name=beginDate kind=\"DATE_TIME\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"beginDate\",\"yyyy-mm-dd\")\' height=26 src=\"http://localhost:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><INPUT style=\"WIDTH: 50px\" value=12:30:30 name=beginDate_time>&nbsp;<IMG style=\"CURSOR: hand\" onclick=\'SelectDateTime(\"beginDate\")\' height=18 src=\"http://localhost:8080/oa/images/form/clock.gif\" width=18 align=absMiddle> </SPAN></FONT></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=79>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%; TEXT-ALIGN: left\" align=left><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\">结束时间：<SPAN lang=EN-US><o:p> </o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=243>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><INPUT title=结束时间 style=\"WIDTH: 97px; HEIGHT: 21px\" size=12 value=CURRENT name=endDate kind=\"DATE_TIME\"><IMG style=\"CURSOR: hand\" onclick=\'SelectDate(\"endDate\",\"yyyy-mm-dd\")\' height=26 src=\"http://localhost:8080/oa/images/form/calendar.gif\" width=26 align=absMiddle><INPUT style=\"WIDTH: 50px\" value=12:30:30 name=endDate_time>&nbsp;<IMG style=\"CURSOR: hand\" onclick=\'SelectDateTime(\"endDate\")\' height=18 src=\"http://localhost:8080/oa/images/form/clock.gif\" width=18 align=absMiddle> </SPAN></FONT></P></TD></TR>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">目 的 地</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333\"><o:p> :</o:p> </SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><INPUT title=目的地 name=target> </SPAN></FONT></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=79>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%; TEXT-ALIGN: left\" align=left><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\">里&nbsp;&nbsp; 程：<SPAN lang=EN-US><o:p> </o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=243>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><INPUT title=里程 name=kilometer> </SPAN></FONT></P></TD></TR>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">申 请 人：</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333\"><o:p> </o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><INPUT title=申请人 name=applier> </SPAN></FONT></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=322 colSpan=2>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%; TEXT-ALIGN: left\" align=left>　</P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\">&nbsp;<SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><o:p> </o:p></SPAN></FONT></P></TD></TR>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">事&nbsp;&nbsp;&nbsp; 由</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333\"><o:p> :</o:p> </SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=546 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><FONT face=\"Times New Roman\"><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=事由 style=\"WIDTH: 374px; HEIGHT: 78px\" name=reason rows=3 cols=44></TEXTAREA></o:p> </SPAN></FONT><FONT face=\"宋体, MS Song\">&nbsp;</FONT></P></TD></TR>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: \'Times New Roman\'; mso-hansi-font-family: \'Times New Roman\'\">备&nbsp;&nbsp;&nbsp; 注：</SPAN><SPAN lang=EN-US style=\"FONT-SIZE: 9pt; COLOR: #333333\"><o:p> </o:p></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=546 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\" align=left><TEXTAREA title=备注 style=\"WIDTH: 374px; HEIGHT: 76px\" name=remark rows=3 cols=45></TEXTAREA></P></TD></TR>\r\n<TR>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=77>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><B><SPAN style=\"FONT-SIZE: 9pt; COLOR: #333333; FONT-FAMILY: 宋体; mso-ascii-font-family: Times New Roman; mso-hansi-font-family: Times New Roman\">是否同意</SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: black 0.75pt inset; PADDING-RIGHT: 2.25pt; BORDER-TOP: black 0.75pt inset; PADDING-LEFT: 2.25pt; PADDING-BOTTOM: 2.25pt; BORDER-LEFT: black 0.75pt inset; PADDING-TOP: 2.25pt; BORDER-BOTTOM: black 0.75pt inset; BACKGROUND-COLOR: transparent\" width=546 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; WORD-BREAK: break-all; LINE-HEIGHT: 140%\"><SELECT title=是否同意 name=result> <OPTION value=是 selected>是</OPTION> <OPTION value=否>否</OPTION></SELECT></P></TD></TR></TBODY></TABLE></DIV>',23,1,1,''),('zbdjd','值班登记单','<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B style=\"mso-bidi-font-weight: normal\"><SPAN style=\"FONT-SIZE: 22pt; FONT-FAMILY: 宋体; mso-ascii-font-family: \" Roman??? New ?Times ??Times mso-hansi-font-family: Roman??;>值班登记单</SPAN></B><B style=\"mso-bidi-font-weight: normal\"><SPAN lang=EN-US style=\"FONT-SIZE: 22pt\"><?xml:namespace prefix = o ns = \"urn:schemas-microsoft-com:office:office\" /><o:p></o:p></SPAN></B></P>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>\r\n<DIV align=center>\r\n<TABLE class=MsoNormalTable style=\"BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; WIDTH: 428.6pt; BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext\" cellSpacing=0 cellPadding=0 width=571 border=1>\r\n<TBODY>\r\n<TR style=\"HEIGHT: 22.8pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">受理日期<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167.85pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=受理日期 style=\"WIDTH: 140px; HEIGHT: 21px\" size=18 name=slrq></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 93px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">具体时间<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: windowtext 1pt solid; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 135.2pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.8pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt\" width=180>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=具体时间 style=\"WIDTH: 130px; HEIGHT: 21px\" size=16 name=jtsj></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.9pt; mso-yfti-irow: 1\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">受理人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167.85pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=受理人 style=\"WIDTH: 138px; HEIGHT: 21px\" size=18 name=slren></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 93px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">受理方式<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: white; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 135.2pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.9pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=180>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><SELECT title=受理方式 name=slfs><OPTION value=来电 selected>来电</OPTION><OPTION value=来访>来访</OPTION><OPTION value=来信>来信</OPTION><OPTION value=网络>网络</OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION><OPTION value=\"\"></OPTION></SELECT></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 21.6pt; mso-yfti-irow: 2; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 21.6pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">单位<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 21.6pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=单位 style=\"WIDTH: 398px; HEIGHT: 21px\" size=48 name=dw></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 22.15pt; mso-yfti-irow: 3; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">电话<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 167.85pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=224>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p>&nbsp;<INPUT title=电话 style=\"WIDTH: 146px; HEIGHT: 21px\" size=19 name=dianhua></o:p></SPAN></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 63pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=84>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">联系人<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 135.2pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 22.15pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" width=180>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=right><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><INPUT title=联系人 style=\"WIDTH: 131px; HEIGHT: 21px\" size=15 name=nsren></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 23.2pt; mso-yfti-irow: 4; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">事由<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 23.2pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p><TEXTAREA title=事由 style=\"WIDTH: 407px; HEIGHT: 64px\" name=shiyou cols=47></TEXTAREA></o:p></SPAN></P></TD></TR>\r\n<TR style=\"HEIGHT: 45.8pt; mso-yfti-irow: 5; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">受理情况<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=受理情况 style=\"WIDTH: 407px; HEIGHT: 70px\" name=slqk rows=3 cols=49></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 45.8pt; mso-yfti-irow: 6; page-break-inside: avoid\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">督办意见<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=督办意见 style=\"WIDTH: 409px; HEIGHT: 63px\" name=dbyj rows=3 cols=48></TEXTAREA>&nbsp;</FONT></P></TD></TR>\r\n<TR style=\"HEIGHT: 45.8pt; mso-yfti-irow: 7; page-break-inside: avoid; mso-yfti-lastrow: yes\">\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; BACKGROUND: #f3f3f3; PADDING-BOTTOM: 0cm; BORDER-LEFT: windowtext 1pt solid; WIDTH: 187px; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=83>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: center\" align=center><B><SPAN style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\">协办情况<SPAN lang=EN-US><o:p></o:p></SPAN></SPAN></B></P></TD>\r\n<TD style=\"BORDER-RIGHT: windowtext 1pt solid; PADDING-RIGHT: 5.4pt; BORDER-TOP: #ece9d8; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; BORDER-LEFT: #ece9d8; WIDTH: 366.05pt; PADDING-TOP: 0cm; BORDER-BOTTOM: windowtext 1pt solid; HEIGHT: 45.8pt; BACKGROUND-COLOR: transparent; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt\" vAlign=top width=488 colSpan=3>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US style=\"FONT-SIZE: 12pt; FONT-FAMILY: 宋体\"><o:p></o:p></SPAN><FONT face=\"宋体, MS Song\"><TEXTAREA title=协办情况 style=\"WIDTH: 408px; HEIGHT: 55px\" name=xbqk rows=3 cols=49></TEXTAREA>&nbsp;</FONT></P></TD></TR></TBODY></TABLE></DIV>\r\n<P class=MsoNormal style=\"MARGIN: 0cm 0cm 0pt\"><SPAN lang=EN-US><o:p><FONT face=\"Times New Roman\">&nbsp;</FONT></o:p></SPAN></P>',6,0,1,'');
CREATE TABLE `form_field` (
  `formCode` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `type` varchar(20) NOT NULL default 'text',
  `title` varchar(200) default NULL,
  `isMacro` tinyint(1) NOT NULL default '0',
  `defaultValue` varchar(250) default NULL,
  `macroType` varchar(30) NOT NULL default '0',
  KEY `formCode` (`formCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('qjd','beginDate','DATE','开始时间',0,'CURRENT','0'),('pcd','sdf','text','sdf',0,'sdf','0'),('pcd','xs','DATE','sx',0,'2006-04-01','0'),('pcd','dd','checkbox','dd',0,'1','0'),('pcd','bb','DATE_TIME','bb',0,'2006-04-01 11:40:13','0'),('zrbdcszy','textfield','text','数值1',0,'5','0'),('zrbdcszy','textfield','text','数值2',0,'2','0'),('dcdbd','bjrq','text','办结时间',0,'','0'),('dcdbd','zbnryq','textarea','主办内容及要求',0,'','0'),('dcdbd','blqk','textarea','主办单位办理情况',0,'','0'),('dcdbd','dbdwyj','textarea','督办单位意见',0,'','0'),('zbdjd','slrq','text','受理日期',0,'','0'),('zbdjd','jtsj','text','具体时间',0,'','0'),('zbdjd','slren','text','受理人',0,'','0'),('zbdjd','dw','text','单位',0,'','0'),('zbdjd','dianhua','text','电话',0,'','0'),('zbdjd','nsren','text','联系人',0,'','0'),('zbdjd','shiyou','textarea','事由',0,'','0'),('zbdjd','slqk','textarea','受理情况',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('zbdjd','dbyj','textarea','督办意见',0,'','0'),('zbdjd','xbqk','textarea','协办情况',0,'','0'),('zbdjd','slfs','select','受理方式',0,'','0'),('fydjd','qyren','text','签印人',0,'','0'),('fydjd','fyrq','text','复印日期',0,'','0'),('fydjd','filename','text','文件名称',0,'','0'),('fydjd','filenpage','text','文件页数',0,'','0'),('fydjd','fyfs','text','复印份数',0,'1','0'),('fydjd','conutpage','text','总计页数',0,'文件页数*复印份数','0'),('fydjd','department','select','部门',0,'','0'),('fydjd','pagetyoe','select','纸型',0,'','0'),('jcna','draftDate','text','拟案日期',0,'','0'),('jcna','name','text','姓名',0,'','0'),('jcna','department','text','部门',0,'','0'),('jcna','humanVictim','text','人事主管',0,'','0'),('jcna','unitLead','text','单位领导',0,'','0'),('jcna','jtsr','textarea','具体事录',0,'','0'),('jcna','overtureContent','textarea','提案内容',0,'','0'),('jcna','remark','textarea','备注',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('jcna','assort','select','分类',0,'','0'),('rcszjrd','date','text','日期',0,'','0'),('rcszjrd','credenceNumber','text','凭证编号',0,'','0'),('rcszjrd','abstact','text','摘要',0,'','0'),('rcszjrd','debtorMoney','text','借方金额',0,'','0'),('rcszjrd','lenderMoney','text','贷方金额',0,'','0'),('rcszjrd','subject','text','科目',0,'','0'),('rcszjrd','payee','text','领款人',0,'','0'),('rcszjrd','approvePerson','text','批准人',0,'','0'),('rcszjrd','remark','textarea','备注',0,'','0'),('lxsqb','itemTitle','text','项目名称',0,'','0'),('lxsqb','applyDate','text','申请日期',0,'','0'),('lxsqb','itemSummerse','textarea','项目概述',0,'','0'),('lxsqb','itemBenefitExcept','textarea','项目效益预期',0,'','0'),('lxsqb','personalDemannd','textarea','人员需求',0,'','0'),('lxsqb','itemChargeBuget','textarea','项目进度',0,'','0'),('lxsqb','leadAuditing','textarea','领导审核意见',0,'','0'),('cpxgsqs','proposer','text','提案人',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('cpxgsqs','applyDate','DATE','申请日期',0,'2006-04-05','0'),('cpxgsqs','applicationContent','textarea','申请内容',0,'','0'),('cpxgsqs','examineDisposeS','textarea','审批与处理情况',0,'','0'),('cpxgsqs','remark','textarea','备注',0,'','0'),('cpxgsqs','applicationReason','select','申请原因',0,'','0'),('cpxgsqs','outputClass','select','产品类型',0,'','0'),('cpznjcbg','outputName','text','产品名称',0,'','0'),('cpznjcbg','checkDate','text','检查日期',0,'','0'),('cpznjcbg','checkMethod','textarea','检查方法',0,'','0'),('cpznjcbg','checkQualityS','textarea','检查质量标准',0,'','0'),('cpznjcbg','mostlyProblem','textarea','主要问题',0,'','0'),('cpznjcbg','disposalIdea','textarea','处理意见',0,'','0'),('cpznjcbg','prepareStage','textarea','准备采取的对策',0,'','0'),('cpznjcbg','leadCheckA','textarea','领导审核审批',0,'','0'),('ncd','orderformNum','text','订单编号',0,'','0'),('ncd','operation','text','业务员',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('ncd','orderDate','text','订单日期',0,'','0'),('ncd','feedbackMan','text','反馈人',0,'','0'),('ncd','completeDate','text','完工反馈日期',0,'','0'),('ncd','invoiceNum','text','发货单号',0,'','0'),('ncd','consignee','text','收货人',0,'','0'),('ncd','contactPhone','text','联系电话',0,'','0'),('ncd','consigntMode','text','发货方式',0,'','0'),('ncd','CoName','text','公司名称',0,'','0'),('ncd','acceptAddress','text','收货地址',0,'','0'),('ncd','freightMode','text','运费结算方式',0,'','0'),('ncd','operationmanger','text','业务经理',0,'','0'),('ncd','consignmentDate','text','发货日期',0,'','0'),('ncd','consignment','text','发货员',0,'','0'),('ncd','consignmentConfirm','text','发货确认日期',0,'','0'),('ncd','operationAffirm','text','业务确认',0,'','0'),('ncd','feedOperation','text','反馈业务员',0,'','0'),('ncd','feedDate','text','反馈日期',0,'','0'),('ncd','clientDemand','textarea','客户要求',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('ncd','completeBack','textarea','完工反馈',0,'','0'),('ncd','consignmentMes','textarea','发货员发货信息',0,'','0'),('qzkhdjd','unit','text','单位',0,'','0'),('qzkhdjd','name','text','姓名',0,'','0'),('qzkhdjd','phone','text','电话',0,'','0'),('qzkhdjd','appellation','text','称谓',0,'','0'),('qzkhdjd','mailbox','text','电子邮箱',0,'','0'),('qzkhdjd','QQ','text','QQ',0,'','0'),('qzkhdjd','MSN','text','MSN',0,'','0'),('qzkhdjd','address','text','地址',0,'','0'),('qzkhdjd','userDemand','textarea','用户需求',0,'','0'),('qzkhdjd','chargeIdea','textarea','主管意见',0,'','0'),('vehicle_apply','licenseNo','macro','车辆牌照',0,'','macro_vehicle_select'),('vehicle_apply','driver','macro','司机',0,'','macro_driver_select'),('vehicle_apply','person','text','用车人',0,'','0'),('vehicle_apply','dept','macro','用车部门',0,'','macro_dept_select'),('vehicle_apply','beginDate','DATE_TIME','起始时间',0,'2006-05-08','0'),('vehicle_apply','endDate','DATE_TIME','结束时间',0,'2006-05-08','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('vehicle_apply','target','text','目的地',0,'','0'),('vehicle_apply','kilometer','text','里程',0,'','0'),('vehicle_apply','applier','text','申请人',0,'','0'),('vehicle_apply','reason','textarea','事由',0,'','0'),('vehicle_apply','remark','textarea','备注',0,'','0'),('vehicle_apply','result','select','是否同意',0,'','0'),('hysqd','sqren','text','申请人',0,'','0'),('hysqd','apply_date','DATE','申请日期',0,'2006-06-15','0'),('hysqd','meeting_title','text','会议名称',0,'','0'),('hysqd','yt','text','议题',0,'','0'),('hysqd','start_date','DATE_TIME','会议时间',0,'','0'),('hysqd','end_date','DATE_TIME','结束时间',0,'','0'),('hysqd','chrs','text','参会人数',0,'','0'),('hysqd','hyshi','macro','会议室',0,'','macro_boardroom_select'),('hysqd','hycontent','textarea','会议内容',0,'','0'),('hysqd','chrenyuan','textarea','参会人员',0,'','0'),('hysqd','bzwpyq','textarea','会场布置及物品准备要求',0,'','0'),('hysqd','spyjian','textarea','审批意见',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('hysqd','result','select','审批结果',0,'','0'),('sales_linkman','customer','macro','客户单位',0,'','macro_customer_list_win'),('sales_linkman','postPriv','text','联系人职位',0,'','0'),('sales_linkman','linkmanName','text','姓名',0,'','0'),('sales_linkman','postcodeHome','text','家庭邮编',0,'','0'),('sales_linkman','addHome','text','家庭住址',0,'','0'),('sales_linkman','telNoWork','text','工作电话',0,'','0'),('sales_linkman','telNoHome','text','家庭电话',0,'','0'),('sales_linkman','mobile','text','手机',0,'','0'),('sales_linkman','EMAIL','text','email',0,'','0'),('sales_linkman','oicq','text','oicq',0,'','0'),('sales_linkman','msn','text','msn',0,'','0'),('sales_linkman','demo','textarea','备注',0,'','0'),('sales_linkman','linkmanSex','select','性别',0,'','0'),('sales_customer_servi','contact_date','DATE','服务日期',0,'2006-06-28','0'),('sales_customer_servi','customer','macro','客户名称',0,'','macro_customer_list_win'),('sales_customer_servi','lxr','macro','联系人',0,'','macro_linkman_list_win');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_customer_servi','cost','text','服务预估成本',0,'','0'),('sales_customer_servi','time_cost','text','时间成本',0,'','0'),('sales_customer_servi','contact_content','textarea','服务内容描述',0,'','0'),('sales_customer_servi','feedback','textarea','客户反馈意见',0,'','0'),('sales_customer_servi','description','textarea','描述',0,'','0'),('sales_customer_servi','memo','textarea','备注',0,'','0'),('sales_customer_servi','contact_type','select','服务类型',0,'','0'),('sales_customer_servi','satisfy','select','客户满意度',0,'','0'),('sales_customer_service','contact_date','DATE','服务日期',0,'2006-06-28','0'),('sales_customer_service','customer','macro','客户名称',0,'','macro_customer_list_win'),('sales_customer_service','lxr','macro','联系人',0,'','macro_linkman_list_win'),('sales_customer_service','cost','text','服务预估成本',0,'','0'),('sales_customer_service','time_cost','text','时间成本',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_customer_service','contact_content','textarea','服务内容描述',0,'','0'),('sales_customer_service','feedback','textarea','客户反馈意见',0,'','0'),('sales_customer_service','description','textarea','描述',0,'','0'),('sales_customer_service','memo','textarea','备注',0,'','0'),('sales_customer_service','contact_type','select','服务类型',0,'','0'),('sales_customer_service','satisfy','select','客户满意度',0,'','0'),('sales_provider_name','provider_company','macro','供应商单位',0,'','macro_provider_list_win'),('sales_provider_name','post_priv','text','联系人职位',0,'','0'),('sales_provider_name','linkman_name','text','姓名',0,'','0'),('sales_provider_name','birthday','text','生日',0,'','0'),('sales_provider_name','hobby','text','爱好',0,'','0'),('sales_provider_name','postal_home','text','家庭邮编',0,'','0'),('sales_provider_name','add_home','text','家庭住址',0,'','0'),('sales_provider_name','tel_no_work','text','工作电话',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_provider_name','tel_no_home','text','家庭电话',0,'','0'),('sales_provider_name','mobile','text','手机',0,'','0'),('sales_provider_name','email','text','email',0,'','0'),('sales_provider_name','qq','text','qq',0,'','0'),('sales_provider_name','msn','text','msn',0,'','0'),('sales_provider_name','memo','textarea','备注',0,'','0'),('sales_provider_name','sex','select','性别',0,'','0'),('sales_product_info','provider','macro','供应商',0,'','macro_provider_list_win'),('sales_product_info','product_name','text','产品名称',0,'','0'),('sales_product_info','product_type','text','产品型号',0,'','0'),('sales_product_info','measure_unit','text','计量单位',0,'','0'),('sales_product_info','cost_price','text','成本价',0,'','0'),('sales_product_info','standard_price','text','出售价',0,'','0'),('sales_product_info','product_desc','textarea','产品描述',0,'','0'),('sales_product_info','memo','textarea','备注',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_product_info','product_mode','select','产品类别',0,'','0'),('sales_contract','customer','macro','客户名称',0,'','macro_customer_list_win'),('sales_contract','contact_no','text','合同编号',0,'','0'),('sales_contract','contact_name','text','合同名称',0,'','0'),('sales_contract','begindate','DATE','生效日期',0,'','0'),('sales_contract','enddate','DATE','结束时间',0,'','0'),('sales_contract','linkman','text','签约人',0,'','0'),('sales_contract','toname','text','签约人',0,'','0'),('sales_contract','create_date','DATE','创建日期',0,'2006-06-30','0'),('sales_contract','seller_name','macro','创建人',0,'','macro_current_user'),('sales_contract','contact_desc','textarea','合同描述',0,'','0'),('sales_contract','contact_item','textarea','合同条款',0,'','0'),('sales_contract','contact_content','textarea','合同内容',0,'','0'),('sales_contract','demo','textarea','备注',0,'','0'),('sales_contract','contact_type1','select','合同类型',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_contract','contact_type','select','合同打印样式',0,'','0'),('sales_product_service_sell','product_name','macro','服务型产品名称',0,'','macro_product_service_list_win'),('sales_product_service_sell','service','text','服务',0,'','0'),('sales_product_service_sell','price','text','单价',0,'','0'),('sales_product_service_sell','count','text','数量',0,'','0'),('sales_product_service_sell','total_count','text','总价',0,'','0'),('sales_product_service_sell','customer_name','text','客户名称',0,'','0'),('sales_product_service_sell','record_date','DATE','记录日期',0,'2006-06-30','0'),('sales_product_service_sell','sales_man','macro','销售员',0,'','macro_current_user'),('sales_product_service_sell','demo','textarea','备注',0,'','0'),('sales_product_sell','product_name','macro','产品名称',0,'','macro_product_list_win'),('sales_product_sell','service_name','text','服务',0,'','0'),('sales_product_sell','price','text','单价',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_product_sell','count','text','数量',0,'','0'),('sales_product_sell','total_price','text','总价',0,'','0'),('sales_product_sell','customer_name','text','客户名称',0,'','0'),('sales_product_sell','record_date','DATE','记录日期',0,'','0'),('sales_product_sell','sales_man','macro','销售员',0,'','macro_current_user'),('sales_product_sell','demo','textarea','备注',0,'','0'),('sales_customer','sales_person','macro','销售员',0,'','macro_current_user'),('sales_customer','customer','text','客户名称',0,'','0'),('sales_customer','custom_num','text','客户编码',0,'','0'),('sales_customer','custom_short','text','客户简称',0,'','0'),('sales_customer','tel','text','电话',0,'','0'),('sales_customer','fax','text','传真',0,'','0'),('sales_customer','web','text','网址',0,'','0'),('sales_customer','email','text','电子邮件',0,'','0'),('sales_customer','postcode','text','邮政编码',0,'','0'),('sales_customer','constomerAdd','textarea','详细地址',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_customer','enterMemo','textarea','企业描述',0,'','0'),('sales_customer','demo','textarea','备注',0,'','0'),('sales_customer','area','select','地区',0,'','0'),('sales_customer','source','select','客户来源',0,'','0'),('sales_customer','kind','select','客户类别',0,'','0'),('sales_customer','sellMode','select','销售方式',0,'','0'),('sales_customer','attribute','select','行业属性',0,'','0'),('sales_customer','enterType','select','企业性质',0,'','0'),('bgypsnd','applyman','text','申请人',0,'','0'),('bgypsnd','applyDate','text','申请日期',0,'','0'),('bgypsnd','department','text','部门',0,'','0'),('bgypsnd','departCharger','text','部门负责人',0,'','0'),('bgypsnd','snsm','textarea','申领说明',0,'','0'),('bgypsnd','spyj','textarea','审批意见',0,'','0'),('bgypsnd','spjg','select','审批结果',0,'同意','0'),('bgypsnd','snwo','list','申领物品',0,'','0'),('gsfw','ngr','macro','拟稿人',0,'','macro_current_user');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('gsfw','date_ng','DATE','拟稿时间',0,'CURRENT','0'),('gsfw','dept','macro','拟稿部门',0,'','macro_dept_select'),('gsfw','date_ff','DATE','分发日期',0,'','0'),('gsfw','mytitle','text','标题',0,'关于...','0'),('gsfw','ztc','text','主题词',0,'','0'),('gsfw','zhusong','text','主送',0,'','0'),('gsfw','chaosong','text','抄送',0,'','0'),('gsfw','nechao','text','内抄',0,'','0'),('gsfw','bmyj','textarea','部门领导审核意见',0,'','0'),('gsfw','bgsyj','textarea','办公室领导核稿意见',0,'','0'),('gsfw','gsqf','textarea','公司领导签发',0,'','0'),('gsfw','main_text','textarea','正文',0,'','0'),('gsfw','gwlx','select','公文类型',0,'决定','0'),('gsfw','gwqx','select','公文去向',0,'上行文','0'),('gsfw','dj','select','秘密等级',0,'一般','0'),('gsfw','jjcd','select','紧急程度',0,'一般','0'),('gsfw','fwzh','select','发文字号',0,'2006','0'),('qksqd','applyMan','text','申请人',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('qksqd','department','text','部门',0,'','0'),('qksqd','fund','text','款额',0,'','0'),('qksqd','departmentChief','text','部门主管',0,'','0'),('qksqd','financeCharge','text','财务主管',0,'','0'),('qksqd','generalManager','text','总经理',0,'','0'),('qksqd','yong_tu','textarea','用途',0,'','0'),('qksqd','remark','textarea','备注',0,'','0'),('qksqd','paymentMode','select','支付方式',0,'现金','0'),('sales_provider_info','provide_name','text','供应商名称',0,'','0'),('sales_provider_info','provider_code','text','供应商编码',0,'','0'),('sales_provider_info','provider_shot','text','供应商简称',0,'','0'),('sales_provider_info','tel','text','电话',0,'','0'),('sales_provider_info','fax','text','传真',0,'','0'),('sales_provider_info','web','text','网址',0,'','0'),('sales_provider_info','email','text','电子邮件',0,'','0'),('sales_provider_info','postcode','text','邮政编码',0,'','0'),('sales_provider_info','provider_add','text','详细地址',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('sales_provider_info','bank','text','开户行',0,'','0'),('sales_provider_info','account','text','帐号',0,'','0'),('sales_provider_info','demo','textarea','备注',0,'','0'),('sales_provider_info','area','select','地区',0,'江西','0'),('ccsqd','applyman','text','申请人',0,'','0'),('ccsqd','applydate','text','申请日期',0,'','0'),('ccsqd','department','text','部门',0,'','0'),('ccsqd','cckssj','DATE','出差开始时间',0,'CURRENT','0'),('ccsqd','ccjssj','DATE','出差结束时间',0,'CURRENT','0'),('ccsqd','ss','text','ss',0,'','0'),('ccsqd','checkman','text','审批人',0,'','0'),('ccsqd','checkdate','text','审批日期',0,'','0'),('ccsqd','ccsy','textarea','出差事由',0,'','0'),('ccsqd','spyj','textarea','审批意见',0,'','0'),('ccsqd','vehicle','select','交通工具',0,'火车','0'),('ccsqd','spjg','select','审批结果',0,'批准','0'),('fw','dept','macro','起草单位',0,'','macro_dept_select'),('fw','ngr','text','拟搞人',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('fw','fzren','text','负责人',0,'','0'),('fw','ccc','DATE_TIME','ccc',0,'CURRENT','0'),('fw','csren','text','初审人',0,'','0'),('fw','dd','DATE','dd',0,'','0'),('fw','hgr','text','核稿人',0,'','0'),('fw','biaoti','text','标题',0,'','0'),('fw','swzh','text','收文字号',0,'','0'),('fw','fwzh','text','发文字号',0,'','0'),('fw','ztci','text','主题词',0,'','0'),('fw','zsjg','text','主送机关',0,'','0'),('fw','csjg','text','抄送机关',0,'','0'),('fw','jdren','text','校对人',0,'','0'),('fw','yzfs','text','印制份数',0,'','0'),('gzjbd','jbren','text','交办人',0,'','0'),('gzjbd','cbren','text','承办人',0,'','0'),('gzjbd','jbrq','DATE','交办日期',0,'CURRENT','0'),('gzjbd','wcrq','DATE','要求完成日期',0,'CURRENT','0'),('gzjbd','jbr_sign','macro','交办人签名',0,'','macro_sign'),('gzjbd','gznr','textarea','承办人工作内容',0,'','0'),('gzjbd','wcqk','textarea','承办人工作完成情况',0,'','0'),('gzjbd','jbryj','textarea','交办人意见',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('jbdjd','booker','text','登记人',0,'','0'),('jbdjd','bookDate','text','登记日期',0,'','0'),('jbdjd','department','text','部门',0,'','0'),('jbdjd','overtimeBeginTime','DATE','加班开始时间',0,'CURRENT','0'),('jbdjd','overtimeEndTime','DATE','加班结束时间',0,'CURRENT','0'),('jbdjd','testifyMan','text','证明人',0,'','0'),('jbdjd','checkPerson','text','审核人',0,'','0'),('jbdjd','checkDate','text','审核日期',0,'','0'),('jbdjd','overtimeContent','textarea','加班内容',0,'','0'),('jbdjd','checkIdea','textarea','审核意见',0,'','0'),('jbdjd','overtimePlace','select','加班地点',0,'单位','0'),('jbdjd','checkResult','select','审核结果',0,'审核通过','0'),('khfkdjd','booker','text','登记人',0,'','0'),('khfkdjd','bookDate','text','登记日期',0,'','0'),('khfkdjd','userName','text','客户名称',0,'','0'),('khfkdjd','linkman','text','联系人',0,'','0'),('khfkdjd','phone','text','电话',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('khfkdjd','feedContent','textarea','反馈内容',0,'','0'),('khfkdjd','analyseDispose','textarea','分析及处理',0,'','0'),('khfkdjd','chargeIdea','textarea','主管意见',0,'','0'),('khfkdjd','feedMode','select','反馈方式',0,'来电','0'),('shouwen','swsj','text','收文时间',0,'','0'),('shouwen','lwdw','text','来文单位',0,'','0'),('shouwen','wjm','text','文件名',0,'','0'),('shouwen','topic','text','主题词',0,'','0'),('shouwen','page','text','页码',0,'','0'),('shouwen','idea','macro','意见',0,'','macro_idea'),('shouwen','gdren','text','归档人',0,'','0'),('shouwen','abstract','textarea','摘要',0,'','0'),('shouwen','attribute','textarea','意见',0,'','0'),('shouwen','pyyj','textarea','批阅意见',0,'','0'),('shouwen','serct','select','密级',0,'普通','0'),('qjsqd','applyman','text','申请人',0,'','0'),('qjsqd','applydate','text','申请日期',0,'','0'),('qjsqd','department','text','部门',0,'','0');
INSERT INTO `form_field` (`formCode`,`name`,`type`,`title`,`isMacro`,`defaultValue`,`macroType`) VALUES ('qjsqd','qjkssj','DATE','请假开始时间',0,'CURRENT','0'),('qjsqd','qjjssj','DATE','请假结束时间',0,'CURRENT','0'),('qjsqd','qjly','text','请假理由',0,'','0'),('qjsqd','spren','text','审批人',0,'','0'),('qjsqd','sprq','text','审批日期',0,'','0'),('qjsqd','spyj','textarea','审批意见',0,'','0'),('qjsqd','jqlb','select','假期类别',0,'病假','0'),('qjsqd','kjxs','select','扣假形式',0,'无','0'),('qjsqd','spjg','select','审批结果',0,'批准','0'),('sales_product_service','provider','macro','服务提供商',0,'','macro_provider_list_win'),('sales_product_service','service_name','text','服务名称',0,'','0'),('sales_product_service','standad_name','text','服务收费标准',0,'','0'),('sales_product_service','service_desc','textarea','服务描述',0,'','0'),('sales_product_service','demo','textarea','备注',0,'','0');
CREATE TABLE `form_table_bgypsnd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `applyman` varchar(250) default '' COMMENT '申请人',
  `applyDate` varchar(250) default '' COMMENT '申请日期',
  `department` varchar(250) default '' COMMENT '部门',
  `departCharger` varchar(250) default '' COMMENT '部门负责人',
  `snsm` text COMMENT '申领说明',
  `spyj` text COMMENT '审批意见',
  `spjg` varchar(250) default '同意' COMMENT '审批结果',
  `snwo` varchar(250) default '' COMMENT '申领物品',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_ccsqd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `applyman` varchar(250) default '' COMMENT '申请人',
  `applydate` varchar(250) default '' COMMENT '申请日期',
  `department` varchar(250) default '' COMMENT '部门',
  `cckssj` date default '0000-00-00' COMMENT '出差开始时间',
  `ccjssj` date default '0000-00-00' COMMENT '出差结束时间',
  `ss` varchar(250) default '' COMMENT 'ss',
  `checkman` varchar(250) default '' COMMENT '审批人',
  `checkdate` varchar(250) default '' COMMENT '审批日期',
  `ccsy` text COMMENT '出差事由',
  `spyj` text COMMENT '审批意见',
  `vehicle` varchar(250) default '火车' COMMENT '交通工具',
  `spjg` varchar(250) default '批准' COMMENT '审批结果',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_cpxgsqs` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `proposer` varchar(250) default '' COMMENT '提案人',
  `applyDate` date default '0000-00-00' COMMENT '申请日期',
  `applicationContent` text COMMENT '申请内容',
  `examineDisposeS` text COMMENT '审批与处理情况',
  `remark` text COMMENT '备注',
  `applicationReason` varchar(250) default '' COMMENT '申请原因',
  `outputClass` varchar(250) default '' COMMENT '产品类型',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_cpznjcbg` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `outputName` varchar(250) default '' COMMENT '产品名称',
  `checkDate` varchar(250) default '' COMMENT '检查日期',
  `checkMethod` text COMMENT '检查方法',
  `checkQualityS` text COMMENT '检查质量标准',
  `mostlyProblem` text COMMENT '主要问题',
  `disposalIdea` text COMMENT '处理意见',
  `prepareStage` text COMMENT '准备采取的对策',
  `leadCheckA` text COMMENT '领导审核审批',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_dcdbd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `bjrq` varchar(250) default '' COMMENT '办结时间',
  `zbnryq` text COMMENT '主办内容及要求',
  `blqk` text COMMENT '主办单位办理情况',
  `dbdwyj` text COMMENT '督办单位意见',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_fw` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `ngr` varchar(250) default '' COMMENT '拟搞人',
  `fzren` varchar(250) default '' COMMENT '负责人',
  `csren` varchar(250) default '' COMMENT '初审人',
  `hgr` varchar(250) default '' COMMENT '核稿人',
  `biaoti` varchar(250) default '' COMMENT '标题',
  `swzh` varchar(250) default '' COMMENT '收文字号',
  `fwzh` varchar(250) default '' COMMENT '发文字号',
  `ztci` varchar(250) default '' COMMENT '主题词',
  `zsjg` varchar(250) default '' COMMENT '主送机关',
  `csjg` varchar(250) default '' COMMENT '抄送机关',
  `jdren` varchar(250) default '' COMMENT '校对人',
  `yzfs` varchar(250) default '' COMMENT '印制份数',
  `ccc` datetime default '0000-00-00 00:00:00' COMMENT 'ccc',
  `dept` varchar(250) default '' COMMENT '起草单位',
  `dd` date default '0000-00-00' COMMENT 'dd',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_fydjd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `qyren` varchar(250) default '' COMMENT '签印人',
  `fyrq` varchar(250) default '' COMMENT '复印日期',
  `filename` varchar(250) default '' COMMENT '文件名称',
  `filenpage` varchar(250) default '' COMMENT '文件页数',
  `fyfs` varchar(250) default '1' COMMENT '复印份数',
  `conutpage` varchar(250) default '文件页数*复印份数' COMMENT '总计页数',
  `department` varchar(250) default '' COMMENT '部门',
  `pagetyoe` varchar(250) default '' COMMENT '纸型',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_gsfw` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `ztc` varchar(250) default '' COMMENT '主题词',
  `zhusong` varchar(250) default '' COMMENT '主送',
  `chaosong` varchar(250) default '' COMMENT '抄送',
  `nechao` varchar(250) default '' COMMENT '内抄',
  `bmyj` text COMMENT '部门领导审核意见',
  `bgsyj` text COMMENT '办公室领导核稿意见',
  `gsqf` text COMMENT '公司领导签发',
  `gwlx` varchar(250) default '' COMMENT '公文类型',
  `gwqx` varchar(250) default '' COMMENT '公文去向',
  `dj` varchar(250) default '' COMMENT '秘密等级',
  `jjcd` varchar(250) default '' COMMENT '紧急程度',
  `fwzh` varchar(250) default '' COMMENT '发文字号',
  `ngr` varchar(250) default '' COMMENT '拟稿人',
  `dept` varchar(250) default '' COMMENT '拟稿部门',
  `main_text` text COMMENT '正文',
  `date_ng` date default '0000-00-00' COMMENT '拟稿时间',
  `date_ff` date default '0000-00-00' COMMENT '分发日期',
  `mytitle` varchar(250) default '关于...' COMMENT '标题',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_gzjbd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `jbren` varchar(250) default '' COMMENT '交办人',
  `cbren` varchar(250) default '' COMMENT '承办人',
  `wcrq` varchar(250) default '' COMMENT '要求完成日期',
  `gznr` text COMMENT '承办人工作内容',
  `wcqk` text COMMENT '承办人工作完成情况',
  `jbryj` text COMMENT '交办人意见',
  `jbrq` date default '0000-00-00' COMMENT '交办日期',
  `jbr_sign` varchar(250) default '' COMMENT '交办人签名',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_hysqd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `sqren` varchar(250) default '' COMMENT '申请人',
  `chrs` varchar(250) default '' COMMENT '参会人数',
  `hycontent` text COMMENT '会议内容',
  `chrenyuan` text COMMENT '参会人员',
  `bzwpyq` text COMMENT '会场布置及物品准备要求',
  `spyjian` text COMMENT '审批意见',
  `apply_date` date default '0000-00-00' COMMENT '申请日期',
  `start_date` datetime default '0000-00-00 00:00:00' COMMENT '会议时间',
  `end_date` datetime default '0000-00-00 00:00:00' COMMENT '结束时间',
  `result` varchar(250) default '' COMMENT '审批结果',
  `meeting_title` varchar(250) default '' COMMENT '会议名称',
  `hyshi` varchar(250) default '' COMMENT '会议室',
  `yt` varchar(250) default '' COMMENT '议题',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_jbdjd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `booker` varchar(250) default '' COMMENT '登记人',
  `bookDate` varchar(250) default '' COMMENT '登记日期',
  `department` varchar(250) default '' COMMENT '部门',
  `overtimeBeginTime` date default '0000-00-00' COMMENT '加班开始时间',
  `overtimeEndTime` date default '0000-00-00' COMMENT '加班结束时间',
  `testifyMan` varchar(250) default '' COMMENT '证明人',
  `checkPerson` varchar(250) default '' COMMENT '审核人',
  `checkDate` varchar(250) default '' COMMENT '审核日期',
  `overtimeContent` text COMMENT '加班内容',
  `checkIdea` text COMMENT '审核意见',
  `overtimePlace` varchar(250) default '单位' COMMENT '加班地点',
  `checkResult` varchar(250) default '审核通过' COMMENT '审核结果',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_jcna` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `draftDate` varchar(250) default '' COMMENT '拟案日期',
  `name` varchar(250) default '' COMMENT '姓名',
  `department` varchar(250) default '' COMMENT '部门',
  `humanVictim` varchar(250) default '' COMMENT '人事主管',
  `unitLead` varchar(250) default '' COMMENT '单位领导',
  `jtsr` text COMMENT '具体事录',
  `overtureContent` text COMMENT '提案内容',
  `remark` text COMMENT '备注',
  `assort` varchar(250) default '' COMMENT '分类',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_khfkdjd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `booker` varchar(250) default '' COMMENT '登记人',
  `bookDate` varchar(250) default '' COMMENT '登记日期',
  `userName` varchar(250) default '' COMMENT '客户名称',
  `linkman` varchar(250) default '' COMMENT '联系人',
  `phone` varchar(250) default '' COMMENT '电话',
  `feedMode` varchar(250) default '' COMMENT '反馈方式',
  `feedContent` text COMMENT '反馈内容',
  `analyseDispose` text COMMENT '分析及处理',
  `chargeIdea` text COMMENT '主管意见',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_lxsqb` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `itemTitle` varchar(250) default '' COMMENT '项目名称',
  `applyDate` varchar(250) default '' COMMENT '申请日期',
  `itemSummerse` text COMMENT '项目概述',
  `itemBenefitExcept` text COMMENT '项目效益预期',
  `personalDemannd` text COMMENT '人员需求',
  `itemChargeBuget` text COMMENT '项目进度',
  `leadAuditing` text COMMENT '领导审核意见',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_ncd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `orderformNum` varchar(250) default '' COMMENT '订单编号',
  `operation` varchar(250) default '' COMMENT '业务员',
  `orderDate` varchar(250) default '' COMMENT '订单日期',
  `feedbackMan` varchar(250) default '' COMMENT '反馈人',
  `completeDate` varchar(250) default '' COMMENT '完工反馈日期',
  `invoiceNum` varchar(250) default '' COMMENT '发货单号',
  `consignee` varchar(250) default '' COMMENT '收货人',
  `contactPhone` varchar(250) default '' COMMENT '联系电话',
  `consigntMode` varchar(250) default '' COMMENT '发货方式',
  `CoName` varchar(250) default '' COMMENT '公司名称',
  `acceptAddress` varchar(250) default '' COMMENT '收货地址',
  `freightMode` varchar(250) default '' COMMENT '运费结算方式',
  `operationmanger` varchar(250) default '' COMMENT '业务经理',
  `consignmentDate` varchar(250) default '' COMMENT '发货日期',
  `consignment` varchar(250) default '' COMMENT '发货员',
  `consignmentConfirm` varchar(250) default '' COMMENT '发货确认日期',
  `operationAffirm` varchar(250) default '' COMMENT '业务确认',
  `feedOperation` varchar(250) default '' COMMENT '反馈业务员',
  `feedDate` varchar(250) default '' COMMENT '反馈日期',
  `clientDemand` text COMMENT '客户要求',
  `completeBack` text COMMENT '完工反馈',
  `consignmentMes` text COMMENT '发货员发货信息',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_qjd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `beginDate` datetime default '0000-00-00 00:00:00' COMMENT '开始时间',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `form_table_qjd` (`flowId`,`flowTypeCode`,`beginDate`) VALUES (902,'qj','2006-03-15 00:00:00'),(1011,'qj','2006-03-17 00:00:00'),(1041,'qj','2006-03-19 00:00:00');
CREATE TABLE `form_table_qjsqd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `applyman` varchar(250) default '' COMMENT '申请人',
  `applydate` varchar(250) default '' COMMENT '申请日期',
  `department` varchar(250) default '' COMMENT '部门',
  `qjkssj` date default '0000-00-00' COMMENT '请假开始时间',
  `qjjssj` date default '0000-00-00' COMMENT '请假结束时间',
  `qjly` varchar(250) default '' COMMENT '请假理由',
  `spren` varchar(250) default '' COMMENT '审批人',
  `sprq` varchar(250) default '' COMMENT '审批日期',
  `spyj` text COMMENT '审批意见',
  `jqlb` varchar(250) default '' COMMENT '假期类别',
  `kjxs` varchar(250) default '' COMMENT '扣假形式',
  `spjg` varchar(250) default '' COMMENT '审批结果',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_qksqd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `applyMan` varchar(250) default '' COMMENT '申请人',
  `department` varchar(250) default '' COMMENT '部门',
  `fund` varchar(250) default '' COMMENT '款额',
  `departmentChief` varchar(250) default '' COMMENT '部门主管',
  `financeCharge` varchar(250) default '' COMMENT '财务主管',
  `generalManager` varchar(250) default '' COMMENT '总经理',
  `remark` text COMMENT '备注',
  `paymentMode` varchar(250) default '' COMMENT '支付方式',
  `yong_tu` text COMMENT '用途',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_qzkhdjd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `unit` varchar(250) default '' COMMENT '单位',
  `name` varchar(250) default '' COMMENT '姓名',
  `phone` varchar(250) default '' COMMENT '电话',
  `appellation` varchar(250) default '' COMMENT '称谓',
  `mailbox` varchar(250) default '' COMMENT '电子邮箱',
  `QQ` varchar(250) default '' COMMENT 'QQ',
  `MSN` varchar(250) default '' COMMENT 'MSN',
  `address` varchar(250) default '' COMMENT '地址',
  `userDemand` text COMMENT '用户需求',
  `chargeIdea` text COMMENT '主管意见',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_rcszjrd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `date` varchar(250) default '' COMMENT '日期',
  `credenceNumber` varchar(250) default '' COMMENT '凭证编号',
  `abstact` varchar(250) default '' COMMENT '摘要',
  `debtorMoney` varchar(250) default '' COMMENT '借方金额',
  `lenderMoney` varchar(250) default '' COMMENT '贷方金额',
  `subject` varchar(250) default '' COMMENT '科目',
  `payee` varchar(250) default '' COMMENT '领款人',
  `approvePerson` varchar(250) default '' COMMENT '批准人',
  `remark` text COMMENT '备注',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_contract` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `contact_no` varchar(250) default '' COMMENT '合同编号',
  `contact_name` varchar(250) default '' COMMENT '合同名称',
  `begindate` date default '0000-00-00' COMMENT '生效日期',
  `enddate` date default '0000-00-00' COMMENT '结束时间',
  `linkman` varchar(250) default '' COMMENT '签约人',
  `toname` varchar(250) default '' COMMENT '签约人',
  `create_date` date default '0000-00-00' COMMENT '创建日期',
  `seller_name` varchar(250) default '' COMMENT '创建人',
  `contact_desc` text COMMENT '合同描述',
  `contact_item` text COMMENT '合同条款',
  `contact_content` text COMMENT '合同内容',
  `demo` text COMMENT '备注',
  `contact_type1` varchar(250) default '' COMMENT '合同类型',
  `contact_type` varchar(250) default '' COMMENT '合同打印样式',
  `customer` varchar(250) default '' COMMENT '客户名称',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_customer` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `sales_person` varchar(250) default '' COMMENT '销售员',
  `custom_num` varchar(250) default '' COMMENT '客户编码',
  `custom_short` varchar(250) default '' COMMENT '客户简称',
  `tel` varchar(250) default '' COMMENT '电话',
  `fax` varchar(250) default '' COMMENT '传真',
  `web` varchar(250) default '' COMMENT '网址',
  `email` varchar(250) default '' COMMENT '电子邮件',
  `postcode` varchar(250) default '' COMMENT '邮政编码',
  `constomerAdd` text COMMENT '详细地址',
  `enterMemo` text COMMENT '企业描述',
  `demo` text COMMENT '备注',
  `area` varchar(250) default '' COMMENT '地区',
  `source` varchar(250) default '' COMMENT '客户来源',
  `kind` varchar(250) default '' COMMENT '客户类别',
  `sellMode` varchar(250) default '' COMMENT '销售方式',
  `attribute` varchar(250) default '' COMMENT '行业属性',
  `enterType` varchar(250) default '' COMMENT '企业性质',
  `customer` varchar(250) default '' COMMENT '客户名称',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_customer_service` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `contact_date` date default '0000-00-00' COMMENT '服务日期',
  `customer` varchar(250) default '' COMMENT '客户名称',
  `lxr` varchar(250) default '' COMMENT '联系人',
  `cost` varchar(250) default '' COMMENT '服务预估成本',
  `time_cost` varchar(250) default '' COMMENT '时间成本',
  `contact_content` text COMMENT '服务内容描述',
  `feedback` text COMMENT '客户反馈意见',
  `description` text COMMENT '描述',
  `memo` text COMMENT '备注',
  `contact_type` varchar(250) default '' COMMENT '服务类型',
  `satisfy` varchar(250) default '' COMMENT '客户满意度',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_linkman` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `customer` varchar(250) default '' COMMENT '客户单位',
  `postPriv` varchar(250) default '' COMMENT '联系人职位',
  `linkmanName` varchar(250) default '' COMMENT '姓名',
  `postcodeHome` varchar(250) default '' COMMENT '家庭邮编',
  `addHome` varchar(250) default '' COMMENT '家庭住址',
  `telNoWork` varchar(250) default '' COMMENT '工作电话',
  `telNoHome` varchar(250) default '' COMMENT '家庭电话',
  `mobile` varchar(250) default '' COMMENT '手机',
  `EMAIL` varchar(250) default '' COMMENT 'email',
  `oicq` varchar(250) default '' COMMENT 'oicq',
  `msn` varchar(250) default '' COMMENT 'msn',
  `demo` text COMMENT '备注',
  `linkmanSex` varchar(250) default '' COMMENT '性别',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_product_info` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `product_name` varchar(250) default '' COMMENT '产品名称',
  `product_type` varchar(250) default '' COMMENT '产品型号',
  `measure_unit` varchar(250) default '' COMMENT '计量单位',
  `cost_price` varchar(250) default '' COMMENT '成本价',
  `standard_price` varchar(250) default '' COMMENT '出售价',
  `product_desc` text COMMENT '产品描述',
  `memo` text COMMENT '备注',
  `product_mode` varchar(250) default '' COMMENT '产品类别',
  `provider` varchar(250) default '' COMMENT '供应商',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_product_sell` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `product_name` varchar(250) default '' COMMENT '产品名称',
  `service_name` varchar(250) default '' COMMENT '服务',
  `price` varchar(250) default '' COMMENT '单价',
  `count` varchar(250) default '' COMMENT '数量',
  `total_price` varchar(250) default '' COMMENT '总价',
  `customer_name` varchar(250) default '' COMMENT '客户名称',
  `record_date` date default '0000-00-00' COMMENT '记录日期',
  `sales_man` varchar(250) default '' COMMENT '销售员',
  `demo` text COMMENT '备注',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_product_service` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `provider` varchar(250) default '' COMMENT '服务提供商',
  `service_name` varchar(250) default '' COMMENT '服务名称',
  `standad_name` varchar(250) default '' COMMENT '服务收费标准',
  `service_desc` text COMMENT '服务描述',
  `demo` text COMMENT '备注',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_product_service_sell` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `product_name` varchar(250) default '' COMMENT '服务型产品名称',
  `service` varchar(250) default '' COMMENT '服务',
  `price` varchar(250) default '' COMMENT '单价',
  `count` varchar(250) default '' COMMENT '数量',
  `total_count` varchar(250) default '' COMMENT '总价',
  `customer_name` varchar(250) default '' COMMENT '客户名称',
  `record_date` date default '0000-00-00' COMMENT '记录日期',
  `sales_man` varchar(250) default '' COMMENT '销售员',
  `demo` text COMMENT '备注',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_provider_info` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `provide_name` varchar(250) default '' COMMENT '供应商名称',
  `provider_code` varchar(250) default '' COMMENT '供应商编码',
  `provider_shot` varchar(250) default '' COMMENT '供应商简称',
  `tel` varchar(250) default '' COMMENT '电话',
  `fax` varchar(250) default '' COMMENT '传真',
  `web` varchar(250) default '' COMMENT '网址',
  `email` varchar(250) default '' COMMENT '电子邮件',
  `provider_add` varchar(250) default '' COMMENT '详细地址',
  `bank` varchar(250) default '' COMMENT '开户行',
  `account` varchar(250) default '' COMMENT '帐号',
  `demo` text COMMENT '备注',
  `area` varchar(250) default '' COMMENT '地区',
  `postcode` varchar(250) default '' COMMENT '邮政编码',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_sales_provider_name` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `id` int(10) unsigned NOT NULL auto_increment,
  `post_priv` varchar(250) default '' COMMENT '联系人职位',
  `linkman_name` varchar(250) default '' COMMENT '姓名',
  `birthday` varchar(250) default '' COMMENT '生日',
  `hobby` varchar(250) default '' COMMENT '爱好',
  `postal_home` varchar(250) default '' COMMENT '家庭邮编',
  `add_home` varchar(250) default '' COMMENT '家庭住址',
  `tel_no_work` varchar(250) default '' COMMENT '工作电话',
  `tel_no_home` varchar(250) default '' COMMENT '家庭电话',
  `mobile` varchar(250) default '' COMMENT '手机',
  `email` varchar(250) default '' COMMENT 'email',
  `qq` varchar(250) default '' COMMENT 'qq',
  `msn` varchar(250) default '' COMMENT 'msn',
  `memo` text COMMENT '备注',
  `sex` varchar(250) default '' COMMENT '性别',
  `provider_company` varchar(250) default '' COMMENT '供应商单位',
  PRIMARY KEY  (`id`),
  KEY `flowId` (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_shouwen` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `lwdw` varchar(250) default '' COMMENT '来文单位',
  `swsj` varchar(250) default '' COMMENT '收文时间',
  `wjm` varchar(250) default '' COMMENT '文件名',
  `topic` varchar(250) default '' COMMENT '主题词',
  `page` varchar(250) default '' COMMENT '页码',
  `gdren` varchar(250) default '' COMMENT '归档人',
  `abstract` text COMMENT '摘要',
  `attribute` text COMMENT '意见',
  `pyyj` text COMMENT '批阅意见',
  `serct` varchar(250) default '' COMMENT '密级',
  `idea` text COMMENT '意见',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_vehicle_apply` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `licenseNo` varchar(250) default '' COMMENT '车辆牌照',
  `dept` varchar(250) default '' COMMENT '用车部门',
  `target` varchar(250) default '' COMMENT '目的地',
  `person` varchar(250) default '' COMMENT '用车人',
  `result` varchar(250) default '' COMMENT '是否同意',
  `beginDate` datetime default '0000-00-00 00:00:00' COMMENT '起始时间',
  `endDate` datetime default '0000-00-00 00:00:00' COMMENT '结束时间',
  `kilometer` varchar(250) default '' COMMENT '里程',
  `applier` varchar(250) default '' COMMENT '申请人',
  `reason` text COMMENT '事由',
  `remark` text COMMENT '备注',
  `driver` varchar(250) default '' COMMENT '司机',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`),
  KEY `beginDate` (`beginDate`),
  KEY `endDate` (`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `form_table_zbdjd` (
  `flowId` int(11) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '',
  `slrq` varchar(250) default '' COMMENT '受理日期',
  `jtsj` varchar(250) default '' COMMENT '具体时间',
  `slren` varchar(250) default '' COMMENT '受理人',
  `dw` varchar(250) default '' COMMENT '单位',
  `dianhua` varchar(250) default '' COMMENT '电话',
  `nsren` varchar(250) default '' COMMENT '联系人',
  `shiyou` text COMMENT '事由',
  `slqk` text COMMENT '受理情况',
  `dbyj` text COMMENT '督办意见',
  `xbqk` text COMMENT '协办情况',
  `slfs` varchar(250) default '' COMMENT '受理方式',
  PRIMARY KEY  (`flowId`),
  KEY `flowTypeCode` (`flowTypeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `kaoqin` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL default '',
  `reason` varchar(100) default NULL,
  `myDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `type` varchar(10) NOT NULL default '',
  `direction` char(1) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `name` (`name`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `link` (
  `id` int(11) NOT NULL auto_increment,
  `url` varchar(200) NOT NULL default '',
  `title` varchar(100) default NULL,
  `image` text,
  `userName` varchar(50) default NULL,
  `sort` int(11) NOT NULL default '0',
  `kind` varchar(50) NOT NULL default 'N''default''',
  PRIMARY KEY  (`id`),
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `log` (
  `ID` bigint(11) NOT NULL auto_increment,
  `USER_NAME` varchar(20) NOT NULL default '',
  `LOG_DATE` varchar(15) NOT NULL default '',
  `LOG_TYPE` int(11) NOT NULL default '0',
  `IP` varchar(15) default NULL,
  `ACTION` varchar(255) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `log` (`ID`,`USER_NAME`,`LOG_DATE`,`LOG_TYPE`,`IP`,`ACTION`) VALUES (14,'admin','1172557594593',0,'127.0.0.1','登录系统');
CREATE TABLE `message` (
  `id` int(11) NOT NULL default '0',
  `title` tinytext NOT NULL,
  `content` longtext NOT NULL,
  `sender` varchar(20) NOT NULL default '',
  `receiver` varchar(20) NOT NULL default '',
  `type` tinyint(3) unsigned NOT NULL default '0',
  `ip` varchar(15) NOT NULL default '',
  `isreaded` tinyint(3) NOT NULL default '0',
  `rq` varchar(15) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `netdisk_dir_priv` (
  `id` int(11) NOT NULL auto_increment,
  `dir_code` varchar(50) NOT NULL default '',
  `see` tinyint(1) NOT NULL default '1',
  `append` tinyint(1) NOT NULL default '0',
  `del` tinyint(1) NOT NULL default '0',
  `modify` tinyint(1) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `type` tinyint(1) NOT NULL default '0',
  `examine` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `IX_dir_priv` (`dir_code`,`name`),
  KEY `dir_code` (`dir_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `netdisk_directory` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(255) default NULL,
  `parent_code` varchar(50) NOT NULL default '',
  `root_code` varchar(50) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default NULL,
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '1',
  `doc_id` int(11) default NULL,
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(20) NOT NULL default 'default',
  `isShared` tinyint(1) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `netdisk_doc_content` (
  `doc_id` int(11) NOT NULL default '0',
  `content` longtext NOT NULL,
  `page_num` int(11) NOT NULL default '1',
  UNIQUE KEY `IX_doc_content_1` (`doc_id`,`page_num`),
  KEY `IX_doc_content` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `netdisk_document` (
  `id` int(11) NOT NULL default '0',
  `keywords` varchar(50) default NULL,
  `isrelateshow` tinyint(1) default '1',
  `title` varchar(100) NOT NULL default '',
  `class1` varchar(50) NOT NULL default '',
  `author` varchar(100) default NULL,
  `modifiedDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `can_comment` tinyint(1) NOT NULL default '0',
  `summary` text,
  `isHome` tinyint(1) NOT NULL default '0',
  `voteoption` varchar(250) default NULL,
  `voteresult` varchar(50) default NULL,
  `type` tinyint(3) unsigned NOT NULL default '0',
  `examine` tinyint(3) unsigned NOT NULL default '0',
  `nick` varchar(50) default NULL,
  `hit` int(11) NOT NULL default '0',
  `template_id` int(11) NOT NULL default '-1',
  `page_count` int(11) NOT NULL default '1',
  `parent_code` varchar(20) default NULL,
  `isNew` tinyint(1) NOT NULL default '0',
  `flowTypeCode` varchar(20) NOT NULL default '' COMMENT 'not used',
  PRIMARY KEY  (`id`),
  KEY `IX_document` (`class1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `netdisk_document_attach` (
  `id` int(11) NOT NULL auto_increment,
  `doc_id` int(11) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` varchar(255) NOT NULL default '',
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `page_num` int(11) NOT NULL default '1',
  `orders` int(11) NOT NULL default '0',
  `file_size` int(11) NOT NULL default '0',
  `ext` varchar(20) default NULL,
  `uploadDate` datetime default NULL,
  `publicShareDir` varchar(20) NOT NULL default '',
  `USER_NAME` varchar(20) default NULL,
  `PUBLIC_SHARE_DEPTS` varchar(255) default NULL COMMENT 'if null then all user can see it',
  PRIMARY KEY  (`id`),
  KEY `doc_id` (`doc_id`),
  KEY `publicShareDir` (`publicShareDir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `netdisk_public_dir_priv` (
  `id` int(11) NOT NULL auto_increment,
  `dir_code` varchar(50) NOT NULL default '',
  `see` tinyint(1) NOT NULL default '1',
  `append` tinyint(1) NOT NULL default '0',
  `del` tinyint(1) NOT NULL default '0',
  `edit` tinyint(1) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `priv_type` tinyint(1) NOT NULL default '0',
  `examine` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `IX_dir_priv` (`dir_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `netdisk_public_dir_priv` (`id`,`dir_code`,`see`,`append`,`del`,`edit`,`name`,`priv_type`,`examine`) VALUES (8,'99',1,0,0,1,'test',1,0);
CREATE TABLE `netdisk_public_directory` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(255) default NULL,
  `parent_code` varchar(50) NOT NULL default '',
  `root_code` varchar(50) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default NULL,
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '1',
  `doc_id` int(11) default NULL,
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(20) NOT NULL default 'default',
  `mappingAddress` varchar(255) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `netdisk_public_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`mappingAddress`) VALUES ('root','全部目录',0,'全部目录','-1','root',1,5,'2006-05-18 12:00:00',0,2,1,-1,-1,'',NULL),('77','图片',0,'图片','root','root',1,0,'2006-05-18 20:47:47',NULL,2,2,0,-1,'',NULL),('99','视频',0,'视频','root','root',2,1,'2006-05-19 08:50:52',NULL,2,2,0,-1,'',NULL),('OA','OA客户端',0,'OA客户端','root','root',3,0,'2006-06-23 14:55:26',NULL,2,2,NULL,-1,'default',NULL),('dmap','D盘映射',0,'D盘映射','root','root',4,0,'2006-10-11 07:36:03',NULL,2,2,0,-1,'','d:/'),('e','E盘',0,'E盘','root','root',5,0,'2006-10-11 08:22:54',NULL,2,2,NULL,-1,'default','e:/oa'),('pp','pp',0,'pp','99','root',1,0,'2006-11-15 21:08:25',NULL,2,3,NULL,-1,'default','');
CREATE TABLE `oa_message` (
  `id` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `content` text NOT NULL,
  `sender` varchar(20) NOT NULL default '',
  `receiver` varchar(20) NOT NULL default '',
  `rq` datetime NOT NULL default '0000-00-00 00:00:00',
  `type` tinyint(3) unsigned NOT NULL default '0',
  `ip` varchar(15) NOT NULL default '',
  `isreaded` tinyint(1) NOT NULL default '0',
  `isDraft` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `oa_message_attach` (
  `id` int(11) NOT NULL auto_increment,
  `msgId` int(11) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` varchar(255) NOT NULL default '',
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `office_equipment` (
  `Id` int(11) NOT NULL auto_increment,
  `typeId` int(11) default NULL,
  `officeName` varchar(250) default NULL,
  `price` double(10,2) default NULL,
  `storageCount` int(11) default NULL,
  `buyPerson` varchar(50) default NULL,
  `measureUnit` varchar(50) default NULL,
  `buyDate` date default NULL,
  `abstracts` varchar(255) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `office_equipment_op` (
  `Id` int(11) NOT NULL auto_increment,
  `officeId` int(11) default NULL,
  `count` int(11) default NULL,
  `opDate` date default NULL,
  `returnDate` date default NULL,
  `type` tinyint(3) default NULL,
  `person` varchar(50) character set utf8 default NULL,
  `remark` text character set utf8,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `office_equipment_type` (
  `Id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `unit` varchar(50) default NULL,
  `abstracts` varchar(250) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `pcinfo` (
  `id` int(11) NOT NULL default '0',
  `info` varchar(32) NOT NULL default '',
  `hostname` varchar(20) NOT NULL default '',
  `ip` varchar(15) NOT NULL default '',
  `mydate` datetime default NULL,
  `isvalid` tinyint(1) NOT NULL default '0',
  `username` varchar(20) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `photo` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(100) default NULL,
  `image` text,
  `userName` varchar(50) default NULL,
  `sort` int(11) NOT NULL default '0',
  `kind` varchar(50) NOT NULL default '',
  `addDate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `IX_photo` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin2_alipay` (
  `msgRootId` int(11) NOT NULL default '0',
  `alipay_seller` varchar(50) NOT NULL default '',
  `alipay_subject` varchar(100) NOT NULL default '',
  `alipay_price` varchar(20) default NULL,
  `alipay_transport` tinyint(3) NOT NULL default '2',
  `alipay_demo` varchar(100) default NULL,
  `alipay_ww` varchar(30) default NULL,
  `alipay_qq` varchar(20) default NULL,
  `alipay_ordinary` varchar(20) default NULL,
  `alipay_express` varchar(20) default NULL,
  PRIMARY KEY  (`msgRootId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction_bid` (
  `id` int(11) NOT NULL auto_increment,
  `msgRootId` int(11) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `price` decimal(19,4) NOT NULL default '0.0000',
  `bidDate` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `msgRootId` (`msgRootId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction_board` (
  `boardCode` varchar(20) NOT NULL default '',
  `auctionRule` text NOT NULL,
  PRIMARY KEY  (`boardCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `plugin_auction_board` (`boardCode`,`auctionRule`) VALUES ('trade','<P>同城交易，更安全，更快捷，更放心');
CREATE TABLE `plugin_auction_catalog` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default NULL,
  `add_date` varchar(15) default NULL,
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '1',
  `doc_id` int(11) default NULL,
  `template_id` int(11) NOT NULL default '-1',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction_catalog_priv` (
  `id` int(11) NOT NULL auto_increment,
  `dir_code` varchar(50) NOT NULL default '',
  `see` tinyint(1) NOT NULL default '0',
  `append` tinyint(1) NOT NULL default '0',
  `del` tinyint(1) NOT NULL default '0',
  `dir_modify` tinyint(1) NOT NULL default '0',
  `examine` tinyint(1) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `type` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `dir_code` (`dir_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction_order` (
  `id` int(11) NOT NULL default '0',
  `auctionId` int(11) NOT NULL default '0',
  `auctionSellType` tinyint(3) unsigned NOT NULL default '0',
  `seller` varchar(50) NOT NULL default '',
  `buyer` varchar(50) NOT NULL default '',
  `price` decimal(19,4) NOT NULL default '0.0000',
  `moneyCode` varchar(50) NOT NULL default '',
  `totalPrice` decimal(19,4) NOT NULL default '0.0000',
  `amount` int(11) NOT NULL default '0',
  `state` tinyint(3) unsigned NOT NULL default '0',
  `orderDate` varchar(15) NOT NULL default '',
  `payTime` varchar(15) default NULL,
  `deliverTime` varchar(15) default NULL,
  `commodityName` varchar(50) NOT NULL default '',
  `sellerScore` int(11) NOT NULL default '-100',
  `buyerScore` int(11) NOT NULL default '-100',
  PRIMARY KEY  (`id`),
  KEY `auctionId` (`auctionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction_shop` (
  `id` int(11) NOT NULL default '0',
  `userName` varchar(50) NOT NULL default '',
  `shopName` varchar(200) NOT NULL default '',
  `address` varchar(255) default NULL,
  `tel` varchar(50) NOT NULL default '',
  `description` varchar(255) default NULL,
  `isValid` tinyint(1) NOT NULL default '1',
  `reason` varchar(10) default NULL,
  `openDate` varchar(15) NOT NULL default '',
  `logo` varchar(255) default NULL,
  `logoWidth` int(11) NOT NULL default '0',
  `skinCode` varchar(50) NOT NULL default 'default',
  `IS_RECOMMANDED` tinyint(1) NOT NULL default '0',
  `contacter` varchar(50) default NULL,
  PRIMARY KEY  (`userName`),
  KEY `IX_plugin_auction_shop` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction_shop_dir` (
  `code` varchar(50) NOT NULL default '',
  `userName` varchar(50) NOT NULL default '',
  `dirName` varchar(250) NOT NULL default '',
  `catalogCode` varchar(50) NOT NULL default '',
  `sort` int(11) NOT NULL default '0',
  `color` varchar(20) default NULL,
  UNIQUE KEY `IX_plugin_auction_shop_dir` (`userName`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction_worth` (
  `id` int(11) NOT NULL auto_increment,
  `msgRootId` bigint(20) NOT NULL default '0',
  `moneyCode` varchar(50) NOT NULL default '',
  `price` decimal(19,4) NOT NULL default '0.0000',
  `dlt` decimal(19,4) NOT NULL default '0.0000',
  `referPrice` decimal(19,4) NOT NULL default '0.0000',
  `isValid` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `msgRootId` (`msgRootId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_board` (
  `boardCode` varchar(20) NOT NULL default '',
  `boardRule` text NOT NULL,
  `pluginCode` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`pluginCode`(1),`boardCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `plugin_board` (`boardCode`,`boardRule`,`pluginCode`) VALUES ('ygtd','','activity'),('sqzw','','debate'),('bzjl','','flower');
CREATE TABLE `plugin_debate` (
  `msg_id` bigint(20) unsigned NOT NULL default '0',
  `viewpoint1` text NOT NULL,
  `viewpoint2` text,
  `vote_count1` int(11) NOT NULL default '0',
  `vote_count2` int(11) NOT NULL default '0',
  `begin_date` varchar(15) default NULL,
  `end_date` varchar(15) default NULL,
  `user_count1` int(11) NOT NULL default '0',
  `user_count2` int(11) NOT NULL default '0',
  `user_count3` int(11) NOT NULL default '0',
  `vote_user1` text,
  `vote_user2` text,
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `plugin_debate` (`msg_id`,`viewpoint1`,`viewpoint2`,`vote_count1`,`vote_count2`,`begin_date`,`end_date`,`user_count1`,`user_count2`,`user_count3`,`vote_user1`,`vote_user2`) VALUES (106,'777777777777777777','888888888888888888',0,0,'1170259200000','1172592000000',0,1,1,'','');
CREATE TABLE `plugin_debate_viewpoint` (
  `msg_id` bigint(20) default NULL,
  `viewpoint_type` tinyint(3) NOT NULL default '0',
  KEY `msg_id` (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `plugin_debate_viewpoint` (`msg_id`,`viewpoint_type`) VALUES (112,2),(123,2),(124,1);
CREATE TABLE `plugin_info` (
  `id` int(11) NOT NULL default '0',
  `typeCode` varchar(50) NOT NULL default '',
  `userName` varchar(50) NOT NULL default '',
  `addDate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_info_board` (
  `boardCode` varchar(20) NOT NULL default '',
  `boardRule` text NOT NULL,
  PRIMARY KEY  (`boardCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_reward` (
  `msg_id` bigint(20) NOT NULL default '0',
  `score` int(11) NOT NULL default '0',
  `is_end` tinyint(1) default '0',
  `money_code` varchar(20) default NULL,
  `score_given` int(11) NOT NULL default '0',
  `best_msg_id` bigint(20) default '0',
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `plugin_reward` (`msg_id`,`score`,`is_end`,`money_code`,`score_given`,`best_msg_id`) VALUES (81,10,0,'experience',0,0),(84,20,0,'credit',0,0),(108,1,0,'experience',0,0),(111,22,0,'gold',0,0),(121,22,0,'experience',0,0),(131,5,1,'gold',5,0),(132,2,0,NULL,0,0),(133,3,0,NULL,0,0),(141,111,0,'experience',0,0),(161,22,0,'experience',2,0),(162,2,0,NULL,0,0);
CREATE TABLE `plugin_reward_board` (
  `boardCode` varchar(20) NOT NULL default '',
  `boardRule` text NOT NULL,
  PRIMARY KEY  (`boardCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `plugin_reward_board` (`boardCode`,`boardRule`) VALUES ('ygtd','');
CREATE TABLE `post` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(20) NOT NULL default '',
  `description` varchar(255) default NULL,
  `deptCode` varchar(20) default NULL,
  `orders` int(11) default '1',
  `userName` varchar(20) default NULL,
  PRIMARY KEY  (`code`),
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ְλ';
INSERT INTO `post` (`code`,`name`,`description`,`deptCode`,`orders`,`userName`) VALUES ('11569262129061209157','管理员','管理员','admin',1,'admin'),('11576747523289511055','test12332','test12323fff','2deputyzjl',1,'test'),('11577968375781889500','技术总监','技术总监','scb',1,'111');
CREATE TABLE `post_member` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(20) NOT NULL default '',
  `name` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `post_member` (`id`,`code`,`name`,`orders`) VALUES (4,'11576747523289511055','test',1);
CREATE TABLE `postcode` (
  `ID` int(11) NOT NULL default '0',
  `province` varchar(50) default NULL,
  `city` varchar(50) default NULL,
  `postcode` varchar(50) default NULL,
  `qh` varchar(50) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1,'北京','北京','100000','010'),(2,'北京','通县','101100','010'),(3,'北京','昌平','102200','010'),(4,'北京','大兴','102600','010'),(5,'北京','密云','101500','010'),(6,'北京','延庆','102100','010'),(7,'北京','顺义','101300','010'),(8,'北京','怀柔','101400','010'),(9,'北京','平台','101200','010'),(10,'上海','上海','200000','021'),(11,'上海','上海县','201100','021'),(12,'上海','嘉定','201800','021'),(13,'上海','松江','201600','021'),(14,'上海','南汇','201300','021'),(15,'上海','奉贤','201400','021'),(16,'上海','川沙','201200','021'),(17,'上海','青浦','201700','021'),(18,'上海','崇明','202100','021'),(19,'上海','金山','201500','021'),(20,'天津','天津','300000','022'),(21,'天津','蓟县','301900','022'),(22,'天津','宝坻','301800','022'),(23,'天津','武清','301700','022'),(24,'天津','静海','301600','022'),(25,'天津','宁河','301500','022'),(26,'重庆','万县','404000','023');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (27,'重庆','永川','402000','023'),(28,'重庆','北碚','400700','023'),(29,'重庆','巴县','401320','023'),(30,'重庆','江北','401120','023'),(31,'重庆','重庆','400000','023'),(32,'重庆','涪陵','408000','023'),(33,'重庆','石柱','409100','023'),(34,'重庆','丰都','408200','023'),(35,'重庆','南川','408400','023'),(36,'重庆','城口','405900','023'),(37,'重庆','巫溪','405800','023'),(38,'重庆','奉节','404600','023'),(39,'重庆','云阳','404500','023'),(40,'重庆','忠县','404300','023'),(41,'重庆','梁平','405200','023'),(42,'重庆','开县','405400','023'),(43,'重庆','大足','402360','023'),(44,'重庆','荣昌','402460','023'),(45,'重庆','壁山','402760','023'),(46,'重庆','铜梁','402560','023'),(47,'重庆','潼南','402660','023'),(48,'重庆','合川','401520','023'),(49,'重庆','江津','402260','023'),(50,'重庆','双桥','400900','023'),(51,'重庆','南桐','400800','023'),(52,'重庆','长寿','401220','023');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (53,'重庆','綦江','401420','023'),(54,'重庆','黔江','409700','023'),(55,'重庆','武隆','408500','023'),(56,'重庆','垫江','408300','023'),(57,'重庆','巫山','404700','023'),(58,'河北','石家庄','050000','0311'),(59,'河北','获鹿','050200','0311'),(60,'河北','正定','050800','0311'),(61,'河北','栾城','051400','0311'),(62,'河北','井陉','050300','0311'),(63,'河北','元氏','051100','0311'),(64,'河北','新乐','050700','0311'),(65,'河北','无极','052400','0311'),(66,'河北','深泽','052500','0311'),(67,'河北','辛集','052300','0311'),(68,'河北','晋州','052200','0311'),(69,'河北','赵县','051500','0311'),(70,'河北','赞皇','051200','0311'),(71,'河北','高邑','051300','0311'),(72,'河北','平山','050400','0311'),(73,'河北','灵寿','050500','0311'),(74,'河北','行唐','050600','0311'),(75,'河北','保定','071000','0312'),(76,'河北','潢城','072100','0312'),(77,'河北','清苑','071100','0312');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (78,'河北','涞水','074100','0312'),(79,'河北','易县','074200','0312'),(80,'河北','涞源','102900','0312'),(81,'河北','唐县','072300','0312'),(82,'河北','定兴','072600','0312'),(83,'河北','涿州','072700','0312'),(84,'河北','高碑店','074000','0312'),(85,'河北','博野','071300','0312'),(86,'河北','安国','071200','0312'),(87,'河北','定州','073000','0312'),(88,'河北','曲阳','073100','0312'),(89,'河北','阜平','073200','0312'),(90,'河北','高阳','071500','0312'),(91,'河北','徐水','072500','0312'),(92,'河北','容城','071700','0312'),(93,'河北','雄县','071800','0312'),(94,'河北','安新','071600','0312'),(95,'河北','望都','072400','0312'),(96,'河北','蠡县','071400','0312'),(97,'河北','顺平','072200','0312'),(98,'河北','张家口','075000','0313'),(99,'河北','宣化','075100','0313'),(100,'河北','怀安','076100','0313'),(101,'河北','万全','076200','0313'),(102,'河北','张北','076400','0313');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (103,'河北','崇礼','076300','0313'),(104,'河北','沽源','076500','0313'),(105,'河北','尚义','076700','0313'),(106,'河北','康保','076600','0313'),(107,'河北','赤城','075500','0313'),(108,'河北','怀来','075400','0313'),(109,'河北','涿鹿','075600','0313'),(110,'河北','蔚县','075700','0313'),(111,'河北','阳原','075800','0313'),(112,'河北','承德','067000','0314'),(113,'河北','承德县','067400','0314'),(114,'河北','兴隆','067300','0314'),(115,'河北','隆化','068100','0314'),(116,'河北','围场','068400','0314'),(117,'河北','平泉','067500','0314'),(118,'河北','宽城','067600','0314'),(119,'河北','丰宁','068300','0314'),(120,'河北','滦平','068200','0314'),(121,'河北','唐山','063000','0315'),(122,'河北','玉田','064100','0315'),(123,'河北','滦县','063700','0315'),(124,'河北','遵化','064200','0315'),(125,'河北','滦南','063500','0315'),(126,'河北','唐海','063200','0315'),(127,'河北','丰南','063300','0315');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (128,'河北','乐亭','063600','0315'),(129,'河北','丰润','064000','0315'),(130,'河北','迁安','064400','0315'),(131,'河北','迁西','064300','0315'),(132,'河北','廊坊','102800','0316'),(133,'河北','霸州','065700','0316'),(134,'河北','永清','302650','0316'),(135,'河北','大城','302950','0316'),(136,'河北','文安','302850','0316'),(137,'河北','固安','102700','0316'),(138,'河北','香河','302550','0316'),(139,'河北','大厂','101700','0316'),(140,'河北','三河','101600','0316'),(141,'河北','沧州','061000','0317'),(142,'河北','黄骅','061100','0317'),(143,'河北','海兴','061200','0317'),(144,'河北','盐山','061300','0317'),(145,'河北','孟村','061400','0317'),(146,'河北','青县','062600','0317'),(147,'河北','南皮','061500','0317'),(148,'河北','东光','061600','0317'),(149,'河北','吴桥','061800','0317'),(150,'河北','泊头','062100','0317'),(151,'河北','河间','062400','0317'),(152,'河北','肃宁','062300','0317');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (153,'河北','任丘','062500','0317'),(154,'河北','献县','062200','0317'),(155,'河北','衡水','053000','0318'),(156,'河北','铙阳','052700','0318'),(157,'河北','武强','053300','0318'),(158,'河北','武邑','053400','0318'),(159,'河北','阜城','061700','0318'),(160,'河北','景县','053500','0318'),(161,'河北','故城','253800','0318'),(162,'河北','枣强','053100','0318'),(163,'河北','冀县','053200','0318'),(164,'河北','深州','052800','0318'),(165,'河北','安平','052600','0318'),(166,'河北','邢台','054000','0319'),(167,'河北','临西','057800','0319'),(168,'河北','内丘','054200','0319'),(169,'河北','临城','054300','0319'),(170,'河北','柏乡','055400','0319'),(171,'河北','宁晋','051600','0319'),(172,'河北','隆尧','055300','0319'),(173,'河北','巨鹿','055200','0319'),(174,'河北','新河','051700','0319'),(175,'河北','南宫','051800','0319'),(176,'河北','清河','054800','0319'),(177,'河北','威县','054700','0319');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (178,'河北','广宗','054600','0319'),(179,'河北','平乡','054500','0319'),(180,'河北','南和','054400','0319'),(181,'河北','任县','055100','0319'),(182,'河北','沙河','054100','0319'),(183,'河北','邯郸','056000','0310'),(184,'河北','武安','056300','0310'),(185,'河北','临漳','056600','0310'),(186,'河北','磁县','056500','0310'),(187,'河北','涉县','056400','0310'),(188,'河北','成安','056700','0310'),(189,'河北','永年','057100','0310'),(190,'河北','鸡泽','057300','0310'),(191,'河北','曲周','057200','0310'),(192,'河北','丘县','057400','0310'),(193,'河北','馆陶','057700','0310'),(194,'河北','大名','056900','0310'),(195,'河北','魏县','056800','0310'),(196,'河北','广平','057600','0310'),(197,'河北','肥乡','057500','0310'),(198,'河北','秦皇岛','066000','0335'),(199,'河北','昌黎','066600','0335'),(200,'河北','卢龙','066400','0335'),(201,'河北','抚宁','066300','0335'),(202,'河北','青龙','066500','0335');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (203,'山西','朔州','038500','0349'),(204,'山西','怀仁','038300','0349'),(205,'山西','应县','037600','0349'),(206,'山西','右玉','037200','0349'),(207,'山西','山阴','038400','0349'),(208,'山西','忻州','034000','0350'),(209,'山西','原平','034100','0350'),(210,'山西','定襄','035400','0350'),(211,'山西','五台','035500','0350'),(212,'山西','代县','034200','0350'),(213,'山西','繁峙','034300','0350'),(214,'山西','宁武','036000','0350'),(215,'山西','神池','036100','0350'),(216,'山西','五寨','036200','0350'),(217,'山西','岢岚','036300','0350'),(218,'山西','河曲','036500','0350'),(219,'山西','保德','036600','0350'),(220,'山西','偏关','036400','0350'),(221,'山西','静乐','035100','0350'),(222,'山西','太原','030000','0351'),(223,'山西','阳曲','030100','0351'),(224,'山西','娄烦','030300','0351'),(225,'山西','清徐','030400','0351'),(226,'山西','古交','030200','0351'),(227,'山西','大同','037000','0352');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (228,'山西','大同县','037300','0352'),(229,'山西','天镇','038200','0352'),(230,'山西','阳高','038100','0352'),(231,'山西','浑源','037400','0352'),(232,'山西','广灵','037500','0352'),(233,'山西','灵丘','034400','0352'),(234,'山西','左云','037100','0352'),(235,'山西','阳泉','075800','0353'),(236,'山西','孟县','045100','0353'),(237,'山西','平定','045200','0353'),(238,'山西','榆次','030600','0354'),(239,'山西','灵石','031300','0354'),(240,'山西','昔阳','045300','0354'),(241,'山西','和顺','032700','0354'),(242,'山西','左权','032600','0354'),(243,'山西','榆社','031800','0354'),(244,'山西','寿阳','031700','0354'),(245,'山西','太谷','030800','0354'),(246,'山西','祁县','030900','0354'),(247,'山西','平遥','031100','0354'),(248,'山西','介休','031200','0354'),(249,'山西','长治','046000','0355'),(250,'山西','长治县','047100','0355'),(251,'山西','壶关','047300','0355'),(252,'山西','平顺','047400','0355');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (253,'山西','黎城','047600','0355'),(254,'山西','襄垣','046200','0355'),(255,'山西','武乡','046300','0355'),(256,'山西','沁县','046400','0355'),(257,'山西','沁源','046500','0355'),(258,'山西','屯留','046100','0355'),(259,'山西','长子','046600','0355'),(260,'山西','潞城','047500','0355'),(261,'山西','晋城','048000','0356'),(262,'山西','高平','046700','0356'),(263,'山西','阳城','048100','0356'),(264,'山西','沁水','048200','0356'),(265,'山西','陵川','048300','0356'),(266,'山西','临汾','041000','0357'),(267,'山西','候马','043000','0357'),(268,'山西','大宁','042300','0357'),(269,'山西','曲沃','043400','0357'),(270,'山西','翼城','043500','0357'),(271,'山西','襄汾','041500','0357'),(272,'山西','洪洞','031600','0357'),(273,'山西','霍州','031400','0357'),(274,'山西','汾西','031500','0357'),(275,'山西','蒲县','041200','0357'),(276,'山西','隰县','041300','0357'),(277,'山西','永和','041400','0357');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (278,'山西','乡宁','042100','0357'),(279,'山西','吉县','042200','0357'),(280,'山西','安泽','042500','0357'),(281,'山西','浮山','042600','0357'),(282,'山西','古县','042400','0357'),(283,'山西','离石','033000','0358'),(284,'山西','石楼','032500','0358'),(285,'山西','方山','033100','0358'),(286,'山西','临县','033200','0358'),(287,'山西','汾阳','033200','0358'),(288,'山西','文水','032100','0358'),(289,'山西','交城','030500','0358'),(290,'山西','孝义','032300','0358'),(291,'山西','交口','032400','0358'),(292,'山西','中阳','033400','0358'),(293,'山西','柳林','033300','0358'),(294,'山西','兴县','035300','0358'),(295,'山西','岚县','035200','0358'),(296,'山西','运城','044000','0359'),(297,'山西','芮城','044600','0359'),(298,'山西','平陆','044300','0359'),(299,'山西','临猗','044100','0359'),(300,'山西','万荣','044200','0359'),(301,'山西','稷山','043200','0359'),(302,'山西','河津','043300','0359');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (303,'山西','新绛','043100','0359'),(304,'山西','闻喜','043800','0359'),(305,'山西','夏县','044400','0359'),(306,'山西','永剂','044500','0359'),(307,'山西','绛县','043600','0359'),(308,'山西','垣曲','043700','0359'),(309,'河南','商丘','476000','0370'),(310,'河南','商丘县','476100','0370'),(311,'河南','虞城','476300','0370'),(312,'河南','夏邑','476400','0370'),(313,'河南','永城','476600','0370'),(314,'河南','柘城','476200','0370'),(315,'河南','宁陵','476700','0370'),(316,'河南','睢县','476900','0370'),(317,'河南','民权','476800','0370'),(318,'河南','郑州','450000','0371'),(319,'河南','上街','451000','0371'),(320,'河南','荥阳','450100','0371'),(321,'河南','新郑','451100','0371'),(322,'河南','中牟','451400','0371'),(323,'河南','新密','452300','0371'),(324,'河南','登封','452400','0371'),(325,'河南','巩县','451200','0371'),(326,'河南','安阳','455000','0372'),(327,'河南','安阳县','455100','0372');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (328,'河南','汤阴','456100','0372'),(329,'河南','林县','456500','0372'),(330,'河南','内黄','456300','0372'),(331,'河南','滑县','456400','0372'),(332,'河南','新乡','453700','0373'),(333,'河南','卫辉','453100','0373'),(334,'河南','延津','453200','0373'),(335,'河南','原阳','453500','0373'),(336,'河南','获嘉','453800','0373'),(337,'河南','长垣','453400','0373'),(338,'河南','封丘','453300','0373'),(339,'河南','辉县','453600','0373'),(340,'河南','许昌','461000','0374'),(341,'河南','长葛','461500','0374'),(342,'河南','鄢陵','461200','0374'),(343,'河南','禹州','452500','0374'),(344,'河南','平顶山','467000','0375'),(345,'河南','舞钢','462500','0375'),(346,'河南','郏县','467100','0375'),(347,'河南','襄城','452600','0375'),(348,'河南','叶县','467200','0375'),(349,'河南','鲁山','467300','0375'),(350,'河南','宝丰','467400','0375'),(351,'河南','汝州','467500','0375'),(352,'河南','信阳','464000','0376');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (353,'河南','信阳县','464100','0376'),(354,'河南','罗山','464200','0376'),(355,'河南','卧龙','473000','0377'),(356,'河南','宛城','473100','0377'),(357,'河南','邓州','474100','0377'),(358,'河南','西峡','474500','0377'),(359,'河南','浙川','474400','0377'),(360,'河南','方城','473200','0377'),(361,'河南','社旗','473300','0377'),(362,'河南','唐河','473400','0377'),(363,'河南','新野','473500','0377'),(364,'河南','镇平','474200','0377'),(365,'河南','南召','474600','0377'),(366,'河南','桐柏','474700','0377'),(367,'河南','内乡','474300','0377'),(368,'河南','开封','475000','0378'),(369,'河南','开封县','475100','0378'),(370,'河南','兰考','475300','0378'),(371,'河南','杞县','475200','0378'),(372,'河南','通许','452200','0378'),(373,'河南','尉氏','452100','0378'),(374,'河南','洛阳','471000','0379'),(375,'河南','洛宁','471700','0379'),(376,'河南','孟津','471100','0379'),(377,'河南','偃师','471900','0379');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (378,'河南','伊川','471300','0379'),(379,'河南','宜阳','471600','0379'),(380,'河南','新安','471800','0379'),(381,'河南','汝阳','471200','0379'),(382,'河南','嵩县','471400','0379'),(383,'河南','栾川','471500','0379'),(384,'河南','焦作','454100','0391'),(385,'河南','修武','454300','0391'),(386,'河南','武陟','454900','0391'),(387,'河南','温县','454800','0391'),(388,'河南','孟县','454700','0391'),(389,'河南','博爱','454400','0391'),(390,'河南','沁阳','454500','0391'),(391,'河南','济源','454600','0391'),(392,'河南','鹤壁','456600','0392'),(393,'河南','浚县','456200','0392'),(394,'河南','淇县','456700','0392'),(395,'河南','濮阳','457000','0393'),(396,'河南','濮阳县','457002','0393'),(397,'河南','台前','457600','0393'),(398,'河南','范县','457500','0393'),(399,'河南','南乐','457400','0393'),(400,'河南','清丰','457300','0393'),(401,'河南','周口','466000','0394'),(402,'河南','西华','466600','0394');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (403,'河南','淮阳','466700','0394'),(404,'河南','郸城','477100','0394'),(405,'河南','鹿邑','477200','0394'),(406,'河南','沈丘','466300','0394'),(407,'河南','项城','466200','0394'),(408,'河南','扶沟','461300','0394'),(409,'河南','太康','475400','0394'),(410,'河南','商水','466100','0394'),(411,'河南','漯河','462000','0395'),(412,'河南','临颖','462600','0395'),(413,'河南','舞阳','462400','0395'),(414,'河南','郾城','462300','0395'),(415,'河南','驻马店','463000','0396'),(416,'河南','泌阳','463700','0396'),(417,'河南','遂平','463100','0396'),(418,'河南','汝南','463300','0396'),(419,'河南','确山','463200','0396'),(420,'河南','西平','462100','0396'),(421,'河南','上蔡','463800','0396'),(422,'河南','平舆','463400','0396'),(423,'河南','新蔡','463500','0396'),(424,'河南','正阳','463600','0396'),(425,'河南','潢川','465100','0397'),(426,'河南','光山','465400','0397'),(427,'河南','新县','465500','0397');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (428,'河南','淮滨','464400','0397'),(429,'河南','固始','465200','0397'),(430,'河南','商城','465300','0397'),(431,'河南','息县','464300','0397'),(432,'河南','三门峡','472000','0398'),(433,'河南','卢氏','472200','0398'),(434,'河南','渑池','472400','0398'),(435,'河南','义马','472300','0398'),(436,'河南','灵宝','472500','0398'),(437,'河南','陕县','472100','0398'),(438,'辽宁','沈阳','110000','024'),(439,'辽宁','新民','110300','024'),(440,'辽宁','辽中','110200','024'),(441,'辽宁','康平','112200','024'),(442,'辽宁','法库','112100','024'),(443,'辽宁','铁岭','112000','0410'),(444,'辽宁','铁岭县','112600','0410'),(445,'辽宁','昌图','112500','0410'),(446,'辽宁','开原','112300','0410'),(447,'辽宁','西丰','112400','0410'),(448,'辽宁','铁法','112700','0410'),(449,'辽宁','大连','116000','0411'),(450,'辽宁','庄河','116400','0411'),(451,'辽宁','长海','116500','0411'),(452,'辽宁','瓦房店','116300','0411');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (453,'辽宁','普兰店','116600','0411'),(454,'辽宁','金县','116100','0411'),(455,'辽宁','新金','116200','0411'),(456,'辽宁','鞍山','114000','0412'),(457,'辽宁','海城','114200','0412'),(458,'辽宁','台安','114100','0412'),(459,'辽宁','岫岩','114300','0412'),(460,'辽宁','抚顺','113000','0413'),(461,'辽宁','抚顺县','113100','0413'),(462,'辽宁','清原','113300','0413'),(463,'辽宁','新宾','113200','0413'),(464,'辽宁','本溪','117000','0414'),(465,'辽宁','本溪县','117100','0414'),(466,'辽宁','桓仁','117200','0414'),(467,'辽宁','丹东','118000','0415'),(468,'辽宁','东港','118300','0415'),(469,'辽宁','凤城','118100','0415'),(470,'辽宁','宽甸','118200','0415'),(471,'辽宁','锦州','121000','0416'),(472,'辽宁','凌海','121200','0416'),(473,'辽宁','黑山','121400','0416'),(474,'辽宁','义县','121100','0416'),(475,'辽宁','北宁','121300','0416'),(476,'辽宁','营口','115000','0417');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (477,'辽宁','盖州','115200','0417'),(478,'辽宁','大石桥','115100','0417'),(479,'辽宁','阜新','123000','0418'),(480,'辽宁','阜新县','123100','0418'),(481,'辽宁','彰武','123200','0418'),(482,'辽宁','辽阳','111000','0419'),(483,'辽宁','辽阳县','111200','0419'),(484,'辽宁','灯塔','111300','0419'),(485,'辽宁','朝阳','122000','0421'),(486,'辽宁','朝阳县','122600','0421'),(487,'辽宁','建平','122400','0421'),(488,'辽宁','北票','122100','0421'),(489,'辽宁','凌源','122500','0421'),(490,'辽宁','喀喇沁左翼','122300','0421'),(491,'辽宁','盘锦','124000','0427'),(492,'辽宁','盘山','124100','0427'),(493,'辽宁','大洼','124200','0427'),(494,'辽宁','葫芦岛','121500','0429'),(495,'辽宁','绥中','121700','0429'),(496,'辽宁','建昌','122200','0429'),(497,'辽宁','兴城','121600','0429'),(498,'吉林','长春','130000','0431'),(499,'吉林','双阳','130600','0431'),(500,'吉林','农安','130200','0431');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (501,'吉林','九台','130500','0431'),(502,'吉林','德惠','130300','0431'),(503,'吉林','榆树','130400','0431'),(504,'吉林','吉林','132000','0432'),(505,'吉林','永吉','132200','0432'),(506,'吉林','磬石','132300','0432'),(507,'吉林','桦甸','132400','0432'),(508,'吉林','蛟河','132500','0432'),(509,'吉林','舒兰','132600','0432'),(510,'吉林','延吉','133000','0433'),(511,'吉林','汪清','133200','0433'),(512,'吉林','和龙','133500','0433'),(513,'吉林','安图','133600','0433'),(514,'吉林','敦化','133700','0433'),(515,'吉林','图们','133100','0433'),(516,'吉林','龙井','133400','0433'),(517,'吉林','四平','136000','0434'),(518,'吉林','双辽','136400','0434'),(519,'吉林','犁树','136500','0434'),(520,'吉林','公主岭','136100','0434'),(521,'吉林','通化','134000','0435'),(522,'吉林','通化县','134100','0435'),(523,'吉林','集安','134200','0435'),(524,'吉林','白城','137000','0436'),(525,'吉林','通榆','137200','0436');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (526,'吉林','大安','131300','0436'),(527,'吉林','洮南','137100','0436'),(528,'吉林','镇赉','137300','0436'),(529,'吉林','辽源','136200','0437'),(530,'吉林','东辽','136600','0437'),(531,'吉林','东丰','136300','0437'),(532,'吉林','松原','131000','0438'),(533,'吉林','扶余','131200','0438'),(534,'吉林','前郭','131100','0438'),(535,'吉林','长岭','131500','0438'),(536,'吉林','乾安','131400','0438'),(537,'吉林','临江','134100','0439'),(538,'吉林','靖宇','135200','0439'),(539,'吉林','长白','134400','0439'),(540,'吉林','抚松','134500','0439'),(541,'吉林','江源','134300','0439'),(542,'吉林','珲春','133300','0440'),(543,'吉林','梅河口','135000','0448'),(544,'吉林','柳河','135300','0448'),(545,'吉林','辉南','135100','0448'),(546,'黑龙江','哈尔滨','150000','0451'),(547,'黑龙江','阿城','150300','0451'),(548,'黑龙江','通河','150900','0451'),(549,'黑龙江','方正','150800','0451');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (550,'黑龙江','尚志','150600','0451'),(551,'黑龙江','延寿','150700','0451'),(552,'黑龙江','双成','150100','0451'),(553,'黑龙江','肇东','151100','0451'),(554,'黑龙江','宾县','150400','0451'),(555,'黑龙江','木兰','151900','0451'),(556,'黑龙江','五常','150200','0451'),(557,'黑龙江','巴彦','151800','0451'),(558,'黑龙江','呼兰','150500','0451'),(559,'黑龙江','齐齐哈尔','161000','0452'),(560,'黑龙江','克山','161600','0452'),(561,'黑龙江','拜泉','161700','0452'),(562,'黑龙江','依安','161500','0452'),(563,'黑龙江','龙江','161100','0452'),(564,'黑龙江','讷河','161300','0452'),(565,'黑龙江','甘南','162100','0452'),(566,'黑龙江','富裕','161200','0452'),(567,'黑龙江','克东','161800','0452'),(568,'黑龙江','泰来','162400','0452'),(569,'黑龙江','牡丹江','157000','0453'),(570,'黑龙江','林口','157600','0453'),(571,'黑龙江','穆棱','157500','0453'),(572,'黑龙江','东宁','157200','0453');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (573,'黑龙江','海林','157100','0453'),(574,'黑龙江','宁安','157400','0453'),(575,'黑龙江','绥芬河','157300','0453'),(576,'黑龙江','虎林','158400','0453'),(577,'美洲','美国',NULL,'1'),(578,'美洲','加拿大',NULL,'1'),(579,'美洲','中途岛',NULL,'1808'),(580,'美洲','威克岛',NULL,'1808'),(581,'美洲','夏威夷',NULL,'1808'),(582,'美洲','安圭拉岛',NULL,'1809'),(583,'美洲','维尔京群岛',NULL,'1809'),(584,'美洲','特立尼达和多巴哥',NULL,'1809'),(585,'美洲','圣卢西亚',NULL,'1809'),(586,'美洲','圣克里斯托费和尼维斯',NULL,'1809'),(587,'美洲','波多黎各',NULL,'1809'),(588,'美洲','蒙特塞拉特岛',NULL,'1809'),(589,'美洲','牙买加',NULL,'1809'),(590,'美洲','格林纳达',NULL,'1809'),(591,'美洲','多米尼加共和国',NULL,'1809'),(592,'美洲','开曼群岛',NULL,'1809'),(593,'美洲','百慕大群岛',NULL,'1809'),(594,'美洲','安提瓜和巴布达',NULL,'1809'),(595,'美洲','巴哈马',NULL,'1809');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (596,'美洲','巴巴多斯',NULL,'1809'),(597,'美洲','特克斯和凯科斯群岛',NULL,'1809'),(598,'美洲','阿拉斯加',NULL,'1907'),(599,'美洲','法罗群岛',NULL,'298'),(600,'美洲','格陵兰岛',NULL,'299'),(601,'美洲','伯利兹',NULL,'501'),(602,'美洲','危地马拉',NULL,'502'),(603,'美洲','萨尔瓦多',NULL,'503'),(604,'美洲','洪都拉斯',NULL,'504'),(605,'美洲','尼加拉瓜',NULL,'505'),(606,'美洲','哥斯达黎加',NULL,'506'),(607,'美洲','巴拿马',NULL,'507'),(608,'美洲','海地',NULL,'509'),(609,'美洲','墨西哥',NULL,'52'),(610,'美洲','古巴',NULL,'53'),(611,'美洲','福克兰群岛',NULL,'500'),(612,'美洲','秘鲁',NULL,'51'),(613,'美洲','阿根延',NULL,'54'),(614,'美洲','巴西',NULL,'55'),(615,'美洲','智利',NULL,'56'),(616,'美洲','哥伦比亚',NULL,'57'),(617,'美洲','委内瑞拉',NULL,'58'),(618,'美洲','玻利维亚',NULL,'591'),(619,'美洲','圭亚那',NULL,'592'),(620,'美洲','厄瓜多尔',NULL,'593');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (621,'美洲','法属圭亚那',NULL,'594'),(622,'美洲','巴拉圭',NULL,'595'),(623,'美洲','马提尼克',NULL,'596'),(624,'美洲','苏里南',NULL,'597'),(625,'美洲','乌拉圭',NULL,'598'),(626,'美洲','荷属安的列斯群岛',NULL,'599'),(627,'非洲','埃及',NULL,'20'),(628,'非洲','摩洛哥',NULL,'210'),(629,'非洲','阿尔及利亚',NULL,'213'),(630,'非洲','突尼斯',NULL,'216'),(631,'非洲','利比亚',NULL,'218'),(632,'非洲','冈比亚',NULL,'220'),(633,'非洲','塞内加尔',NULL,'221'),(634,'非洲','毛里塔尼亚',NULL,'222'),(635,'非洲','马里',NULL,'223'),(636,'非洲','几内亚',NULL,'224'),(637,'非洲','科特迪瓦',NULL,'225'),(638,'非洲','布基纳法索',NULL,'226'),(639,'非洲','尼日尔',NULL,'227'),(640,'非洲','多哥',NULL,'228'),(641,'非洲','贝宁',NULL,'229'),(642,'非洲','毛里求斯',NULL,'230'),(643,'非洲','利比里亚',NULL,'231'),(644,'非洲','塞拉利昴',NULL,'232'),(645,'非洲','加纳',NULL,'233');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (646,'非洲','尼日利亚',NULL,'234'),(647,'非洲','乍得',NULL,'235'),(648,'非洲','中非',NULL,'236'),(649,'非洲','喀麦隆',NULL,'237'),(650,'非洲','佛得角',NULL,'238'),(651,'非洲','圣多美和普林西比',NULL,'239'),(652,'非洲','赤道几内亚',NULL,'240'),(653,'非洲','加蓬',NULL,'241'),(654,'非洲','刚果',NULL,'242'),(655,'非洲','扎伊尔',NULL,'243'),(656,'非洲','安哥拉',NULL,'244'),(657,'非洲','几内亚比绍',NULL,'245'),(658,'非洲','阿森松',NULL,'247'),(659,'非洲','塞舌尔',NULL,'248'),(660,'非洲','苏丹',NULL,'249'),(661,'非洲','卢旺达',NULL,'250'),(662,'非洲','埃塞俄比亚',NULL,'251'),(663,'非洲','索马里',NULL,'252'),(664,'非洲','吉布提',NULL,'253'),(665,'非洲','肯尼亚',NULL,'254'),(666,'非洲','坦桑尼亚',NULL,'255'),(667,'非洲','乌干达',NULL,'256'),(668,'非洲','布隆迪',NULL,'257'),(669,'非洲','莫桑比克',NULL,'258'),(670,'非洲','赞比亚',NULL,'260');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (671,'非洲','马达加斯加',NULL,'261'),(672,'非洲','留尼旺岛',NULL,'262'),(673,'非洲','津巴布韦',NULL,'263'),(674,'非洲','纳米比亚',NULL,'264'),(675,'非洲','马拉维',NULL,'265'),(676,'非洲','莱索托',NULL,'266'),(677,'黑龙江','鸡西','158100','0453'),(678,'黑龙江','鸡东','158200','0453'),(679,'黑龙江','密山','158300','0453'),(680,'黑龙江','七台河','154600','0453'),(681,'黑龙江','勃利','154500','0453'),(682,'黑龙江','佳木斯','154000','0454'),(683,'黑龙江','依兰','154800','0454'),(684,'黑龙江','汤原','154700','0454'),(685,'黑龙江','桦南','154400','0454'),(686,'黑龙江','富锦','156100','0454'),(687,'黑龙江','抚远','156500','0454'),(688,'黑龙江','同江','156400','0454'),(689,'黑龙江','桦川','154300','0454'),(690,'黑龙江','饶河','156700','0454'),(691,'黑龙江','萝北','154200','0454'),(692,'黑龙江','鹤岗','154100','0454'),(693,'黑龙江','绥滨','156200','0454');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (694,'黑龙江','双鸭山','155100','0454'),(695,'黑龙江','友谊','156900','0454'),(696,'黑龙江','宝清','156600','0454'),(697,'黑龙江','集贤','154900','0454'),(698,'黑龙江','绥化','152000','0458'),(699,'黑龙江','明水','151700','0458'),(700,'黑龙江','庆安','152400','0458'),(701,'黑龙江','海伦','152300','0458'),(702,'黑龙江','绥棱','152200','0458'),(703,'黑龙江','望奎','152100','0458'),(704,'黑龙江','兰西','151500','0458'),(705,'黑龙江','青冈','151600','0458'),(706,'黑龙江','黑河','164300','0456'),(707,'黑龙江','北安','164000','0456'),(708,'黑龙江','孙吴','164200','0456'),(709,'黑龙江','逊克','164400','0456'),(710,'黑龙江','德都','164100','0456'),(711,'黑龙江','嫩江','161400','0456'),(712,'黑龙江','五大连池','164500','0456'),(713,'黑龙江','加格达奇','165000','0457'),(714,'黑龙江','塔河','165200','0457'),(715,'黑龙江','呼玛','165100','0457'),(716,'黑龙江','漠河','165300','0457');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (717,'黑龙江','伊春','153000','0458'),(718,'黑龙江','嘉荫','153200','0458'),(719,'黑龙江','铁力','152500','0458'),(720,'黑龙江','大庆','163000','0459'),(721,'黑龙江','林甸','162300','0459'),(722,'黑龙江','安达','151400','0459'),(723,'黑龙江','肇州','151200','0459'),(724,'黑龙江','杜尔伯特','162000','0459'),(725,'黑龙江','肇源','151300','0459'),(726,'内蒙古','海拉尔','021000','0470'),(727,'内蒙古','鄂温克','021100','0470'),(728,'内蒙古','阿荣旗','162750','0470'),(729,'内蒙古','牙克石','022100','0470'),(730,'内蒙古','扎兰屯','162650','0470'),(731,'内蒙古','鄂伦春','022400','0470'),(732,'内蒙古','陈巴尔虎旗','021500','0470'),(733,'内蒙古','新巴尔虎左旗','021200','0470'),(734,'内蒙古','新巴尔虎右旗','021300','0470'),(735,'内蒙古','根河','022300','0470'),(736,'内蒙古','额尔古纳右旗','022200','0470'),(737,'内蒙古','莫力达瓦旗','162800','0470');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (738,'内蒙古','满洲里','021400','0470'),(739,'内蒙古','呼和浩特','010000','0471'),(740,'内蒙古','托克托','010200','0471'),(741,'内蒙古','土默特左旗','010100','0471'),(742,'内蒙古','和林格尔','011500','0471'),(743,'内蒙古','武川','011700','0471'),(744,'内蒙古','清水河','011600','0471'),(745,'内蒙古','包头','014000','0472'),(746,'内蒙古','固阳','014200','0472'),(747,'内蒙古','土默特右旗','014100','0472'),(748,'内蒙古','白云鄂博','014080','0472'),(749,'内蒙古','达茂旗','014300','0472'),(750,'内蒙古','乌海','016000','0473'),(751,'内蒙古','集宁','012000','0474'),(752,'内蒙古','四子王旗','011800','0474'),(753,'内蒙古','化德','013300','0474'),(754,'内蒙古','丰镇','012100','0474'),(755,'内蒙古','卓资','012300','0474'),(756,'内蒙古','商都','013400','0474'),(757,'内蒙古','兴和','013600','0474'),(758,'内蒙古','凉城','013700','0474'),(759,'内蒙古','察哈尔右翼前旗','012200','0474');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (760,'内蒙古','察哈尔右翼中旗','013500','0474'),(761,'内蒙古','察哈尔右翼后旗','012400','0474'),(762,'内蒙古','通辽','028000','0475'),(763,'内蒙古','开鲁','028400','0475'),(764,'内蒙古','库伦旗','028200','0475'),(765,'内蒙古','奈曼旗','028300','0475'),(766,'内蒙古','扎鲁特旗','029100','0475'),(767,'内蒙古','科尔沁左翼中旗','029300','0475'),(768,'内蒙古','科尔沁左翼后旗','028100','0475'),(769,'内蒙古','霍林郭勒','029200','0475'),(770,'内蒙古','赤峰','024000','0476'),(771,'内蒙古','阿鲁科尔沁','025500','0476'),(772,'内蒙古','宁城','024200','0476'),(773,'内蒙古','敖汉旗','024300','0476'),(774,'内蒙古','翁牛特旗','024500','0476'),(775,'内蒙古','巴林左旗','025400','0476'),(776,'内蒙古','巴林右旗','025100','0476'),(777,'内蒙古','林西','025200','0476'),(778,'内蒙古','克什克腾旗','025300','0476'),(779,'内蒙古','喀喇沁旗','024400','0476');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (780,'内蒙古','东胜','017000','0477'),(781,'内蒙古','达拉特旗','014300','0477'),(782,'内蒙古','伊金霍洛旗','017200','0477'),(783,'内蒙古','准格尔旗','017100','0477'),(784,'内蒙古','杭棉旗','017400','0477'),(785,'内蒙古','乌审','017300','0477'),(786,'内蒙古','鄂托克旗','016100','0477'),(787,'内蒙古','鄂托克前旗','016200','0477'),(788,'内蒙古','临河','015000','0478'),(789,'内蒙古','五原','015100','0478'),(790,'内蒙古','磴口','015200','0478'),(791,'内蒙古','乌拉特前镇','014400','0478'),(792,'内蒙古','乌拉特中镇','015300','0478'),(793,'内蒙古','乌拉特后镇','015500','0478'),(794,'内蒙古','杭锦后旗','015400','0478'),(795,'内蒙古','锡林浩特','026000','0479'),(796,'内蒙古','二连浩特','012600','0479'),(797,'内蒙古','多伦','027300','0479'),(798,'内蒙古','太仆寺旗','027000','0479'),(799,'内蒙古','苏尼特左旗','013100','0479'),(800,'内蒙古','苏尼特右旗','012500','0479');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (801,'内蒙古','镶黄旗','013200','0479'),(802,'台湾','阿莲','000822','886'),(803,'内蒙古','东乌珠穆沁旗','026300','0479'),(804,'内蒙古','西乌珠穆沁旗','026200','0479'),(805,'内蒙古','阿马嗄旗','026100','0479'),(806,'内蒙古','正镶白旗','027100','0479'),(807,'内蒙古','正蓝旗','027200','0479'),(808,'内蒙古','乌兰浩特','137400','0482'),(809,'内蒙古','扎赉特旗','137600','0482'),(810,'内蒙古','突泉','037500','0482'),(811,'内蒙古','科右中旗','029400','0482'),(812,'内蒙古','阿拉善左旗','750300','0483'),(813,'内蒙古','阿拉善右旗','737300','0488'),(814,'内蒙古','额济纳旗','735400','0488'),(815,'江苏','南京','210000','025'),(816,'江苏','江浦','211800','025'),(817,'江苏','六合','211500','025'),(818,'江苏','江宁','211100','025'),(819,'江苏','高淳','211300','025'),(820,'江苏','溧水','211200','025'),(821,'江苏','无锡','214000','0510'),(822,'江苏','江阴','214400','0510');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (823,'江苏','宜兴','214200','0510'),(824,'江苏','锡山','214100','0510'),(825,'江苏','镇江','212000','0511'),(826,'江苏','丹徒','212100','0511'),(827,'江苏','丹阳','212300','0511'),(828,'江苏','句容','212400','0511'),(829,'江苏','扬中','212200','0511'),(830,'江苏','苏州','215000','0512'),(831,'江苏','吴江','215200','0512'),(832,'江苏','吴县','215100','0512'),(833,'江苏','南通','226300','0513'),(834,'江苏','如东','226400','0513'),(835,'江苏','如皋','226500','0513'),(836,'江苏','通州市','226300','0513'),(837,'江苏','海门','226100','0513'),(838,'江苏','启东','226200','0513'),(839,'江苏','海安','226600','0513'),(840,'江苏','扬州','225000','0514'),(841,'江苏','江都','225200','0514'),(842,'江苏','邗江','225100','0514'),(843,'江苏','仪征','211400','0514'),(844,'江苏','高邮','225600','0514'),(845,'江苏','宝应','225800','0514'),(846,'江苏','盐城','224000','0515'),(847,'江苏','响水','224600','0515');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (848,'江苏','滨海','224500','0515'),(849,'江苏','阜宁','224400','0515'),(850,'江苏','射阳','224300','0515'),(851,'江苏','建湖','224700','0515'),(852,'江苏','大丰','224100','0515'),(853,'江苏','东台','224200','0515'),(854,'江苏','徐州','221000','0516'),(855,'江苏','铜山','221100','0516'),(856,'江苏','丰县','221700','0516'),(857,'江苏','沛县','221600','0516'),(858,'江苏','邳县','221300','0516'),(859,'江苏','新沂','221400','0516'),(860,'江苏','睢宁','221200','0516'),(861,'江苏','淮阴','223000','0517'),(862,'江苏','淮阴县','223300','0517'),(863,'江苏','淮安','223200','0517'),(864,'江苏','洪泽','223100','0517'),(865,'江苏','金湖','211600','0517'),(866,'江苏','涟水','223400','0517'),(867,'江苏','盱眙','211700','0517'),(868,'江苏','连云港','222000','0518'),(869,'江苏','东海','222300','0518'),(870,'江苏','赣榆','222100','0518'),(871,'江苏','灌云','222200','0518'),(872,'江苏','灌南','223500','0518');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (873,'江苏','常州','213000','0519'),(874,'江苏','武进','213100','0519'),(875,'江苏','金坛','213200','0519'),(876,'江苏','溧阳','213300','0519'),(877,'江苏','张家港','215600','0520'),(878,'江苏','常熟','215500','0520'),(879,'江苏','昆山','215300','0520'),(880,'江苏','太仓','215400','0520'),(881,'江苏','泰州','225300','0523'),(882,'江苏','靖江','214500','0523'),(883,'江苏','泰兴','225400','0523'),(884,'江苏','姜堰','225500','0523'),(885,'江苏','兴化','225700','0523'),(886,'江苏','沐阳','223600','0527'),(887,'江苏','宿迁','223800','0527'),(888,'江苏','泗阳','223700','0527'),(889,'江苏','泗洪','211900','0527'),(890,'山东','荷泽','274000','0530'),(891,'山东','巨野','274900','0530'),(892,'山东','定陶','274100','0530'),(893,'山东','成武','243600','0530'),(894,'山东','单县','273700','0530'),(895,'山东','曹县','274400','0530'),(896,'山东','东明','274500','0530'),(897,'山东','鄄城','274600','0530');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (898,'山东','郓城','274700','0530'),(899,'山东','济南','250000','0531'),(900,'山东','长清','250300','0531'),(901,'山东','章丘','250200','0531'),(902,'山东','商河','251600','0531'),(903,'山东','济阳','251400','0531'),(904,'山东','平阴','250400','0531'),(905,'山东','青岛','266000','0532'),(906,'山东','胶南','266400','0532'),(907,'山东','胶州','266300','0532'),(908,'山东','平度','262800','0532'),(909,'山东','莱西','266600','0532'),(910,'山东','即墨','266200','0532'),(911,'山东','淄博','255000','0533'),(912,'山东','桓台','256400','0533'),(913,'山东','高青','256300','0533'),(914,'山东','沂源','256100','0533'),(915,'山东','德州','253000','0534'),(916,'山东','庆云','253700','0534'),(917,'山东','监邑','251500','0534'),(918,'山东','夏津','253200','0534'),(919,'山东','平原','253100','0534'),(920,'山东','宁津','253400','0534'),(921,'山东','齐河','251100','0534'),(922,'山东','乐陵','253600','0534');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (923,'山东','武城','253300','0534'),(924,'山东','禹城','251200','0534'),(925,'山东','陵县','253500','0534'),(926,'山东','烟台','264000','0535'),(927,'山东','招远','265400','0535'),(928,'山东','莱阳','265200','0535'),(929,'山东','海阳','265100','0535'),(930,'山东','长岛','265800','0535'),(931,'山东','莱州','261400','0535'),(932,'山东','龙口','265700','0535'),(933,'山东','蓬莱','265600','0535'),(934,'山东','栖霞','265300','0535'),(935,'山东','牟平','264100','0535'),(936,'山东','潍坊','261000','0536'),(937,'山东','寿光','262700','0536'),(938,'山东','昌邑','261300','0536'),(939,'山东','高密','261500','0536'),(940,'山东','诸城','262200','0536'),(941,'山东','安丘','262100','0536'),(942,'山东','临朐','262600','0536'),(943,'山东','青州','262500','0536'),(944,'山东','昌乐','262400','0536'),(945,'山东','济宁','272100','0537'),(946,'山东','梁山','274800','0537'),(947,'山东','曲阜','273100','0537');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (948,'山东','兖州','272000','0537'),(949,'山东','邹城','273500','0537'),(950,'山东','微山','277600','0537'),(951,'山东','鱼台','272300','0537'),(952,'山东','金乡','272200','0537'),(953,'山东','嘉祥','272400','0537'),(954,'山东','泗水','273200','0537'),(955,'山东','汶上','272500','0537'),(956,'山东','泰安','271000','0538'),(957,'山东','新泰','271200','0538'),(958,'山东','宁阳','271400','0538'),(959,'山东','东平','271500','0538'),(960,'山东','肥城','271600','0538'),(961,'山东','临沂','276000','0539'),(962,'山东','苍山','277700','0539'),(963,'山东','平邑','273300','0539'),(964,'山东','蒙阴','276200','0539'),(965,'山东','沂水','276400','0539'),(966,'山东','沂南','276300','0539'),(967,'山东','莒南','276600','0539'),(968,'山东','临沭','276700','0539'),(969,'山东','郯城','276100','0539'),(970,'山东','费县','273400','0539'),(971,'山东','滨州','256600','0543'),(972,'山东','博兴','256500','0543');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (973,'山东','邹平','256200','0543'),(974,'山东','惠民','251700','0543'),(975,'山东','无棣','251900','0543'),(976,'山东','沾化','256800','0543'),(977,'山东','阳信','251800','0543'),(978,'山东','东营','257000','0546'),(979,'山东','利津','257400','0546'),(980,'山东','广饶','257300','0546'),(981,'山东','垦利','257500','0546'),(982,'山东','威海','264200','0631'),(983,'山东','荣城','264300','0631'),(984,'山东','文登','264400','0631'),(985,'山东','乳山','264500','0631'),(986,'山东','枣庄','277100','0632'),(987,'山东','滕州','277500','0632'),(988,'山东','日照','276800','0633'),(989,'山东','五莲','262300','0633'),(990,'山东','河口','257200','0633'),(991,'山东','莱芜','271100','0634'),(992,'山东','聊城','252000','0635'),(993,'山东','临清','252600','0635'),(994,'山东','茌平','252100','0635'),(995,'山东','高唐','251300','0635'),(996,'山东','东阿','252200','0635'),(997,'山东','阳谷','252300','0635');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (998,'山东','莘县','252400','0635'),(999,'山东','冠县','252500','0635'),(1000,'安徽','寿县','232200','0564'),(1001,'安徽','舒城','231300','0564'),(1002,'安徽','六安','237000','0564'),(1003,'安徽','绩溪','245300','0563'),(1004,'安徽','广德','242200','0563'),(1005,'安徽','旌德','242600','0563'),(1006,'安徽','宁国','242300','0563'),(1007,'安徽','郎溪','242100','0563'),(1008,'安徽','泾县','242500','0563'),(1009,'安徽','宣州','242000','0563'),(1010,'安徽','铜陵县','244100','0562'),(1011,'安徽','铜陵','244000','0562'),(1012,'安徽','濉溪','235100','0561'),(1013,'安徽','淮北','235000','0561'),(1014,'安徽','黟县','245500','0559'),(1015,'安徽','休宁','245400','0559'),(1016,'安徽','祁门','245600','0559'),(1017,'安徽','歙县','245200','0559'),(1018,'安徽','黄山','245000','0559'),(1019,'安徽','利辛','236700','0558'),(1020,'安徽','临泉','236400','0558'),(1021,'安徽','太和','236600','0558');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1022,'安徽','颍上','236200','0558'),(1023,'安徽','界首','236500','0558'),(1024,'安徽','涡阳','233600','0558'),(1025,'安徽','蒙城','233500','0558'),(1026,'安徽','阜南','236300','0558'),(1027,'安徽','毫州','236800','0558'),(1028,'安徽','阜阳','236000','0558'),(1029,'安徽','泗县','234300','0557'),(1030,'安徽','灵壁','234200','0557'),(1031,'安徽','砀山','235300','0557'),(1032,'安徽','萧县','235200','0557'),(1033,'安徽','宿州','234000','0557'),(1034,'安徽','岳西','246600','0556'),(1035,'安徽','怀宁','246100','0556'),(1036,'安徽','宿松','246500','0556'),(1037,'安徽','潜山','246300','0556'),(1038,'安徽','望江','246200','0556'),(1039,'安徽','桐城','231400','0556'),(1040,'安徽','枞阳','246700','0556'),(1041,'安徽','太湖','246400','0556'),(1042,'安徽','安庆','246000','0556'),(1043,'安徽','当涂','243100','0555'),(1044,'安徽','马鞍山','243000','0555'),(1045,'安徽','凤台','232100','0554');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1046,'安徽','淮南','232000','0554'),(1047,'安徽','南陵','242400','0553'),(1048,'安徽','繁昌','241200','0553'),(1049,'安徽','芜湖县','241100','0553'),(1050,'安徽','芜湖','241000','0553'),(1051,'安徽','固镇','233700','0552'),(1052,'安徽','怀远','233400','0552'),(1053,'安徽','五河','233300','0552'),(1054,'安徽','蚌埠','233000','0552'),(1055,'安徽','长丰','231100','0551'),(1056,'安徽','肥西','231200','0551'),(1057,'安徽','肥东','231600','0551'),(1058,'安徽','明光','239400','0550'),(1059,'安徽','定远','233200','0550'),(1060,'安徽','来安','239200','0550'),(1061,'安徽','天长','239300','0550'),(1062,'安徽','凤阳','233100','0550'),(1063,'安徽','全椒','239500','0550'),(1064,'安徽','滁州','239000','0550'),(1065,'安徽','合肥','230000','0551'),(1066,'安徽','石台','245100','0566'),(1067,'安徽','东至','247200','0566'),(1068,'安徽','青阳','242800','0566'),(1069,'安徽','贵池','247100','0566');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1070,'安徽','含山','238100','0565'),(1071,'安徽','和县','238200','0565'),(1072,'安徽','庐江','231500','0565'),(1073,'安徽','无为','238300','0565'),(1074,'安徽','巢湖','238000','0565'),(1075,'安徽','金寨','237300','0564'),(1076,'安徽','霍山','237200','0564'),(1077,'安徽','霍邱','237400','0564'),(1078,'浙江','衢州','324000','0570'),(1079,'浙江','江山','324100','0570'),(1080,'浙江','常山','324200','0570'),(1081,'浙江','开化','324300','0570'),(1082,'浙江','衢县','324000','0570'),(1083,'浙江','龙游','324400','0570'),(1084,'浙江','杭州','310000','0571'),(1085,'浙江','余杭','311100','0571'),(1086,'浙江','富阳','311400','0571'),(1087,'浙江','淳安','311700','0571'),(1088,'浙江','建德','311600','0571'),(1089,'浙江','桐庐','311500','0571'),(1090,'浙江','临安','311300','0571'),(1091,'浙江','萧山','311200','0571'),(1092,'浙江','湖州','313000','0572'),(1093,'浙江','德清','313200','0572');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1094,'浙江','安吉','313300','0572'),(1095,'浙江','长兴','313100','0572'),(1096,'浙江','嘉兴','314000','0573'),(1097,'浙江','桐乡','314500','0573'),(1098,'浙江','嘉善','314100','0573'),(1099,'浙江','海盐','314300','0573'),(1100,'浙江','平湖','314200','0573'),(1101,'浙江','海宁','314400','0573'),(1102,'浙江','宁波','315000','0574'),(1103,'浙江','镇海','315200','0574'),(1104,'浙江','余姚','315400','0574'),(1105,'浙江','慈溪','315300','0574'),(1106,'浙江','鄞县','315100','0574'),(1107,'浙江','奉化','315500','0574'),(1108,'浙江','宁海','315600','0574'),(1109,'浙江','象山','315700','0574'),(1110,'浙江','绍兴','312000','0575'),(1111,'浙江','绍兴县','312300','0575'),(1112,'浙江','上虞','312300','0575'),(1113,'浙江','嵊县','312400','0575'),(1114,'浙江','新昌','312500','0575'),(1115,'浙江','诸暨','311800','0575'),(1116,'浙江','台州','317000','0576'),(1117,'浙江','临海','317000','0576');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1118,'浙江','黄岩','317400','0576'),(1119,'浙江','椒江','317700','0576'),(1120,'浙江','温岭','317500','0576'),(1121,'浙江','玉环','317600','0576'),(1122,'浙江','仙居','317300','0576'),(1123,'浙江','天台','317200','0576'),(1124,'浙江','三门','317100','0576'),(1125,'浙江','温州','325000','0577'),(1126,'浙江','瓯海','325000','0577'),(1127,'浙江','永嘉','325100','0577'),(1128,'浙江','乐清','325600','0577'),(1129,'浙江','洞头','325700','0577'),(1130,'浙江','瑞安','325200','0577'),(1131,'浙江','平阳','325400','0577'),(1132,'浙江','苍南','325800','0577'),(1133,'浙江','泰顺','325500','0577'),(1134,'浙江','文成','325300','0577'),(1135,'浙江','丽水','323000','0578'),(1136,'浙江','缙云','321400','0578'),(1137,'浙江','青田','323900','0578'),(1138,'浙江','云和','323600','0578'),(1139,'浙江','庆元','323800','0578'),(1140,'浙江','龙泉','323700','0578'),(1141,'浙江','遂昌','323300','0578');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1142,'浙江','松阳','323400','0578'),(1143,'浙江','景宁','323500','0578'),(1144,'浙江','金华','321000','0579'),(1145,'浙江','金华县','321000','0579'),(1146,'浙江','义乌','322000','0579'),(1147,'浙江','东阳','322100','0579'),(1148,'浙江','浦江','322200','0579'),(1149,'浙江','永康','321300','0579'),(1150,'浙江','武义','321200','0579'),(1151,'浙江','兰溪','321100','0579'),(1152,'浙江','磐安','322300','0579'),(1153,'浙江','舟山','316000','0580'),(1154,'浙江','岱山','316200','0580'),(1155,'浙江','嵊泗','202450','0580'),(1156,'浙江','普陀','316100','0580'),(1157,'福建','福州','350000','0591'),(1158,'福建','闽候','350100','0591'),(1159,'福建','连江','350500','0591'),(1160,'福建','长乐','350200','0591'),(1161,'福建','福清','350300','0591'),(1162,'福建','平潭','350400','0591'),(1163,'福建','永泰','350700','0591'),(1164,'福建','闽清','350800','0591'),(1165,'福建','罗源','350600','0591');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1166,'福建','厦门','361000','0592'),(1167,'福建','同安','361100','0592'),(1168,'福建','宁德','352100','0593'),(1169,'福建','福安','355000','0593'),(1170,'福建','柘荣','355300','0593'),(1171,'福建','福鼎','355200','0593'),(1172,'福建','霞浦','355100','0593'),(1173,'福建','寿宁','355500','0593'),(1174,'福建','古田','352200','0593'),(1175,'福建','屏南','352300','0593'),(1176,'福建','周宁','355400','0593'),(1177,'福建','莆田','351100','0594'),(1178,'福建','仙游','351200','0594'),(1179,'福建','泉州','362000','0595'),(1180,'福建','晋江','362200','0595'),(1181,'福建','南安','362300','0595'),(1182,'福建','安溪','362400','0595'),(1183,'福建','永春','362600','0595'),(1184,'福建','德化','362500','0595'),(1185,'福建','惠安','362100','0595'),(1186,'福建','石狮','362700','0595'),(1187,'福建','漳州','363000','0596'),(1188,'福建','南靖','363600','0596'),(1189,'福建','华安','363800','0596');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1190,'福建','长泰','363900','0596'),(1191,'福建','龙海','363100','0596'),(1192,'福建','漳浦','363200','0596'),(1193,'福建','云霄','363300','0596'),(1194,'福建','东山','363400','0596'),(1195,'福建','诏安','363500','0596'),(1196,'福建','平和','363700','0596'),(1197,'福建','龙岩','364000','0597'),(1198,'福建','漳平','364400','0597'),(1199,'福建','永定','364100','0597'),(1200,'福建','上杭','364200','0597'),(1201,'福建','武平','364300','0597'),(1202,'福建','长汀','366300','0597'),(1203,'福建','连城','366200','0597'),(1204,'福建','三明','365000','0598'),(1205,'福建','沙县','365500','0598'),(1206,'福建','尤溪','365100','0598'),(1207,'福建','大田','366100','0598'),(1208,'福建','永安','366000','0598'),(1209,'福建','清流','365300','0598'),(1210,'福建','宁化','365400','0598'),(1211,'福建','明溪','365200','0598'),(1212,'福建','建宁','354500','0598'),(1213,'福建','泰宁','354400','0598');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1214,'福建','将乐','353300','0598'),(1215,'福建','南平','353000','0599'),(1216,'福建','建瓯','353100','0599'),(1217,'福建','顺昌','353200','0599'),(1218,'福建','建阳','354200','0599'),(1219,'福建','邵武','354000','0599'),(1220,'福建','浦城','353400','0599'),(1221,'福建','松溪','353500','0599'),(1222,'福建','政和','353600','0599'),(1223,'福建','光泽','354100','0599'),(1224,'福建','武夷山','354300','0599'),(1225,'湖北','武汉','430000','027'),(1226,'湖北','武昌','430200','027'),(1227,'湖北','武昌县','430200','027'),(1228,'湖北','蔡甸','430100','027'),(1229,'湖北','黄陂','432200','027'),(1230,'湖北','新洲','431400','027'),(1231,'湖北','襄樊','441000','0710'),(1232,'湖北','襄阳','441100','0710'),(1233,'湖北','宜城','441400','0710'),(1234,'湖北','南漳','441500','0710'),(1235,'湖北','谷城','441700','0710'),(1236,'湖北','枣阳','441200','0710'),(1237,'湖北','老河口','441800','0710');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1238,'湖北','保康','441600','0710'),(1239,'湖北','鄂州','436000','0711'),(1240,'湖北','孝感','432100','0712'),(1241,'湖北','大悟','432800','0712'),(1242,'湖北','汉川','432300','0712'),(1243,'湖北','应城','432400','0712'),(1244,'湖北','云梦','432500','0712'),(1245,'湖北','安陆','432600','0712'),(1246,'湖北','广水','432700','0712'),(1247,'湖北','黄冈','436100','0713'),(1248,'湖北','黄州','436100','0713'),(1249,'湖北','麻城','431600','0713'),(1250,'湖北','红安','431500','0713'),(1251,'湖北','浠水','436200','0713'),(1252,'湖北','罗田','436600','0713'),(1253,'湖北','英山','436700','0713'),(1254,'湖北','蕲春','436300','0713'),(1255,'湖北','黄梅','436500','0713'),(1256,'湖北','武穴','436400','0713'),(1257,'湖北','黄石','435000','0714'),(1258,'湖北','大冶','435100','0714'),(1259,'湖北','咸宁','437000','0715'),(1260,'湖北','阳新','435200','0715'),(1261,'湖北','通山','437600','0715');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1262,'湖北','崇阳','437500','0715'),(1263,'湖北','通城','437400','0715'),(1264,'湖北','蒲圻','437300','0715'),(1265,'湖北','嘉鱼','437200','0715'),(1266,'湖北','荆沙','434100','0716'),(1267,'湖北','沙市','434000','0716'),(1268,'湖北','监利','433300','0716'),(1269,'湖北','石首','434400','0716'),(1270,'湖北','公安','434300','0716'),(1271,'湖北','松滋','434200','0716'),(1272,'湖北','钟祥','431900','0716'),(1273,'湖北','京山','431800','0716'),(1274,'湖北','宜昌','443000','0717'),(1275,'湖北','宜昌县','443100','0717'),(1276,'湖北','远发','444200','0717'),(1277,'湖北','当阳','444100','0717'),(1278,'湖北','枝江','443200','0717'),(1279,'湖北','枝城','443300','0717'),(1280,'湖北','长阳','443500','0717'),(1281,'湖北','五峰','443400','0717'),(1282,'湖北','秭归','443600','0717'),(1283,'湖北','兴山','443700','0717'),(1284,'湖北','恩施','445000','0718'),(1285,'湖北','建始','445300','0718');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1286,'湖北','巴东','444300','0718'),(1287,'湖北','鹤峰','445800','0718'),(1288,'湖北','宣恩','445500','0718'),(1289,'湖北','来凤','445700','0718'),(1290,'湖北','咸丰','445600','0718'),(1291,'湖北','利川','445400','0718'),(1292,'湖北','十堰','442000','0719'),(1293,'湖北','郧县','442500','0719'),(1294,'湖北','丹江口','441900','0719'),(1295,'湖北','房县','442100','0719'),(1296,'湖北','神农架','442400','0719'),(1297,'湖北','竹山','442200','0719'),(1298,'湖北','竹溪','442300','0719'),(1299,'湖北','郧西','442600','0719'),(1300,'湖北','随枣','441200','0722'),(1301,'湖北','随州','441300','0722'),(1302,'湖北','荆门','434500','0727'),(1303,'湖北','江汉','433000','0728'),(1304,'湖北','天门','431700','0728'),(1305,'湖北','潜江','433100','0728'),(1306,'湖北','洪湖','433200','0728'),(1307,'湖南','岳阳','414000','0730'),(1308,'湖南','岳阳县','414100','0730'),(1309,'湖南','湘阴','410500','0730');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1310,'湖南','华容','414200','0730'),(1311,'湖南','临湘','414300','0730'),(1312,'湖南','平江','410400','0730'),(1313,'湖南','汨罗','414400','0730'),(1314,'湖南','长沙','410000','0731'),(1315,'湖南','长沙县','410100','0731'),(1316,'湖南','宁乡','410600','0731'),(1317,'湖南','望城','410200','0731'),(1318,'湖南','浏阳','410300','0731'),(1319,'湖南','湘潭','411100','0732'),(1320,'湖南','湘潭县','411200','0732'),(1321,'湖南','韶山','411300','0732'),(1322,'湖南','湘乡','411400','0732'),(1323,'湖南','株洲','412000','0733'),(1324,'湖南','株洲县','412100','0733'),(1325,'湖南','攸县','412300','0733'),(1326,'湖南','茶陵','412400','0733'),(1327,'湖南','醴陵','412200','0733'),(1328,'湖南','炎陵','412500','0733'),(1329,'湖南','衡阳','421000','0734'),(1330,'湖南','衡阳县','421200','0734'),(1331,'湖南','耒阳','421800','0734'),(1332,'湖南','常宁','421500','0734'),(1333,'湖南','衡南','421100','0734');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1334,'湖南','衡东','421400','0734'),(1335,'湖南','衡山','421300','0734'),(1336,'湖南','祁东','421600','0734'),(1337,'湖南','郴州','423000','0735'),(1338,'湖南','资兴','423400','0735'),(1339,'湖南','桂东','423500','0735'),(1340,'湖南','汝城','424100','0735'),(1341,'湖南','临武','424300','0735'),(1342,'湖南','嘉禾','424500','0735'),(1343,'湖南','安仁','423600','0735'),(1344,'湖南','桂阳','424400','0735'),(1345,'湖南','永兴','423300','0735'),(1346,'湖南','宜章','424200','0735'),(1347,'湖南','常德','415100','0736'),(1348,'湖南','桃源','425700','0736'),(1349,'湖南','汉寿','415900','0736'),(1350,'湖南','石门','415300','0736'),(1351,'湖南','澧县','425500','0736'),(1352,'湖南','津市','415400','0736'),(1353,'湖南','安乡','415600','0736'),(1354,'湖南','临澧','415200','0736'),(1355,'湖南','益阳','413000','0737'),(1356,'湖南','桃江','413400','0737'),(1357,'湖南','安化','413500','0737');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1358,'湖南','南县','413200','0737'),(1359,'湖南','沅江','413100','0737'),(1360,'湖南','娄底','417000','0738'),(1361,'湖南','双峰','411500','0738'),(1362,'湖南','冷水江','417500','0738'),(1363,'湖南','新化','417600','0738'),(1364,'湖南','涟源','417100','0738'),(1365,'湖南','邵阳','422000','0739'),(1366,'湖南','邵阳县','422100','0739'),(1367,'湖南','新宁','422700','0739'),(1368,'湖南','城步','422500','0739'),(1369,'湖南','新邵','422900','0739'),(1370,'湖南','绥宁','422600','0739'),(1371,'湖南','武岗','422400','0739'),(1372,'湖南','洞口','422300','0739'),(1373,'湖南','邵东','422800','0739'),(1374,'湖南','隆回','422200','0739'),(1375,'湖南','吉首','416000','0743'),(1376,'湖南','凤凰','416200','0743'),(1377,'湖南','龙山','416800','0743'),(1378,'湖南','永顺','416700','0743'),(1379,'湖南','保靖','416500','0743'),(1380,'湖南','花垣','416400','0743'),(1381,'湖南','古丈','416300','0743');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1382,'湖南','泸溪','416100','0743'),(1383,'湖南','张家界','416600','0744'),(1384,'湖南','桑植','416900','0744'),(1385,'湖南','慈利','415800','0744'),(1386,'湖南','怀化','418000','0745'),(1387,'湖南','麻阳','419400','0745'),(1388,'湖南','芷江','419100','0745'),(1389,'湖南','黔阳','418100','0745'),(1390,'湖南','溆浦','419300','0745'),(1391,'湖南','通道','418500','0745'),(1392,'湖南','靖州','418400','0745'),(1393,'湖南','会同','418300','0745'),(1394,'湖南','新晃','419200','0745'),(1395,'湖南','辰溪','419500','0745'),(1396,'湖南','沅陵','419600','0745'),(1397,'湖南','洪江','418200','0745'),(1398,'湖南','永州','425000','0746'),(1399,'湖南','东安','425900','0746'),(1400,'湖南','祁阳','421700','0746'),(1401,'湖南','新田','425700','0746'),(1402,'湖南','宁远','425600','0746'),(1403,'湖南','蓝山','425800','0746'),(1404,'湖南','江华','425500','0746'),(1405,'湖南','江永','425400','0746');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1406,'湖南','道县','425300','0746'),(1407,'湖南','双牌','425200','0746'),(1408,'广东','广州','510000','020'),(1409,'广东','番禺','511400','020'),(1410,'广东','花县','510800','020'),(1411,'广东','从化','510900','020'),(1412,'广东','增城','511300','020'),(1413,'广东','汕尾','516600','0660'),(1414,'广东','海丰','516400','0660'),(1415,'广东','陆河','516700','0660'),(1416,'广东','陆丰','516500','0660'),(1417,'广东','潮阳','515100','0661'),(1418,'广东','阳江','529500','0662'),(1419,'广东','阳春','529600','0662'),(1420,'广东','阳东','529500','0662'),(1421,'广东','阳西','529800','0662'),(1422,'广东','揭阳','515500','0663'),(1423,'广东','揭东','515500','0663'),(1424,'广东','惠来','515200','0663'),(1425,'广东','揭西','515400','0663'),(1426,'广东','普宁','515300','0663'),(1427,'广东','茂名','525000','0668'),(1428,'广东','化州','525100','0668'),(1429,'广东','高州','525200','0668');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1430,'广东','信宜','525300','0668'),(1431,'广东','电白','525400','0668'),(1432,'广东','江门','529000','0750'),(1433,'广东','台山','529200','0750'),(1434,'广东','开平','529300','0750'),(1435,'广东','恩平','529400','0750'),(1436,'广东','新会','529100','0750'),(1437,'广东','鹤山','529700','0750'),(1438,'广东','韶关','512000','0751'),(1439,'广东','曲江','512100','0751'),(1440,'广东','翁源','512600','0751'),(1441,'广东','新丰','511100','0751'),(1442,'广东','始兴','512500','0751'),(1443,'广东','仁化','512300','0751'),(1444,'广东','南雄','512400','0751'),(1445,'广东','乳源','512700','0751'),(1446,'广东','乐昌','512200','0751'),(1447,'广东','惠州','516000','0752'),(1448,'广东','惠东','526300','0752'),(1449,'广东','惠阳','516200','0752'),(1450,'广东','博罗','516100','0752'),(1451,'广东','龙门','511200','0752'),(1452,'广东','梅州','514000','0753'),(1453,'广东','梅县','514000','0753');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1454,'广东','蕉岭','514100','0753'),(1455,'广东','大埔','514200','0753'),(1456,'广东','丰顺','514300','0753'),(1457,'广东','五华','514400','0753'),(1458,'广东','兴宁','514500','0753'),(1459,'广东','平远','514600','0753'),(1460,'广东','汕头','515000','0754'),(1461,'广东','澄海','515800','0754'),(1462,'广东','南澳','515900','0754'),(1463,'广东','深圳','518000','0755'),(1464,'广东','宝安','518100','0755'),(1465,'广东','珠海','519000','0756'),(1466,'广东','斗门','519100','0756'),(1467,'广东','佛山','528000','0757'),(1468,'广东','南海','528200','0757'),(1469,'广东','高明','528500','0757'),(1470,'广东','三水','528100','0757'),(1471,'广东','肇庆','526000','0758'),(1472,'广东','高要','526100','0758'),(1473,'广东','四会','526200','0758'),(1474,'广东','怀集','526400','0758'),(1475,'广东','封开','526500','0758'),(1476,'广东','德庆','526600','0758'),(1477,'广东','广宁','526300','0758');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1478,'广东','湛江','524000','0759'),(1479,'广东','遂溪','524300','0759'),(1480,'广东','廉江','524400','0759'),(1481,'广东','吴川','524500','0759'),(1482,'广东','徐闻','524100','0759'),(1483,'广东','雷州','524200','0759'),(1484,'广东','中山','528400','0760'),(1485,'广东','河源','517000','0762'),(1486,'广东','连平','517100','0762'),(1487,'广东','和平','517200','0762'),(1488,'广东','龙川','517300','0762'),(1489,'广东','紫金','517400','0762'),(1490,'广东','清远','511500','0763'),(1491,'广东','佛冈','511600','0763'),(1492,'广东','英德','513000','0763'),(1493,'广东','连山','513200','0763'),(1494,'广东','阳山','513100','0763'),(1495,'广东','连南','513300','0763'),(1496,'广东','连州','513400','0763'),(1497,'广东','顺德','528300','0765'),(1498,'广东','云浮','527300','0766'),(1499,'广东','罗定','527200','0766'),(1500,'广东','郁南','527100','0766'),(1501,'广东','新兴','527400','0766');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1502,'广东','潮州','515600','0768'),(1503,'广东','潮安','515600','0768'),(1504,'广东','饶平','515700','0768'),(1505,'广东','东莞','511700','0769'),(1506,'广西','防城港','535700','0770'),(1507,'广西','上思','535500','0770'),(1508,'广西','南宁','530000','0771'),(1509,'广西','上林','530500','0771'),(1510,'广西','凭祥','532600','0771'),(1511,'广西','邕宁','530200','0771'),(1512,'广西','崇左','532200','0771'),(1513,'广西','宁明','532500','0771'),(1514,'广西','武鸣','530100','0771'),(1515,'广西','马山','530600','0771'),(1516,'广西','龙州','532400','0771'),(1517,'广西','宾阳','530400','0771'),(1518,'广西','大新','532300','0771'),(1519,'广西','天等','532800','0771'),(1520,'广西','横县','530300','0771'),(1521,'广西','隆安','532700','0771'),(1522,'广西','扶绥','532100','0771'),(1523,'广西','柳州','545000','0772'),(1524,'广西','柳江','545100','0772'),(1525,'广西','鹿寨','545600','0772');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1526,'广西','柳城','545200','0772'),(1527,'广西','三江','545500','0772'),(1528,'广西','融安','545400','0772'),(1529,'广西','融冰','545300','0772'),(1530,'广西','金秀','545700','0772'),(1531,'广西','合山','546500','0772'),(1532,'广西','忻城','546200','0772'),(1533,'广西','来宾','546100','0772'),(1534,'广西','武宣','545900','0772'),(1535,'广西','象州','545800','0772'),(1536,'广西','桂林','541000','0773'),(1537,'广西','阳朔','541900','0773'),(1538,'广西','临桂','541100','0773'),(1539,'广西','荔浦','546600','0773'),(1540,'广西','灌阳','541600','0773'),(1541,'广西','平乐','542400','0773'),(1542,'广西','兴安','541300','0773'),(1543,'广西','灵川','541200','0773'),(1544,'广西','全州','541500','0773'),(1545,'广西','永福','541800','0773'),(1546,'广西','龙胜','541700','0773'),(1547,'广西','恭城','542500','0773'),(1548,'广西','资源','541400','0773'),(1549,'广西','梧州','543000','0774');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1550,'广西','苍梧','543100','0774'),(1551,'广西','藤县','543300','0774'),(1552,'广西','岑溪','543200','0774'),(1553,'广西','昭平','546800','0774'),(1554,'广西','贺县','542800','0774'),(1555,'广西','蒙山','546700','0774'),(1556,'广西','钟山','542600','0774'),(1557,'广西','富川','542700','0774'),(1558,'广西','玉林','537000','0775'),(1559,'广西','容县','537500','0775'),(1560,'广西','北流','537400','0775'),(1561,'广西','陆川','537700','0775'),(1562,'广西','博白','537600','0775'),(1563,'广西','贵港','537100','0775'),(1564,'广西','桂平','537200','0775'),(1565,'广西','平南','537300','0775'),(1566,'广西','百色','533000','0776'),(1567,'广西','田林','533300','0776'),(1568,'广西','隆林','533400','0776'),(1569,'广西','西林','533500','0776'),(1570,'广西','凌云','533100','0776'),(1571,'广西','田阳','533600','0776'),(1572,'广西','靖西','533800','0776'),(1573,'广西','田东','531500','0776');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1574,'广西','乐业','533200','0776'),(1575,'广西','平果','531400','0776'),(1576,'广西','德保','533700','0776'),(1577,'广西','那坡','533900','0776'),(1578,'广西','钦州','535000','0777'),(1579,'广西','灵山','535400','0777'),(1580,'广西','浦北','535300','0777'),(1581,'广西','河池','547000','0778'),(1582,'广西','宜州','546300','0778'),(1583,'广西','罗城','546400','0778'),(1584,'广西','环江','547100','0778'),(1585,'广西','天峨','547300','0778'),(1586,'广西','凤山','547600','0778'),(1587,'广西','东兰','547400','0778'),(1588,'广西','南丹','547200','0778'),(1589,'广西','巴马','547500','0778'),(1590,'广西','都安','530700','0778'),(1591,'广西','大化','530800','0778'),(1592,'广西','北海','536000','0779'),(1593,'广西','合浦','536100','0779'),(1594,'江西','新余','336500','0790'),(1595,'江西','分宜','336600','0790'),(1596,'江西','南昌','330000','0791'),(1597,'江西','南昌县','330200','0791');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1598,'江西','新建','330100','0791'),(1599,'江西','进贤','331700','0791'),(1600,'江西','安义','330500','0791'),(1601,'江西','九江','332000','0792'),(1602,'江西','九江县','332100','0792'),(1603,'江西','庐山','332900','0792'),(1604,'江西','修水','322400','0792'),(1605,'江西','湖口','332500','0792'),(1606,'江西','星子','332800','0792'),(1607,'江西','瑞昌','333200','0792'),(1608,'江西','德安','330400','0792'),(1609,'江西','彭泽','332700','0792'),(1610,'江西','都昌','332600','0792'),(1611,'江西','永修','330300','0792'),(1612,'江西','武宁','332300','0792'),(1613,'江西','上饶','334000','0793'),(1614,'江西','上饶县','334100','0793'),(1615,'江西','玉山','334700','0793'),(1616,'江西','余干','335100','0793'),(1617,'江西','弋阳','334400','0793'),(1618,'江西','波阳','333100','0793'),(1619,'江西','广丰','334600','0793'),(1620,'江西','万年','335500','0793'),(1621,'江西','铅山','334500','0793');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1622,'江西','横峰','334300','0793'),(1623,'江西','婺源','333200','0793'),(1624,'江西','德兴','334200','0793'),(1625,'江西','抚州','344000','0794'),(1626,'江西','资溪','335300','0794'),(1627,'江西','广昌','344900','0794'),(1628,'江西','东乡','331800','0794'),(1629,'江西','金溪','344800','0794'),(1630,'江西','崇仁','344200','0794'),(1631,'江西','临川','344100','0794'),(1632,'江西','宜黄','344400','0794'),(1633,'江西','尔安','344300','0794'),(1634,'江西','南城','344700','0794'),(1635,'江西','南丰','344500','0794'),(1636,'江西','黎川','344600','0794'),(1637,'江西','宜春','336000','0795'),(1638,'江西','宜丰','336300','0795'),(1639,'江西','上高','336400','0795'),(1640,'江西','奉新','330700','0795'),(1641,'江西','靖安','330600','0795'),(1642,'江西','高安','330800','0795'),(1643,'江西','丰城','331100','0795'),(1644,'江西','樟树','331200','0795'),(1645,'江西','万载','336100','0795');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1646,'江西','铜鼓','336200','0795'),(1647,'江西','吉安','343000','0796'),(1648,'江西','吉安县','343100','0796'),(1649,'江西','新干','331300','0796'),(1650,'江西','永丰','331500','0796'),(1651,'江西','吉水','331600','0796'),(1652,'江西','峡江','331400','0796'),(1653,'江西','泰和','343700','0796'),(1654,'江西','万安','343800','0796'),(1655,'江西','遂川','343900','0796'),(1656,'江西','宁冈','343500','0796'),(1657,'江西','永新','343400','0796'),(1658,'江西','井岗山','343600','0796'),(1659,'江西','安福','343200','0796'),(1660,'江西','赣州','341000','0797'),(1661,'江西','瑞金','342500','0797'),(1662,'江西','于都','342300','0797'),(1663,'江西','兴国','342400','0797'),(1664,'江西','宁都','342800','0797'),(1665,'江西','石城','342700','0797'),(1666,'江西','寻乌','342200','0797'),(1667,'江西','南康','341400','0797'),(1668,'江西','赣县','341100','0797'),(1669,'江西','大余','341500','0797');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1670,'江西','上犹','341200','0797'),(1671,'江西','崇义','341300','0797'),(1672,'江西','信丰','341600','0797'),(1673,'江西','龙南','341700','0797'),(1674,'江西','定南','341900','0797'),(1675,'江西','全南','341800','0797'),(1676,'江西','安远','342100','0797'),(1677,'江西','会昌','342600','0797'),(1678,'江西','景德镇','333000','0798'),(1679,'江西','乐平','333300','0798'),(1680,'江西','浮梁','333400','0798'),(1681,'江西','萍乡','337000','0799'),(1682,'江西','莲花','337100','0799'),(1683,'江西','鹰潭','335000','0701'),(1684,'江西','贵溪','335400','0701'),(1685,'江西','余江','335200','0701'),(1686,'四川','成都','610000','028'),(1687,'四川','温江','611100','028'),(1688,'四川','金堂','610400','028'),(1689,'四川','双流','610200','028'),(1690,'四川','新津','611400','028'),(1691,'四川','蒲江','611600','028'),(1692,'四川','郫县','611700','028'),(1693,'四川','新都','610500','028');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1694,'四川','彭州','611900','028'),(1695,'四川','都江堰','611800','028'),(1696,'四川','崇州','611200','028'),(1697,'四川','大邑','611300','028'),(1698,'四川','邛崃','611500','028'),(1699,'四川','攀枝花','617000','0812'),(1700,'四川','自贡','643000','0813'),(1701,'四川','富顺','643200','0813'),(1702,'四川','荣县','643100','0813'),(1703,'四川','绵阳','621000','0816'),(1704,'四川','平武','622500','0816'),(1705,'四川','安县','622600','0816'),(1706,'四川','江油','621700','0816'),(1707,'四川','梓潼','622100','0816'),(1708,'四川','三台','621100','0816'),(1709,'四川','盐亭','621600','0816'),(1710,'四川','南充','637100','0817'),(1711,'四川','西充','637200','0817'),(1712,'四川','南部','637300','0817'),(1713,'四川','阆中','637400','0817'),(1714,'四川','营山','638150','0817'),(1715,'四川','蓬安','638200','0817'),(1716,'四川','仪陇','637600','0817'),(1717,'四川','达川','636400','0818');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1718,'四川','宣汉','636100','0818'),(1719,'四川','开江','636200','0818'),(1720,'四川','万源','636300','0818'),(1721,'四川','大竹','635100','0818'),(1722,'四川','渠县','635200','0818'),(1723,'四川','遂宁','629000','0825'),(1724,'四川','蓬溪','629100','0825'),(1725,'四川','射洪','629200','0825'),(1726,'四川','广安','638000','0826'),(1727,'四川','岳池','638300','0826'),(1728,'四川','武胜','638400','0825'),(1729,'四川','华蓥','638600','0825'),(1730,'四川','邻水','635300','0830'),(1731,'四川','泸州','646000','0830'),(1732,'四川','合江','646200','0830'),(1733,'四川','纳溪','646300','0830'),(1734,'四川','叙永','646400','0830'),(1735,'四川','古蔺','646500','0830'),(1736,'四川','宜宾','644000','0831'),(1737,'四川','南溪','644100','0831'),(1738,'四川','屏山','645300','0831'),(1739,'四川','兴文','644400','0831'),(1740,'四川','长宁','644300','0831'),(1741,'四川','珙县','644500','0831');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1742,'四川','高县','645100','0831'),(1743,'四川','筠连','645200','0831'),(1744,'四川','江安','644200','0831'),(1745,'四川','内江','641000','0832'),(1746,'四川','资中','641200','0832'),(1747,'四川','资阳','641300','0832'),(1748,'四川','简阳','641400','0832'),(1749,'四川','威远','642400','0832'),(1750,'四川','隆昌','642100','0832'),(1751,'四川','乐至','641500','0832'),(1752,'四川','乐山','614000','0833'),(1753,'四川','峨边','614300','0833'),(1754,'四川','眉山','612100','0833'),(1755,'四川','峨眉山','614200','0833'),(1756,'四川','仁寿','612500','0833'),(1757,'四川','井研','612600','0833'),(1758,'四川','洪雅','612300','0833'),(1759,'四川','沐川','614500','0833'),(1760,'四川','彭山','612700','0833'),(1761,'四川','青神','612400','0833'),(1762,'四川','丹梭','612200','0833'),(1763,'四川','马边','614600','0833'),(1764,'四川','犍为','614400','0833'),(1765,'四川','夹江','614100','0833');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1766,'四川','金口河','614700','0833'),(1767,'四川','西昌','615000','0834'),(1768,'四川','雅安','625000','0835'),(1769,'四川','康定','626000','0836'),(1770,'四川','马尔康','624000','0837'),(1771,'四川','德阳','618200','0838'),(1772,'四川','广汉','618300','0838'),(1773,'四川','什邡','618400','0838'),(1774,'四川','绵竹','618200','0838'),(1775,'四川','中江','618100','0838'),(1776,'四川','广元','628000','0839'),(1777,'四川','剑阁','628300','0839'),(1778,'四川','旺苍','628200','0839'),(1779,'四川','青川','628100','0839'),(1780,'四川','苍溪','628400','0839'),(1781,'四川','璧山','632700','0822'),(1782,'四川','米易','617200','0822'),(1783,'四川','盐边','617100','0822'),(1784,'四川','宁南','615400','0824'),(1785,'四川','盐源','615700','0824'),(1786,'四川','平昌','635400','0827'),(1787,'四川','通江','635700','0827'),(1788,'四川','南江','635600','0827'),(1789,'四川','巴中','635500','0827');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1790,'四川','酉阳','648800','0829'),(1791,'四川','秀山','648900','0829'),(1792,'四川','彭水','648600','0829'),(1793,'四川','理县','623100','0840'),(1794,'四川','昭觉','616100','0841'),(1795,'四川','甘洛','616800','0841'),(1796,'四川','宝兴','625700','0843'),(1797,'四川','石棉','625400','0743'),(1798,'四川','木里','615800','0844'),(1799,'四川','会理','615100','0844'),(1800,'四川','会东','615200','0844'),(1801,'四川','冕宁','615600','0844'),(1802,'四川','越西','616600','0845'),(1803,'四川','雷波','616500','0845'),(1804,'四川','喜德','616700','0845'),(1805,'四川','普格','615300','0845'),(1806,'台湾','安定','000745','887'),(1807,'台湾','安平','000708','888'),(1808,'四川','布拖','616300','0845'),(1809,'四川','金阳','616200','0845'),(1810,'四川','美姑','616400','0845'),(1811,'四川','名山','625100','0846'),(1812,'四川','荥经','625200','0846'),(1813,'四川','汉源','625300','0846');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1814,'四川','天全','625500','0846'),(1815,'四川','芦山','625600','0846'),(1816,'四川','汶川','623000','0848'),(1817,'四川','松潘','623300','0849'),(1818,'海南','海口','570000','0898'),(1819,'海南','澄迈','571900','0898'),(1820,'海南','安定','571200','0898'),(1821,'海南','文昌','571300','0898'),(1822,'海南','屯昌','571600','0898'),(1823,'海南','琼海','571400','0898'),(1824,'海南','万宁','571500','0898'),(1825,'海南','琼山','571100','0898'),(1826,'海南','三亚','572000','0899'),(1827,'海南','通什','572200','0899'),(1828,'海南','乐东','572500','0899'),(1829,'海南','保亭','572300','0899'),(1830,'海南','陵水','572400','0899'),(1831,'海南','琼中','572900','0899'),(1832,'海南','儋州','571700','0890'),(1833,'海南','白沙','572800','0890'),(1834,'海南','洋浦','578000','0890'),(1835,'海南','东方','572600','0890'),(1836,'海南','昌江','572700','0890'),(1837,'海南','临高','571800','0890');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1838,'贵州','贵阳','550000','0851'),(1839,'贵州','清镇','551400','0851'),(1840,'贵州','修文','550200','0851'),(1841,'贵州','息烽','551100','0851'),(1842,'贵州','开阳','550300','0851'),(1843,'贵州','遵义','563000','0852'),(1844,'贵州','赤水','564700','0852'),(1845,'贵州','习水','564600','0852'),(1846,'贵州','仁怀','564500','0852'),(1847,'贵州','遵义县','563100','0852'),(1848,'贵州','桐梓','563200','0852'),(1849,'贵州','绥阳','533300','0852'),(1850,'贵州','正安','563400','0852'),(1851,'贵州','道真','563500','0852'),(1852,'贵州','湄潭','564100','0852'),(1853,'贵州','凤冈','564200','0852'),(1854,'贵州','务川','564300','0852'),(1855,'贵州','余庆','564400','0852'),(1856,'贵州','安顺','561000','0853'),(1857,'贵州','都匀','558000','0854'),(1858,'贵州','凯里','556000','0855'),(1859,'贵州','铜仁','564300','0856'),(1860,'贵州','毕节','551700','0857'),(1861,'贵州','六盘水','553000','0858');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1862,'贵州','兴义','562400','0859'),(1863,'贵州','册亨','552200','0859'),(1864,'贵州','望谟','552300','0859'),(1865,'贵州','安龙','552400','0859'),(1866,'贵州','兴仁','562300','0859'),(1867,'贵州','贞丰','562200','0859'),(1868,'贵州','普安','561500','0859'),(1869,'贵州','晴隆','561400','0859'),(1870,'贵州','平坝','561100','0863'),(1871,'贵州','紫云','550800','0863'),(1872,'贵州','关岭','561300','0863'),(1873,'贵州','镇宁','561200','0863'),(1874,'贵州','普定','562100','0863'),(1875,'贵州','贵定','551300','0864'),(1876,'贵州','福泉','550500','0864'),(1877,'贵州','瓮安','550400','0864'),(1878,'贵州','三都','558100','0864'),(1879,'贵州','荔波','558400','0864'),(1880,'贵州','独山','558200','0864'),(1881,'贵州','平塘','558300','0864'),(1882,'贵州','罗甸','550100','0864'),(1883,'贵州','惠水','550600','0864'),(1884,'贵州','龙里','551200','0864'),(1885,'贵州','榕江','557200','0865');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1886,'贵州','黄平','556100','0865'),(1887,'贵州','施秉','556200','0865'),(1888,'贵州','镇远','557700','0865'),(1889,'贵州','岑巩','557800','0865'),(1890,'贵州','三穗','556500','0865'),(1891,'贵州','天柱','556600','0865'),(1892,'贵州','锦屏','556700','0865'),(1893,'贵州','黎平','557300','0865'),(1894,'贵州','从江','557400','0865'),(1895,'贵州','沿河','565300','0866'),(1896,'贵州','松桃','554100','0866'),(1897,'贵州','万山','554200','0866'),(1898,'贵州','玉屏','554000','0866'),(1899,'贵州','江口','554400','0866'),(1900,'贵州','石阡','555100','0866'),(1901,'贵州','思南','565100','0866'),(1902,'贵州','印江','555200','0866'),(1903,'贵州','德江','565200','0866'),(1904,'贵州','长顺','550700','0867'),(1905,'贵州','威宁','553100','0867'),(1906,'贵州','赫章','553200','0867'),(1907,'贵州','纳雍','553300','0867'),(1908,'贵州','黔西','551500','0867'),(1909,'贵州','大方','551600','0867');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1910,'贵州','金沙','551800','0867'),(1911,'贵州','织金','552100','0867'),(1912,'贵州','剑河','556400','0868'),(1913,'贵州','六枝','553400','0868'),(1914,'贵州','盘县','561600','0868'),(1915,'贵州','雷山','557100','0868'),(1916,'贵州','丹寨','557500','0868'),(1917,'贵州','麻江','557600','0868'),(1918,'贵州','台江','556300','0868'),(1919,'云南','昭通','657000','0870'),(1920,'云南','镇雄','657200','0870'),(1921,'云南','永善','657300','0870'),(1922,'云南','彝良','657600','0870'),(1923,'云南','大关','657400','0870'),(1924,'云南','威信','657900','0870'),(1925,'云南','盐津','657500','0870'),(1926,'云南','巧家','654600','0870'),(1927,'云南','绥江','657700','0870'),(1928,'云南','鲁甸','657100','0870'),(1929,'云南','水富','657800','0870'),(1930,'云南','昆明','650000','0871'),(1931,'云南','富民','650400','0871'),(1932,'云南','嵩明','651700','0871'),(1933,'云南','宜良','652100','0871');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1934,'云南','呈贡','650500','0871'),(1935,'云南','晋宁','650600','0871'),(1936,'云南','安宁','650300','0871'),(1937,'云南','路南','652200','0871'),(1938,'云南','禄劝','651500','0871'),(1939,'云南','大理','671000','0872'),(1940,'云南','鹤庆','671500','0872'),(1941,'云南','剑川','671300','0872'),(1942,'云南','祥云','672100','0872'),(1943,'云南','南涧','675700','0872'),(1944,'云南','宾川','671600','0872'),(1945,'云南','云龙','672700','0872'),(1946,'云南','弥渡','675600','0872'),(1947,'云南','洱源','671200','0872'),(1948,'云南','永平','672600','0872'),(1949,'云南','巍山','672400','0872'),(1950,'云南','漾濞','672500','0872'),(1951,'云南','个旧','661400','0873'),(1952,'云南','石屏','662200','0873'),(1953,'云南','弥勒','652300','0873'),(1954,'云南','红河','654400','0873'),(1955,'云南','开远','661000','0873'),(1956,'云南','蒙自','661100','0873'),(1957,'云南','建水','654300','0873');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1958,'云南','河口','661300','0873'),(1959,'云南','泸西','652400','0873'),(1960,'云南','金平','661500','0873'),(1961,'云南','绿春','662500','0873'),(1962,'云南','元阳','662400','0873'),(1963,'云南','屏边','661200','0873'),(1964,'云南','曲靖','655000','0874'),(1965,'云南','寻甸','655200','0874'),(1966,'云南','马龙','655100','0874'),(1967,'云南','会泽','654200','0874'),(1968,'云南','师宗','655700','0874'),(1969,'云南','陆良','655600','0874'),(1970,'云南','富源','655500','0874'),(1971,'云南','宣威','665400','0874'),(1972,'云南','罗平','665800','0874'),(1973,'云南','保山','678000','0875'),(1974,'云南','腾冲','679100','0875'),(1975,'云南','昌宁','678100','0875'),(1976,'云南','龙陵','678300','0875'),(1977,'云南','施甸','678200','0875'),(1978,'云南','文山','663000','0876'),(1979,'云南','砚山','663100','0876'),(1980,'云南','丘北','663200','0876'),(1981,'云南','广南','663300','0876');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (1982,'云南','马关','663700','0876'),(1983,'云南','富宁','663400','0876'),(1984,'云南','西畴','663500','0876'),(1985,'云南','麻栗坡','663600','0876'),(1986,'云南','玉溪','653100','0877'),(1987,'云南','华宁','652800','0877'),(1988,'云南','江川','652600','0877'),(1989,'云南','新平','653400','0877'),(1990,'云南','元江','653300','0877'),(1991,'云南','通海','652700','0877'),(1992,'云南','易门','651100','0877'),(1993,'云南','澄江','652500','0877'),(1994,'云南','峨山','653200','0877'),(1995,'云南','楚雄','675000','0878'),(1996,'云南','禄丰','651200','0878'),(1997,'云南','牟定','675500','0878'),(1998,'云南','大姚','675400','0878'),(1999,'云南','永仁','651400','0878'),(2000,'云南','南华','675200','0878'),(2001,'云南','姚安','675300','0878'),(2002,'云南','元谋','651300','0878'),(2003,'云南','双柏','675100','0878'),(2004,'云南','武定','651600','0878'),(2005,'云南','思茅','665000','0879');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2006,'云南','普洱','665100','0879'),(2007,'云南','墨江','654800','0879'),(2008,'云南','景谷','666400','0879'),(2009,'云南','景东','676200','0879'),(2010,'云南','澜沧','665600','0879'),(2011,'云南','西盟','665700','0879'),(2012,'云南','江城','665900','0879'),(2013,'云南','镇沅','666500','0879'),(2014,'云南','孟连','665800','0879'),(2015,'云南','东川','654100','0881'),(2016,'云南','临沧','677000','0883'),(2017,'云南','耿马','677500','0883'),(2018,'云南','镇康','677700','0883'),(2019,'云南','沧源','677400','0883'),(2020,'云南','永德','677600','0883'),(2021,'云南','凤庆','675900','0883'),(2022,'云南','云县','675800','0883'),(2023,'云南','双江','677300','0883'),(2024,'云南','六库','673100','0886'),(2025,'云南','泸水','673200','0886'),(2026,'云南','福贡','673400','0886'),(2027,'云南','贡山','673500','0886'),(2028,'云南','兰坪','671400','0886'),(2029,'云南','中甸','674400','0887');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2030,'云南','维西','674600','0887'),(2031,'云南','德钦','674500','0887'),(2032,'云南','丽江','674100','0888'),(2033,'云南','宁蒗','674300','0888'),(2034,'云南','华坪','617300','0888'),(2035,'云南','永胜','674200','0888'),(2036,'云南','景洪','666100','0691'),(2037,'云南','孟海','666200','0691'),(2038,'云南','孟腊','666300','0691'),(2039,'云南','潞西','678400','0692'),(2040,'云南','畹町','678500','0692'),(2041,'云南','瑞丽','678600','0692'),(2042,'云南','陇川','678700','0692'),(2043,'云南','盈江','679300','0692'),(2044,'云南','梁河','679200','0692'),(2045,'西藏','拉萨','850000','0891'),(2046,'西藏','日喀则','857000','0892'),(2047,'西藏','林芝','850400','0894'),(2048,'西藏','昌都','854000','0895'),(2049,'西藏','堆龙德庆','851400','0801'),(2050,'西藏','曲水','850600','0801'),(2051,'西藏','尼木','851300','0801'),(2052,'西藏','仁布','857200','0801'),(2053,'西藏','扎囊','850800','0804');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2054,'西藏','贡嘎','850700','0804'),(2055,'西藏','江达','854100','0805'),(2056,'西藏','芒康','854500','0805'),(2057,'西藏','八宿','854600','0805'),(2058,'西藏','洛隆','855400','0805'),(2059,'西藏','丁青','855700','0805'),(2060,'西藏','巴青','852100','0806'),(2061,'西藏','比如','852300','0806'),(2062,'西藏','那曲','852000','0896'),(2063,'西藏','班戈','852500','0806'),(2064,'西藏','措勤','859300','0806'),(2065,'西藏','阿里','859000','0807'),(2066,'西藏','索县','852200','0807'),(2067,'西藏','尼玛','852600','0808'),(2068,'西藏','山南','★★★','0893'),(2069,'陕西','合阳','715300','0913'),(2070,'陕西','蒲城','715500','0913'),(2071,'陕西','韩城','715400','0913'),(2072,'陕西','富平','711700','0913'),(2073,'陕西','潼关','714300','0913'),(2074,'陕西','华阴','714200','0913'),(2075,'陕西','大荔','715100','0913'),(2076,'陕西','华县','714100','0913'),(2077,'陕西','渭南','714000','0913');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2078,'陕西','榆林','719000','0912'),(2079,'陕西','富县','727500','0911'),(2080,'陕西','安塞','717400','0911'),(2081,'陕西','甘泉','716100','0911'),(2082,'陕西','志丹','717500','0911'),(2083,'陕西','洛川','727400','0911'),(2084,'陕西','宜川','716200','0911'),(2085,'陕西','黄龙','715700','0911'),(2086,'陕西','吴旗','717600','0911'),(2087,'陕西','延长','717100','0911'),(2088,'陕西','子长','717300','0911'),(2089,'陕西','延川','717200','0911'),(2090,'陕西','黄陵','727300','0911'),(2091,'陕西','延安','716000','0911'),(2092,'陕西','彬县','713500','0910'),(2093,'陕西','乾县','713300','0910'),(2094,'陕西','礼泉','713200','0910'),(2095,'陕西','泾阳','713700','0910'),(2096,'陕西','三原','713800','0910'),(2097,'陕西','淳化','711200','0910'),(2098,'陕西','旬邑','711300','0910'),(2099,'陕西','兴平','713100','0910'),(2100,'陕西','永寿','713400','0910'),(2101,'陕西','长武','713600','0910');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2102,'陕西','武功','712200','0910'),(2103,'陕西','咸阳','712000','0910'),(2104,'陕西','长安','710100','029'),(2105,'陕西','临潼','710600','029'),(2106,'陕西','蓝田','710500','029'),(2107,'陕西','周至','710400','029'),(2108,'陕西','户县','710300','029'),(2109,'陕西','高陵','710200','029'),(2110,'陕西','西安','710000','029'),(2111,'陕西','商南','726300','0914'),(2112,'陕西','略阳','724300','0916'),(2113,'陕西','宁强','724400','0916'),(2114,'陕西','佛坪','723400','0916'),(2115,'陕西','留坝','724100','0916'),(2116,'陕西','白河','725800','0915'),(2117,'陕西','镇坪','725600','0915'),(2118,'陕西','山阳','726400','0924'),(2119,'陕西','镇安','711500','0924'),(2120,'陕西','柞水','711400','0924'),(2121,'陕西','清涧','718300','0924'),(2122,'陕西','神木','719300','0922'),(2123,'陕西','靖边','718500','0922'),(2124,'陕西','定边','718600','0922'),(2125,'陕西','绥德','718000','0922');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2126,'陕西','米脂','718100','0922'),(2127,'陕西','横山','719100','0922'),(2128,'陕西','府谷','719400','0922'),(2129,'陕西','佳县','719200','0922'),(2130,'陕西','子洲','718400','0922'),(2131,'陕西','吴堡','718200','0922'),(2132,'陕西','宜君','727200','0919'),(2133,'陕西','耀县','727100','0919'),(2134,'陕西','铜川','727000','0919'),(2135,'陕西','麟游','721500','0917'),(2136,'陕西','太白','721600','0917'),(2137,'陕西','千阳','721100','0917'),(2138,'陕西','陇县','721200','0917'),(2139,'陕西','凤县','721700','0917'),(2140,'陕西','眉县','722300','0917'),(2141,'陕西','扶风','722200','0917'),(2142,'陕西','岐山','722400','0917'),(2143,'陕西','凤翔','721400','0917'),(2144,'陕西','宝鸡县','721300','0917'),(2145,'陕西','宝鸡','721000','0917'),(2146,'陕西','勉县','724200','0916'),(2147,'陕西','镇巴','713600','0916'),(2148,'陕西','西乡','723500','0916'),(2149,'陕西','洋县','723300','0916');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2150,'陕西','城固','723200','0916'),(2151,'陕西','南郑','723100','0916'),(2152,'陕西','汉中','723000','0916'),(2153,'陕西','紫阳','725300','0915'),(2154,'陕西','平利','725500','0915'),(2155,'陕西','石泉','725200','0915'),(2156,'陕西','旬阳','725700','0915'),(2157,'陕西','汉阴','725100','0915'),(2158,'陕西','宁陕','711600','0915'),(2159,'陕西','岚皋','725400','0915'),(2160,'陕西','安康','725000','0915'),(2161,'陕西','洛南','726100','0914'),(2162,'陕西','丹凤','726200','0914'),(2163,'陕西','商州','726000','0914'),(2164,'陕西','澄城','715200','0913'),(2165,'台湾','八德','000334','889'),(2166,'陕西','白水','715600','0913'),(2167,'甘肃','临夏市','731100','0930'),(2168,'甘肃','兰州','730000','0931'),(2169,'甘肃','红古区','730000','0931'),(2170,'甘肃','皋兰','730200','0931'),(2171,'甘肃','榆中','730100','0931'),(2172,'甘肃','永登','730300','0931'),(2173,'甘肃','定西','743000','0932');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2174,'甘肃','静宁','743400','0933'),(2175,'甘肃','泾川','744300','0933'),(2176,'甘肃','灵台','744400','0933'),(2177,'甘肃','崇信','744200','0933'),(2178,'甘肃','华亭','744100','0993'),(2179,'甘肃','庄浪','741700','0993'),(2180,'甘肃','西峰','745000','0934'),(2181,'甘肃','金昌','733000','0935'),(2182,'甘肃','民勤','733300','0935'),(2183,'甘肃','天祝','733200','0935'),(2184,'甘肃','古浪','733100','0935'),(2185,'甘肃','金川','737100','0935'),(2186,'甘肃','永昌','737200','0935'),(2187,'甘肃','张掖','734000','0936'),(2188,'甘肃','山丹','734100','0936'),(2189,'甘肃','高台','734300','0936'),(2190,'甘肃','民乐','734500','0936'),(2191,'甘肃','临泽','734200','0936'),(2192,'甘肃','萧南','734400','0936'),(2193,'甘肃','酒泉','735000','0937'),(2194,'甘肃','玉门','735200','0937'),(2195,'甘肃','安西','736100','0937'),(2196,'甘肃','敦煌','736200','0937'),(2197,'甘肃','金塔','735300','0937');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2198,'甘肃','阿克塞','736400','0937'),(2199,'甘肃','嘉峪关','735100','0937'),(2200,'甘肃','肃北','736300','0937'),(2201,'甘肃','天水','741000','0938'),(2202,'甘肃','甘谷','741200','0938'),(2203,'甘肃','武山','741300','0938'),(2204,'甘肃','秦安','741600','0938'),(2205,'甘肃','张家川','741500','0938'),(2206,'甘肃','清水','741400','0938'),(2207,'甘肃','武都','746000','0939'),(2208,'甘肃','白银','730900','0943'),(2209,'甘肃','靖远','730600','0943'),(2210,'甘肃','平凉','744000','0943'),(2211,'甘肃','景泰','730400','0943'),(2212,'甘肃','会宁','743200','0943'),(2213,'甘肃','临夏县','731800','0940'),(2214,'甘肃','永靖','731600','0940'),(2215,'甘肃','和政','731200','0940'),(2216,'甘肃','东乡','731400','0940'),(2217,'甘肃','康乐','731500','0940'),(2218,'甘肃','广河','731300','0940'),(2219,'甘肃','积石山','731700','0940'),(2220,'甘肃','甘南州','747000','0941'),(2221,'甘肃','夏河','747100','0941');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2222,'甘肃','临潭','747500','0941'),(2223,'甘肃','舟曲','746300','0941'),(2224,'甘肃','碌曲','747200','0941'),(2225,'甘肃','玛曲','747300','0941'),(2226,'甘肃','旧尼','747600','0941'),(2227,'甘肃','迭部','747400','0941'),(2228,'甘肃','陇西','748100','0942'),(2229,'甘肃','漳县','748300','0942'),(2230,'甘肃','通渭','743300','0942'),(2231,'甘肃','岷县','748400','0942'),(2232,'甘肃','临洮','730500','0942'),(2233,'甘肃','渭源','748200','0942'),(2234,'甘肃','庆阳','745100','0944'),(2235,'甘肃','宁县','745200','0944'),(2236,'台湾','八里','000249','890'),(2237,'甘肃','镇原','744500','0944'),(2238,'甘肃','环县','745700','0944'),(2239,'甘肃','合水','745400','0944'),(2240,'甘肃','正宁','745300','0944'),(2241,'甘肃','华池','745600','0944'),(2242,'甘肃','成县','742500','0949'),(2243,'甘肃','康县','746500','0949'),(2244,'甘肃','文县','746400','0949'),(2245,'甘肃','宕昌','748500','0949');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2246,'甘肃','西和','742100','0949'),(2247,'甘肃','礼县','742200','0949'),(2248,'甘肃','徽县','742300','0949'),(2249,'甘肃','两当','742400','0949'),(2250,'青海','海晏','812200','0970'),(2251,'青海','西宁','810000','0971'),(2252,'青海','大通','810100','0971'),(2253,'青海','乐都','810700','0972'),(2254,'青海','湟中','811600','0972'),(2255,'青海','互助','810500','0972'),(2256,'青海','湟源','812100','0972'),(2257,'青海','民和','810800','0972'),(2258,'青海','循化','811100','0972'),(2259,'青海','化隆','810900','0972'),(2260,'青海','同仁','811300','0973'),(2261,'青海','共和','813000','0974'),(2262,'青海','玛沁','814000','0975'),(2263,'青海','玉树','815000','0976'),(2264,'青海','德令哈','817000','0977'),(2265,'青海','门源','810300','0978'),(2266,'青海','格尔木','816000','0979'),(2267,'青海','河南','811500','0982'),(2268,'青海','尖扎','811200','0982'),(2269,'青海','泽库','811400','0982');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2270,'青海','乌兰','817100','0983'),(2271,'青海','都兰','816100','0983'),(2272,'青海','天峻','817200','0983'),(2273,'青海','治多','815400','0983'),(2274,'青海','称多','815100','0983'),(2275,'青海','囊谦','815200','0983'),(2276,'青海','杂多','815300','0983'),(2277,'青海','曲麻莱','815500','0983'),(2278,'青海','龙羊峡','811800','0983'),(2279,'青海','茫崖','817500','0984'),(2280,'青海','贵德','811700','0984'),(2281,'青海','贵南','813100','0984'),(2282,'青海','兴海','813300','0984'),(2283,'青海','同德','813200','0984'),(2284,'青海','祁连','810400','0984'),(2285,'青海','刚察','812300','0984'),(2286,'青海','大柴旦','817300','0984'),(2287,'青海','冷湖','817400','0984'),(2288,'青海','达日','814200','0985'),(2289,'青海','玛多','813500','0985'),(2290,'青海','班玛','814300','0985'),(2291,'青海','甘德','814100','0985'),(2292,'宁夏','银川','750000','0951'),(2293,'宁夏','贺兰','750200','0951');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2294,'宁夏','永宁','750100','0951'),(2295,'宁夏','石嘴山','753000','0952'),(2296,'宁夏','平罗','753400','0952'),(2297,'宁夏','惠农','753600','0952'),(2298,'宁夏','陶乐','753500','0952'),(2299,'宁夏','吴忠','751100','0953'),(2300,'宁夏','中宁','751200','0953'),(2301,'宁夏','中卫','751700','0953'),(2302,'宁夏','青铜峡','751600','0953'),(2303,'宁夏','灵武','751400','0953'),(2304,'宁夏','同心','751300','0953'),(2305,'宁夏','盐池','751500','0953'),(2306,'宁夏','固原','756000','0954'),(2307,'宁夏','海原','756100','0954'),(2308,'宁夏','西吉','756200','0954'),(2309,'宁夏','隆德','756300','0954'),(2310,'宁夏','泾源','756400','0954'),(2311,'宁夏','彭阳','756500','0954'),(2312,'新疆','塔城','834700','0901'),(2313,'新疆','额敏','834600','0901'),(2314,'新疆','裕民','834800','0901'),(2315,'新疆','托里','834500','0901'),(2316,'新疆','哈密','839000','0902'),(2317,'新疆','马里坤','839200','0902');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2318,'新疆','伊吾','839300','0902'),(2319,'新疆','和田','848000','0903'),(2320,'新疆','皮山','845100','0903'),(2321,'新疆','墨玉','848100','0903'),(2322,'新疆','洛浦','848200','0903'),(2323,'新疆','策勒','848300','0903'),(2324,'新疆','于田','848400','0903'),(2325,'新疆','民丰','848500','0903'),(2326,'新疆','阿勒泰','836500','0906'),(2327,'新疆','青河','836200','0906'),(2328,'新疆','布尔律','836600','0906'),(2329,'新疆','哈巴河','836700','0906'),(2330,'新疆','富蕴','836100','0906'),(2331,'新疆','福海','836400','0906'),(2332,'新疆','吉木乃','836800','0906'),(2333,'新疆','阿图什','845300','0908'),(2334,'新疆','乌恰','845400','0908'),(2335,'新疆','阿克陶','845500','0908'),(2336,'新疆','博乐','833400','0909'),(2337,'新疆','精河','833300','0909'),(2338,'新疆','温泉','833500','0909'),(2339,'新疆','克拉玛依','834000','0990'),(2340,'新疆','布克赛尔','834000','0990'),(2341,'新疆','乌鲁木齐','830000','0991');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2342,'新疆','奎屯','833200','0992'),(2343,'新疆','乌苏','833000','0992'),(2344,'新疆','石河子','832000','0993'),(2345,'新疆','沙湾','832100','0993'),(2346,'新疆','昌吉','831100','0994'),(2347,'新疆','奇台','831800','0994'),(2348,'新疆','米泉','831400','0994'),(2349,'新疆','呼图壁','831200','0994'),(2350,'新疆','玛纳斯','832200','0994'),(2351,'新疆','吉木萨尔','831700','0994'),(2352,'新疆','阜康','831500','0994'),(2353,'新疆','木垒','831900','0994'),(2354,'新疆','吐鲁番','838000','0995'),(2355,'新疆','鄯善','838200','0995'),(2356,'新疆','托克逊','838100','0995'),(2357,'新疆','库尔勒','841000','0996'),(2358,'新疆','焉耆','841100','0996'),(2359,'新疆','博湖','841400','0996'),(2360,'新疆','轮台','841600','0996'),(2361,'新疆','和静','841300','0996'),(2362,'新疆','和硕','841200','0996'),(2363,'新疆','若羌','841800','0996'),(2364,'新疆','尉犁','841500','0996'),(2365,'新疆','且末','841900','0996');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2366,'新疆','阿克苏','843000','0997'),(2367,'新疆','库车','842000','0997'),(2368,'新疆','新和','842100','0997'),(2369,'新疆','沙雅','842200','0997'),(2370,'新疆','拜城','842300','0997'),(2371,'新疆','温宿','843100','0997'),(2372,'新疆','乌什','843400','0997'),(2373,'新疆','阿拉尔','843300','0997'),(2374,'新疆','阿瓦提','843200','0997'),(2375,'新疆','柯坪','843600','0997'),(2376,'新疆','阿合奇','843500','0997'),(2377,'新疆','咯什','844000','0998'),(2378,'新疆','疏附','844100','0998'),(2379,'新疆','伽师','844300','0998'),(2380,'新疆','巴楚','843800','0998'),(2381,'新疆','麦盖提','844600','0998'),(2382,'新疆','叶城','844900','0998'),(2383,'新疆','泽普','844800','0998'),(2384,'新疆','莎车','844700','0998'),(2385,'新疆','岳普湖','844400','0998'),(2386,'新疆','英吉沙','844500','0998'),(2387,'新疆','塔什库尔干','845200','0999'),(2388,'新疆','疏勒','844200','0999');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2389,'新疆','伊宁','835000','0999'),(2390,'新疆','察布查尔','835300','0999'),(2391,'新疆','霍城','835200','0999'),(2392,'新疆','新源','835800','0999'),(2393,'新疆','巩留','835400','0999'),(2394,'新疆','尼勒克','835700','0999'),(2395,'新疆','特克斯','835500','0999'),(2396,'新疆','昭苏','835600','0999'),(2397,'台湾','白河','000732','891'),(2398,'台湾','白沙','000884','892'),(2399,'台湾','板桥','000220','893'),(2400,'台湾','褒忠','000634','894'),(2401,'台湾','宝山','000308','895'),(2402,'台湾','卑南','000931','896'),(2403,'台湾','北斗','000521','897'),(2404,'台湾','北港','000651','898'),(2405,'台湾','北门','000727','899'),(2406,'台湾','北埔','000314','900'),(2407,'台湾','北投','000112','901'),(2408,'台湾','补子','000613','902'),(2409,'台湾','布袋','000739','903'),(2410,'台湾','草屯','000542','904'),(2411,'台湾','长宾','000937','905'),(2412,'台湾','长治','000905','906');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2413,'台湾','潮州','000910','907'),(2414,'台湾','车城','000923','908'),(2415,'台湾','城中区','000100','909'),(2416,'台湾','成功','000936','910'),(2417,'台湾','池上','000934','911'),(2418,'台湾','春日','000920','912'),(2419,'台湾','刺桐','000647','913'),(2420,'非洲','博茨瓦纳',NULL,'267'),(2421,'非洲','斯威士兰',NULL,'268'),(2422,'非洲','科摩罗',NULL,'269'),(2423,'非洲','南非',NULL,'27'),(2424,'非洲','圣赫勒拿',NULL,'290'),(2425,'非洲','阿鲁巴岛',NULL,'297'),(2426,'亚洲','马来西亚',NULL,'60'),(2427,'亚洲','印度尼西亚',NULL,'62'),(2428,'亚洲','菲律宾',NULL,'63'),(2429,'亚洲','新加坡',NULL,'65'),(2430,'亚洲','泰国',NULL,'66'),(2431,'亚洲','关岛',NULL,'671'),(2432,'亚洲','文莱',NULL,'673'),(2433,'亚洲','日本',NULL,'81'),(2434,'亚洲','韩国',NULL,'82'),(2435,'亚洲','越南',NULL,'84'),(2436,'亚洲','朝鲜',NULL,'850'),(2437,'亚洲','香港特别行政区',NULL,'852');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2438,'亚洲','澳门地区',NULL,'853'),(2439,'亚洲','柬埔寨',NULL,'855'),(2440,'亚洲','老挝',NULL,'856'),(2441,'亚洲','中国',NULL,'86'),(2442,'亚洲','孟加拉国',NULL,'880'),(2443,'亚洲','土耳其',NULL,'90'),(2444,'亚洲','印度',NULL,'91'),(2445,'亚洲','巴基期坦',NULL,'92'),(2446,'亚洲','斯里兰卡',NULL,'94'),(2447,'亚洲','马尔代夫',NULL,'961'),(2448,'亚洲','黎巴嫩',NULL,'962'),(2449,'亚洲','约旦',NULL,'963'),(2450,'亚洲','叙利亚',NULL,'964'),(2451,'亚洲','伊拉克',NULL,'965'),(2452,'亚洲','科威物',NULL,'966'),(2453,'亚洲','沙物阿拉伯',NULL,'967'),(2454,'亚洲','阿拉伯也门共和国',NULL,'968'),(2455,'亚洲','阿曼',NULL,'969'),(2456,'亚洲','阿拉伯联合酋长国',NULL,'972'),(2457,'亚洲','以色列',NULL,'973'),(2458,'亚洲','巴林',NULL,'974'),(2459,'亚洲','卡塔尔',NULL,'975'),(2460,'亚洲','不丹',NULL,'976');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2461,'亚洲','蒙古',NULL,'977'),(2462,'亚洲','尼泊尔',NULL,'978'),(2463,'亚洲','伊朗',NULL,'98'),(2464,'欧洲','俄罗斯',NULL,'7'),(2465,'欧洲','希腊',NULL,'30'),(2466,'欧洲','荷兰',NULL,'31'),(2467,'欧洲','比利时',NULL,'32'),(2468,'欧洲','法国',NULL,'33'),(2469,'欧洲','摩纳哥',NULL,'3393'),(2470,'欧洲','安道尔',NULL,'3362'),(2471,'欧洲','西班牙',NULL,'34'),(2472,'欧洲','加那利群岛',NULL,'3422'),(2473,'欧洲','直布罗陀',NULL,'350'),(2474,'欧洲','葡萄牙',NULL,'351'),(2475,'欧洲','卢森保',NULL,'352'),(2476,'欧洲','爱尔兰',NULL,'353'),(2477,'欧洲','冰岛',NULL,'354'),(2478,'欧洲','阿尔巴尼亚',NULL,'355'),(2479,'欧洲','马耳他',NULL,'356'),(2480,'欧洲','塞浦路斯',NULL,'357'),(2481,'欧洲','芬兰',NULL,'358'),(2482,'欧洲','保加利亚',NULL,'359'),(2483,'欧洲','匈牙利',NULL,'336'),(2484,'欧洲','德国',NULL,'349'),(2485,'欧洲','南斯拉夫',NULL,'338'),(2486,'欧洲','意大利',NULL,'39');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2487,'欧洲','圣马力诺',NULL,'3954'),(2488,'欧洲','梵蒂冈',NULL,'396'),(2489,'欧洲','罗马尼亚',NULL,'40'),(2490,'欧洲','瑞士',NULL,'41'),(2491,'欧洲','列士敦士登',NULL,'4175'),(2492,'欧洲','奥地利',NULL,'43'),(2493,'欧洲','英国',NULL,'44'),(2494,'欧洲','丹麦',NULL,'45'),(2495,'欧洲','瑞典',NULL,'46'),(2496,'欧洲','挪威',NULL,'47'),(2497,'欧洲','法兰',NULL,'48'),(2498,'大洋洲','澳大利亚',NULL,'61'),(2499,'大洋洲','新西兰',NULL,'64'),(2500,'大洋洲','马里亚纳群岛',NULL,'670'),(2501,'大洋洲','科科斯岛',NULL,'6722'),(2502,'大洋洲','诺福克岛',NULL,'6723'),(2503,'大洋洲','圣庭岛',NULL,'6724'),(2504,'大洋洲','瑙鲁',NULL,'674'),(2505,'大洋洲','巴布亚新几内亚',NULL,'675'),(2506,'大洋洲','汤加',NULL,'676'),(2507,'大洋洲','所罗门群岛',NULL,'677'),(2508,'大洋洲','瓦努阿图',NULL,'678'),(2509,'大洋洲','斐济',NULL,'679'),(2510,'大洋洲','科克群岛',NULL,'682');
INSERT INTO `postcode` (`ID`,`province`,`city`,`postcode`,`qh`) VALUES (2511,'大洋洲','纽埃岛',NULL,'683'),(2512,'大洋洲','东萨摩亚',NULL,'684'),(2513,'大洋洲','西萨摩亚',NULL,'685'),(2514,'大洋洲','基里巴斯',NULL,'686'),(2515,'大洋洲','新喀里多尼亚群岛',NULL,'687'),(2516,'大洋洲','图瓦卢',NULL,'688'),(2517,'大洋洲','法属波里尼西亚',NULL,'689'),(2518,'美洲','圣文桑特岛和格雷纳丁',NULL,'1809'),(2519,'亚洲','阿富汗',NULL,'93'),(2520,NULL,NULL,NULL,NULL);
CREATE TABLE `privilege` (
  `priv` varchar(20) NOT NULL default '',
  `description` varchar(250) NOT NULL default '',
  `isSystem` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`priv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `privilege` (`priv`,`description`,`isSystem`) VALUES ('admin','管理员',1),('admin.address.public','公共通讯',1),('admin.backup','备份权限',1),('admin.blog','博客管理',0),('admin.chat','讨论管理',0),('admin.fileark','文件柜管理',1),('admin.flow','流程管理',1),('admin.forum','论坛管理',0),('admin.meetingroom','会议室管理',1),('admin.post','部门人员',1),('admin.role','角色管理',0),('admin.user','用户管理',1),('admin.usergroup','用户组管理',0),('asset','资产管理',1),('book.all','图书总管理员',1),('flow.init','发起流程',1),('meetingroom','会议室管理',0),('message','发送短消息',0),('message.group','群发短消息',0),('notice','公共通知',1),('officeequip','办公用品管理',1),('sales','销售总管理',0),('sales.contract','合同管理',0),('sales.product','产品信息管理',0),('sales.provider','供应商、供应联系人管理',0),('sales.sell','产品销售',0),('sales.user','是否销售人员',0),('task','发起任务',0);
INSERT INTO `privilege` (`priv`,`description`,`isSystem`) VALUES ('vehicle','车辆管理',0),('workplan','工作计划',1);
CREATE TABLE `redmoonid` (
  `idType` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`idType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `redmoonid` (`idType`,`id`) VALUES (0,5),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1);
CREATE TABLE `scheduler` (
  `id` int(10) unsigned NOT NULL default '0',
  `interval` int(10) unsigned default '1',
  `cron` varchar(255) NOT NULL default '',
  `data_map` varchar(255) default NULL,
  `job_name` varchar(255) default NULL,
  `job_class` varchar(255) NOT NULL default '',
  `month_day` varchar(255) default NULL,
  `user_name` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sms_record` (
  `ID` int(11) NOT NULL default '0',
  `USERNAME` varchar(20) NOT NULL default '',
  `SENDMOBILE` varchar(13) NOT NULL default '',
  `MSGTEXT` varchar(70) NOT NULL default '',
  `SENDTIME` date NOT NULL default '0000-00-00',
  `orgAddr` varchar(15) default NULL,
  PRIMARY KEY  (`ID`,`SENDMOBILE`,`SENDTIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_advertisement` (
  `id` int(11) NOT NULL default '0',
  `title` varchar(50) NOT NULL default '',
  `begin_date` datetime default NULL,
  `end_date` datetime default NULL,
  `ad_type` int(11) NOT NULL default '0',
  `content` text,
  `height` int(11) default NULL,
  `width` int(11) default NULL,
  `url` varchar(255) default NULL,
  `boardcodes` varchar(255) default NULL,
  `font_size` varchar(20) default NULL,
  `image_alt` varchar(255) default NULL,
  `ad_kind` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `ad_type` (`ad_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_board` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(255) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `child_count` int(11) default NULL,
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  `add_id` int(11) default NULL,
  `logo` varchar(50) default NULL,
  `today_count` int(11) NOT NULL default '0',
  `today_date` varchar(15) NOT NULL default '0',
  `topic_count` int(11) NOT NULL default '0',
  `post_count` int(11) NOT NULL default '0',
  `theme` varchar(20) default 'N''default''',
  `skin` varchar(20) default 'N''default''',
  `boardRule` varchar(255) default NULL,
  `color` varchar(15) default NULL,
  `webeditAllowType` int(11) NOT NULL default '2',
  `add_date` varchar(15) NOT NULL default '0',
  `plugin2Code` varchar(20) default NULL,
  `check_msg` tinyint(2) default NULL COMMENT '0',
  `del_mode` tinyint(2) default NULL COMMENT '0',
  `display_style` tinyint(3) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_board` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`islocked`,`type`,`layer`,`add_id`,`logo`,`today_count`,`today_date`,`topic_count`,`post_count`,`theme`,`skin`,`boardRule`,`color`,`webeditAllowType`,`add_date`,`plugin2Code`,`check_msg`,`del_mode`,`display_style`) VALUES ('bgtd','办公天地',1,'办公天地','root','root',3,3,0,0,2,0,'',0,'0',0,0,'default','default','','',2,'0',NULL,NULL,NULL,0),('blog','博客',0,'','hidden','root',1,0,0,1,3,191,'',0,'1161505982390',0,0,'default','','','',2,'0','',0,0,0),('bzjl','版主交流',1,'斑竹的办公场所！','社区管理','root',2,0,0,1,3,21,NULL,0,'1172539492437',0,0,'default','','<P>&nbsp;</P>','',2,'0','',0,0,0),('hidden','隐藏版块区',0,'','root','root',2,1,0,0,2,NULL,'',0,'0',0,0,'default','default',NULL,'',1,'0',NULL,NULL,NULL,0),('qcql','群策群力',1,'群策群力','bgtd','root',2,0,0,1,3,105,'',0,'1172539492531',0,0,'default','','','',2,'0','',0,0,0),('root','全部版块',1,'','-1','root',1,3,0,0,1,0,NULL,0,'0',0,0,'default','default',NULL,NULL,1,'0',NULL,NULL,NULL,0),('sqzw','社区站务',1,'社区站务，欢迎大家来讨论社区建设','社区管理','root',1,0,0,1,3,124,NULL,0,'1172539492359',0,0,'default','','<P><FONT color=#ff0000><STRONG>请在本版中提出您的意见和建议！谢谢！</STRONG></FONT></P>','',2,'0','',0,0,0);
INSERT INTO `sq_board` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`islocked`,`type`,`layer`,`add_id`,`logo`,`today_count`,`today_date`,`topic_count`,`post_count`,`theme`,`skin`,`boardRule`,`color`,`webeditAllowType`,`add_date`,`plugin2Code`,`check_msg`,`del_mode`,`display_style`) VALUES ('tytx','图游天下',1,'图游天下','bgtd','root',3,0,0,1,3,1323,'',0,'0',0,0,'default','','','',2,'0','',0,0,0),('ygtd','员工天地',1,'员工天地','bgtd','root',1,0,0,1,3,71,'',0,'1172539492500',0,0,'default','','sadfsadfsafsdfdsf','',2,'0','',0,0,0),('社区管理','社区管理',1,'','root','root',1,2,0,0,2,0,NULL,0,'0',0,0,'default','default','','',2,'0',NULL,NULL,NULL,0);
CREATE TABLE `sq_board_entrance` (
  `boardCode` varchar(50) NOT NULL default '',
  `entranceCode` varchar(50) NOT NULL default '',
  UNIQUE KEY `IX_sq_board_entrance` (`boardCode`,`entranceCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_board_score` (
  `boardCode` varchar(50) NOT NULL default '',
  `scoreCode` varchar(50) NOT NULL default '',
  UNIQUE KEY `IX_sq_board_score` (`boardCode`,`scoreCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_boardmanager` (
  `name` varchar(20) NOT NULL default '',
  `boardcode` varchar(20) NOT NULL default '',
  `sort` tinyint(3) unsigned NOT NULL default '1',
  PRIMARY KEY  (`name`,`boardcode`),
  KEY `name` (`name`),
  CONSTRAINT `FK_sq_boardmanager_Member` FOREIGN KEY (`name`) REFERENCES `sq_user` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_boardrender` (
  `boardCode` varchar(20) NOT NULL default '',
  `renderCode` varchar(20) NOT NULL default '',
  KEY `IX_render` (`boardCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_boardrender` (`boardCode`,`renderCode`) VALUES ('ygtd','RenderMM');
CREATE TABLE `sq_chatroom` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `description` varchar(255) default NULL,
  `expire` varchar(15) default NULL,
  `sort` int(11) NOT NULL default '0',
  `topic` varchar(250) default NULL,
  `peopleNum` int(11) NOT NULL default '100',
  `playMusic` tinyint(1) NOT NULL default '0',
  `isopen` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`name`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_chatroom` (`id`,`name`,`description`,`expire`,`sort`,`topic`,`peopleNum`,`playMusic`,`isopen`) VALUES (25,'一网情深',NULL,NULL,0,'一网情深',100,0,1),(11,'不见不散',NULL,NULL,0,'不见不散',100,0,1),(28,'佳人有约',NULL,NULL,0,'佳人有约',100,1,1),(0,'办公室',NULL,NULL,0,'办公室',100,0,1),(22,'南国红豆屋',NULL,NULL,0,'南国红豆屋',100,1,1),(21,'天若有情',NULL,NULL,0,'天若有情',100,1,1),(18,'开心小屋',NULL,NULL,0,'开心小屋',100,1,1),(20,'情人酒吧',NULL,NULL,0,'情人酒吧',100,1,1),(19,'生于七十年代',NULL,NULL,0,'生于七十年代',100,1,1),(29,'相思网络中',NULL,NULL,0,'相思网络中',100,1,1),(26,'红粉知己',NULL,NULL,0,'红粉知己',100,1,1),(16,'缘份的天空',NULL,NULL,0,'缘份的天空',100,1,1),(14,'英语聊天室',NULL,NULL,0,'英语聊天室',100,1,1),(17,'菁菁校园',NULL,NULL,0,'菁菁校园',100,1,1),(27,'菩提树下',NULL,NULL,0,'菩提树下',100,1,1);
CREATE TABLE `sq_classmaster` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL default '',
  `classcode` varchar(20) NOT NULL default '',
  `sort` int(11) NOT NULL default '0',
  PRIMARY KEY  (`name`),
  KEY `id` (`id`),
  CONSTRAINT `sq_classmaster_ibfk_1` FOREIGN KEY (`name`) REFERENCES `sq_user` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_forbid_ip` (
  `ip` varchar(15) NOT NULL default '',
  `user_name` varchar(20) default NULL,
  `add_date` varchar(15) default NULL,
  `reason` varchar(255) default NULL,
  PRIMARY KEY  (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_forbid_ip_range` (
  `id` int(11) NOT NULL default '0',
  `begin` varchar(15) NOT NULL default '',
  `end` varchar(15) NOT NULL default '',
  `user_name` varchar(20) default NULL,
  `add_date` varchar(15) default NULL,
  `reason` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_forum` (
  `id` int(11) NOT NULL default '1',
  `userCount` int(11) NOT NULL default '0',
  `userNew` varchar(20) default NULL,
  `createDate` varchar(15) NOT NULL default '0',
  `topicCount` int(11) NOT NULL default '0',
  `postCount` int(11) NOT NULL default '0',
  `todayCount` int(11) NOT NULL default '0',
  `todayDate` varchar(15) NOT NULL default '0',
  `yestodayCount` int(11) NOT NULL default '0',
  `maxCount` int(11) NOT NULL default '0',
  `maxDate` varchar(15) NOT NULL default '0',
  `maxOnlineCount` int(11) NOT NULL default '0',
  `maxOnlineDate` varchar(15) NOT NULL default '0',
  `notices` varchar(60) default '-1',
  `filterUserName` varchar(255) default NULL,
  `filterMsg` varchar(255) default NULL,
  `isShowLink` tinyint(1) NOT NULL default '1',
  `status` tinyint(3) NOT NULL default '1',
  `reason` varchar(255) default NULL,
  `GUEST_ACTION` varchar(20) NOT NULL default '11',
  `ad_topic_bottom` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_forum` (`id`,`userCount`,`userNew`,`createDate`,`topicCount`,`postCount`,`todayCount`,`todayDate`,`yestodayCount`,`maxCount`,`maxDate`,`maxOnlineCount`,`maxOnlineDate`,`notices`,`filterUserName`,`filterMsg`,`isShowLink`,`status`,`reason`,`GUEST_ACTION`,`ad_topic_bottom`) VALUES (1,0,'','1172545449609',0,0,0,'1172473269578',0,0,'0',1,'1172557619171','','混蛋|','混蛋|',1,1,'','11','');
CREATE TABLE `sq_friend` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `friend` varchar(20) NOT NULL default '',
  `rq` varchar(15) NOT NULL default '0',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_id` (
  `idType` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`idType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_id` (`idType`,`id`) VALUES (0,1),(1,5),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1);
CREATE TABLE `sq_images` (
  `id` int(11) NOT NULL default '0',
  `path` varchar(200) NOT NULL default '',
  `otherid` varchar(20) NOT NULL default '',
  `kind` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `idx_otherid` (`otherid`),
  KEY `idx_kind` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_master` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL default '',
  `sort` tinyint(3) unsigned NOT NULL default '0',
  `description` varchar(100) default NULL,
  PRIMARY KEY  (`name`),
  KEY `id` (`id`),
  CONSTRAINT `FK_sq_master_Member` FOREIGN KEY (`name`) REFERENCES `sq_user` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_message` (
  `id` bigint(20) NOT NULL default '0',
  `name` varchar(20) NOT NULL default 'N''无名氏''',
  `expression` tinyint(3) unsigned default '25',
  `boardcode` varchar(20) NOT NULL default 'N''xlmx''',
  `replyid` bigint(11) NOT NULL default '-1',
  `rootid` bigint(11) NOT NULL default '-1',
  `msg_layer` int(11) NOT NULL default '1',
  `length` int(11) NOT NULL default '0',
  `orders` int(11) NOT NULL default '1',
  `title` varchar(200) NOT NULL default '',
  `content` longtext NOT NULL,
  `recount` int(11) NOT NULL default '0',
  `hit` int(11) NOT NULL default '0',
  `lydate` varchar(15) NOT NULL default '0',
  `ip` varchar(15) default NULL,
  `msg_level` int(11) NOT NULL default '0',
  `isprivate` tinyint(1) NOT NULL default '1',
  `msg_type` tinyint(3) unsigned default '0',
  `filename` varchar(250) default NULL,
  `extname` varchar(3) default NULL,
  `iselite` tinyint(1) NOT NULL default '0',
  `islocked` tinyint(1) NOT NULL default '0',
  `isguide` tinyint(3) unsigned NOT NULL default '0',
  `show_ubbcode` tinyint(1) NOT NULL default '1',
  `show_smile` tinyint(1) NOT NULL default '1',
  `email_notify` tinyint(1) NOT NULL default '0',
  `replier` varchar(20) default NULL,
  `redate` varchar(15) default NULL,
  `iswebedit` tinyint(3) unsigned NOT NULL default '0',
  `color` varchar(20) default NULL,
  `colorExpire` varchar(15) NOT NULL default '0',
  `isBold` tinyint(1) NOT NULL default '0',
  `boldExpire` varchar(15) NOT NULL default '0',
  `isBlog` tinyint(1) NOT NULL default '0',
  `blogUserDir` varchar(50) NOT NULL default 'default',
  `replyRootName` varchar(50) default NULL,
  `pluginCode` varchar(20) default NULL,
  `plugin2Code` varchar(20) default NULL,
  `thread_type` int(11) NOT NULL default '0',
  `check_status` tinyint(3) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `rootid` (`rootid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_message_attach` (
  `id` bigint(20) NOT NULL default '0',
  `msgId` bigint(20) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` text NOT NULL,
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `DOWNLOAD_COUNT` int(11) NOT NULL default '0',
  `UPLOAD_DATE` varchar(15) NOT NULL default '0',
  `FILE_SIZE` bigint(20) NOT NULL default '0',
  `USER_NAME` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `msgId` (`msgId`),
  KEY `idx_upload_date` (`UPLOAD_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_online` (
  `name` varchar(50) NOT NULL default '',
  `boardcode` varchar(20) default NULL,
  `ip` varchar(15) NOT NULL default '',
  `doing` varchar(50) default NULL,
  `logtime` varchar(15) NOT NULL default '0',
  `staytime` varchar(15) NOT NULL default '0',
  `isguest` tinyint(1) NOT NULL default '0',
  `covered` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`name`),
  KEY `IX_sq_online` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_online` (`name`,`boardcode`,`ip`,`doing`,`logtime`,`staytime`,`isguest`,`covered`) VALUES ('1172557619156662517509','ygtd','127.0.0.1',NULL,'1172557619156','1172557619156',1,0);
CREATE TABLE `sq_poll` (
  `msg_id` bigint(20) unsigned NOT NULL auto_increment,
  `expire_date` date default NULL,
  `max_choice` tinyint(3) unsigned NOT NULL default '1',
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_poll_option` (
  `msg_id` bigint(20) NOT NULL default '0',
  `orders` int(10) unsigned NOT NULL default '0',
  `vote_user` text,
  `content` varchar(45) NOT NULL default '',
  `vote_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`msg_id`,`orders`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_roomemcee` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `room` varchar(20) NOT NULL default '',
  `sort` int(11) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_setup_user_level` (
  `levelAmount` int(11) NOT NULL default '0',
  `description` varchar(50) NOT NULL default '',
  `levelPicPath` varchar(255) default NULL,
  `groupCode` varchar(20) default NULL,
  PRIMARY KEY  (`levelAmount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_setup_user_level` (`levelAmount`,`description`,`levelPicPath`,`groupCode`) VALUES (0,'初入江湖','level1.gif','everyone'),(1000,'小有名气','level2.gif',''),(2000,'名动一方','level3.gif',''),(3000,'天下闻名','level4.gif',''),(4000,'一代宗师','level5.gif',''),(5000,'超凡入圣','level6.gif',''),(6000,'天外飞仙','level7.gif',''),(7000,'无所不能','level8.gif','');
CREATE TABLE `sq_thread` (
  `id` bigint(20) NOT NULL default '0' COMMENT 'The id of message''s root id',
  `boardcode` varchar(20) default NULL,
  `msg_level` int(11) NOT NULL default '0',
  `iselite` tinyint(1) NOT NULL default '0',
  `lydate` varchar(15) NOT NULL default '0',
  `redate` varchar(15) default '0' COMMENT 'reply date',
  `name` varchar(20) NOT NULL default '',
  `blogUserDir` varchar(50) default NULL,
  `isBlog` tinyint(1) NOT NULL default '0',
  `hit` int(11) NOT NULL default '0',
  `check_status` tinyint(3) NOT NULL default '1',
  `thread_type` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `boardcode` (`boardcode`),
  KEY `name` (`name`),
  KEY `blog_name_blogUserDir` (`name`,`blogUserDir`),
  KEY `lydate` (`lydate`),
  KEY `redate` (`redate`),
  KEY `hit` (`hit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_thread_type` (
  `id` int(11) NOT NULL default '0',
  `board_code` varchar(20) NOT NULL default '',
  `display_order` int(10) unsigned NOT NULL default '1',
  `name` varchar(20) NOT NULL default '',
  `color` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `board_code` (`board_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_user` (
  `name` varchar(20) NOT NULL default '',
  `pwd` varchar(32) default NULL,
  `rawPwd` varchar(32) default NULL,
  `RegDate` varchar(15) NOT NULL default '0',
  `realname` varchar(50) default NULL,
  `RealPic` varchar(50) default NULL,
  `Question` varchar(50) default NULL,
  `Answer` varchar(50) default NULL,
  `Email` varchar(50) default NULL,
  `Gender` char(1) default NULL,
  `OICQ` varchar(10) default NULL,
  `Birthday` varchar(15) default '0',
  `IDCard` varchar(50) default NULL,
  `Career` varchar(100) default NULL,
  `Job` varchar(50) default NULL,
  `State` varchar(50) default NULL,
  `City` varchar(50) default NULL,
  `Address` varchar(255) default NULL,
  `PostCode` varchar(50) default NULL,
  `Phone` varchar(50) default NULL,
  `Mobile` varchar(50) default NULL,
  `Hobbies` varchar(50) default NULL,
  `lastTime` varchar(15) NOT NULL default '0',
  `curTime` varchar(15) NOT NULL default '0',
  `sign` varchar(200) default NULL,
  `myface` varchar(50) default NULL,
  `myfacewidth` int(11) default '120',
  `myfaceheight` int(11) default '150',
  `favoriate` varchar(250) default NULL,
  `ispolice` tinyint(1) NOT NULL default '0',
  `arrestday` int(11) NOT NULL default '0',
  `arrestreason` text,
  `arresttime` varchar(15) default NULL,
  `arrestpolice` varchar(20) default NULL,
  `experience` int(11) NOT NULL default '0',
  `credit` int(11) NOT NULL default '500',
  `addcount` int(11) NOT NULL default '0',
  `delcount` int(11) NOT NULL default '0',
  `eliteCount` int(11) NOT NULL default '0',
  `Marriage` tinyint(3) unsigned NOT NULL default '0',
  `gold` int(11) NOT NULL default '0',
  `isValid` tinyint(1) NOT NULL default '1',
  `diskSpaceAllowed` int(11) NOT NULL default '1024000',
  `diskSpaceUsed` int(11) NOT NULL default '0',
  `isSecret` tinyint(1) NOT NULL default '1',
  `IP` varchar(15) default NULL,
  `timeZone` varchar(9) NOT NULL default '',
  `releasetime` varchar(15) NOT NULL default '0',
  `home` varchar(200) default NULL,
  `msn` varchar(200) default NULL,
  `group_code` varchar(20) default NULL,
  `icq` varchar(50) default NULL,
  `uc` varchar(50) default NULL,
  `yahoo` varchar(50) default NULL,
  `locale` varchar(20) default NULL,
  `nick` varchar(20) NOT NULL default '',
  `check_status` tinyint(3) NOT NULL default '1',
  PRIMARY KEY  (`name`),
  KEY `RegDate` (`RegDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_user` (`name`,`pwd`,`rawPwd`,`RegDate`,`realname`,`RealPic`,`Question`,`Answer`,`Email`,`Gender`,`OICQ`,`Birthday`,`IDCard`,`Career`,`Job`,`State`,`City`,`Address`,`PostCode`,`Phone`,`Mobile`,`Hobbies`,`lastTime`,`curTime`,`sign`,`myface`,`myfacewidth`,`myfaceheight`,`favoriate`,`ispolice`,`arrestday`,`arrestreason`,`arresttime`,`arrestpolice`,`experience`,`credit`,`addcount`,`delcount`,`eliteCount`,`Marriage`,`gold`,`isValid`,`diskSpaceAllowed`,`diskSpaceUsed`,`isSecret`,`IP`,`timeZone`,`releasetime`,`home`,`msn`,`group_code`,`icq`,`uc`,`yahoo`,`locale`,`nick`,`check_status`) VALUES ('admin',NULL,NULL,'1157098314031',NULL,'face.gif',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,120,150,NULL,0,0,NULL,NULL,NULL,0,500,0,0,0,0,0,1,1024000,0,1,NULL,'','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin',1);
CREATE TABLE `sq_user_group` (
  `code` varchar(50) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `isSystem` tinyint(1) NOT NULL default '0',
  `display_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_user_group` (`code`,`description`,`isSystem`,`display_order`) VALUES ('everyone','所有人',1,1);
CREATE TABLE `sq_user_group_priv` (
  `group_code` varchar(20) NOT NULL default '',
  `priv` varchar(50) NOT NULL default '',
  `add_topic` char(1) NOT NULL default '1',
  `reply_topic` char(1) NOT NULL default '1',
  `vote` char(1) NOT NULL default '1',
  `search` char(1) NOT NULL default '1',
  `attach_upload` char(1) NOT NULL default '1',
  `attach_download` char(1) NOT NULL default '1',
  `board_code` varchar(50) NOT NULL default '',
  `money_code` varchar(20) default NULL,
  `money_sum` int(11) NOT NULL default '0',
  `is_default` char(1) NOT NULL default '1',
  `enter_board` char(1) NOT NULL default '1',
  `view_topic` char(1) NOT NULL default '1',
  PRIMARY KEY  (`group_code`,`board_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user''s privilege';
CREATE TABLE `sq_user_priv` (
  `user_name` varchar(20) NOT NULL default '',
  `priv` varchar(50) NOT NULL default '',
  `attach_day_count` int(10) unsigned default NULL,
  `attach_size` int(10) unsigned default '0' COMMENT 'unit is K',
  `add_topic` char(1) default '1',
  `reply_topic` char(1) default '1',
  `vote` char(1) default '1',
  `search` char(1) default '1',
  `attach_upload` char(1) default '1',
  `attach_download` char(1) default '1',
  `attach_today` varchar(15) default NULL,
  `attach_today_upload_count` int(10) unsigned NOT NULL default '0',
  `is_default` char(1) default '1',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user''s privilege';
CREATE TABLE `sq_user_prop` (
  `name` varchar(20) NOT NULL default '',
  `flower_count` int(11) NOT NULL default '0',
  `egg_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_user_prop` (`name`,`flower_count`,`egg_count`) VALUES ('1',0,0),('admin',0,0);
CREATE TABLE `sq_user_treasure` (
  `userName` varchar(50) NOT NULL default '',
  `treasureCode` varchar(50) NOT NULL default '',
  `buyDate` varchar(15) NOT NULL default '0',
  `amount` int(11) NOT NULL default '0',
  UNIQUE KEY `IX_sq_user_treasure` (`userName`,`treasureCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `task` (
  `id` int(11) NOT NULL default '0',
  `initiator` varchar(20) NOT NULL default '',
  `title` varchar(34) NOT NULL default '',
  `content` longtext NOT NULL,
  `person` varchar(20) default NULL,
  `rootid` int(11) NOT NULL default '0',
  `type` varchar(4) NOT NULL default '',
  `layer` int(11) NOT NULL default '0',
  `orders` int(11) NOT NULL default '0',
  `parentid` int(11) NOT NULL default '-1',
  `mydate` datetime NOT NULL default '0000-00-00 00:00:00',
  `IP` varchar(15) NOT NULL default '',
  `expression` tinyint(3) unsigned NOT NULL default '0',
  `recount` int(11) NOT NULL default '0',
  `fileName` varchar(7) default NULL,
  `ext` varchar(10) default NULL,
  `status` tinyint(1) NOT NULL default '0',
  `jobCode` varchar(11) default '20',
  `actionId` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `initiator` (`initiator`),
  KEY `person` (`person`),
  KEY `actionId` USING BTREE (`actionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `task_attach` (
  `id` int(11) NOT NULL auto_increment,
  `taskId` int(11) NOT NULL default '0',
  `fullPath` varchar(250) NOT NULL default '0',
  `diskName` varchar(250) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `visualPath` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `taskId` (`taskId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_admin_dept` (
  `id` int(11) NOT NULL default '0',
  `userName` varchar(20) NOT NULL default '',
  `deptCode` varchar(20) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_archive` (
  `id` varchar(20) NOT NULL default '',
  `name` varchar(20) NOT NULL default '',
  `realName` varchar(20) default NULL,
  `birthday` date default NULL,
  `nation` varchar(10) default NULL,
  `IDCard` varchar(20) default NULL,
  `photo` varchar(250) default NULL,
  `gender` tinyint(1) NOT NULL default '0',
  `marriage` tinyint(1) NOT NULL default '0',
  `jiGuan` varchar(20) default NULL,
  `hukouAddress` varchar(250) default NULL,
  `xueLi` int(11) NOT NULL default '0',
  `zhuanYe` varchar(50) default NULL,
  `school` varchar(50) default NULL,
  `workDate` date default NULL,
  `workDateAtHere` date default NULL,
  `dept` varchar(50) default NULL,
  `zhiWu` varchar(50) default NULL,
  `zhiChen` varchar(20) default NULL,
  `politics` int(11) NOT NULL default '0',
  `homeAddress` varchar(250) default NULL,
  `homeTel` varchar(20) default NULL,
  `email` varchar(30) default NULL,
  `postChange` text,
  `education` text,
  `resume` text,
  `socialRelation` text,
  `jiangchenRecord` text,
  `zhiwuQinkuang` text,
  `trainRecord` text,
  `danbaoRecord` varchar(11) default NULL,
  `contract` text,
  `insure` text,
  `tijianRecord` text,
  `remark` text,
  `attachment` varchar(250) default NULL,
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_desktop_setup` (
  `ID` int(10) unsigned NOT NULL default '0',
  `USER_NAME` varchar(20) NOT NULL default '',
  `TITLE` varchar(255) NOT NULL default '',
  `COUNT` int(10) unsigned NOT NULL default '10',
  `WIN_LEFT` int(10) unsigned NOT NULL default '0',
  `WIN_TOP` int(10) unsigned NOT NULL default '0',
  `WIN_WIDTH` int(10) unsigned NOT NULL default '200',
  `WIN_HEIGHT` int(10) unsigned NOT NULL default '100',
  `MODULE_CODE` varchar(20) default NULL,
  `MODULE_ITEM` varchar(100) default NULL,
  `IS_SYSTEM` int(10) unsigned NOT NULL default '0',
  `MORE_PAGE` varchar(255) default NULL,
  `IS_LOCKED` char(1) NOT NULL default '',
  `ZINDEX` int(10) unsigned NOT NULL default '100',
  `WIN_MIN` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  KEY `user_name` (`USER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `user_desktop_setup` (`ID`,`USER_NAME`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`) VALUES (1,'1','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(2,'1','待办工作流',20,6,0,418,244,'flow','',0,NULL,'',1,0),(3,'1','任务督办',10,8,512,418,265,'task','',0,NULL,'',1,0),(4,'1','短消息',10,7,255,418,248,'msg','',0,NULL,'',1,0),(5,'1','论坛新贴',10,431,514,371,260,'forum','',0,NULL,'',1,0),(6,'1','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0),(12,'bluewind','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(13,'bluewind','待办工作流',20,6,0,418,244,'flow','',0,NULL,'',1,0),(14,'bluewind','任务督办',10,8,512,418,265,'task','',0,NULL,'',1,0),(15,'bluewind','短消息',10,7,255,418,248,'msg','',0,NULL,'',1,0),(16,'bluewind','论坛新贴',10,431,514,371,260,'forum','',0,NULL,'',1,0),(17,'bluewind','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0),(365,'test','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0);
INSERT INTO `user_desktop_setup` (`ID`,`USER_NAME`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`) VALUES (366,'test','待办工作流',20,6,0,418,244,'flow','',0,NULL,'',1,0),(367,'test','任务督办',10,7,523,418,269,'task','',0,NULL,'',3,0),(368,'test','短消息',10,7,255,418,265,'msg','',0,NULL,'',2,0),(369,'test','论坛新贴',10,431,514,371,264,'forum','',0,NULL,'',3,0),(370,'test','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0),(397,'3','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(398,'3','待办工作流',20,6,0,418,252,'flow','',0,NULL,'',2,0),(399,'3','任务督办',10,8,512,418,265,'task','',0,NULL,'',1,0),(400,'3','短消息',10,7,255,418,248,'msg','',0,NULL,'',1,0),(401,'3','论坛新贴',10,431,514,371,260,'forum','',0,NULL,'',1,0),(402,'3','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0),(430,'2','公共通知',10,429,0,371,250,'fileark','notice',0,NULL,'',5,0),(431,'2','待办工作流',20,6,0,418,248,'flow','',0,NULL,'',15,0);
INSERT INTO `user_desktop_setup` (`ID`,`USER_NAME`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`) VALUES (432,'2','任务督办',10,8,512,418,265,'task','',0,NULL,'',1,0),(433,'2','短消息',10,7,255,418,248,'msg','',0,NULL,'',1,0),(434,'2','论坛新贴',10,431,514,371,260,'forum','',0,NULL,'',1,0),(435,'2','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0),(441,'111','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(442,'111','待办工作流',20,6,0,418,244,'flow','',0,NULL,'',1,0),(443,'111','任务督办',10,8,512,418,265,'task','',0,NULL,'',1,0),(444,'111','短消息',10,7,255,418,248,'msg','',0,NULL,'',1,0),(445,'111','论坛新贴',10,431,514,371,260,'forum','',0,NULL,'',1,0),(446,'111','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0),(452,'admin','公共通知',10,432,2,371,257,'fileark','notice',0,NULL,'',12,0),(453,'admin','待办工作流',20,10,1,416,271,'flow','',0,NULL,'',37,0),(454,'admin','任务督办',10,14,528,418,285,'task','',0,NULL,'',11,0);
INSERT INTO `user_desktop_setup` (`ID`,`USER_NAME`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`) VALUES (455,'admin','短消息',10,6,278,422,252,'msg','',0,NULL,'',26,0),(456,'admin','论坛新贴',10,432,537,374,280,'forum','',0,NULL,'',15,0),(457,'admin','日程安排',10,432,278,373,260,'plan','',0,NULL,'',15,0),(464,'张晨','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(465,'333','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(466,'222','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(467,'5','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(469,'6','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(470,'3','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',3,0),(471,'2','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',16,0),(473,'test','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',4,0),(475,'张晨','公共通知',10,664,65,371,250,'fileark','notice',0,NULL,'',2,0);
INSERT INTO `user_desktop_setup` (`ID`,`USER_NAME`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`) VALUES (476,'333','公共通知',10,664,65,371,250,'fileark','notice',0,NULL,'',2,0),(477,'222','公共通知',10,664,65,371,250,'fileark','notice',0,NULL,'',2,0),(478,'5','公共通知',10,664,65,371,250,'fileark','notice',0,NULL,'',2,0),(480,'6','公共通知',10,664,65,371,250,'fileark','notice',0,NULL,'',2,0),(481,'3','公共通知',10,664,65,371,250,'fileark','notice',0,NULL,'',4,0),(482,'2','公共通知',10,664,65,371,250,'fileark','notice',0,NULL,'',17,0),(487,'张晨','文章',500,0,0,200,100,'document','255',0,NULL,'',3,0),(489,'222','文章',500,0,0,200,100,'document','255',0,NULL,'',3,0),(490,'5','文章',500,0,0,200,100,'document','255',0,NULL,'',3,0),(492,'6','文章',500,0,0,200,100,'document','255',0,NULL,'',3,0),(493,'3','文章',500,0,0,200,100,'document','255',0,NULL,'',5,0),(494,'2','文章',500,0,0,200,100,'document','255',0,NULL,'',18,0);
INSERT INTO `user_desktop_setup` (`ID`,`USER_NAME`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`) VALUES (507,'我是谁','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(508,'我是谁','待办工作流',20,6,0,418,244,'flow','',0,NULL,'',1,0),(509,'我是谁','任务督办',10,8,512,418,265,'task','',0,NULL,'',1,0),(510,'我是谁','短消息',10,7,255,418,248,'msg','',0,NULL,'',1,0),(511,'我是谁','论坛新贴',10,431,514,371,260,'forum','',0,NULL,'',1,0),(512,'我是谁','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0),(518,'你','公共通知',10,430,0,371,246,'fileark','notice',0,NULL,'',1,0),(519,'你','待办工作流',20,6,0,418,244,'flow','',0,NULL,'',1,0),(520,'你','任务督办',10,8,512,418,265,'task','',0,NULL,'',1,0),(521,'你','短消息',10,7,255,418,248,'msg','',0,NULL,'',1,0),(522,'你','论坛新贴',10,431,514,371,260,'forum','',0,NULL,'',1,0),(523,'你','日程安排',10,431,254,371,253,'plan','',0,NULL,'',1,0);
CREATE TABLE `user_group` (
  `code` varchar(50) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `isSystem` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `user_group` (`code`,`description`,`isSystem`) VALUES ('Administrators','管理员组',1),('Everyone','每个人',1),('ky','一般科员',0);
CREATE TABLE `user_group_of_role` (
  `userGroupCode` varchar(50) NOT NULL default '',
  `roleCode` varchar(50) NOT NULL default '',
  KEY `IX_user_of_role` (`userGroupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_group_priv` (
  `groupCode` varchar(20) NOT NULL default '',
  `priv` varchar(20) NOT NULL default '',
  KEY `IX_group_priv` (`groupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_of_group` (
  `user_name` varchar(50) NOT NULL default '',
  `group_code` varchar(50) NOT NULL default '',
  KEY `IX_user_of_group` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `user_of_group` (`user_name`,`group_code`) VALUES ('admin','Administrators');
CREATE TABLE `user_of_role` (
  `userName` varchar(50) NOT NULL default '',
  `roleCode` varchar(50) NOT NULL default '',
  KEY `IX_user_of_role` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_plan` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(50) NOT NULL default '',
  `content` tinytext,
  `userName` varchar(20) NOT NULL default '',
  `myDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `zdrq` datetime NOT NULL default '0000-00-00 00:00:00',
  `isRemind` tinyint(1) NOT NULL default '0',
  `remindDate` datetime default NULL,
  `remindCount` int(11) NOT NULL default '0',
  `IS_REMIND_BY_SMS` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `myDate` (`myDate`),
  KEY `remindDate_myDate` (`remindDate`,`myDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_priv` (
  `username` varchar(20) NOT NULL default '',
  `priv` varchar(50) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_role` (
  `code` varchar(50) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `isSystem` tinyint(1) NOT NULL default '0',
  `orders` int(11) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_role_priv` (
  `roleCode` varchar(20) NOT NULL default '',
  `priv` varchar(20) NOT NULL default '',
  KEY `IX_role_priv` (`roleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_setup` (
  `USER_NAME` varchar(20) NOT NULL default '',
  `MESSAGE_TO_DEPT` varchar(255) default NULL,
  `MESSAGE_TO_USERGROUP` varchar(255) default NULL,
  `MESSAGE_TO_USERROLE` varchar(255) default NULL,
  `MESSAGE_TO_MAX_USER` int(11) NOT NULL default '5',
  `MESSAGE_USER_MAX_COUNT` int(11) NOT NULL default '800',
  `IS_MSG_WIN_POPUP` tinyint(1) NOT NULL default '1',
  `IS_CHAT_SOUND_PLAY` tinyint(1) NOT NULL default '1',
  `IS_CHAT_ICON_SHOW` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`USER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `user_setup` (`USER_NAME`,`MESSAGE_TO_DEPT`,`MESSAGE_TO_USERGROUP`,`MESSAGE_TO_USERROLE`,`MESSAGE_TO_MAX_USER`,`MESSAGE_USER_MAX_COUNT`,`IS_MSG_WIN_POPUP`,`IS_CHAT_SOUND_PLAY`,`IS_CHAT_ICON_SHOW`) VALUES ('admin','','','',5,800,1,1,1);
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(20) NOT NULL default '',
  `pwd` varchar(32) default NULL,
  `pwdRaw` varchar(32) default NULL,
  `regDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `realName` varchar(17) default NULL,
  `picture` varchar(17) default NULL COMMENT '论坛中所用的图片',
  `email` varchar(17) default NULL,
  `gender` tinyint(1) default '0',
  `QQ` varchar(15) default NULL,
  `birthday` datetime default NULL,
  `IDCard` varchar(17) default NULL,
  `isMarriaged` tinyint(1) NOT NULL default '0' COMMENT '0 未婚',
  `state` varchar(17) default NULL,
  `city` varchar(17) default NULL,
  `address` varchar(17) default NULL,
  `postCode` varchar(20) default NULL,
  `phone` varchar(17) default NULL,
  `mobile` varchar(12) default NULL,
  `hobbies` varchar(17) default NULL,
  `lastTime` datetime NOT NULL default '0000-00-00 00:00:00',
  `isValid` tinyint(3) unsigned NOT NULL default '1' COMMENT '1 有效 0 禁止',
  `emailName` varchar(20) default NULL,
  `MSN` varchar(20) default NULL,
  `proxy` varchar(20) default NULL COMMENT 'null -- no proxy  代理者的职位编码',
  `proxyBeginDate` datetime default NULL,
  `proxyEndDate` datetime default NULL,
  `diskSpaceAllowed` bigint(20) NOT NULL default '10240000',
  `diskSpaceUsed` bigint(20) NOT NULL default '0',
  `rankCode` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `Index_mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `users` (`id`,`name`,`pwd`,`pwdRaw`,`regDate`,`realName`,`picture`,`email`,`gender`,`QQ`,`birthday`,`IDCard`,`isMarriaged`,`state`,`city`,`address`,`postCode`,`phone`,`mobile`,`hobbies`,`lastTime`,`isValid`,`emailName`,`MSN`,`proxy`,`proxyBeginDate`,`proxyEndDate`,`diskSpaceAllowed`,`diskSpaceUsed`,`rankCode`) VALUES (2,'admin','96e79218965eb72c92a549dd5a330112','111111','2006-08-30 00:00:00','admin',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0000-00-00 00:00:00',1,NULL,NULL,'',NULL,NULL,10240000,0,NULL);
CREATE TABLE `vehicle` (
  `licenseNo` varchar(50) NOT NULL default '',
  `engineNo` varchar(50) NOT NULL default '',
  `type` int(11) default NULL,
  `driver` varchar(20) NOT NULL default '',
  `price` varchar(20) NOT NULL default '0',
  `image` varchar(255) default NULL,
  `buyDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `state` int(11) default NULL,
  `remark` text,
  `brand` varchar(200) default NULL,
  PRIMARY KEY  (`licenseNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `vehicle_driver` (
  `Id` int(11) NOT NULL auto_increment,
  `userName` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `vehicle_maintenance` (
  `id` int(11) NOT NULL default '0',
  `licenseNo` varchar(50) NOT NULL default '',
  `beginDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `endDate` datetime default NULL,
  `type` int(11) NOT NULL default '0',
  `cause` varchar(200) default NULL,
  `expense` varchar(50) default NULL,
  `transactor` varchar(20) NOT NULL default '',
  `remark` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `vehicle_type` (
  `Id` int(11) NOT NULL auto_increment,
  `typeCode` varchar(11) default NULL,
  `description` varchar(11) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `vehicle_use` (
  `id` int(11) NOT NULL default '0',
  `licenseNo` varchar(50) NOT NULL default '',
  `beginDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `endDate` datetime default NULL,
  `vehicleUser` varchar(20) NOT NULL default '',
  `vehicleDeptNo` int(11) NOT NULL default '0',
  `transactor` varchar(20) NOT NULL default '',
  `destination` varchar(50) NOT NULL default '',
  `cause` text,
  `remark` text,
  `state` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `visual_attach` (
  `id` int(11) NOT NULL auto_increment,
  `visualId` int(11) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` text NOT NULL,
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `formCode` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `visualId` (`visualId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `work_log` (
  `id` int(11) NOT NULL auto_increment,
  `userName` varchar(20) NOT NULL default '',
  `content` text NOT NULL,
  `myDate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `work_plan` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(250) default NULL,
  `content` text,
  `beginDate` date default NULL,
  `endDate` date default NULL,
  `typeId` int(11) NOT NULL default '0',
  `remark` text,
  `principal` varchar(100) default NULL,
  `isMessageRemind` tinyint(1) NOT NULL default '1',
  `author` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `work_plan_attach` (
  `id` int(11) NOT NULL auto_increment,
  `workPlanId` int(11) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` varchar(255) NOT NULL default '',
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(200) NOT NULL default '',
  `page_num` int(11) NOT NULL default '1',
  `orders` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `workPlanId` (`workPlanId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `work_plan_dept` (
  `workPlanId` int(11) default NULL,
  `deptCode` varchar(50) default NULL,
  KEY `workPlanId` (`workPlanId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `work_plan_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `work_plan_user` (
  `workPlanId` int(11) default NULL,
  `userName` varchar(20) NOT NULL default '',
  KEY `workPlanId` (`workPlanId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
