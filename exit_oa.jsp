<%@ page contentType="text/html;charset=utf-8"
import = "cn.js.fan.util.ErrMsgException"
%>
<%@ page import="java.util.Calendar" %>
<html>
<head>
<title>退出</title>
<LINK href="common.css" type=text/css rel=stylesheet>
<%@ include file="inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege" />
<%
privilege.logout(request, response);
String iskicked = request.getParameter("iskicked");
if (iskicked!=null)
	out.print(fchar.p_center("您已被踢出讨论室！"));
else
	out.print(fchar.Alert("您已安全退出"));
%>
</body>
<script language=javascript>
<!--
window.top.location.href = "index.jsp";
// window.top.close();
//-->
</script>
</html>


