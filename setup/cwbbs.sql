SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE=NO_AUTO_VALUE_ON_ZERO */;


CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cwbbs`;
USE `cwbbs`;
CREATE TABLE `blog` (
  `id` int(11) NOT NULL default '0',
  `blogCount` int(11) NOT NULL default '0',
  `newBlogId` bigint(20) default NULL,
  `topicCount` int(11) NOT NULL default '0',
  `postCount` int(11) NOT NULL default '0',
  `todayCount` int(11) NOT NULL default '0',
  `todayDate` varchar(15) NOT NULL default '',
  `yestodayCount` int(11) NOT NULL default '0',
  `maxCount` int(11) NOT NULL default '0',
  `maxDate` varchar(15) NOT NULL default '',
  `star` varchar(20) default NULL,
  `homeClasses` varchar(255) default NULL,
  `recommandBlogs` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `blog` (`id`,`blogCount`,`newBlogId`,`topicCount`,`postCount`,`todayCount`,`todayDate`,`yestodayCount`,`maxCount`,`maxDate`,`star`,`homeClasses`,`recommandBlogs`) VALUES (1,0,0,0,0,0,'1182995827015',0,0,'2005-10-02','','wx,keji,yishu,trap,teach,movie,sport','');
CREATE TABLE `blog_directory` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default '0',
  `add_date` varchar(15) NOT NULL default '',
  `islocked` tinyint(1) NOT NULL default '0',
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  `doc_id` int(11) NOT NULL default '-1',
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(50) NOT NULL default 'N''default''',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `blog_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`) VALUES ('cuzhong','初中',0,'','teach','root',2,0,'0',0,2,3,0,-1,'N\'default\''),('dance','舞蹈',0,'','yishu','root',1,0,'0',0,2,3,0,-1,'N\'default\''),('daxue','大学',0,'','teach','root',4,0,'0',0,2,3,0,-1,'N\'default\''),('dianzi','电子',0,'','keji','root',1,0,'0',0,2,3,0,-1,'N\'default\''),('donghua','动画',0,'','movie','root',3,0,'0',0,2,3,0,-1,'N\'default\''),('football','足球',0,'','sport','root',1,0,'0',0,2,3,0,-1,'N\'default\''),('gaozhong','高中',0,'','teach','root',3,0,'0',0,2,3,0,-1,'N\'default\''),('gc','歌唱',0,'','yishu','root',2,0,'0',0,2,3,0,-1,'N\'default\''),('keji','科技博客',1,'','root','root',2,3,'0',0,0,2,0,-1,'N\'default\''),('lanqiu','篮球',0,'','sport','root',2,0,'0',0,2,3,0,-1,'N\'default\''),('movie','电影博客',0,'','root','root',6,5,'0',0,0,2,0,-1,'N\'default\''),('msdc','名山大川',0,'','trap','root',1,0,'0',0,2,3,0,-1,'N\'default\'');
INSERT INTO `blog_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`) VALUES ('paint','绘画',0,'','yishu','root',5,0,'0',0,2,3,0,-1,'N\'default\''),('paiqiu','排球',0,'','sport','root',3,0,'0',0,2,3,0,-1,'N\'default\''),('pinpangqiu','乒乓球',0,'','sport','root',4,0,'0',0,2,3,0,-1,'N\'default\''),('program','程序',0,'','keji','root',3,0,'0',0,2,3,0,-1,'N\'default\''),('qiangzhan','枪战',0,'','movie','root',5,0,'0',0,2,3,0,-1,'N\'default\''),('root','全部分类',0,NULL,'-1','root',1,7,'0',0,0,1,0,-1,'N\'default\''),('sanwen','散文',1,'','wx','root',1,0,'0',0,2,3,0,-1,'N\'default\''),('sheji','射击',0,'','sport','root',6,0,'0',0,2,3,0,-1,'N\'default\''),('sheyin','摄影',0,'','yishu','root',4,0,'0',0,2,3,0,-1,'N\'default\''),('shige','诗歌',1,'','wx','root',2,0,'0',0,2,3,0,-1,'N\'default\''),('shougong','手工',0,'','yishu','root',3,0,'0',0,2,3,0,-1,'N\'default\''),('shuma','数码',0,'','keji','root',2,0,'0',0,2,3,0,-1,'N\'default\'');
INSERT INTO `blog_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`) VALUES ('sport','体育博客',0,'','root','root',7,7,'0',0,0,2,0,-1,'N\'default\''),('sport_other','其它',0,'','sport','root',7,0,'0',0,2,3,0,-1,'N\'default\''),('teach','教育博客',0,'','root','root',5,4,'0',0,0,2,0,-1,'N\'default\''),('trap','旅游博客',0,'','root','root',4,3,'0',0,0,2,0,-1,'N\'default\''),('tyfg','田园风光',0,'','trap','root',3,0,'0',0,2,3,0,-1,'N\'default\''),('war','战争',0,'','movie','root',2,0,'0',0,2,3,0,-1,'N\'default\''),('wuda','武打',0,'','movie','root',4,0,'0',0,2,3,0,-1,'N\'default\''),('wx','文学博客',0,'','root','root',1,3,'0',0,0,2,0,-1,'N\'default\''),('xiaoshuo','小说',0,'','wx','root',3,0,'0',0,2,3,0,-1,'N\'default\''),('xiaoxue','小学',0,'','teach','root',1,0,'0',0,2,3,0,-1,'N\'default\''),('xtrq','乡土人情',0,'','trap','root',2,0,'0',0,2,3,0,-1,'N\'default\''),('yanqin','言情',0,'','movie','root',1,0,'0',0,2,3,0,-1,'N\'default\'');
INSERT INTO `blog_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`) VALUES ('yishu','艺术博客',0,'','root','root',3,5,'0',0,0,2,0,-1,'N\'default\''),('youyong','游泳',0,'','sport','root',5,0,'0',0,2,3,0,-1,'N\'default\'');
CREATE TABLE `blog_footprint` (
  `msg_id` bigint(20) NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  `blog_id` bigint(20) default NULL,
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`msg_id`,`user_name`),
  KEY `blog_id` USING BTREE (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blog_group_user` (
  `user_name` varchar(20) NOT NULL default '',
  `blog_id` bigint(20) NOT NULL default '0',
  `add_date` datetime default NULL,
  `priv_topic` char(1) NOT NULL default '0',
  `priv_all` char(1) NOT NULL default '0' COMMENT 'manage user',
  `priv_dir` char(1) NOT NULL default '0',
  `check_status` tinyint(3) NOT NULL default '0',
  `apply_reason` varchar(200) default NULL,
  PRIMARY KEY  (`blog_id`,`user_name`),
  KEY `Index_user_name` (`user_name`),
  KEY `Index_blog_id` (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='users of circle';
CREATE TABLE `blog_link` (
  `id` int(11) NOT NULL default '0',
  `url` varchar(200) NOT NULL default '',
  `title` varchar(100) default NULL,
  `image` text,
  `blog_id` bigint(20) NOT NULL default '0',
  `sort` int(11) NOT NULL default '0',
  `is_remote` tinyint(3) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `userName` (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blog_music` (
  `id` bigint(20) unsigned NOT NULL default '0',
  `title` varchar(255) default NULL,
  `music` varchar(255) NOT NULL default '',
  `blog_id` bigint(20) unsigned NOT NULL default '0',
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `is_remote` tinyint(3) unsigned NOT NULL default '0',
  `sort` int(10) unsigned NOT NULL default '0',
  `is_bk_music` tinyint(1) unsigned NOT NULL default '1',
  `link` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `IX_music` USING BTREE (`blog_id`),
  KEY `add_date` (`add_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blog_photo` (
  `id` int(11) NOT NULL default '0',
  `title` varchar(100) default NULL,
  `image` varchar(255) default NULL,
  `blog_id` bigint(20) unsigned NOT NULL default '0',
  `sort` int(11) NOT NULL default '0',
  `addDate` varchar(15) NOT NULL default '',
  `is_remote` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `IX_photo` USING BTREE (`blog_id`),
  KEY `addDate` (`addDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blog_user_config` (
  `id` bigint(20) unsigned NOT NULL default '0',
  `userName` varchar(50) NOT NULL default '',
  `title` varchar(50) NOT NULL default '',
  `subtitle` varchar(50) default NULL,
  `penName` varchar(50) NOT NULL default '',
  `skin` varchar(50) NOT NULL default 'default',
  `notice` varchar(255) NOT NULL default '',
  `addDate` varchar(15) NOT NULL default '',
  `isValid` tinyint(1) NOT NULL default '1',
  `viewCount` int(11) NOT NULL default '0',
  `msgCount` int(11) NOT NULL default '0',
  `replyCount` int(11) NOT NULL default '0',
  `kind` varchar(20) NOT NULL default '',
  `blog_type` int(10) unsigned NOT NULL default '0' COMMENT '0-person 1-group',
  `update_date` varchar(15) default NULL,
  `icon` varchar(250) default NULL,
  `friends` varchar(255) default NULL,
  `is_footprint` tinyint(1) NOT NULL default '1',
  `domain` varchar(20) default NULL,
  `is_bk_music` tinyint(1) unsigned NOT NULL default '0',
  `is_user_css` tinyint(1) unsigned NOT NULL default '0',
  `css_path` varchar(40) default NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_userName` (`userName`),
  KEY `upload_date` (`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blog_user_dir` (
  `code` varchar(50) NOT NULL default '',
  `blog_id` varchar(50) NOT NULL default '',
  `dirName` varchar(250) NOT NULL default '',
  `catalogCode` varchar(50) NOT NULL default 'N''default''',
  `sort` int(11) NOT NULL default '0',
  `color` varchar(20) default NULL,
  `addDate` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`code`),
  KEY `blog_id` (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `blog_video` (
  `id` bigint(20) unsigned NOT NULL default '0',
  `title` varchar(255) default NULL,
  `video` varchar(255) NOT NULL default '',
  `blog_id` bigint(20) unsigned NOT NULL default '0',
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `is_remote` tinyint(3) unsigned NOT NULL default '0',
  `sort` int(10) unsigned NOT NULL default '0',
  `link` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `IX_video` USING BTREE (`blog_id`),
  KEY `add_date` (`add_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cms_comment` (
  `id` bigint(11) NOT NULL default '0',
  `content` text NOT NULL,
  `add_date` varchar(15) NOT NULL default '',
  `doc_id` int(11) NOT NULL default '0',
  `ip` varchar(15) NOT NULL default '',
  `nick` varchar(50) default NULL,
  `link` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `IX_comment` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cms_images` (
  `id` bigint(20) NOT NULL default '0',
  `path` varchar(255) NOT NULL default '',
  `mainkey` varchar(20) NOT NULL default '',
  `kind` varchar(20) NOT NULL default '',
  `subkey` int(11) NOT NULL default '1',
  `visualPath` varchar(200) default NULL,
  PRIMARY KEY  (`id`),
  KEY `IX_images` (`mainkey`),
  KEY `IX_images_1` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `cms_images` (`id`,`path`,`mainkey`,`kind`,`subkey`,`visualPath`) VALUES (10,'upfile/webeditimg/2006/8/2357ddd8a4354a8b82292978ec6821f6.jpg','1','document',1,NULL),(11,'upfile/webeditimg/2006/8/528e140122ca4930a85d31ca942a0ab3.jpg','2','document',1,NULL),(12,'upfile/webeditimg/2006/8/96ede6606c104816bc9f7a6722929a9c.jpg','3','document',1,NULL);
CREATE TABLE `cms_robot` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(250) NOT NULL default '',
  `gather_count` int(11) NOT NULL default '1',
  `charset` varchar(30) default NULL,
  `list_url_type` tinyint(3) NOT NULL default '0',
  `list_url_link` varchar(250) NOT NULL default '0',
  `list_page_begin` int(11) NOT NULL default '0',
  `list_page_end` int(11) default '0',
  `list_field_rule` varchar(250) default NULL,
  `list_doc_url_rule` varchar(250) default NULL,
  `list_doc_url_prefix` varchar(250) default NULL,
  `doc_title_rule` varchar(250) NOT NULL default '',
  `doc_source_rule` varchar(250) default NULL,
  `doc_author_rule` varchar(250) default NULL,
  `doc_content_rule` varchar(250) default NULL,
  `doc_page_mode` tinyint(3) NOT NULL default '0',
  `doc_page_rule` varchar(250) default NULL,
  `doc_page_url_rule` varchar(250) default NULL,
  `doc_page_url_prefix` varchar(250) default NULL,
  `doc_page_num_rule` varchar(250) default NULL,
  `doc_title_filter` varchar(250) default NULL,
  `doc_title_replace_before` varchar(250) default NULL,
  `doc_title_replace_after` varchar(250) default NULL,
  `doc_title_key` varchar(250) default NULL,
  `doc_content_filter` varchar(250) default NULL,
  `doc_content_replace_before` varchar(250) default NULL,
  `doc_content_replace_after` varchar(250) default NULL,
  `doc_save_img` tinyint(1) NOT NULL default '1',
  `doc_save_flash` tinyint(1) NOT NULL default '1',
  `doc_img_flash_prefix` varchar(250) default NULL,
  `dir_code` varchar(20) NOT NULL default '',
  `examine` tinyint(4) NOT NULL default '0',
  `doc_title_repeat_allow` tinyint(3) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `cms_robot` (`id`,`name`,`gather_count`,`charset`,`list_url_type`,`list_url_link`,`list_page_begin`,`list_page_end`,`list_field_rule`,`list_doc_url_rule`,`list_doc_url_prefix`,`doc_title_rule`,`doc_source_rule`,`doc_author_rule`,`doc_content_rule`,`doc_page_mode`,`doc_page_rule`,`doc_page_url_rule`,`doc_page_url_prefix`,`doc_page_num_rule`,`doc_title_filter`,`doc_title_replace_before`,`doc_title_replace_after`,`doc_title_key`,`doc_content_filter`,`doc_content_replace_before`,`doc_content_replace_after`,`doc_save_img`,`doc_save_flash`,`doc_img_flash_prefix`,`dir_code`,`examine`,`doc_title_repeat_allow`) VALUES (181,'网易国内最新新闻',10,'gb2312',0,'http://news.163.com/special/00011SFV/gnList_02.html\r\nhttp://news.163.com/special/00011SFV/gnList_03.html\r\nhttp://news.163.com/special/00011SFV/gnList_04.html\r\nhttp://news.163.com/special/00011SFV/gnList_05.html',2,10,'<div class=\"area\">\r\n<!-- left -->\r\n<div class=\"col1\">[list]<div class=\"clear\">　</div>\r\n</div>','<li><a href=\"[url]\"','','<h1>[subject]</h1>','来源:[from]','','<div id=\"endText\">[message]\r\n</div>',0,'http://news.163.com/special/00011SFV/gnList_[pagearea].html','http://news.163.com/special/00011SFV/gnList_0[page].html','',NULL,'','','','','','','',1,1,'','first_1',0,1);
CREATE TABLE `cms_template` (
  `id` int(10) unsigned NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `path` varchar(255) NOT NULL default '',
  `type_code` int(11) NOT NULL default '0',
  `orders` int(11) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `cms_template` (`id`,`name`,`path`,`type_code`,`orders`) VALUES (21,'第一频道','doc/template/doc_show.htm',0,1),(32,'默认','doc/template/doc_show.htm',0,0),(49,'图片显示','doc/template/img_doc_show.htm',0,1),(62,'软件','doc/template/soft_doc_show.htm',0,1),(101,'默认模板','doc/template/doc_list_template.htm',1,0),(111,'默认专题列表页','doc/template/subject_list_template.htm',2,1);
CREATE TABLE `cws_cms_advertisement` (
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
  `nick` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `ad_type` (`ad_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cws_cms_forum_user_group_priv` (
  `group_code` varchar(20) NOT NULL default '',
  `dir_code` varchar(20) NOT NULL default '',
  `search` char(1) NOT NULL default '1',
  `download_attach` char(1) NOT NULL default '1',
  `is_default` char(1) NOT NULL default '1',
  `view_doc` char(1) NOT NULL default '1',
  `money_code` varchar(20) default NULL,
  `money_sum` int(11) NOT NULL default '0',
  PRIMARY KEY  (`group_code`,`dir_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user''s privilege';
INSERT INTO `cws_cms_forum_user_group_priv` (`group_code`,`dir_code`,`search`,`download_attach`,`is_default`,`view_doc`,`money_code`,`money_sum`) VALUES ('everyone','alldir','1','0','1','1','',0),('guest','alldir','1','0','1','1','',0),('guest','email','1','0','1','1','',0),('guest','first_1','1','0','1','1','',0),('guest','first_2','1','0','1','1','',0);
CREATE TABLE `cws_cms_img_doc` (
  `doc_id` int(11) NOT NULL default '0',
  `small_img` varchar(255) default NULL,
  `page_type` tinyint(3) NOT NULL default '0',
  `images` text,
  PRIMARY KEY  (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cws_cms_img_store_dir` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `child_count` int(11) default NULL,
  `add_date` varchar(15) NOT NULL default '',
  `dir_type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cws_cms_img_store_file` (
  `id` int(11) NOT NULL default '0',
  `dir_code` varchar(20) NOT NULL default '',
  `name` varchar(200) NOT NULL default '',
  `disk_name` varchar(100) NOT NULL default '',
  `visual_path` varchar(200) NOT NULL default '',
  `upload_date` varchar(15) default NULL,
  `file_size` bigint(20) NOT NULL default '0',
  `ext` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `dir_code` (`dir_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cws_cms_nav` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `orders` int(10) unsigned NOT NULL default '0',
  `link` varchar(255) NOT NULL default '',
  `color` varchar(20) default NULL,
  `target` varchar(20) default NULL,
  `nav_type` int(10) unsigned default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `cws_cms_nav` (`code`,`name`,`orders`,`link`,`color`,`target`,`nav_type`) VALUES ('11821374106711424885','首页',0,'../index.jsp','','_self',2),('11821376339061283082','论坛',1,'../forum/index.jsp','#008888','_self',2),('11821518585001181913','日志',2,'listmsg.jsp','','_self',2),('11821519350781903853','创建团队',3,'user/userconfig_add.jsp?blogType=1','','_self',2),('11821519605001492714','相册',4,'listblogphoto.jsp','','_self',2),('11821519821251861313','博客',5,'listblog.jsp','','_self',2),('11830949922811532292','威客',7,'forum/listtopic.jsp?boardcode=witkey','#ffffff','_self',0),('11830950767815562524','换客',8,'forum/listtopic.jsp?boardcode=hk','#ffffff','_self',0),('佳人有约','佳人有约',5,'forum/listtopic.jsp?boardcode=qrl','#ffffff','_self',0),('博客','博客',6,'blog/index.jsp','#F7BEC2','',0),('同城交易','同城交易',3,'forum/listtopic.jsp?boardcode=trade','#B5FADB','',0),('百姓信息','百姓信息',4,'forum/listtopic.jsp?boardcode=info','#ffffff','',0),('论坛','论坛',2,'forum/index.jsp','#ffffff','',0);
INSERT INTO `cws_cms_nav` (`code`,`name`,`orders`,`link`,`color`,`target`,`nav_type`) VALUES ('首页','首页',1,'index.jsp','#ffffff','_self',0);
CREATE TABLE `cws_cms_software_dir` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `child_count` int(11) default NULL,
  `add_date` varchar(15) NOT NULL default '',
  `dir_type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `cws_cms_software_dir` (`code`,`name`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`dir_type`,`layer`) VALUES ('root','全部','','-1','root',1,0,'1111111111',1,1);
CREATE TABLE `cws_cms_software_doc` (
  `doc_id` int(11) NOT NULL default '0',
  `small_img` varchar(255) default NULL,
  `soft_rank` varchar(20) NOT NULL default '',
  `accredit` varchar(20) default NULL,
  `urls` text,
  `file_type` varchar(20) default NULL,
  `lang` varchar(20) default NULL,
  `soft_type` varchar(11) default NULL,
  `os` varchar(50) default NULL,
  `offical_url` varchar(250) default NULL,
  `offical_demo` varchar(250) default NULL,
  `file_size` int(11) default NULL,
  `download_count` bigint(20) NOT NULL default '0',
  `unit` varchar(10) default NULL,
  `dir_code` varchar(20) default NULL,
  `parent_code` varchar(20) default NULL,
  PRIMARY KEY  (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cws_cms_software_file` (
  `id` int(11) NOT NULL default '0',
  `dir_code` varchar(20) NOT NULL default '',
  `name` varchar(200) NOT NULL default '',
  `disk_name` varchar(100) NOT NULL default '',
  `visual_path` varchar(200) NOT NULL default '',
  `upload_date` varchar(15) default NULL,
  `file_size` bigint(20) NOT NULL default '0',
  `ext` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `dir_code` (`dir_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `cws_cms_subject_dir` (
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
  `page_template_id` int(11) NOT NULL default '-1',
  `template_id` int(10) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
INSERT INTO `cws_cms_subject_dir` (`code`,`name`,`description`,`parentCode`,`rootCode`,`orders`,`childCount`,`addDate`,`type`,`layer`,`page_template_id`,`template_id`) VALUES ('root','全部专题','全部专题','-1','root',1,1,'0000-00-00 00:00:00',1,1,-1,0);
CREATE TABLE `cws_cms_subject_doc` (
  `id` bigint(20) NOT NULL default '0',
  `doc_id` int(11) NOT NULL default '0',
  `code` varchar(20) NOT NULL default '',
  `doc_level` int(11) NOT NULL default '0',
  `create_date` varchar(15) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `code_docid` USING BTREE (`code`,`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `dir_priv` (
  `id` int(11) NOT NULL default '0',
  `dir_code` varchar(50) NOT NULL default '',
  `see` tinyint(1) NOT NULL default '1',
  `append` tinyint(1) NOT NULL default '0',
  `del` tinyint(1) NOT NULL default '0',
  `dir_modify` tinyint(1) NOT NULL default '0',
  `examine` tinyint(1) NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `priv_type` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `IX_dir_priv` (`dir_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `dir_priv` (`id`,`dir_code`,`see`,`append`,`del`,`dir_modify`,`examine`,`name`,`priv_type`) VALUES (1,'soft',1,0,0,0,0,'Everyone',0),(11,'img',1,0,0,0,0,'Everyone',0);
CREATE TABLE `directory` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `child_count` int(11) default NULL,
  `add_date` varchar(15) NOT NULL default '',
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  `doc_id` int(11) default NULL,
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(50) NOT NULL default 'default',
  `price` decimal(19,2) default NULL,
  `template_doc_id` int(11) NOT NULL default '-1',
  `doc_count` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`price`,`template_doc_id`,`doc_count`) VALUES ('article','文章系统',0,'','root','root',2,4,'1154857963109',NULL,0,2,0,-1,'default','0.00',-1,0),('email','邮件',0,'','template','root',1,0,'1154857963109',NULL,2,3,0,-1,'default','0.00',-1,0),('first','第一频道',1,'','article','root',1,2,'1165757206859',NULL,2,3,0,-1,'default','0.00',-1,0),('first_1','第一频道(1)',1,'','first','root',1,0,'1165759304250',NULL,2,4,0,-1,'default','0.00',-1,0),('first_2','第一频道(2)',1,'','first','root',2,0,'1165759319109',NULL,2,4,0,-1,'default','0.00',-1,0),('img','图片新闻',1,'图片新闻','article','root',4,0,'1183088600703',NULL,2,3,0,-1,'img','0.00',49,0),('root','全部栏目',0,'','-1','root',1,2,'1154857963109',0,0,1,0,-1,'default','0.00',-1,0),('second','第二频道',1,'','article','root',2,0,'1178633145453',NULL,2,3,0,-1,'default','0.00',-1,0),('soft','软件下载',1,'软件下载','article','root',3,0,'1183088546734',NULL,2,3,0,-1,'software','0.00',62,0);
INSERT INTO `directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`,`price`,`template_doc_id`,`doc_count`) VALUES ('template','模板',0,'','root','root',1,1,'1154857963109',NULL,0,2,0,-1,'default','0.00',-1,0),('z','z',0,'z','dd','root',1,0,'1159243676546',NULL,2,5,0,-1,'default','0.00',-1,0);
CREATE TABLE `doc_content` (
  `doc_id` int(11) NOT NULL default '0',
  `content` longtext NOT NULL,
  `page_num` int(11) NOT NULL default '1',
  UNIQUE KEY `IX_doc_content_1` (`doc_id`,`page_num`),
  KEY `IX_doc_content` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `doc_content` (`doc_id`,`content`,`page_num`) VALUES (5,'<p><style type=\"text/css\">\r\n\r\n\r\n\r\n\r\n\r\n<!--\r\nTABLE {\r\n BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px\r\n}\r\nTD {\r\n BORDER-RIGHT: 0px; BORDER-TOP: 0px\r\n}\r\n--></style></p>\n<table bordercolor=\"#4aa2ad\" height=\"154\" cellspacing=\"0\" cellpadding=\"5\" width=\"98%\" align=\"center\" border=\"1\">\n    <tbody>\n        <tr align=\"left\">\n            <td nowrap=\"nowrap\" background=\"upfile/webeditimg/2005/12/3e4062027abe4035a4dbd704bf4f952a.gif\" height=\"21\">\n            <p align=\"center\">社区欢迎您&nbsp;</p>\n            </td>\n        </tr>\n        <tr>\n            <td valign=\"top\" align=\"center\" height=\"125\">\n            <p align=\"left\"><strong>尊敬的用户</strong>$name：您好！</p>\n            <div align=\"left\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;社区欢迎您，谢谢您的支持！</div>\n            <div align=\"left\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;快来看看吧，您也来灌灌水，说不定您会成为社区明星哦！</div>\n            <div align=\"left\">&nbsp;</div>\n            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;社区管委会<br />\n            &nbsp;&nbsp;&nbsp;</p>\n            </td>\n        </tr>\n    </tbody>\n</table>',1),(6,'<p>ffffffffffffffffffffffffffffff</p>\n<p>sdfg</p>\n<p>df</p>\n<p>g</p>\n<p>dfsg</p>\n<p>d</p>\n<p>sfg</p>',1);
CREATE TABLE `document` (
  `id` int(11) NOT NULL default '0',
  `keywords` varchar(50) default NULL,
  `isrelateshow` tinyint(1) default '1',
  `title` varchar(255) NOT NULL default '',
  `class1` varchar(50) NOT NULL default '',
  `author` varchar(100) default NULL,
  `modifiedDate` varchar(15) NOT NULL default '',
  `can_comment` tinyint(1) NOT NULL default '0',
  `summary` text,
  `isHome` tinyint(1) NOT NULL default '0',
  `doc_type` tinyint(3) unsigned NOT NULL default '0',
  `examine` tinyint(3) unsigned NOT NULL default '0',
  `nick` varchar(50) default NULL,
  `hit` int(11) NOT NULL default '0',
  `template_id` int(11) NOT NULL default '-1',
  `page_count` int(11) NOT NULL default '1',
  `parent_code` varchar(20) default NULL,
  `isNew` tinyint(1) NOT NULL default '0',
  `flowTypeCode` varchar(20) default NULL,
  `color` varchar(20) default NULL,
  `isBold` char(1) NOT NULL default '0',
  `expire_date` varchar(15) default NULL,
  `source` varchar(255) default NULL,
  `page_template_id` int(11) NOT NULL default '-1',
  `createDate` varchar(15) default NULL,
  `doc_level` int(11) NOT NULL default '0',
  `page_type` int(11) NOT NULL default '0',
  `page_no` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `dirCode` USING BTREE (`class1`),
  KEY `dirCode_examine` (`class1`,`examine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `document` (`id`,`keywords`,`isrelateshow`,`title`,`class1`,`author`,`modifiedDate`,`can_comment`,`summary`,`isHome`,`doc_type`,`examine`,`nick`,`hit`,`template_id`,`page_count`,`parent_code`,`isNew`,`flowTypeCode`,`color`,`isBold`,`expire_date`,`source`,`page_template_id`,`createDate`,`doc_level`,`page_type`,`page_no`) VALUES (5,'email',0,'sdfsdf','email','admin','1183105242546',1,NULL,0,0,0,'admin',0,0,1,'0',0,'','','0','0','',-1,'1183104457109',0,0,1),(6,'first_1',0,'ffffffff','first_1','admin','1183105247359',1,NULL,0,0,10,'admin',-1,0,1,'0',0,'','','0','0','ffffffffffffffff',-1,'1183105247359',0,0,1);
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
  `upload_date` varchar(15) default NULL,
  PRIMARY KEY  (`id`),
  KEY `doc_id` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `document_poll` (
  `doc_id` int(11) unsigned NOT NULL default '0',
  `expire_date` date default NULL,
  `max_choice` tinyint(3) unsigned NOT NULL default '1',
  PRIMARY KEY  (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `document_poll_option` (
  `doc_id` int(11) NOT NULL default '0',
  `orders` int(10) unsigned NOT NULL default '0',
  `vote_user` text,
  `content` varchar(45) NOT NULL default '',
  `vote_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`doc_id`,`orders`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `guestbook` (
  `id` int(11) NOT NULL auto_increment,
  `shopCode` varchar(50) NOT NULL default '',
  `userName` varchar(50) NOT NULL default '',
  `content` text NOT NULL,
  `ip` varchar(15) NOT NULL default '',
  `lydate` varchar(15) NOT NULL default '',
  `reply` text,
  `redate` varchar(15) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `link` (
  `id` int(11) NOT NULL auto_increment,
  `url` varchar(200) NOT NULL default '',
  `title` varchar(100) default NULL,
  `image` varchar(255) default NULL,
  `userName` varchar(20) default NULL,
  `sort` int(11) NOT NULL default '0',
  `kind` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `message` (
  `id` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `content` text NOT NULL,
  `sender` varchar(20) NOT NULL default '',
  `receiver` varchar(20) NOT NULL default '',
  `rq` varchar(15) NOT NULL default '',
  `type` tinyint(3) unsigned NOT NULL default '0',
  `ip` varchar(15) NOT NULL default '',
  `isreaded` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `miniplugin_home` (
  `id` int(11) NOT NULL default '0',
  `hot` varchar(100) default NULL,
  `recommandBoard` varchar(255) default NULL,
  `recommandMsg` varchar(200) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin2_alipay` (
  `msgRootId` bigint(20) NOT NULL default '0',
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
CREATE TABLE `plugin_activity` (
  `msg_id` bigint(20) unsigned NOT NULL default '0',
  `organizer` varchar(255) NOT NULL default '',
  `user_count` int(10) NOT NULL default '-1',
  `expire_date` varchar(15) NOT NULL default '',
  `money_code` varchar(20) default NULL,
  `attend_money_count` int(10) unsigned NOT NULL default '0',
  `exit_money_count` int(10) unsigned NOT NULL default '0',
  `tel` varchar(50) default NULL,
  `user_level` varchar(20) default NULL,
  `users` text,
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_auction` (
  `msgRootId` bigint(20) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `userType` varchar(50) NOT NULL default 'N''0''',
  `counts` int(11) NOT NULL default '-1',
  `beginDate` varchar(15) NOT NULL default '',
  `endDate` varchar(15) default NULL,
  `state` tinyint(3) unsigned NOT NULL default '0',
  `userName` varchar(50) NOT NULL default '',
  `sellType` varchar(10) default NULL,
  `curBidPrice` decimal(19,4) NOT NULL default '0.0000',
  `orderId` int(11) NOT NULL default '-1',
  `shopDir` varchar(50) NOT NULL default 'N''default''',
  `recommand` tinyint(1) NOT NULL default '0',
  `catalogCode` varchar(50) NOT NULL default '',
  `isShow` tinyint(1) NOT NULL default '0',
  `image` varchar(255) default NULL,
  PRIMARY KEY  (`msgRootId`),
  KEY `endDate` (`endDate`)
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
INSERT INTO `plugin_auction_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('bicycle','自行车',0,'','cheliang','root',4,0,'',NULL,1,3,NULL,-1),('caizhuang','彩妆',0,'','meirong','root',2,0,'',NULL,1,3,NULL,-1),('camera','数码相机',0,'','shuma','root',1,0,'',NULL,1,3,NULL,-1),('chaju','茶具',0,'','rcyp','root',2,0,'',NULL,1,3,NULL,-1),('cheliang','车辆',0,'','root','root',4,5,'',NULL,0,2,NULL,-1),('chongyin','冲印',0,'','shuma','root',5,0,'',NULL,1,3,NULL,-1),('chongzhi','充值卡',0,'','mobile','root',5,0,'',NULL,1,3,NULL,-1),('coffiee','咖啡',0,'','shipinbaojian','root',1,0,'',NULL,1,3,NULL,-1),('computer','计算机',0,'计算机','root','root',1,2,'',NULL,0,2,0,-1),('couple','情侣装',0,'','nuzhuang','root',6,0,'',NULL,1,3,NULL,-1),('cunshan','衬衫',0,'','nuzhuang','root',1,0,'',NULL,1,3,NULL,-1),('diandong','电动车',0,'','cheliang','root',2,0,'',NULL,1,3,NULL,-1),('dianhua','电话机',0,'','mobile','root',2,0,'',NULL,1,3,NULL,-1);
INSERT INTO `plugin_auction_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('dianqi','电器',0,'','root','root',6,2,'',NULL,0,2,NULL,-1),('duanwai','短外套',0,'','nuzhuang','root',12,0,'',NULL,1,3,NULL,-1),('flower','鲜花',0,'','liping','root',2,0,'',NULL,1,3,NULL,-1),('game','游戏',0,'游戏','software','root',1,0,'',NULL,1,4,NULL,-1),('hardware','硬件',0,'硬件','computer','root',1,3,'',NULL,0,3,0,-1),('hufu','护肤',0,'','meirong','root',4,0,'',NULL,1,3,NULL,-1),('jiaju','家具',0,'','rcyp','root',1,0,'',NULL,1,3,NULL,-1),('jianfei','减肥',0,'','shipinbaojian','root',4,0,'',NULL,1,3,NULL,-1),('kz','裤子',0,'','nuzhuang','root',14,0,'',NULL,1,3,NULL,-1),('lei','蕾丝衫/雪纺衫',0,'','nuzhuang','root',5,0,'',NULL,1,3,NULL,-1),('liping','宠物、工艺品',0,'','root','root',10,3,'',NULL,0,2,0,-1),('lipingshiping','礼品饰品',0,'','rcyp','root',4,0,'',NULL,1,3,NULL,-1),('maoyi','毛衣',0,'','nuzhuang','root',2,0,'',NULL,1,3,NULL,-1);
INSERT INTO `plugin_auction_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('marry','婚纱/礼服',0,'','nuzhuang','root',8,0,'',NULL,1,3,NULL,-1),('meirong','美容美体',0,'','root','root',3,4,'',NULL,0,2,NULL,-1),('mianbu','面部保养',0,'','meirong','root',1,0,'',NULL,1,3,NULL,-1),('mobile','手机、通讯设备、卡',0,'','root','root',8,6,'',NULL,0,2,NULL,-1),('moto','摩托车',0,'','cheliang','root',3,0,'',NULL,1,3,NULL,-1),('neiyi','内衣',0,'','nuzhuang','root',10,0,'',NULL,1,3,NULL,-1),('niuzai','牛仔',0,'','nuzhuang','root',3,0,'',NULL,1,3,NULL,-1),('notebook','笔记本',0,'','hardware','root',2,0,'',NULL,1,4,0,-1),('nuzhuang','女装',0,'','root','root',5,17,'',NULL,0,2,NULL,-1),('old','中老年服装',0,'','nuzhuang','root',9,0,'',NULL,1,3,NULL,-1),('pc','台式机',0,'','hardware','root',3,0,'',NULL,1,4,0,-1),('peijian','配件',0,'','mobile','root',4,0,'',NULL,1,3,NULL,-1),('pet','宠物',0,'','liping','root',1,0,'',NULL,1,3,NULL,-1);
INSERT INTO `plugin_auction_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('pinpai','品牌内衣',0,'','nuzhuang','root',11,0,'',NULL,1,3,NULL,-1),('qiche','汽车',0,'','cheliang','root',1,0,'',NULL,1,3,NULL,-1),('qunzi','裙子',0,'','nuzhuang','root',15,0,'',NULL,1,3,NULL,-1),('rcyp','日常用品',0,'','root','root',2,4,'',NULL,0,2,NULL,-1),('riyong','日用',0,'','dianqi','root',1,0,'',NULL,1,3,NULL,-1),('root','全部分类',0,'','-1','root',1,10,'',NULL,0,1,0,-1),('shancun','闪存',0,'','shuma','root',3,0,'',NULL,1,3,NULL,-1),('shexiang','摄像机',0,'','shuma','root',2,0,'',NULL,1,3,NULL,-1),('shipinbaojian','食品、保健品',0,'','root','root',7,4,'',NULL,0,2,NULL,-1),('shiping','手机饰品',0,'','mobile','root',6,0,'',NULL,1,3,NULL,-1),('shoubu','手部保养',0,'','meirong','root',3,0,'',NULL,1,3,NULL,-1),('shougong','手工',0,'','liping','root',3,0,'',NULL,1,3,NULL,-1),('shouji','手机',0,'','mobile','root',1,0,'',NULL,1,3,NULL,-1);
INSERT INTO `plugin_auction_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('shuma','数码',0,'','root','root',9,5,'',NULL,0,2,0,-1),('smpeijian','配件',0,'','shuma','root',4,0,'',NULL,1,3,NULL,-1),('software','软件',0,'','computer','root',2,1,'',NULL,0,3,0,-1),('tang','唐装/中式服装',0,'','nuzhuang','root',7,0,'',NULL,1,3,NULL,-1),('taozhuang','套装',0,'','nuzhuang','root',16,0,'',NULL,1,3,NULL,-1),('tea','茶叶',0,'','shipinbaojian','root',2,0,'',NULL,1,3,NULL,-1),('techan','特产',0,'','shipinbaojian','root',3,0,'',NULL,1,3,NULL,-1),('tongche','童车',0,'','cheliang','root',5,0,'',NULL,1,3,NULL,-1),('wenju','文具',0,'','rcyp','root',3,0,'',NULL,1,3,NULL,-1),('xiaobeixin','小背心/吊带衫',0,'','nuzhuang','root',4,0,'',NULL,1,3,0,-1),('xiaolintong','小灵通',0,'','mobile','root',3,0,'',NULL,1,3,NULL,-1),('yingyin','影音',0,'','dianqi','root',2,0,'',NULL,1,3,NULL,-1),('yunfu','孕妇装',0,'','nuzhuang','root',17,0,'',NULL,1,3,NULL,-1);
INSERT INTO `plugin_auction_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('zhongchang','中长外套',0,'','nuzhuang','root',13,0,'',NULL,1,3,NULL,-1);
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
  `hit` bigint(20) NOT NULL default '0',
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
INSERT INTO `plugin_board` (`boardCode`,`boardRule`,`pluginCode`) VALUES ('test','','activity'),('test','','debate'),('sqzw','','flower'),('test','','flower'),('hk','','huanke'),('score','','present'),('witkey','','witkey');
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
CREATE TABLE `plugin_debate_viewpoint` (
  `msg_id` bigint(20) default NULL,
  `viewpoint_type` tinyint(3) NOT NULL default '0',
  KEY `msg_id` (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_dig` (
  `id` bigint(20) unsigned NOT NULL default '0',
  `msg_id` bigint(20) unsigned NOT NULL default '0',
  `score_code` varchar(20) NOT NULL default '',
  `pay` double NOT NULL default '0',
  `reward` double NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  `dig_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `msg_id` (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_entrance_vip_card` (
  `id` varchar(15) NOT NULL default '',
  `userName` varchar(20) default NULL,
  `beginDate` varchar(15) default NULL,
  `endDate` varchar(15) default NULL,
  `fee` int(11) default NULL,
  `kind` varchar(20) NOT NULL default '',
  `fingerPrint` varchar(32) default NULL,
  `pwd` varchar(32) NOT NULL default '',
  `pwdRaw` varchar(32) NOT NULL default '0',
  `isUseFingerPrint` tinyint(1) NOT NULL default '0',
  `isValid` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userName_kind` (`userName`,`kind`,`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_entrance_vip_user` (
  `userName` varchar(20) NOT NULL default '',
  `beginDate` varchar(15) default NULL,
  `endDate` varchar(15) default NULL,
  `isValid` tinyint(1) NOT NULL default '0',
  `boards` varchar(255) default NULL,
  PRIMARY KEY  (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_entrance_vip_user_group` (
  `groupCode` varchar(20) NOT NULL default '',
  `beginDate` varchar(15) default NULL,
  `endDate` varchar(15) default NULL,
  `isValid` tinyint(1) NOT NULL default '0',
  `boards` varchar(255) default NULL,
  PRIMARY KEY  (`groupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_flower` (
  `msg_id` bigint(11) NOT NULL default '0',
  `flow_count` int(11) NOT NULL default '0',
  `egg_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_group` (
  `id` bigint(20) unsigned NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `catalog_code` varchar(20) NOT NULL default '',
  `creator` varchar(20) NOT NULL default '',
  `create_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `description` varchar(255) default NULL,
  `logo` varchar(50) default NULL,
  `notice` varchar(255) NOT NULL default '',
  `is_open` tinyint(3) unsigned NOT NULL default '1' COMMENT 'can user attend',
  `msg_count` int(10) unsigned NOT NULL default '0',
  `photo_count` int(10) unsigned NOT NULL default '0',
  `total_count` int(10) unsigned NOT NULL default '0',
  `user_count` int(10) unsigned NOT NULL default '0',
  `skin_code` varchar(20) NOT NULL default '',
  `banner` varchar(50) default NULL,
  `recommand_point` int(10) unsigned NOT NULL default '0',
  `color` varchar(20) default NULL,
  `is_bold` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `Index_catalog_code` (`catalog_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_group_activity` (
  `msg_id` bigint(20) unsigned NOT NULL default '0',
  `group_id` bigint(20) unsigned NOT NULL default '0',
  `id` bigint(20) unsigned NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `group_id_user_name` (`group_id`,`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_group_catalog` (
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
INSERT INTO `plugin_group_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('root','全部分类',1,'全部分类','-1','root',1,2,NULL,0,0,1,0,-1);
CREATE TABLE `plugin_group_photo` (
  `id` int(11) NOT NULL default '0',
  `title` varchar(100) default NULL,
  `image` varchar(255) default NULL,
  `group_id` bigint(20) unsigned default NULL,
  `sort` int(11) NOT NULL default '0',
  `addDate` varchar(15) NOT NULL default '',
  `is_remote` tinyint(4) NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `group_id` USING BTREE (`group_id`,`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_group_thread` (
  `id` bigint(20) unsigned NOT NULL default '0',
  `group_id` bigint(20) unsigned NOT NULL default '0',
  `add_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `msg_id` bigint(20) unsigned NOT NULL default '0',
  `reply_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_name` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `msg_id` (`msg_id`),
  KEY `group_id_user_name` USING BTREE (`group_id`,`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_group_user` (
  `user_name` varchar(20) NOT NULL default '',
  `group_id` bigint(20) NOT NULL default '0',
  `add_date` datetime default NULL,
  `priv_all` char(1) NOT NULL default '0' COMMENT 'manage user',
  `check_status` tinyint(3) NOT NULL default '0',
  `apply_reason` varchar(200) default NULL,
  `msg_count` int(11) NOT NULL default '0',
  `photo_count` int(11) NOT NULL default '0',
  `total_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`group_id`,`user_name`),
  KEY `Index_user_name` (`user_name`),
  KEY `Index_groupId_userName` USING BTREE (`group_id`,`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='users of group';
CREATE TABLE `plugin_huanke_catalog` (
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
INSERT INTO `plugin_huanke_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('cs','衬衫',0,'衬衫','nz/nsjp','root',1,0,'1183103565421',NULL,1,3,NULL,-1),('cz/xs/hf/mt','彩妆/香水/护肤/美体',0,'彩妆/香水/护肤/美体','root','root',3,2,'1183085503484',NULL,0,2,0,-1),('fs','发饰',0,'发饰','zbss/sb/yj','root',2,0,'1183104065656',NULL,1,3,NULL,-1),('gzm/xyz/zm','化妆棉/吸油纸/纸膜',0,'化妆棉/吸油纸/纸膜','cz/xs/hf/mt','root',2,0,'1183103642906',NULL,1,3,NULL,-1),('hzp','化妆品',0,'化妆品','cz/xs/hf/mt','root',1,0,'1183103609078',NULL,1,3,NULL,-1),('ipodsst','iPod随身听',0,'iPod随身听','ssst/yx/rj','root',3,0,'1183103539250',NULL,1,3,NULL,-1),('mp3','MP3',0,'MP3','ssst/yx/rj','root',2,0,'1183103499781',NULL,1,3,NULL,-1),('mp4','MP4',0,'MP4','ssst/yx/rj','root',1,0,'1183103482265',NULL,1,3,NULL,-1),('my','毛衣',0,'毛衣','nz/nsjp','root',2,0,'1183103579343',NULL,1,3,NULL,-1),('nssp','男士饰品',0,'男士饰品','zbss/sb/yj','root',3,0,'1183104082265',NULL,1,3,NULL,-1);
INSERT INTO `plugin_huanke_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('nz/nsjp','女装/女士精品',0,'女装/女士精品','root','root',2,3,'1183085089343',NULL,0,2,0,-1),('root','全部分类',0,'','-1','root',1,5,NULL,NULL,0,1,0,-1),('ssst/yx/rj','随身视听/音响/耳机',0,'随身视听/音响/耳机','root','root',1,3,'1183084848906',NULL,0,2,0,-1),('tywz','通用网址',0,'通用网址','xlsp/wlyx','root',3,0,'1183104175234',NULL,1,3,NULL,-1),('xlsp/wlyx','虚拟商品/网络游戏',0,'虚拟商品/网络游戏','root','root',5,3,'1183088417671',NULL,0,2,0,-1),('ywym','英文域名',0,'英文域名','xlsp/wlyx','root',1,0,'1183104133218',NULL,1,3,NULL,-1),('zbss','珠宝首饰',0,'珠宝首饰','zbss/sb/yj','root',1,0,'1183104047875',NULL,1,3,NULL,-1),('zbss/sb/yj','珠宝首饰/手表/眼镜',1,'珠宝首饰/手表/眼镜','root','root',4,3,'1183085534343',NULL,0,2,0,-1),('zwym','中文域名',0,'中文域名','xlsp/wlyx','root',2,0,'1183104160468',NULL,1,3,NULL,-1);
INSERT INTO `plugin_huanke_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('zzs','针织衫',0,'针织衫','nz/nsjp','root',3,0,'1183103592437',NULL,1,3,NULL,-1);
CREATE TABLE `plugin_huanke_goods` (
  `msg_root_id` bigint(20) NOT NULL default '0',
  `catalog_code` varchar(50) NOT NULL default '',
  `goods` varchar(200) NOT NULL default '',
  `depreciation` varchar(20) NOT NULL default '',
  `contact` varchar(100) NOT NULL default '',
  `province` varchar(255) NOT NULL default '',
  `price` varchar(20) default NULL,
  `exchange_province` varchar(255) NOT NULL default '',
  `exchange_condition` varchar(100) NOT NULL default '',
  `exchange_catalog_code` varchar(50) default NULL,
  `exchange_goods` varchar(200) default NULL,
  `exchange_description` text,
  `status` int(6) NOT NULL default '1',
  `submit_date` varchar(15) NOT NULL default '',
  `user_name` varchar(30) NOT NULL default '',
  `msg_id` bigint(20) NOT NULL default '-1',
  PRIMARY KEY  (`msg_root_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_huanke_reply` (
  `msg_id` bigint(11) NOT NULL default '0',
  `reply_type` tinyint(1) NOT NULL default '0',
  `exchange_goods` varchar(200) default NULL,
  `exchange_catalog_code` varchar(50) default NULL,
  `exchange_depreciation` varchar(20) default NULL,
  `exchange_province` varchar(255) default NULL,
  `contact` varchar(100) default NULL,
  `exchange_user_name` varchar(20) NOT NULL default '',
  `submit_date` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_huanke_user` (
  `user_name` varchar(20) NOT NULL default '',
  `email` varchar(50) NOT NULL default '',
  `pwd` varchar(20) NOT NULL default '',
  `nick` varchar(50) NOT NULL default '',
  `submit_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_login_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_info` (
  `id` bigint(20) NOT NULL default '0',
  `typeCode` varchar(50) NOT NULL default '',
  `userName` varchar(50) NOT NULL default '',
  `addDate` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_info_directory` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default '0',
  `add_date` varchar(15) NOT NULL default '',
  `islocked` tinyint(1) NOT NULL default '0',
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  `doc_id` int(11) NOT NULL default '-1',
  `template_id` int(11) NOT NULL default '-1',
  `pluginCode` varchar(50) NOT NULL default 'N''default''',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `plugin_info_directory` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`,`pluginCode`) VALUES ('cz','出租',0,'','root','root',1,0,'1182603500062',0,2,2,-1,-1,'N\'default\''),('hd','活动',0,'','root','root',2,0,'1182603507281',0,2,2,-1,-1,'N\'default\''),('ly','旅游',0,'','root','root',8,0,'1182603626109',0,2,2,-1,-1,'N\'default\''),('qg','求购',0,'','root','root',6,0,'1182603598953',0,2,2,-1,-1,'N\'default\''),('qz','求职',0,'','root','root',4,0,'1182603586109',0,2,2,-1,-1,'N\'default\''),('root','全部目录',1,'root','-1','root',1,9,'2007-6-16',0,0,1,-1,-1,'N\'default\''),('tg','团购',0,'','root','root',9,0,'1182603634015',0,2,2,-1,-1,'N\'default\''),('xw','寻物',0,'','root','root',7,0,'1182603617328',0,2,2,-1,-1,'N\'default\''),('zp','招聘',0,'','root','root',3,0,'1182603517343',0,2,2,-1,-1,'N\'default\''),('zr','转让',0,'','root','root',5,0,'1182603591562',0,2,2,-1,-1,'N\'default\'');
CREATE TABLE `plugin_present` (
  `id` bigint(20) NOT NULL default '0',
  `msg_id` bigint(20) NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '0',
  `money_code` varchar(20) default NULL,
  `score` int(11) NOT NULL default '0',
  `give_date` varchar(15) NOT NULL default '',
  `reason` varchar(250) default NULL,
  PRIMARY KEY  (`id`),
  KEY `Index_2` (`msg_id`)
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
INSERT INTO `plugin_reward` (`msg_id`,`score`,`is_end`,`money_code`,`score_given`,`best_msg_id`) VALUES (3342,55,0,'experience',1,0),(3343,1,0,NULL,0,0);
CREATE TABLE `plugin_sweet` (
  `msgRootId` bigint(20) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `state` tinyint(3) unsigned NOT NULL default '0',
  `spouse` varchar(20) default NULL,
  PRIMARY KEY  (`msgRootId`),
  UNIQUE KEY `IX_plugin_sweet` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_sweet_life` (
  `msgRootId` bigint(20) NOT NULL default '0',
  `marryDate` varchar(15) NOT NULL default '',
  `divorceDate` varchar(15) default NULL,
  `ownerName` varchar(20) NOT NULL default '',
  `spouseName` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`msgRootId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_sweet_sq_message` (
  `msgId` bigint(20) NOT NULL default '0',
  `scretLevel` int(11) NOT NULL default '0',
  `userAction` int(11) NOT NULL default '0',
  PRIMARY KEY  (`msgId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_sweet_user` (
  `msgRootId` bigint(20) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `type` int(11) NOT NULL default '0',
  `state` int(11) NOT NULL default '0',
  UNIQUE KEY `IX_plugin_sweet_user` (`msgRootId`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_sweet_userinfo` (
  `name` varchar(50) NOT NULL default '',
  `gender` varchar(50) NOT NULL default 'N''男''',
  `age` int(11) NOT NULL default '0',
  `birthday` varchar(15) default NULL,
  `marriage` varchar(10) NOT NULL default '0',
  `province` varchar(50) default NULL,
  `workAddress` varchar(200) default NULL,
  `tall` varchar(10) default NULL,
  `xueli` varchar(50) default NULL,
  `job` varchar(50) default NULL,
  `salary` varchar(20) default NULL,
  `address` varchar(50) default NULL,
  `postCode` int(11) default '0',
  `tel` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `OICQ` int(11) default NULL,
  `ICQ` varchar(50) default NULL,
  `MSN` varchar(50) default NULL,
  `description` varchar(255) default NULL,
  `sport` varchar(50) default NULL,
  `book` varchar(50) default NULL,
  `music` varchar(50) default NULL,
  `celebrity` varchar(50) default NULL,
  `photo` varchar(100) default NULL,
  `hobby` varchar(50) default NULL,
  `frendType` varchar(50) default NULL,
  `frendAge` varchar(20) default NULL,
  `frendTall` varchar(10) default NULL,
  `frendMarriage` varchar(30) default NULL,
  `frendProvince` varchar(50) default NULL,
  `frendXueli` varchar(50) default NULL,
  `frendSalary` varchar(20) default NULL,
  `frendRequire` text,
  `manager` varchar(50) default NULL,
  `isChecked` tinyint(1) NOT NULL default '0',
  `member` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_witkey` (
  `msg_root_id` bigint(20) NOT NULL default '0',
  `catalog_code` varchar(50) NOT NULL default '',
  `money_code` varchar(20) NOT NULL default '',
  `score` int(11) NOT NULL default '0',
  `city` varchar(100) NOT NULL default '',
  `end_date` varchar(15) NOT NULL default '',
  `status` tinyint(3) NOT NULL default '0',
  `level` int(11) NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  `contribution_count` int(11) NOT NULL default '0',
  `user_count` int(11) NOT NULL default '0',
  `contact` varchar(250) NOT NULL default '',
  `msg_id` bigint(20) default '-1',
  PRIMARY KEY  (`msg_root_id`),
  KEY `index_end_date` (`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_witkey_catalog` (
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
INSERT INTO `plugin_witkey_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('ch','策划',0,'策划','root','root',1,5,'1183084145812',NULL,0,2,0,-1),('cpbz','产品包装',0,'产品包装','sj','root',2,0,'1183103009453',NULL,1,3,NULL,-1),('cps','产品书',0,'产品书','zx','root',1,0,'1183103178546',NULL,1,3,NULL,-1),('cx','程序',0,'程序','root','root',2,6,'1183084119828',NULL,0,2,0,-1),('cxkf','程序开发',0,'程序开发','wz','root',3,0,'1183103142015',NULL,1,3,NULL,-1),('dmsj','店面设计',0,'店面设计','sj','root',3,0,'1183103040046',NULL,1,3,NULL,-1),('fach','方案策划',0,'方案策划','ch','root',4,0,'1183084389234',NULL,1,3,NULL,-1),('ftbs','发帖比赛',0,'发帖比赛','lw','root',1,0,'1183102710140',NULL,1,3,NULL,-1),('fy','翻译',0,'翻译','lw','root',2,0,'1183102727187',NULL,1,3,NULL,-1),('gjkf','工具开发',0,'工具开发','cx','root',1,0,'1183084462890',NULL,1,3,NULL,-1),('hdch','活动策划',0,'活动策划','ch','root',2,0,'1183084334546',NULL,1,3,NULL,-1);
INSERT INTO `plugin_witkey_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('jj','家教',0,'家教','lw','root',3,0,'1183102775546',NULL,1,3,NULL,-1),('lw','劳务',1,'劳务','root','root',3,4,'1183084190390',NULL,0,2,0,-1),('mgsj','美工设计',0,'美工设计','wz','root',1,0,'1183103105125',NULL,1,3,NULL,-1),('pl','评论',0,'评论','zx','root',2,0,'1183103192843',NULL,1,3,NULL,-1),('pmsj','平面设计',0,'平面设计','sj','root',1,0,'1183102989281',NULL,1,3,NULL,-1),('qmfw','起名服务',0,'起名服务','ch','root',5,0,'1183084430984',NULL,1,3,NULL,-1),('qt','其它',0,'其它','root','root',7,0,'1183084210437',NULL,0,2,0,-1),('qyyy','企业应用',0,'企业应用','cx','root',6,0,'1183084668671',NULL,1,3,NULL,-1),('rjhh','软件汉化',0,'软件汉化','cx','root',4,0,'1183084575046',NULL,1,3,NULL,-1),('root','全部分类',0,'','-1','root',1,7,NULL,NULL,0,1,0,-1),('scdc','市场调查',0,'市场调查','ch','root',1,0,'1183084266359',NULL,1,3,0,-1);
INSERT INTO `plugin_witkey_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('sj','设计',1,'设计','root','root',4,5,'1183083829625',NULL,0,2,0,-1),('slsj','室内设计',0,'室内设计','sj','root',4,0,'1183103063531',NULL,1,3,NULL,-1),('sylx','摄影录像',0,'摄影录像','sj','root',5,0,'1183103080296',NULL,1,3,NULL,-1),('txkf','图型开发',0,'图型开发','cx','root',5,0,'1183084604687',NULL,1,3,NULL,-1),('wt','委托',0,'委托','lw','root',4,0,'1183102804218',NULL,1,3,NULL,-1),('wz','网站',0,'网站','root','root',5,4,'1177644953546',NULL,0,2,0,-1),('wzch','网站策划',0,'网站策划','ch','root',3,0,'1183084356328',NULL,1,3,NULL,-1),('wztg','网站推广',0,'网站推广','wz','root',4,0,'1183103157437',NULL,1,3,NULL,-1),('xwgj','新闻稿件',0,'新闻稿件','zx','root',3,0,'1183103214609',NULL,1,3,NULL,-1),('ydkf','移动开发',0,'移动开发','cx','root',3,0,'1183084515734',NULL,1,3,NULL,-1),('ymsj','网页设计',0,'网页设计','wz','root',2,0,'1183103126281',NULL,1,3,NULL,-1);
INSERT INTO `plugin_witkey_catalog` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`doc_id`,`template_id`) VALUES ('yxwg','游戏外挂',0,'游戏外挂','cx','root',2,0,'1183084484484',NULL,1,3,NULL,-1),('zx','撰写',0,'撰写','root','root',6,3,'1183084165015',NULL,0,2,0,-1);
CREATE TABLE `plugin_witkey_evaluation` (
  `id` int(11) NOT NULL default '0',
  `msg_id` bigint(20) NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  `content` text NOT NULL,
  `add_date` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_witkey_reply` (
  `user_name` varchar(20) NOT NULL default '',
  `view_type` int(11) default NULL,
  `reply_type` int(11) NOT NULL default '0',
  `msg_id` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `plugin_witkey_user` (
  `msg_root_id` bigint(20) NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  `real_name` varchar(20) NOT NULL default '',
  `city` varchar(50) NOT NULL default '',
  `tel` varchar(30) default NULL,
  `oicq` varchar(15) default NULL,
  `other_contact` varchar(200) default NULL,
  `add_date` varchar(15) NOT NULL default '',
  `contribution_count` int(11) NOT NULL default '0',
  `communication_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`user_name`,`msg_root_id`),
  KEY `add_date_index` (`add_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `privilege` (
  `priv` varchar(20) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `isSystem` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`priv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `privilege` (`priv`,`description`,`isSystem`) VALUES ('admin','管理员权限',1),('auction','拍卖管理',0),('backup','备份操作',1),('chat','聊天管理',1),('email','Email 群发',1),('forum','论坛总管理',1),('forum.bak','论坛数据备份',1),('forum.boardmanager','分配版主',1),('forum.message','论坛贴子操作',1),('forum.plugin','论坛插件管理',1),('forum.user','论坛用户管理',1),('user','管理用户',1);
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
  `add_date` varchar(15) NOT NULL default '',
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '0',
  `add_id` int(11) default NULL,
  `logo` varchar(50) default NULL,
  `today_count` int(11) NOT NULL default '0',
  `today_date` varchar(15) NOT NULL default '',
  `topic_count` int(11) NOT NULL default '0',
  `post_count` int(11) NOT NULL default '0',
  `theme` varchar(20) default 'N''default''',
  `skin` varchar(20) default NULL,
  `boardRule` text,
  `color` varchar(15) default NULL,
  `webeditAllowType` int(11) NOT NULL default '2',
  `plugin2Code` varchar(20) default NULL,
  `check_msg` tinyint(2) NOT NULL default '0',
  `del_mode` tinyint(2) NOT NULL default '0' COMMENT 'Del default to dustbin',
  `display_style` tinyint(3) NOT NULL default '0',
  `is_bold` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_board` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`add_id`,`logo`,`today_count`,`today_date`,`topic_count`,`post_count`,`theme`,`skin`,`boardRule`,`color`,`webeditAllowType`,`plugin2Code`,`check_msg`,`del_mode`,`display_style`,`is_bold`) VALUES ('alipay','支付宝交易',1,'支付宝交易','dssh','root',4,0,'1154847835015',0,1,3,0,'11548480623432099878744.gif',0,'1176992204062',0,0,'','','','',2,'alipay',0,0,0,0),('blog','博客',0,'','hidden','root',1,0,'0',0,1,3,0,'',0,'1183078410937',0,0,'default','default','','',2,'',0,0,0,0),('bzjl','版主交流',1,'斑竹聚会，讨论交流。','sqgl','root',2,1,'0',0,1,3,0,'1154826091734217518162.gif',0,'1160955855718',0,0,'default','default','<P>&nbsp;</P>','',2,'',0,0,0,0),('bzjlsecret','版主议事厅',1,'只有版主才能进入','bzjl','root',1,0,'0',0,1,4,0,'',0,'1154445401359',2,9,'default','default','','',2,'',0,0,0,0),('dssh','都市生活',1,'缤纷都市，多彩生活。','root','root',2,8,'0',0,0,2,0,'',0,'1154445401359',0,0,'default','default','','',2,'alipay',1,0,0,0),('hidden','隐藏版块区',0,'','root','root',1,1,'0',0,0,2,0,'',0,'1154445401359',0,0,'default','default','','',2,'',0,0,0,0);
INSERT INTO `sq_board` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`add_id`,`logo`,`today_count`,`today_date`,`topic_count`,`post_count`,`theme`,`skin`,`boardRule`,`color`,`webeditAllowType`,`plugin2Code`,`check_msg`,`del_mode`,`display_style`,`is_bold`) VALUES ('hk','换客',1,'','dssh','root',6,0,'1182999904734',0,1,3,0,'',0,'1182999904734',0,0,'','','','',2,'',0,0,0,0),('info','分类信息',1,'分类信息列表，方便百姓生活','dssh','root',3,0,'0',0,1,3,0,'11548267085931412002470.gif',0,'1182050364546',0,0,'default','default','','',2,'',0,0,0,0),('master','总版主议事厅',1,'暂时公开，过段时间加密本版','sqzw','root',1,0,'0',0,1,4,0,'11706714847811485393247.jpg',0,'1154445401359',4,9,'default','default','','',2,'',0,0,0,0),('qrl','佳人有约',1,'特色版块，虚拟家园','dssh','root',1,0,'0',0,1,3,0,'11548260147962138883725.gif',0,'1160955854328',0,0,'sweet','sweet','','',2,'',0,0,0,0),('reward','悬赏解决问题',1,'悬赏解决问题','dssh','root',5,0,'1160798528484',0,1,3,0,'',0,'1180957114437',0,0,'','','<P>&nbsp;</P>','',2,'',0,0,0,0);
INSERT INTO `sq_board` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`add_id`,`logo`,`today_count`,`today_date`,`topic_count`,`post_count`,`theme`,`skin`,`boardRule`,`color`,`webeditAllowType`,`plugin2Code`,`check_msg`,`del_mode`,`display_style`,`is_bold`) VALUES ('root','全部版块',1,'','-1','root',1,3,'0',0,0,1,0,NULL,0,'1154445401359',0,0,'default','default','','',2,'',0,0,0,0),('score','评分',1,'','dssh','root',8,0,'1183088957531',0,1,3,NULL,'',0,'1183088957531',0,0,'','',NULL,'',2,'',0,0,0,0),('sqgl','社区管理',1,'','root','root',3,2,'0',0,0,2,0,NULL,0,'1154445401359',0,0,'default','default','','',2,'',0,0,0,0),('sqzw','社区站务',1,'社区站务，欢迎大家来讨论社区建设','sqgl','root',1,1,'0',0,1,3,0,'1170671464562356858128.jpg',0,'1181981825796',0,0,'','','<STRONG><FONT color=#e9397f>请大家在此提出对“云网论坛”的意见和建议！本论坛目前尚处于测试期，欢迎大家多多批评和指导！</FONT></STRONG>','',4,'',0,0,1,0),('trade','同城交易',1,'同城交易，安全放心','dssh','root',2,0,'0',0,1,3,0,'1154826755984210275085.gif',0,'1181781263562',0,0,'','','<P><STRONG><FONT style=\"BACKGROUND-COLOR: #ffffff\" color=#875dc4>1、开店方法：点击<U><FONT color=#ff0000>我要开店</FONT></U>，填写简单的信息提交，建好店后，在版块中发贴，就可以发布商品，并且同步在店铺的首页中显示出来。<FONT style=\"BACKGROUND-COLOR: #ff0000\" color=#eeeeee>注意：一个贴子对应一件商品</FONT>。管理店铺的入口，在您的小店的首页面上。<B','#ee0005',2,'',0,0,0,0);
INSERT INTO `sq_board` (`code`,`name`,`isHome`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`add_id`,`logo`,`today_count`,`today_date`,`topic_count`,`post_count`,`theme`,`skin`,`boardRule`,`color`,`webeditAllowType`,`plugin2Code`,`check_msg`,`del_mode`,`display_style`,`is_bold`) VALUES ('witkey','威客',1,'','dssh','root',7,0,'1183088917703',0,1,3,NULL,'',0,'1183088917703',0,0,'','',NULL,'',2,'',1,0,0,0);
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
  `is_hide` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`name`,`boardcode`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_boardrender` (
  `boardCode` varchar(20) NOT NULL default '',
  `renderCode` varchar(20) NOT NULL default '',
  KEY `IX_render` (`boardCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
CREATE TABLE `sq_classmaster` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL default '',
  `classcode` varchar(20) NOT NULL default '',
  `sort` int(11) NOT NULL default '0',
  PRIMARY KEY  (`name`),
  KEY `id` (`id`),
  CONSTRAINT `sq_classmaster_ibfk_2` FOREIGN KEY (`name`) REFERENCES `sq_user` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_desktop_setup` (
  `ID` int(10) unsigned NOT NULL default '0',
  `SYSTEM_CODE` varchar(20) NOT NULL default '',
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
  `POSITION` varchar(20) default NULL,
  `TITLE_LEN` int(11) NOT NULL default '30',
  `PROPERTIES` varchar(250) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `systemcode_position` (`SYSTEM_CODE`(1),`POSITION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_desktop_setup` (`ID`,`SYSTEM_CODE`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`,`POSITION`,`TITLE_LEN`,`PROPERTIES`) VALUES (1,'0','第二频道',10,0,0,200,100,'cms_dir','second',0,NULL,'',27,0,'19',30,'date=yes,dateFormat=yy-MM-dd HH:mm'),(11,'0','软件下载',10,0,0,200,100,'cms_dir','soft',0,NULL,'',28,0,'20',30,''),(12,'0','图片新闻',10,0,0,200,100,'cms_dir','img',0,NULL,'',29,0,'21',30,''),(21,'2','名山大川',10,0,0,200,100,'blog','msdc',0,NULL,'',23,0,'20',30,''),(31,'2','田园风光',10,0,0,200,100,'blog','tyfg',0,NULL,'',24,0,'24',30,''),(32,'0','文章目录',10,0,0,200,100,'cms_dir','first',0,NULL,'',1,0,'1',30,'date=yes,dateFormat=[yy-MM-dd HH:mm]'),(33,'2','乡土人情',10,0,0,200,100,'blog','xtrq',0,NULL,'',25,0,'25',30,''),(41,'0','文章',10,0,0,200,100,'document','55',0,NULL,'',2,0,'2',30,''),(67,'0','论坛贴子',10,0,0,200,100,'forum','test',0,NULL,'',9,0,'3',30,''),(72,'0','博客新文章',10,0,0,200,100,'blog','cws_newBlogTopic',0,NULL,'',11,0,'4',30,'');
INSERT INTO `sq_desktop_setup` (`ID`,`SYSTEM_CODE`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`,`POSITION`,`TITLE_LEN`,`PROPERTIES`) VALUES (81,'0','文章目录1',10,0,0,200,100,'cms_dir','first',0,NULL,'',12,0,'5',30,''),(102,'2','博客聚焦',10,0,0,200,100,'blog','cws_blogFocus',0,NULL,'',3,0,'2',30,'date=yes,dateFormat=[yy-MM-dd]'),(111,'2','博客公告',10,0,0,200,100,'blog','cws_blogNotice',0,NULL,'',4,0,'1',30,'date=yes,dateFormat=[yy-MM-dd]'),(131,'2','博客广告',10,0,0,200,100,'blog','ad_1',0,NULL,'',5,0,'16',30,''),(141,'2','最新注册博客',10,0,0,200,100,'blog','cws_newAddBlog',0,NULL,'',6,0,'5',30,''),(151,'2','单行滚动屏',10,0,0,200,100,'blog','cws_verticalScroller',0,NULL,'',7,0,'6',30,''),(161,'2','Flash图片',10,0,0,200,100,'blog','cws_flashImages',0,NULL,'',8,0,'7',30,''),(171,'2','博客之星',10,0,0,200,100,'blog','cws_blogStars',0,NULL,'',9,0,'8',30,''),(181,'2','推荐博客',10,0,0,200,100,'blog','cws_recommandBlog',0,NULL,'',10,0,'9',30,'');
INSERT INTO `sq_desktop_setup` (`ID`,`SYSTEM_CODE`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`,`POSITION`,`TITLE_LEN`,`PROPERTIES`) VALUES (182,'2','----博客新文章----',10,0,0,200,100,'blog','cws_newBlogTopic',0,NULL,'',11,0,'10',30,''),(191,'2','----最近更新博客----',10,0,0,200,100,'blog','cws_newUpdateBlog',0,NULL,'',12,0,'11',30,''),(201,'2','----最新相册图片----',4,0,0,200,100,'blog','cws_newPhotos',0,NULL,'',13,0,'12',30,''),(211,'2','----发表排行----',10,0,0,200,100,'blog','cws_postRank',0,NULL,'',14,0,'13',30,''),(221,'2','----评论排行----',10,0,0,200,100,'blog','cws_replyRank',0,NULL,'',15,0,'14',30,''),(222,'2','散文',10,0,0,200,100,'blog','sanwen',0,NULL,'',16,0,'15',30,''),(231,'2','博客广告',10,0,0,200,100,'blog','ad_2',0,NULL,'',17,0,'17',30,''),(241,'2','广告3',10,0,0,200,100,'blog','ad_3',0,NULL,'',18,0,'18',30,''),(251,'2','广告4',10,0,0,200,100,'blog','ad_4',0,NULL,'',19,0,'19',30,''),(261,'2','广告5',10,0,0,200,100,'blog','ad_5',0,NULL,'',20,0,'20',30,'');
INSERT INTO `sq_desktop_setup` (`ID`,`SYSTEM_CODE`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`,`POSITION`,`TITLE_LEN`,`PROPERTIES`) VALUES (271,'2','广告6',10,0,0,200,100,'blog','ad_6',0,NULL,'',21,0,'21',30,''),(281,'2','广告7',10,0,0,200,100,'blog','ad_7',0,NULL,'',22,0,'22',30,''),(301,'0','广告',500,0,0,200,100,'cms_home','ad_1',0,NULL,'',14,0,'7',30,''),(311,'0','----Flash图片----',10,0,0,200,100,'cms_home','cws_flashImages',0,NULL,'',15,0,'8',30,''),(322,'0','今日焦点',10,0,0,200,100,'cms_home','focus',0,NULL,'',16,0,'9',30,''),(331,'0','----论坛通知----',10,0,0,200,100,'forum','notice',0,NULL,'',17,0,'10',30,''),(352,'0','----焦点热贴----',10,0,0,200,100,'forum','hot',0,NULL,'',18,0,'11',40,''),(361,'0','----版块排行----',10,0,0,200,100,'forum','boardRank',0,NULL,'',19,0,'12',30,''),(371,'0','----在线排行----',10,0,0,200,100,'forum','onlineTimeRank',0,NULL,'',20,0,'14',30,''),(372,'0','----经验排行----',10,0,0,200,100,'forum','experienceRank',0,NULL,'',21,0,'13',30,'');
INSERT INTO `sq_desktop_setup` (`ID`,`SYSTEM_CODE`,`TITLE`,`COUNT`,`WIN_LEFT`,`WIN_TOP`,`WIN_WIDTH`,`WIN_HEIGHT`,`MODULE_CODE`,`MODULE_ITEM`,`IS_SYSTEM`,`MORE_PAGE`,`IS_LOCKED`,`ZINDEX`,`WIN_MIN`,`POSITION`,`TITLE_LEN`,`PROPERTIES`) VALUES (381,'0','----论坛新贴----',10,0,0,200,100,'forum','newTopic',0,NULL,'',22,0,'15',26,''),(382,'0','第一频道',10,0,0,200,100,'cms_dir','first',0,NULL,'',23,0,'16',30,''),(391,'0','广告1',10,0,0,200,100,'cms_home','ad_1',0,NULL,'',24,0,'17',30,'');
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
  `userNew` varchar(20) default '0',
  `createDate` varchar(15) default NULL,
  `topicCount` int(11) NOT NULL default '0',
  `postCount` int(11) NOT NULL default '0',
  `todayCount` int(11) NOT NULL default '0',
  `todayDate` varchar(15) NOT NULL default '',
  `yestodayCount` int(11) NOT NULL default '0',
  `maxCount` int(11) NOT NULL default '0',
  `maxDate` varchar(15) NOT NULL default '',
  `maxOnlineCount` int(11) NOT NULL default '0',
  `maxOnlineDate` varchar(15) NOT NULL default '',
  `notices` varchar(60) default NULL,
  `filterUserName` varchar(255) default NULL,
  `filterMsg` varchar(255) default NULL,
  `isShowLink` tinyint(1) NOT NULL default '1',
  `status` tinyint(3) NOT NULL default '1',
  `reason` varchar(255) default NULL,
  `GUEST_ACTION` varchar(20) NOT NULL default '11' COMMENT '1->Guest can see topic 2->Guest can download  attachment',
  `ad_topic_bottom` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_forum` (`id`,`userCount`,`userNew`,`createDate`,`topicCount`,`postCount`,`todayCount`,`todayDate`,`yestodayCount`,`maxCount`,`maxDate`,`maxOnlineCount`,`maxOnlineDate`,`notices`,`filterUserName`,`filterMsg`,`isShowLink`,`status`,`reason`,`GUEST_ACTION`,`ad_topic_bottom`) VALUES (1,0,'','1182841290546',0,0,0,'1182731616218',0,0,'0',4,'1183103622593','3322,3488','共产党|他妈的|放屁|狗屎','共*产*党',1,1,'<P>论坛维护中，请稍后访问！</P>','11','462,463,461');
CREATE TABLE `sq_forum_media_dir` (
  `code` varchar(20) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `description` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `child_count` int(11) NOT NULL default '0',
  `add_date` varchar(15) NOT NULL default '',
  `dir_type` tinyint(3) unsigned NOT NULL default '0',
  `layer` int(11) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_forum_media_dir` (`code`,`name`,`description`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`dir_type`,`layer`) VALUES ('11780211873591057368','我们','','root','root',1,0,'2007-05-01',1,2),('root','全部','','-1','root',1,1,'',1,1);
CREATE TABLE `sq_forum_media_file` (
  `id` int(11) NOT NULL default '0',
  `dir_code` varchar(20) NOT NULL default '',
  `name` varchar(200) NOT NULL default '',
  `disk_name` varchar(100) NOT NULL default '',
  `visual_path` varchar(200) NOT NULL default '',
  `upload_date` varchar(15) default NULL,
  `file_size` bigint(20) NOT NULL default '0',
  `ext` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `dir_code` (`dir_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_forum_menu` (
  `code` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `isHome` tinyint(1) NOT NULL default '0',
  `link` varchar(100) default NULL,
  `parent_code` varchar(20) NOT NULL default '',
  `root_code` varchar(20) NOT NULL default '',
  `orders` int(11) NOT NULL default '1',
  `child_count` int(11) default NULL,
  `add_date` varchar(15) default NULL,
  `islocked` tinyint(1) default NULL,
  `type` tinyint(3) unsigned default NULL,
  `layer` int(11) NOT NULL default '1',
  `pre_code` varchar(20) NOT NULL default '',
  `width` int(10) unsigned NOT NULL default '60',
  `is_has_path` tinyint(3) unsigned NOT NULL default '0',
  `is_resource` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_forum_menu` (`code`,`name`,`isHome`,`link`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`pre_code`,`width`,`is_has_path`,`is_resource`) VALUES ('1007415003','search',1,'$u/forum/search.jsp','370544897','root',1,0,'1189072331078',NULL,0,3,'',70,1,1),('1238827260','分栏显示',1,'','root','root',9,0,'1189089922468',NULL,1,2,'view_frame',75,0,0),('1294005646','online',1,'$u/forum/boardstatus.jsp?type=online','715133965','root',4,0,'1189093593531',NULL,0,3,'',60,1,1),('1373426122','blog',1,'$u/blog/index.jsp','root','root',10,0,'1189139807953',NULL,0,2,'',60,1,1),('1618982048','逮捕嫌犯',1,'$u/prision_arrest.jsp','374803226','root',1,0,'1189323006890',NULL,0,4,'',60,1,0),('1909459463','forum',1,'$u/forum/index.jsp','root','root',2,0,'1189068567546',NULL,0,2,'',50,1,1),('2015844525','今日贴数',0,'http://localhost:8080/cwbbs/forum/boardstatus.jsp?type=today_count','715133965','root',1,0,'1189069342890',NULL,0,3,'',60,0,0),('2097416729','rank',1,'$u/forum/stats.jsp','715133965','root',7,0,'1189135884031',NULL,0,3,'',60,1,1),('221349759','主题贴数',0,'http://localhost:8080/cwbbs/forum/boardstatus.jsp?type=topic_count','715133965','root',2,0,'1189069368109',NULL,0,3,'',60,0,0);
INSERT INTO `sq_forum_menu` (`code`,`name`,`isHome`,`link`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`pre_code`,`width`,`is_has_path`,`is_resource`) VALUES ('226978891','member',1,'$u/listmember.jsp','root','root',6,0,'1189071913562',NULL,0,2,'',50,1,1),('34283033','exit',1,'$u/exit.jsp','root','root',11,0,'1189087302046',NULL,1,2,'exit',50,1,1),('370544897','社区服务',1,'','root','root',7,4,'1189072139000',NULL,0,2,'',70,0,0),('374803226','社区监狱',1,'$u/prison.jsp','370544897','root',2,2,'1189077882671',NULL,0,3,'',70,1,0),('383927196','treasure',1,'$u/forum/treasure.jsp','370544897','root',4,0,'1189136198265',NULL,0,3,'',60,1,1),('452601720','user_center',1,'$u/usercenter.jsp','root','root',4,0,'1189136092000',NULL,0,2,'',65,1,1),('508001742','风格',1,'','root','root',8,0,'1189088543453',NULL,1,2,'style',80,0,0),('542942385','探监保释',1,'$u/prision_bail.jsp','374803226','root',2,0,'1189323036375',NULL,0,4,'',60,1,0),('554812984','登录',0,'','root','root',3,0,'1189092511312',NULL,1,2,'login',50,0,0),('654829321','short_msg',1,'javascript:hopenWin(\'/cwbbs/message/message.jsp\',320,260)','370544897','root',3,0,'1189077279937',NULL,0,3,'',70,1,1);
INSERT INTO `sq_forum_menu` (`code`,`name`,`isHome`,`link`,`parent_code`,`root_code`,`orders`,`child_count`,`add_date`,`islocked`,`type`,`layer`,`pre_code`,`width`,`is_has_path`,`is_resource`) VALUES ('715133965','论坛状态',1,'','root','root',5,7,'1189069321437',NULL,0,2,'',70,0,0),('736791079','home',1,'$u/index.jsp','root','root',1,0,'1189068523671',NULL,0,2,'',50,1,1),('888679918','online_detail',1,'$u/forum/showonline.jsp','715133965','root',5,0,'1189135755328',NULL,0,3,'',60,1,1),('959020446','post_count',1,'$u/forum/boardstatus.jsp?type=post_count','715133965','root',3,0,'1189093390078',NULL,0,3,'',60,1,1),('989583704','score_rule',1,'$u/forum/score_rule.jsp','715133965','root',6,0,'1189135794265',NULL,0,3,'',60,1,1),('root','全部菜单',1,'','','root',1,11,NULL,0,2,1,'',60,0,0);
CREATE TABLE `sq_forum_robot` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(250) NOT NULL default '',
  `gather_count` int(11) NOT NULL default '1',
  `charset` varchar(30) default NULL,
  `list_url_type` tinyint(3) NOT NULL default '0',
  `list_url_link` varchar(250) NOT NULL default '0',
  `list_page_begin` int(11) NOT NULL default '0',
  `list_page_end` int(11) default '0',
  `list_field_rule` varchar(250) default NULL,
  `list_doc_url_rule` varchar(250) default NULL,
  `list_doc_url_prefix` varchar(250) default NULL,
  `doc_title_rule` varchar(250) NOT NULL default '',
  `doc_content_rule` varchar(250) default NULL,
  `doc_page_url_prefix` varchar(250) default NULL,
  `doc_page_num_rule` varchar(250) default NULL,
  `doc_title_filter` varchar(250) default NULL,
  `doc_title_replace_before` varchar(250) default NULL,
  `doc_title_replace_after` varchar(250) default NULL,
  `doc_title_key` varchar(250) default NULL,
  `doc_title_repeat_allow` tinyint(3) NOT NULL default '1',
  `doc_content_filter` varchar(250) default NULL,
  `doc_content_replace_before` varchar(250) default NULL,
  `doc_content_replace_after` varchar(250) default NULL,
  `doc_save_img` tinyint(1) NOT NULL default '1',
  `doc_save_flash` tinyint(1) NOT NULL default '1',
  `doc_img_flash_prefix` varchar(250) default NULL,
  `dir_code` varchar(20) NOT NULL default '',
  `examine` tinyint(4) NOT NULL default '0',
  `topic_user_name` varchar(50) NOT NULL default '',
  `expression` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_forum_robot` (`id`,`name`,`gather_count`,`charset`,`list_url_type`,`list_url_link`,`list_page_begin`,`list_page_end`,`list_field_rule`,`list_doc_url_rule`,`list_doc_url_prefix`,`doc_title_rule`,`doc_content_rule`,`doc_page_url_prefix`,`doc_page_num_rule`,`doc_title_filter`,`doc_title_replace_before`,`doc_title_replace_after`,`doc_title_key`,`doc_title_repeat_allow`,`doc_content_filter`,`doc_content_replace_before`,`doc_content_replace_after`,`doc_save_img`,`doc_save_flash`,`doc_img_flash_prefix`,`dir_code`,`examine`,`topic_user_name`,`expression`) VALUES (132,'aaa',233,'utf-8',0,'sadfasdf',1,0,'sdfsadf','sadf','','sadf','asdf',NULL,NULL,'sadf','','','asdf',1,'asdf','','',1,1,'asdasd','test',2,'',15),(133,'aaa copy',233,'gbk',0,'sadfasdf',1,0,'sdfsadf','sadf','','sadf','asdf',NULL,NULL,'sadf','','','asdf',1,'asdf','','',1,1,'asdasd','test',0,'ccc,c',15),(141,'mop',3,'gb2312',1,'http://bbs.news.mop.com/forumdisplay.php?fid=48&page=[page]',1,10,'<form method=\"post\" name=\"moderate\" action[list]</form>','>\r\n<a href=\"[url]\" class=\"','http://bbs.news.mop.com/','<tr>\r\n<td align=\"center\" colspan=\"2\" style=\"font-size:24px;font-weight:bold;\" height=\"62\">\r\n标题：\r\n[subject]</td>\r\n</tr>\r\n</table>','</tr>\r\n<tr>\r\n<td class=\"content\">\r\n[message]\r\n</td>',NULL,NULL,'','','','',0,'','','',0,1,'http://bbs.news.mop.com/','test',1,'ccc,c',-1),(151,'mop copy',10,'gb2312',1,'http://bbs.news.mop.com/forumdisplay.php?fid=48&page=[page]',1,10,'<form method=\"post\" name=\"moderate\" action[list]</form>','>\r\n<a href=\"[url]\" class=\"','http://bbs.news.mop.com/','<tr>\r\n<td align=\"center\" colspan=\"2\" style=\"font-size:24px;font-weight:bold;\" height=\"62\">\r\n标题：\r\n[subject]</td>\r\n</tr>\r\n</table>','</tr>\r\n<tr>\r\n<td class=\"content\">\r\n[message]\r\n</td>',NULL,NULL,'','','','',1,'','','',1,1,'http://bbs.news.mop.com/','test',1,'ccc,c',-1);
INSERT INTO `sq_forum_robot` (`id`,`name`,`gather_count`,`charset`,`list_url_type`,`list_url_link`,`list_page_begin`,`list_page_end`,`list_field_rule`,`list_doc_url_rule`,`list_doc_url_prefix`,`doc_title_rule`,`doc_content_rule`,`doc_page_url_prefix`,`doc_page_num_rule`,`doc_title_filter`,`doc_title_replace_before`,`doc_title_replace_after`,`doc_title_key`,`doc_title_repeat_allow`,`doc_content_filter`,`doc_content_replace_before`,`doc_content_replace_after`,`doc_save_img`,`doc_save_flash`,`doc_img_flash_prefix`,`dir_code`,`examine`,`topic_user_name`,`expression`) VALUES (152,'ddd',10,'gb2312',1,'http://bbs.news.mop.com/forumdisplay.php?fid=48&page=[page]',1,10,'<form method=\"post\" name=\"moderate\" action[list]</form>','>\r\n<a href=\"[url]\" class=\"','http://bbs.news.mop.com/','<tr>\r\n<td align=\"center\" colspan=\"2\" style=\"font-size:24px;font-weight:bold;\" height=\"62\">\r\n标题：\r\n[subject]</td>\r\n</tr>\r\n</table>','</tr>\r\n<tr>\r\n<td class=\"content\">\r\n[message]\r\n</td>',NULL,NULL,'','','','',1,'sdfasdf','','',1,1,'http://bbs.news.mop.com/','test',1,'ccc,c',-1),(162,'163采集',5,'gb2312',0,'http://bbs5.news.163.com/board/postlist.jsp?b=society&p=2&l=50&order=1',1,10,'<TABLE width=\"100%\" border=0 cellPadding=2 cellSpacing=1 bgcolor=\"#A4B6D7\" style=\"table-layout: fixed; word-wrap:Break-word;\">\r\n[list]</TR>\r\n  </TBODY>\r\n</TABLE>','<a href=\"[url]\" class=f14 target=\"_blank\">','http://bbs5.news.163.com/','主题：[subject]</A>','<TD class=\"f14 imgzoom\">\r\n      <P>\r\n[message]\r\n</TD></TR>\r\n  <TR bgColor=#f2f8ff>',NULL,NULL,'','','','',0,'','','',1,1,'http://bbs5.news.163.com/','test',1,'ccc,c',-1);
INSERT INTO `sq_forum_robot` (`id`,`name`,`gather_count`,`charset`,`list_url_type`,`list_url_link`,`list_page_begin`,`list_page_end`,`list_field_rule`,`list_doc_url_rule`,`list_doc_url_prefix`,`doc_title_rule`,`doc_content_rule`,`doc_page_url_prefix`,`doc_page_num_rule`,`doc_title_filter`,`doc_title_replace_before`,`doc_title_replace_after`,`doc_title_key`,`doc_title_repeat_allow`,`doc_content_filter`,`doc_content_replace_before`,`doc_content_replace_after`,`doc_save_img`,`doc_save_flash`,`doc_img_flash_prefix`,`dir_code`,`examine`,`topic_user_name`,`expression`) VALUES (163,'天涯',3,'gbk',1,'http://www13.tianya.cn/new/publicforum/ArticlesList.asp?idWriter=5244202&Key=124992527&stritem=no0[page]',1,10,'<td width=90 nowrap align=\"center\"><font color=white>更新日期</font></td>\r\n</tr>\r\n</table>[list]<td width=380 nowrap align=\"center\"><font color=white>论　　题</font>','<a href=\'[url]\'  target=\'_blank\'>*</td>\r\n	<td width=90>','http://www13.tianya.cn','</font></a>』\r\n[subject]</font></TD></TR></table></td></table><BR>','</table>\r\n<DIV class=content style=\"WORD-WRAP:break-word\">\r\n[message]\r\n<TABLE cellspacing=0 border=0 bgcolor=f5f9fa width=100% ><',NULL,NULL,'','','','',0,'','','',1,1,'http://www13.tianya.cn/','info',1,'ccc,c',29),(171,'中华新闻网',3,'gbk',1,'http://forum.xinhuanet.com/listtopic.jsp?bid=50&page=[page]&catid=0',1,5,'<td bgcolor=\"#88B0F5\" width=\"49\" align=\"center\" class=\"w12\" valign=\"bottom\">点击</td>\r\n    <td bgcolor=\"#FFFFFF\" height=\"22\" width=\"4\"></td>\r\n  </tr>\r\n</table>[list]后页</font></a> \r\n    \r\n    </td>','<a href=\"[url]\" target=\"_blank\" class=\"txt\">','http://forum.xinhuanet.com/','<title>[subject]</title>','<table width=\"92%\" border=\"0\" cellspacing=\"0\" cellpadding=\"8\" class=\"black128\">\r\n              <tr> \r\n                <td>[message]</td>',NULL,NULL,'','','','',0,'','','',1,1,'','reward',1,'c,ccc',15);
INSERT INTO `sq_forum_robot` (`id`,`name`,`gather_count`,`charset`,`list_url_type`,`list_url_link`,`list_page_begin`,`list_page_end`,`list_field_rule`,`list_doc_url_rule`,`list_doc_url_prefix`,`doc_title_rule`,`doc_content_rule`,`doc_page_url_prefix`,`doc_page_num_rule`,`doc_title_filter`,`doc_title_replace_before`,`doc_title_replace_after`,`doc_title_key`,`doc_title_repeat_allow`,`doc_content_filter`,`doc_content_replace_before`,`doc_content_replace_after`,`doc_save_img`,`doc_save_flash`,`doc_img_flash_prefix`,`dir_code`,`examine`,`topic_user_name`,`expression`) VALUES (172,'163',3,'gbk',0,'http://bbs5.news.163.com/board/postlist.jsp?b=society&p=2&l=50&order=1',1,10,'<TABLE width=\"100%\" border=0 cellPadding=2 cellSpacing=1 bgcolor=\"#A4B6D7\" style=\"table-layout: fixed; word-wrap:Break-word;\">\r\n[list]</TR>\r\n  </TBODY>\r\n</TABLE>','<a href=\"[url]\" class=f14 target=\"_blank\">','http://bbs5.news.163.com','主题：[subject]</A></TD>','<TD class=\"f14 imgzoom\">\r\n      <P>\r\n[message]\r\n</TD></TR>\r\n  <TR bgColor=#f2f8ff>',NULL,NULL,'','','','',0,'','','',1,1,'http://bbs5.news.163.com/','test',1,'ccc,c',-1);
CREATE TABLE `sq_friend` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `friend` varchar(20) NOT NULL default '',
  `rq` varchar(15) NOT NULL default '',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_id` (
  `idType` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`idType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_id` (`idType`,`id`) VALUES (0,1),(1,15),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,21),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,41),(36,1),(37,1),(38,31),(39,1);
CREATE TABLE `sq_images` (
  `id` bigint(11) NOT NULL default '0',
  `path` varchar(200) NOT NULL default '',
  `otherid` bigint(20) NOT NULL default '0',
  `kind` varchar(20) NOT NULL default '',
  `is_remote` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `IX_images` (`otherid`),
  KEY `IX_images_1` (`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_master` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(20) NOT NULL default '',
  `sort` tinyint(3) unsigned NOT NULL default '0',
  `description` varchar(100) default NULL,
  PRIMARY KEY  (`name`),
  KEY `id` (`id`),
  CONSTRAINT `sq_master_ibfk_1` FOREIGN KEY (`name`) REFERENCES `sq_user` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_message` (
  `id` bigint(20) NOT NULL default '0',
  `name` varchar(20) NOT NULL default 'N''无名氏''',
  `expression` tinyint(3) unsigned default '25',
  `boardcode` varchar(20) NOT NULL default 'N''xlmx''',
  `replyid` bigint(20) NOT NULL default '-1',
  `rootid` bigint(20) NOT NULL default '-1',
  `msg_layer` int(11) NOT NULL default '1',
  `length` int(11) NOT NULL default '0',
  `orders` int(11) NOT NULL default '1',
  `title` varchar(200) NOT NULL default '',
  `content` longtext NOT NULL,
  `recount` int(11) NOT NULL default '0',
  `hit` int(11) NOT NULL default '0',
  `lydate` varchar(15) NOT NULL default '',
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
  `colorExpire` varchar(15) default NULL,
  `isBold` tinyint(1) NOT NULL default '0',
  `boldExpire` varchar(15) default NULL,
  `isBlog` tinyint(1) default '0',
  `blogUserDir` varchar(50) NOT NULL default 'default',
  `replyRootName` varchar(50) default NULL,
  `pluginCode` varchar(20) default NULL,
  `plugin2Code` varchar(20) default NULL,
  `thread_type` int(11) NOT NULL default '0',
  `check_status` tinyint(3) NOT NULL default '1',
  `blog_id` bigint(20) NOT NULL default '-1',
  `last_operate` int(11) NOT NULL default '-1',
  `blog_dir_code` varchar(20) default NULL,
  `msg_notify` tinyint(3) unsigned NOT NULL default '0',
  `sms_notify` tinyint(3) unsigned NOT NULL default '0',
  `score` double NOT NULL default '0',
  `score_dyn` double NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `rootid` (`rootid`),
  KEY `replyid` (`replyid`),
  KEY `replyRootName` (`replyRootName`),
  KEY `name` (`name`),
  KEY `boardcode_checkStatus` (`boardcode`,`check_status`),
  KEY `blogid_checkstatus_isblog` (`blog_id`,`check_status`,`isBlog`),
  KEY `lydate` USING BTREE (`lydate`),
  KEY `blog_dir_code` USING BTREE (`blog_dir_code`),
  KEY `score` (`score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_message_attach` (
  `id` bigint(20) NOT NULL default '0',
  `msgId` bigint(20) NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `fullpath` varchar(255) default NULL,
  `diskname` varchar(100) NOT NULL default '',
  `visualpath` varchar(255) NOT NULL default '',
  `orders` int(11) NOT NULL default '0',
  `DOWNLOAD_COUNT` int(11) NOT NULL default '0',
  `UPLOAD_DATE` varchar(15) default NULL,
  `FILE_SIZE` bigint(20) NOT NULL default '0',
  `USER_NAME` varchar(20) default NULL,
  `ext` varchar(20) default NULL,
  `is_remote` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `msgId` (`msgId`),
  KEY `user_name` (`USER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_message_op` (
  `id` bigint(20) NOT NULL auto_increment,
  `msg_id` bigint(20) NOT NULL default '0',
  `op_type` int(11) NOT NULL default '0',
  `expire_date` datetime default NULL,
  `user_name` varchar(20) default NULL,
  `op_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `msg_title` varchar(250) default NULL,
  `msg_user` varchar(20) default NULL,
  `msg_date` datetime default NULL,
  `boardcode` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `msg_id` (`msg_id`),
  KEY `user_name` (`user_name`),
  KEY `op_date` (`op_date`),
  KEY `boardcode` (`boardcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_message_recommend` (
  `Id` int(11) NOT NULL default '0',
  `msg_id` bigint(20) NOT NULL default '0',
  `report_reason` varchar(255) NOT NULL default '',
  `user_name` varchar(20) NOT NULL default '',
  `submit_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`Id`),
  KEY `msg_id` (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_message_report` (
  `Id` int(11) NOT NULL default '0',
  `msg_id` bigint(20) NOT NULL default '0',
  `report_reason` varchar(255) NOT NULL default '',
  `user_name` varchar(20) NOT NULL default '',
  `submit_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`Id`),
  KEY `msg_id` (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_online` (
  `name` varchar(26) NOT NULL default '',
  `boardcode` varchar(20) default NULL,
  `ip` varchar(15) NOT NULL default '',
  `doing` varchar(50) default NULL,
  `logtime` varchar(15) NOT NULL default '',
  `staytime` varchar(15) NOT NULL default '',
  `isguest` tinyint(1) NOT NULL default '0',
  `covered` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`name`),
  KEY `IX_sq_online` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_poll` (
  `msg_id` bigint(20) unsigned NOT NULL default '0',
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
  `sort` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `room` (`room`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_scheduler` (
  `id` int(10) unsigned NOT NULL default '0',
  `cron` varchar(255) NOT NULL default '',
  `data_map` varchar(255) default NULL,
  `job_name` varchar(255) default NULL,
  `job_class` varchar(255) NOT NULL default '',
  `month_day` varchar(255) default NULL,
  `user_name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_score_record` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `lydate` varchar(15) NOT NULL default '',
  `buyer` varchar(20) NOT NULL default '',
  `seller` varchar(20) default NULL,
  `from_score` varchar(20) default NULL,
  `to_score` varchar(20) default NULL,
  `operation` varchar(20) NOT NULL default '',
  `from_value` float NOT NULL default '0',
  `to_value` float NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `record_list` (`buyer`,`operation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_setup_user_level` (
  `levelAmount` int(11) NOT NULL default '0',
  `description` varchar(50) NOT NULL default '',
  `levelPicPath` varchar(255) default NULL,
  `groupCode` varchar(20) default NULL,
  PRIMARY KEY  (`levelAmount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_setup_user_level` (`levelAmount`,`description`,`levelPicPath`,`groupCode`) VALUES (0,'初入江湖','level1.gif',''),(1000,'小有名气','level2.gif',''),(2000,'名动一方','level3.gif',''),(3000,'天下闻名','level4.gif',''),(4000,'一代宗师','level5.gif',NULL),(5000,'超凡入圣','level6.gif',NULL),(6000,'天外飞仙','level7.gif',NULL),(7000,'无所不能','level8.gif','');
CREATE TABLE `sq_tag` (
  `name` varchar(20) NOT NULL default '',
  `create_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `count` int(10) unsigned NOT NULL default '0',
  `is_system` tinyint(1) NOT NULL default '0',
  `id` bigint(20) unsigned NOT NULL default '0',
  `user_name` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_tag` (`name`,`create_date`,`count`,`is_system`,`id`,`user_name`) VALUES ('娱乐','2007-06-29 15:19:54',0,1,11,'sys'),('搞笑','2007-06-29 15:20:06',0,1,12,'sys'),('自拍','2007-06-29 15:20:16',0,1,13,'sys'),('体育','2007-06-29 15:20:25',0,1,14,'sys'),('社会','2007-06-29 15:20:48',0,1,15,'sys'),('音乐','2007-06-29 15:20:54',0,1,16,'sys'),('生活','2007-06-29 15:21:32',0,1,18,'sys'),('科技','2007-06-29 15:21:40',0,1,19,'sys'),('惊险','2007-06-29 15:22:30',0,1,21,'sys'),('动漫','2007-06-29 15:22:41',0,1,22,'sys'),('游戏','2007-06-29 15:22:50',0,1,23,'sys'),('教育','2007-06-29 15:22:57',0,1,24,'sys'),('影视','2007-06-29 15:23:12',0,1,25,'sys'),('原创','2007-06-29 15:23:21',0,1,26,'sys');
CREATE TABLE `sq_tag_message` (
  `tag_id` bigint(20) unsigned NOT NULL default '0',
  `msg_id` bigint(20) unsigned NOT NULL default '0',
  `create_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_name` varchar(20) NOT NULL default '',
  PRIMARY KEY  USING BTREE (`tag_id`,`msg_id`),
  KEY `msg_id` (`msg_id`),
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_thread` (
  `id` bigint(20) NOT NULL default '0' COMMENT 'The id of message''s root id',
  `boardcode` varchar(20) default NULL,
  `msg_level` int(11) NOT NULL default '0',
  `iselite` tinyint(1) NOT NULL default '0',
  `lydate` varchar(15) NOT NULL default '',
  `redate` varchar(15) default NULL COMMENT 'reply date',
  `name` varchar(20) NOT NULL default '',
  `blogUserDir` varchar(50) default NULL,
  `isBlog` tinyint(1) NOT NULL default '0',
  `hit` int(11) NOT NULL default '0',
  `check_status` tinyint(3) NOT NULL default '1',
  `thread_type` int(11) NOT NULL default '0',
  `blog_id` bigint(20) NOT NULL default '-1',
  `blog_dir_code` varchar(20) default NULL,
  `score` double NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `name` (`name`),
  KEY `lydate` (`lydate`),
  KEY `redate` (`redate`),
  KEY `name_blogUserDir` (`name`,`blogUserDir`),
  KEY `boardcode_checkStatus_threadType` (`boardcode`,`check_status`,`thread_type`),
  KEY `blogid_checkstatus_isblog` (`blog_id`,`check_status`,`isBlog`),
  KEY `blog_dir_code` (`blog_dir_code`),
  KEY `score` (`score`)
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
  `rawPwd` varchar(20) default NULL,
  `nick` varchar(20) NOT NULL default '',
  `RegDate` varchar(15) NOT NULL default '',
  `realname` varchar(20) default NULL,
  `RealPic` varchar(50) default NULL,
  `Question` varchar(50) default NULL,
  `Answer` varchar(50) default NULL,
  `Email` varchar(50) default NULL,
  `Gender` char(1) default NULL,
  `OICQ` varchar(15) default NULL,
  `Birthday` varchar(15) default NULL,
  `IDCard` varchar(50) default NULL,
  `Career` varchar(255) default NULL,
  `Job` varchar(50) default NULL,
  `State` varchar(50) default NULL,
  `City` varchar(50) default NULL,
  `Address` varchar(255) default NULL,
  `PostCode` varchar(20) default NULL,
  `Phone` varchar(50) default NULL,
  `Mobile` varchar(30) default NULL,
  `Hobbies` varchar(50) default NULL,
  `lastTime` varchar(15) NOT NULL default '',
  `curTime` varchar(15) NOT NULL default '',
  `sign` varchar(255) default NULL,
  `myface` varchar(50) default NULL,
  `favoriate` varchar(250) default NULL,
  `ispolice` tinyint(1) NOT NULL default '0',
  `arrestday` int(11) NOT NULL default '0',
  `releasetime` varchar(15) NOT NULL default '0',
  `arrestreason` varchar(255) default NULL,
  `arresttime` varchar(15) NOT NULL default '0',
  `arrestpolice` varchar(20) default NULL,
  `experience` int(11) NOT NULL default '0',
  `credit` int(11) NOT NULL default '500',
  `addcount` int(11) NOT NULL default '0',
  `delcount` int(11) NOT NULL default '0',
  `eliteCount` int(11) NOT NULL default '0',
  `Marriage` tinyint(3) unsigned NOT NULL default '0',
  `gold` int(11) NOT NULL default '0',
  `isValid` tinyint(1) NOT NULL default '1',
  `diskSpaceAllowed` int(11) NOT NULL default '10240000',
  `diskSpaceUsed` int(11) NOT NULL default '0',
  `isSecret` tinyint(1) NOT NULL default '1',
  `IP` varchar(15) default NULL,
  `timeZone` varchar(9) NOT NULL default '',
  `home` varchar(255) default NULL,
  `msn` varchar(200) default NULL,
  `group_code` varchar(20) default NULL,
  `icq` varchar(50) default NULL,
  `uc` varchar(50) default NULL,
  `yahoo` varchar(50) default NULL,
  `check_status` tinyint(3) NOT NULL default '1',
  `locale` varchar(20) default NULL,
  `online_time` float NOT NULL default '0' COMMENT 'Hour',
  PRIMARY KEY  (`name`),
  KEY `RegDate` (`RegDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_user_group` (
  `code` varchar(50) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `isSystem` tinyint(1) NOT NULL default '0',
  `display_order` int(11) NOT NULL default '0',
  `ip_begin` varchar(15) default NULL,
  `ip_end` varchar(15) default NULL,
  `is_guest` tinyint(3) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sq_user_group` (`code`,`description`,`isSystem`,`display_order`,`ip_begin`,`ip_end`,`is_guest`) VALUES ('everyone','everyone',1,1,NULL,NULL,0),('guest','guest',1,2,NULL,NULL,0);
CREATE TABLE `sq_user_group_priv` (
  `group_code` varchar(20) NOT NULL default '',
  `priv` varchar(50) default NULL,
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
  `view_listmember` char(1) NOT NULL default '1',
  `view_online` char(1) NOT NULL default '1',
  PRIMARY KEY  (`group_code`,`board_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user''s privilege';
INSERT INTO `sq_user_group_priv` (`group_code`,`priv`,`add_topic`,`reply_topic`,`vote`,`search`,`attach_upload`,`attach_download`,`board_code`,`money_code`,`money_sum`,`is_default`,`enter_board`,`view_topic`,`view_listmember`,`view_online`) VALUES ('guest','','0','0','0','0','1','1','alipay','',0,'0','1','1','0','1'),('guest','11','1','1','1','1','1','1','allboard',NULL,0,'1','1','1','1','1'),('guest','11','1','1','1','1','1','1','blog',NULL,0,'1','1','1','1','1'),('guest','','0','0','0','0','1','1','bzjl','',0,'0','1','1','0','1'),('guest','','0','0','0','0','1','1','bzjlsecret','',0,'0','1','1','0','1'),('guest','','0','0','0','0','0','1','hk','',0,'0','1','1','0','1'),('guest','','0','0','0','0','1','1','info','',0,'0','1','1','0','1'),('guest','','0','0','0','0','1','1','master','',0,'0','1','1','0','1'),('guest','','0','0','0','0','1','1','qrl','',0,'0','1','1','0','1'),('guest','','0','0','0','0','1','1','reward','',0,'0','1','1','0','1'),('guest','','0','0','0','0','1','1','score','',0,'0','1','1','0','1'),('guest','','0','0','0','0','1','1','sqzw','',0,'0','1','1','0','1');
INSERT INTO `sq_user_group_priv` (`group_code`,`priv`,`add_topic`,`reply_topic`,`vote`,`search`,`attach_upload`,`attach_download`,`board_code`,`money_code`,`money_sum`,`is_default`,`enter_board`,`view_topic`,`view_listmember`,`view_online`) VALUES ('guest','','0','0','0','0','1','1','trade','',0,'0','1','1','0','1'),('guest','','0','0','0','0','0','1','witkey','',0,'0','1','1','0','1');
CREATE TABLE `sq_user_priv` (
  `user_name` varchar(20) NOT NULL default '',
  `priv` varchar(50) default NULL,
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
INSERT INTO `sq_user_priv` (`user_name`,`priv`,`attach_day_count`,`attach_size`,`add_topic`,`reply_topic`,`vote`,`search`,`attach_upload`,`attach_download`,`attach_today`,`attach_today_upload_count`,`is_default`) VALUES ('11830985585001490881','11',50,1500,'1','1','1','1','1','1',NULL,0,'1');
CREATE TABLE `sq_user_prop` (
  `name` varchar(20) NOT NULL default '',
  `flower_count` int(11) NOT NULL default '0',
  `egg_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sq_user_treasure` (
  `userName` varchar(50) NOT NULL default '',
  `treasureCode` varchar(50) NOT NULL default '',
  `buyDate` varchar(15) NOT NULL default '',
  `amount` int(11) NOT NULL default '0',
  UNIQUE KEY `IX_sq_user_treasure` (`userName`,`treasureCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_group` (
  `code` varchar(50) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `isSystem` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `user_group` (`code`,`description`,`isSystem`) VALUES ('Administrators','管理员组',1),('Everyone','每个人',1);
CREATE TABLE `user_group_priv` (
  `group_code` varchar(20) NOT NULL default '',
  `priv` varchar(20) NOT NULL default '',
  KEY `IX_group_priv` (`group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_of_group` (
  `user_name` varchar(50) NOT NULL default '',
  `group_code` varchar(50) NOT NULL default '',
  KEY `IX_user_of_group` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `user_priv` (
  `username` varchar(20) NOT NULL default '',
  `priv` varchar(50) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `users` (
  `name` varchar(20) NOT NULL default '',
  `pwd` varchar(32) NOT NULL default '',
  `realname` varchar(20) NOT NULL default '',
  `description` varchar(200) default NULL,
  `enter_count` int(11) NOT NULL default '0',
  `enter_last` varchar(15) NOT NULL default '0',
  `is_foreground_user` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `users` (`name`,`pwd`,`realname`,`description`,`enter_count`,`enter_last`,`is_foreground_user`) VALUES ('admin','96e79218965eb72c92a549dd5a330112','admin',NULL,30,'1183336879187',0);
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
