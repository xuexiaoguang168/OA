<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
</head>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.post")) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<frameset cols="200,*" frameborder="NO" border="0" framespacing="0">
  <frame src="post_dept.jsp" name="leftFrame" >
  <frame src="post_main.jsp" name="midFrame">
</frameset>
<noframes><body>
</body></noframes>
</html>
