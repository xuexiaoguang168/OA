<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.cloudwebsoft.framework.db.*"%>
<%@ page import="cn.js.fan.util.web.*"%>
<%@ page import="java.sql.*"%>
<%
JdbcTemplate jt = new JdbcTemplate(new com.cloudwebsoft.framework.db.Connection(cn.js.fan.web.Global.defaultDB));

out.print("清除account<BR>");
String sql = "delete from account";
jt.addBatch(sql);

// address
out.print("清除Address<BR>");
sql = "delete from address";
jt.addBatch(sql);
sql = "delete from address_type";
jt.addBatch(sql);

out.print("清除assert<BR>");
sql = "delete from asset_info";
jt.addBatch(sql);
sql = "delete from asset_type_info";
jt.addBatch(sql);

out.print("清除boardroom<BR>");
sql = "delete from boardroom";
jt.addBatch(sql);
sql = "delete from boardroom_used_status";
jt.addBatch(sql);

out.print("清除book<BR>");
sql = "delete from book";
jt.addBatch(sql);
sql = "delete from book_type";
jt.addBatch(sql);

out.print("清除email<BR>");
sql = "delete from email";
jt.addBatch(sql);
sql = "delete from email_attach";
jt.addBatch(sql);
sql = "delete from email_pop3";
jt.addBatch(sql);


out.print("清除flow<BR>");
sql = "delete from flow_cms_images";
jt.addBatch(sql);
sql = "delete from flow_document_attach";
jt.addBatch(sql);
sql = "delete from flow_doc_content";
jt.addBatch(sql);
sql = "delete from flow_document";
jt.addBatch(sql);
sql = "delete from flow_monitor";
jt.addBatch(sql);
sql = "delete from flow_link";
jt.addBatch(sql);
sql = "delete from flow_action";
jt.addBatch(sql);
sql = "delete from flow";
jt.addBatch(sql);
sql = "delete from flow_predefined";
jt.addBatch(sql);
sql = "delete from flow_sequence";
jt.addBatch(sql);
sql = "delete from flow_my_action";
jt.addBatch(sql);

out.print("清除表单信息<BR>");
sql = "delete from form_table_fw";
jt.addBatch(sql);
sql = "delete from form_table_shouwen";
jt.addBatch(sql);
sql = "delete from form_table_gzjbd";
jt.addBatch(sql);
sql = "delete from form_table_dcdbd";
jt.addBatch(sql);
sql = "delete from form_table_zbdjd";
jt.addBatch(sql);
sql = "delete from form_table_hysqd";
jt.addBatch(sql);
sql = "delete from form_table_fydjd";
jt.addBatch(sql);
sql = "delete from form_table_qjsqd";
jt.addBatch(sql);
sql = "delete from form_table_jcna";
jt.addBatch(sql);
sql = "delete from form_table_qksqd";
jt.addBatch(sql);
sql = "delete from form_table_rcszjrd";
jt.addBatch(sql);
sql = "delete from form_table_lxsqb";
jt.addBatch(sql);
sql = "delete from form_table_cpxgsqs";
jt.addBatch(sql);
sql = "delete from form_table_cpznjcbg";
jt.addBatch(sql);
sql = "delete from form_table_ncd";
jt.addBatch(sql);
sql = "delete from form_table_qzkhdjd";
jt.addBatch(sql);
sql = "delete from form_table_khfkdjd";
jt.addBatch(sql);
sql = "delete from form_table_vehicle_apply";
jt.addBatch(sql);
sql = "delete from form_table_gsfw";
jt.addBatch(sql);
sql = "delete from form_table_bgypsnd";
jt.addBatch(sql);
sql = "delete from form_table_jbdjd";
jt.addBatch(sql);
sql = "delete from form_table_ccsqd";
jt.addBatch(sql);
sql = "delete from form_table_sales_linkman";
jt.addBatch(sql);
sql = "delete from form_table_sales_provider_info";
jt.addBatch(sql);
sql = "delete from form_table_sales_provider_name";
jt.addBatch(sql);
sql = "delete from form_table_sales_product_info";
jt.addBatch(sql);
sql = "delete from form_table_sales_contract";
jt.addBatch(sql);
sql = "delete from form_table_sales_customer_service";
jt.addBatch(sql);
sql = "delete from form_table_sales_product_service";
jt.addBatch(sql);
sql = "delete from form_table_sales_product_sell";
jt.addBatch(sql);
sql = "delete from form_table_sales_product_service_sell";
jt.addBatch(sql);
sql = "delete from form_table_sales_customer";
jt.addBatch(sql);

