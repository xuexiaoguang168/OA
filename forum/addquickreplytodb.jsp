<%@ page contentType="text/html;charset=utf-8"
import = "java.io.File"
import = "cn.js.fan.util.ErrMsgException"
import = "cn.js.fan.util.ParamUtil"
import="com.redmoon.forum.*"
%>
<%@ page import="cn.js.fan.web.Global" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.redmoon.forum.person.UserSet"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice" />
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="form" scope="page" class="cn.js.fan.security.Form" />
<%
boolean cansubmit = false;
com.redmoon.forum.Config cfg = new com.redmoon.forum.Config();
int interval = cfg.getIntProperty("forum.addMsgInterval");
int maxtimespan = interval;
try {
	cansubmit = form.cansubmit(request,"addtopic", maxtimespan);// 防止重复刷新	
}
catch (ErrMsgException e) {
	out.println(StrUtil.Alert_Back(e.getMessage()));
	return;
}

boolean isSuccess = false;
String privurl = "", boardcode="";
MsgDb md = new MsgDb();
MsgDb replyMsgDb = null;
try {
	MsgMgr msgMgr = new MsgMgr();
	privurl = request.getParameter("privurl");
	boardcode = request.getParameter("boardcode");
	long replyid = ParamUtil.getLong(request, "replyid");
	md = md.getMsgDb(replyid);
	isSuccess = msgMgr.AddQuickReply(application, request);
	replyMsgDb = msgMgr.getMsgDb(msgMgr.getId());
}
catch (ErrMsgException e) {
	out.println(StrUtil.Alert_Back(e.getMessage()));
	return;
}
%>
<%
// 取得皮肤路径
Leaf lf = new Leaf();
lf = lf.getLeaf(boardcode);
String skincode = lf.getSkin();
if (skincode.equals("") || skincode.equals(UserSet.defaultSkin)) {
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
<title><lt:Label res="res.label.forum.addreply" key="quick_reply"/> - <%=Global.AppName%></title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
//-->
</script>
<style type="text/css">
<!--
body {
	margin-top: 0px;
}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000">
<%if (!md.isBlog()) {%>
<%@ include file="inc/header.jsp"%>
<%}%>
<%
if (isSuccess)
{
	if (!md.isBlog()) {
		%>
		<ol><lt:Label key="info_op_success"/></ol>
		<%
		out.println(StrUtil.waitJump("<a href='"+privurl+"'>" + SkinUtil.LoadString(request, "res.label.forum.addreply", "back_to_priv") + "</a>",3,privurl));
		%>
		<ol><a href="listtopic.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>"><lt:Label res="res.label.forum.addreply" key="back_to_cur_board"/></a></ol>
		<%
		if (replyMsgDb.getCheckStatus()==MsgDb.CHECK_STATUS_NOT) {
			out.println("<ol>" + SkinUtil.LoadString(request, "res.label.forum.addtopic", "need_check") + "</ol>");
		}
		%>
	<%}else{
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), privurl));
	}
}%>
<%if (!md.isBlog()) {%>
<%@ include file="inc/footer.jsp"%>
<%}%>
</body>
</html>


