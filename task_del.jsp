<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*" %>
<html>
<head>
<title>删除任务项</title>
<%@ include file="inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="common.css" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="task" scope="page" class="com.redmoon.oa.task.TaskMgr"/>
<br>
<%
int delid = ParamUtil.getInt(request, "delid");
int rootid = ParamUtil.getInt(request, "rootid");
String privurl = "task_show.jsp?rootid=" + rootid + "&showid=" + rootid;
try {
	if (task.del(request,delid)) {
	%>
		<BR><ol>删除成功！</ol>
	<%
		out.println(fchar.waitJump("<a href='task.jsp'>返回！</a>",3, privurl));
	} else {%>
		<p align=center>删除失败！</p>
	<%}
}
catch (ErrMsgException e) {
	out.print(fchar.makeErrMsg(e.getMessage()));
}
%>
</body>
</html>