out.print("清除kaoqin<BR>");
sql = "delete from kaoqin";
jt.addBatch(sql);

out.print("清除log<BR>");
sql = "delete from log";
jt.addBatch(sql);

out.print("清除网络硬盘<BR>");
sql = "delete from netdisk_document_attach";
jt.addBatch(sql);
sql = "delete from netdisk_document";
jt.addBatch(sql);
sql = "delete from netdisk_doc_content";
jt.addBatch(sql);
sql = "delete from netdisk_dir_priv";
jt.addBatch(sql);
sql = "delete from netdisk_directory";
jt.addBatch(sql);

out.print("清除oa_message信息<BR>");
sql = "delete from oa_message_attach";
jt.addBatch(sql);
sql = "delete from oa_message";
jt.addBatch(sql);

out.print("清除office_equipment信息<BR>");
sql = "delete from office_equipment";
jt.addBatch(sql);
sql = "delete from office_equipment_op";
jt.addBatch(sql);
sql = "delete from office_equipment_type";
jt.addBatch(sql);

out.print("清除dept_user信息<BR>");
sql = "delete from dept_user";
jt.addBatch(sql);
sql = "INSERT INTO dept_user (DEPT_CODE, USER_NAME, ORDERS) VALUES ('admin','admin',0)";
jt.addBatch(sql);

out.print("清除task信息<BR>");
sql = "delete from task";
jt.addBatch(sql);
sql = "delete from task_attach";
jt.addBatch(sql);

out.print("清除user_admin_dept信息<BR>");
sql = "delete from user_admin_dept";
jt.addBatch(sql);

out.print("清除user_archive信息<BR>");
sql = "delete from user_archive";
jt.addBatch(sql);

out.print("清空用户组信息<BR>");
sql = "delete from sq_user_group";
jt.addBatch(sql);

out.print("清除权限相关信息<BR>");
sql = "delete from user_group_of_role";
jt.addBatch(sql);
sql = "delete from user_group_priv";
jt.addBatch(sql);
sql = "delete from user_of_group";
jt.addBatch(sql);
sql = "delete from user_of_role";
jt.addBatch(sql);
sql = "delete from user_priv";
jt.addBatch(sql);
sql = "delete from user_role";
jt.addBatch(sql);
sql = "delete from user_role_priv";
jt.addBatch(sql);

sql = "delete from user_setup";
jt.addBatch(sql);

sql = "delete from users";
jt.addBatch(sql);

sql = "insert into users (name,pwd,pwdRaw,realName,regDate,proxy) values ('admin', '96e79218965eb72c92a549dd5a330112','111111', 'admin', '2006-08-30', '')";
jt.addBatch(sql);

out.print("清除user_plan<BR>");
sql = "delete from user_plan";
jt.addBatch(sql);


out.print("清除vehicle<BR>");
sql = "delete from vehicle";
jt.addBatch(sql);
sql = "delete from vehicle_driver";
jt.addBatch(sql);
sql = "delete from vehicle_maintenance";
jt.addBatch(sql);
sql = "delete from vehicle_type";
jt.addBatch(sql);
sql = "delete from vehicle_use";
jt.addBatch(sql);
sql = "delete from visual_attach";
jt.addBatch(sql);

out.print("清除work_log<BR>");
sql = "delete from work_log";
jt.addBatch(sql);

out.print("清除work_plan<BR>");
sql = "delete from work_plan";
jt.addBatch(sql);
sql = "delete from work_plan_attach";
jt.addBatch(sql);
sql = "delete from work_plan_dept";
jt.addBatch(sql);
sql = "delete from work_plan_type";
jt.addBatch(sql);
sql = "delete from work_plan_user";
jt.addBatch(sql);

