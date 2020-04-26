<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<html>
<head>
<title>签名</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style4 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000" style="background-image:url()">
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

// 窗口不能做成模式对话框，因为form及location.href都会弹出新窗口
String op = ParamUtil.get(request, "op");
if (op.equals("sign")) {
	String pwd = ParamUtil.get(request, "pwd");
	UserDb ud = new UserDb();
	ud = ud.getUserDb(privilege.getUser(request));
	if (ud.getPwdRaw().equals(pwd)) {
	%>
		<script>
		window.opener.setIntpuObjValue("<%=ud.getRealName() + "   " + cn.js.fan.util.DateUtil.format(new java.util.Date(), "yyyy年MM月dd日")%>");
		window.close();
		</script>
	<%
		return;
	}
	else {
		out.print(StrUtil.Alert("密码错误！"));
	}
}
%>
<table width="100%" cellPadding="0" cellSpacing="0">
  <tbody>
    <tr>
      <td height="28" class="right-title">&nbsp;请输入密码</td>
    </tr>
  <form name="form1" action="?op=sign" method="post">
    <tr>
      <td height="40" align="center" bgcolor="#FFFFFF" class="head">
	  <input name="pwd" type="password">
	  &nbsp;&nbsp;
        <input type="submit" value="签名"></td></tr>
  </form>
</table>
</body>
</html>