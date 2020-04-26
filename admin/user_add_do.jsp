<%@ page contentType="text/html;charset=utf-8"
import = "java.io.File"
import = "cn.js.fan.util.ErrMsgException"
%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Calendar" %>
<html>
<head>
<title>注册</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="usermgr" scope="page" class="com.redmoon.oa.person.UserMgr" />
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="admin.user";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

boolean isSuccess = false;
try {
	isSuccess = usermgr.add(request);
}
catch (ErrMsgException e) {
	out.println(fchar.Alert_Back("增加用户失败："+e.getMessage()));
}
if (isSuccess)
{
	out.println(fchar.waitJump("<li>增加用户成功！</li><li><a href='post_frame.jsp'>点击安排部门</a></li>", 3, "user_list.jsp"));
}
else
	out.println(fchar.Alert_Back("增加用户失败！"));
%>
</body>
</html>


