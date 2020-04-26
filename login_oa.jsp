<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.chat.ChatClient"%>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.Properties" %>
<html>
<head>
<title>登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="inc/nocache.jsp"%>
<link rel="stylesheet" href="common.css" type="text/css">
<script language=javascript>
<!--
function openWin(target) {
	var newwin = window.open("","","toolbar=yes, menubar=yes, scrollbars=no, resizable=no,status=yes")
	if (document.all){
		newwin.moveTo(0,0)
		newwin.resizeTo(800,575)
		newwin.location=target
		opener=null;//用'popo'也可以不弹出提示关闭窗口;
		window.close();
	}
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
boolean re = false;
try{
	re = privilege.login(request, response);
}
catch(WrongPasswordException e){
	out.println(fchar.makeErrMsg("登录错误："+e.getMessage()));
}
catch (InvalidNameException e) {
	out.println(fchar.makeErrMsg("登录错误："+e.getMessage()));
}
catch (ErrMsgException e) {
	out.println(fchar.makeErrMsg("登录错误："+e.getMessage()));
}
%>
</body>
<%
if (re) {
%>
<script language="JavaScript">
<!--
//newwin = window.open('2.htm', '', 'height=475, width=800, top=0, left=0, toolbar=yes, menubar=yes, scrollbars=no, resizable=no,location=no, status=yes');
//openWin("oa.jsp",800,600);
//newwin = window.open('2.htm', 'd', 'height=475, width=800, top=0, left=0, toolbar=yes, menubar=yes, scrollbars=no, resizable=no,location=no, status=yes');
//newwin.moveTo(0,0)
//newwin.resizeTo(800,575)
//opener=null;//用'popo'也可以不弹出提示关闭窗口;
//window.close();
window.location.href="oa.jsp";
//-->
</script>
<%	
}
else {
	out.print( StrUtil.Alert_Back( "登录失败！" ) );
}
%>
</html>