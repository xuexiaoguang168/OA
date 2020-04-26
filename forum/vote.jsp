<%@ page contentType="text/html;charset=utf-8"
import = "cn.js.fan.util.*"
import = "java.io.File"
import = "cn.js.fan.util.ErrMsgException"
%>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.redmoon.forum.Leaf" %>
<%@ page import="cn.js.fan.web.Global" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isUserLogin(request)) {
	out.println(StrUtil.Alert_Back(SkinUtil.LoadString(request, SkinUtil.ERR_NOT_LOGIN)));
	return;
}

UserPrivDb upd = new UserPrivDb();
upd = upd.getUserPrivDb(privilege.getUser(request));
if (!upd.getBoolean("vote")) {
	response.sendRedirect("../info.jsp?info= " + StrUtil.UrlEncode(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String boardcode = ParamUtil.get(request, "boardcode");
// 取得皮肤路径
Leaf lf = new Leaf();
lf = lf.getLeaf(boardcode);
if (lf==null) {
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, SkinUtil.ERR_ID)));
	return;
}
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
<title><lt:Label res="res.label.forum.vote" key="vote"/> - <%=Global.AppName%></title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="Topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<%
boolean isSuccess = false;
String privurl = request.getParameter("privurl");
try {
	isSuccess = Topic.vote(request);
}
catch (ErrMsgException e) {
	out.println(StrUtil.Alert_Back(e.getMessage()));
	return;
}
if (isSuccess)
{
%>
<ol><lt:Label res="res.label.forum.treasure" key="vote_success"/></ol>
<%
out.println(StrUtil.waitJump("<a href='"+privurl+"'>" + SkinUtil.LoadString(request, "res.label.forum.vote", "go_back") + "</a>",3,privurl));
}
else
{
%>
<ol><lt:Label res="res.label.forum.treasure" key="vote_fail"/></ol>
<%}%>
<%@ include file="inc/footer.jsp"%>
</body>
</html>


