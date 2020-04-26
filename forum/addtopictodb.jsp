<%@ page contentType="text/html;charset=utf-8"
import = "java.io.File"
import = "cn.js.fan.util.ErrMsgException"
%>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.redmoon.forum.person.UserSet"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="form" scope="page" class="cn.js.fan.security.Form" />
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
boolean isSuccess = false;
String privurl = "";

boolean cansubmit = false;
com.redmoon.forum.Config cfg = new com.redmoon.forum.Config();
int interval = cfg.getIntProperty("forum.addMsgInterval");
int maxtimespan = interval;
try {
	cansubmit = form.cansubmit(request, "addtopic", maxtimespan);// 防止重复刷新	
}
catch (ErrMsgException e) {
	out.println(StrUtil.Alert_Back(e.getMessage()));
	return;
}
%>
<jsp:useBean id="Topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<%
String boardcode = "";
long id = -1;
if (cansubmit) {
	try {
		isSuccess = Topic.AddNew(application, request);
		privurl = Topic.getprivurl();
		boardcode = Topic.getCurBoardCode();
		id = Topic.getId();
	}
	catch (ErrMsgException e) {
		out.println(StrUtil.Alert_Back(e.getMessage()));
		return;
	}
}

if (Topic.isBlog()) {
	String addFlag = ParamUtil.get(request, "addFlag");
	// 说明是从博客用户管理后台发表的
	if (addFlag.equals("blog")) {
		MsgDb md = Topic.getMsgDb(Topic.getId());
		if (md.getCheckStatus()==MsgDb.CHECK_STATUS_NOT) {
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "res.label.forum.addtopic", "need_check"), "../blog/user/listtopic.jsp?userName=" + StrUtil.UrlEncode(Topic.getName())));			
		}
		else
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "../blog/user/listtopic.jsp?userName=" + StrUtil.UrlEncode(Topic.getName())));	
		return;
	}
	// 是从论坛发贴时选择博客目录发表的
	if (boardcode.equals(Leaf.CODE_BLOG)) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "showblog.jsp?rootid=" + id));	
		return;
	}
}
%>
<%
// 取得皮肤路径
Leaf lf = new Leaf();
lf = lf.getLeaf(boardcode);
String skincode = lf.getSkin();
if (skincode.equals(UserSet.defaultSkin)) {
	skincode = UserSet.getSkin(request);
	if (skincode==null || skincode.equals(""))
		skincode = UserSet.defaultSkin;
}	
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
String skinPath = skin.getPath();
%>
<html>
<head>
<title><lt:Label res="res.label.forum.addtopic" key="addtopic"/> - <%=Global.AppName%></title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="inc/header.jsp"%>
<%
if (isSuccess)
{
%>
	<ol><lt:Label key="info_op_success"/></ol>
<%
	out.println(SkinUtil.waitJump(request, "<a href='showtopic.jsp?rootid="+id+"'>" + SkinUtil.LoadString(request, "res.label.forum.addtopic", "jump_to_topic") + "</a>",3,"showtopic.jsp?rootid=" + id));
	out.println("<ol><a href='"+privurl+"'>" + SkinUtil.LoadString(request, "info_back") + "</a></ol>");
	MsgDb md = Topic.getMsgDb(Topic.getId());
	if (md.getCheckStatus()==MsgDb.CHECK_STATUS_NOT) {
		out.println("<ol>" + SkinUtil.LoadString(request, "res.label.forum.addtopic", "need_check") + "</ol>");
	}
}%>
<%@ include file="inc/footer.jsp"%>
</body>
</html>


