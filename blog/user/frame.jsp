<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<%
String str = SkinUtil.LoadString(request,"res.label.blog.user.frame", "title");
str = StrUtil.format(str, new Object[] {Global.AppName});
%>
<HTML><HEAD><TITLE><%=str%></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.3790.259" name=GENERATOR></HEAD>
<jsp:useBean id="strutil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isUserLogin(request))
{
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "err_not_login")));
	return;
}
String userName = ParamUtil.get(request, "userName");
if (userName.equals("")) {
	out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "not_name_frame")));
	return;
}
UserConfigDb as = new UserConfigDb();
as = as.getUserConfigDb(userName);
if (!as.isLoaded())
{
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "activate_blog_fail")));
	return;
}
String user = privilege.getUser(request);
if (!userName.equals(user)) {
	if (!privilege.isMasterLogin(request)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, SkinUtil.PVG_INVALID)));
		return;
	}
}
%>
<FRAMESET border=0 
frameSpacing=0 rows=49,* frameBorder=NO cols=*><FRAME name=topFrame 
src="top.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" noResize scrolling=no><FRAMESET 
border=0 frameSpacing=0 rows=* frameBorder=NO cols=198,*><FRAME name=leftFrame 
src="menu.jsp" 
noResize scrolling=yes><FRAME name=mainFrame 
src="listtopic.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" 
scrolling=yes></FRAMESET></FRAMESET><noframes></noframes></HTML>
