<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="cn.js.fan.util.ParamUtil"%>
<%@ page import="com.redmoon.forum.person.*"%>
<html>
<head>
<title>����û���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%@ include file="inc/nocache.jsp"%>
<link rel="stylesheet" href="common.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="inc/inc.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice"/>
<%
boolean re = false;
try{
	String regName = ParamUtil.get(request, "RegName");
	re = userservice.isRegNameExist(request, regName);
}
catch(cn.js.fan.util.ErrMsgException e){
	out.println("<BR>&nbsp;<B>" + e.getMessage() + "</B>");
	return;
}
if (!re)
	out.print("<BR>&nbsp;<B>���û���������,������ע��!</B>");
else
	out.print("<BR>&nbsp;<B><font color=red>�Բ��𣬸��û����Ѵ���!</font></B>");
%>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>