// ----------------------清除BBS的相关信息----------------------------
out.print("清除blog信息<BR>");
sql = "update blog set blogCount=0,newBlogUserName='',topicCount=0,postCount=0,todayCount=0,yestodayCount=0,maxCount=0,star='',recommandBlogs=''";
jt.addBatch(sql);
sql = "delete from blog_user_dir";
jt.addBatch(sql);
sql = "delete from photo";
jt.addBatch(sql);
sql = "delete from blog_user_config";
jt.addBatch(sql);

out.print("清除CMS信息<BR>");
sql = "delete from cms_images";
jt.addBatch(sql);
sql = "delete from cms_comment";
jt.addBatch(sql);
sql = "delete from document_attach";
jt.addBatch(sql);
sql = "delete from doc_content";
jt.addBatch(sql);
sql = "delete from document";
jt.addBatch(sql);

sql = "INSERT INTO doc_content (doc_id,content,page_num) VALUES (1,'<IMG height=150 src=\"upfile/webeditimg/2006/8/2357ddd8a4354a8b82292978ec6821f6.jpg\" width=554>',1)";
jt.addBatch(sql);
sql = "INSERT INTO doc_content (doc_id,content,page_num) VALUES (2,'<IMG height=104 src=\"upfile/webeditimg/2006/8/528e140122ca4930a85d31ca942a0ab3.jpg\" width=879>',1)";
jt.addBatch(sql);
sql = "INSERT INTO doc_content (doc_id,content,page_num) VALUES (3,'<IMG height=104 src=\"upfile/webeditimg/2006/8/96ede6606c104816bc9f7a6722929a9c.jpg\" width=879>',1)";
jt.addBatch(sql);
sql = "INSERT INTO document (id,keywords,isrelateshow,title,class1,author,modifiedDate,can_comment,summary,isHome,voteoption,voteresult,type,examine,nick,hit,template_id,page_count,parent_code,isNew,flowTypeCode) VALUES (1,'ad',1,'公告旁的广告','blog_ad1','admin','2006-08-30',1,NULL,0,'','',0,0,'admin',23,-1,1,'blog_ad',0,'')";
jt.addBatch(sql);
sql = "INSERT INTO document (id,keywords,isrelateshow,title,class1,author,modifiedDate,can_comment,summary,isHome,voteoption,voteresult,type,examine,nick,hit,template_id,page_count,parent_code,isNew,flowTypeCode) VALUES (2,'ad',1,'首页中部横幅','blog_ad2','admin','2006-08-30',1,NULL,0,'','',0,0,'admin',0,-1,1,'blog_ad',0,'')";
jt.addBatch(sql);
sql = "INSERT INTO document (id,keywords,isrelateshow,title,class1,author,modifiedDate,can_comment,summary,isHome,voteoption,voteresult,type,examine,nick,hit,template_id,page_count,parent_code,isNew,flowTypeCode) VALUES (3,'',1,'首页底部横幅','blog_ad3','admin','2006-08-30',1,NULL,0,'','',0,0,'admin',0,-1,1,'blog_ad',0,'')";
jt.addBatch(sql);

sql = "delete from redmoonid";
jt.addBatch(sql);

sql = "INSERT INTO redmoonid (idType,id) VALUES (0,5)";
jt.addBatch(sql);

for (int k=1; k<=38; k++) {
	sql = "INSERT INTO redmoonid (idType,id) VALUES (" + k + ",1)";
	jt.addBatch(sql);
}

sql = "delete from sq_id";
jt.addBatch(sql);

sql = "INSERT INTO sq_id (idType,id) VALUES (0,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (1,5)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (2,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (3,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (4,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (5,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (6,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (7,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (8,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (9,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (10,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (11,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (12,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (13,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (14,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (15,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (16,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (17,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (18,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (19,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (20,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (21,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (22,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (23,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (24,1)";
jt.addBatch(sql);
sql = "INSERT INTO sq_id (idType,id) VALUES (25,1)";
jt.addBatch(sql);

sql = "INSERT INTO cms_images (id,path,mainkey,kind,subkey) VALUES (10,'upfile/webeditimg/2006/8/2357ddd8a4354a8b82292978ec6821f6.jpg','1','document',1)";
jt.addBatch(sql);
sql = "INSERT INTO cms_images (id,path,mainkey,kind,subkey) VALUES (11,'upfile/webeditimg/2006/8/528e140122ca4930a85d31ca942a0ab3.jpg','2','document',1)";
jt.addBatch(sql);
sql = "INSERT INTO cms_images (id,path,mainkey,kind,subkey) VALUES (12,'upfile/webeditimg/2006/8/96ede6606c104816bc9f7a6722929a9c.jpg','3','document',1)";
jt.addBatch(sql);

