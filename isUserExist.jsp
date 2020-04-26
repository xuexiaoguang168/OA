<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="cn.js.fan.util.*"%>
<html>
<head>
<title>查询用户是否存在</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="inc/nocache.jsp"%>
<link rel="stylesheet" href="common.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="user" scope="page" class="com.redmoon.oa.person.UserDb"/>
<%
boolean re = false;
re = user.isExist(ParamUtil.get(request, "name"));
if (!re)
	out.print("<BR><p align=center>该用户名不存在,您可以注册!</p>");
else
	out.print("<BR><p align=center>该用户名已存在！</p>");
%>
</body>
</html>