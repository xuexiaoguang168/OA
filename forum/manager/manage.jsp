<%@ page contentType="text/html;charset=utf-8"
import = "java.io.File"
%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
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
%>
<html>
<head>
<title><lt:Label res="res.label.forum.manager" key="toptic_mgr"/></title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="topic" scope="page" class="com.redmoon.forum.MsgMgr"/>
<%
long id = ParamUtil.getLong(request, "id");

int value = ParamUtil.getInt(request, "value");
String privurl = request.getParameter("privurl");
String action = StrUtil.getNullString(request.getParameter("action"));
boolean re = false;
String boardcode = "";
try {
MsgDb md = new MsgDb();
md = md.getMsgDb(id);
boardcode = md.getboardcode();
if (action.equals("setOnTop"))
	re = topic.setOnTop(request,id,value);
if (action.equals("setLocked"))
	re = topic.setLocked(request,id,value);
if (action.equals("setElite"))
	re = topic.setElite(request,id,value);
//if (action.equals("setGuide"))
//	re = topic.setGuide(request,id,value);
if (re) {
%>
<ol><%=SkinUtil.LoadString(request,"info_operate_success")%></ol>
<%
out.println(StrUtil.waitJump("<a href='"+privurl+"'>" + SkinUtil.LoadString(request,"res.label.forum.manager","back_to_front_page") + "</a>",3,privurl));
} else {%>
<p align=center><%=SkinUtil.LoadString(request,"info_operate_fail")%></p>
<%}
}
catch (ErrMsgException e) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, e.getMessage()));
}
%>
<%@ include file="../inc/footer.jsp"%>
</body>
</html>


