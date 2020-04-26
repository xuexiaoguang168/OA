<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<html>
<head>
<%
String userstr = SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "my_blog");
userstr = StrUtil.format(userstr, new Object[] {Global.AppName});
%>
<title><%=userstr%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="../../common.css" type=text/css rel=stylesheet>
</head>
<body>
<%
String op = ParamUtil.get(request, "op");
%>
<%if (op.equals("add")) {%>
<%@ include file="../../forum/inc/header.jsp"%>
<%}%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<p>&nbsp;</p>
<%
if (!privilege.isUserLogin(request)) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "err_not_login")));
	return;
}
String userName = privilege.getUser(request);
UserConfigDb ucd = new UserConfigDb();
ucd = ucd.getUserConfigDb(userName);
if (op.equals("add") && ucd.isLoaded()) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "activate_blog")));
	return;
}

if (op.equals("add")) {
	UserConfigMgr ucm = new UserConfigMgr();
	boolean re = false;
	try {
		re = ucm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
		return;
	}
	if (re) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "activate_success"), "../myblog.jsp?userName=" + StrUtil.UrlEncode(userName)));
	}
	else
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "activate_fail")));
}
if (op.equals("modify")) {
	UserConfigMgr ucm = new UserConfigMgr();
	boolean re = false;
	try {
		re = ucm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
		return;
	}
	if (re) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "userconfig_edit.jsp?userName=" + StrUtil.UrlEncode(userName)));
	}
	else
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "info_op_fail")));
}
%>
<%if (op.equals("add")) {%>
<%@ include file="../../forum/inc/footer.jsp"%>
<%}%>
</body>
</html>