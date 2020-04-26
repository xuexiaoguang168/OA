<%@ page contentType="text/html;charset=utf-8"
import = "java.io.File"
import="com.redmoon.forum.*"
import="cn.js.fan.util.*"
%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.util.ErrMsgException" %>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();

String delid = request.getParameter("delid");
if (delid==null || !StrUtil.isNumeric(delid))
{
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, SkinUtil.ERR_ID)));
	return;
}
long id = Long.parseLong(delid);
MsgMgr msgMgr = new MsgMgr();
MsgDb md = msgMgr.getMsgDb(id);
%>
<html>
<head>
<title><lt:Label res="res.label.forum.deltopic" key="deltopic"/> - <%=Global.AppName%></title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%if (!md.isBlog()) {%>
<%@ include file="inc/header.jsp"%>
<%}%>
<%
String privurl = ParamUtil.get(request, "privurl");
String boardcode = StrUtil.getNullString(request.getParameter("boardcode"));
try {
boolean re = msgMgr.delTopic(application, request, id);
if (re) {
	if (md.isBlog()) {
		if (privurl.equals(""))
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "../blog/user/listtopic.jsp"));	
		else
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), privurl));	
		return;
	}
	else {
%>
		<ol><lt:Label res="res.label.forum.deltopic" key="del_success"/></ol>
<%
		if (md.getReplyid()!=-1) {
			out.println(StrUtil.waitJump("<a href='"+privurl+"'>" + SkinUtil.LoadString(request, "res.label.forum.deltopic", "go_back") + "</a>",3,privurl));
			out.println("<ol><a href='listtopic.jsp?boardcode=" + StrUtil.UrlEncode(md.getboardcode()) + "'>" + SkinUtil.LoadString(request, "res.label.forum.deltopic", "back_to_bard") + "</a></ol>");
		}
		else {
			privurl = "listtopic.jsp?boardcode=" + StrUtil.UrlEncode(md.getboardcode());
			out.println(StrUtil.waitJump("<a href='listtopic.jsp?boardcode=" + StrUtil.UrlEncode(md.getboardcode()) + "'>" + SkinUtil.LoadString(request, "res.label.forum.deltopic", "back_to_bard") + "</a>",3,privurl));
		}
	}
} else {%>
<p align=center><lt:Label key="info_op_fail"/></p>
<%}
}
catch (ErrMsgException e) {
	out.print(SkinUtil.makeErrMsg(request, e.getMessage()));
}
%>
<%if (!md.isBlog()) {%>
<%@ include file="inc/footer.jsp"%>
<%}%>
</body>
</html>