sql = "delete from sq_images";
jt.addBatch(sql);

sql = "delete from link";
jt.addBatch(sql);

// 短消息
sql = "delete from message";
jt.addBatch(sql);

//清除短信发送记录
sql = "delete from sms_record";
jt.addBatch(sql);

sql = "delete from sq_forbid_ip";
jt.addBatch(sql);

sql = "delete from sq_poll";
jt.addBatch(sql);

sql = "delete from sq_poll_option";
jt.addBatch(sql);

sql = "delete from sq_forbid_ip_range";
jt.addBatch(sql);

//清除调度策略
sql = "delete from scheduler";
jt.addBatch(sql);

// 插件2
sql = "delete from plugin2_alipay";
jt.addBatch(sql);

sql = "delete from plugin_info";
jt.addBatch(sql);

// sq
sql = "delete from sq_board_entrance";
jt.addBatch(sql);

sql = "delete from sq_board_score";
jt.addBatch(sql);

sql = "delete from sq_boardmanager";
jt.addBatch(sql);

sql = "delete from sq_friend";
jt.addBatch(sql);

sql = "delete from sq_master";
jt.addBatch(sql);

sql = "delete from sq_message_attach";
jt.addBatch(sql);

sql = "delete from sq_thread";
jt.addBatch(sql);

sql = "delete from sq_message";
jt.addBatch(sql);

sql = "delete from sq_online";
jt.addBatch(sql);

sql = "delete from sq_roomemcee";
jt.addBatch(sql);

sql = "delete from sq_user";
jt.addBatch(sql);

sql = "insert into sq_user (name,regDate,nick,realPic) values ('admin', '1157098314031','admin','face.gif')";
jt.addBatch(sql);

sql = "delete from sq_user_priv";
jt.addBatch(sql);

sql = "delete from sq_user_group_priv";
jt.addBatch(sql);

sql = "delete from sq_user_treasure";
jt.addBatch(sql);

//清除论坛广告和通知
sql = "update sq_forum set notices='',ad_topic_bottom='',yestodayCount=0";
jt.addBatch(sql);

out.print("清空用户组信息<BR>");
sql = "delete from sq_user_group";
jt.addBatch(sql);

sql = "insert into sq_user_group values ('everyone','所有人',1,1)";
jt.addBatch(sql);

jt.executeBatch();

out.print("清空论坛统计信息<BR>");

ForumDb forum = new ForumDb();
forum.setTopicCount(0);
forum.setPostCount(0); 
forum.setUserCount(0);
forum.setUserNew("");
forum.setUserCount(0);
forum.setMaxCount(0);
forum.setMaxDate(null);
forum.setMaxOnlineCount(0);
forum.setMaxOnlineDate(null);
forum.setTodayCount(0);
forum.save();

out.print("清空版块统计<BR>");

LeafChildrenCacheMgr dlcm = new LeafChildrenCacheMgr("root");
java.util.Vector vt = dlcm.getChildren();
Iterator ir = vt.iterator();
while (ir.hasNext()) {
	Leaf leaf = (Leaf) ir.next();
	String parentCode = leaf.getCode();

	LeafChildrenCacheMgr dl = new LeafChildrenCacheMgr(parentCode);
	java.util.Vector v = dl.getChildren();
	Iterator ir1 = v.iterator();
	while (ir1.hasNext()) {
		Leaf lf = (Leaf) ir1.next();
		lf.setPostCount(0);
		lf.setTopicCount(0);
		lf.setTodayCount(0);
		lf.update();
	}
}

out.print("删除文件夹upfile<BR>");
cn.js.fan.util.file.FileUtil.del(application.getRealPath("/") + "upfile");
cn.js.fan.util.file.FileUtil.del(application.getRealPath("/") + "forum/upfile");

out.print("刷新缓存<BR>");
cn.js.fan.cache.jcs.RMCache rmcache = cn.js.fan.cache.jcs.RMCache.getInstance();
rmcache.clear();
%><title>清空数据</title>
清空操作结束！