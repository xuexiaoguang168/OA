<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<html>
<head>
<title>意见</title>
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
if (op.equals("idea")) {
	String idea = ParamUtil.get(request, "idea");
	UserDb ud = new UserDb();
	ud = ud.getUserDb(privilege.getUser(request));
	String str = "\r\n\r\n" + idea + "\r\n                                     " + ud.getRealName() + "   " + cn.js.fan.util.DateUtil.format(new java.util.Date(), "yyyy年MM月dd日");
	%>
		<textarea name="idea" style="display:none"><%=str%></textarea>
		<script>
		window.opener.setIntpuObjValue(idea.value);
		window.close();
		</script>
	<%
}
%>
<table width="100%" cellPadding="0" cellSpacing="0">
  <tbody>
    <tr>
      <td height="28" class="right-title">&nbsp;请输入意见</td>
    </tr>
  <form name="form1" action="?op=idea" method="post">
    <tr>
      <td height="20" align="center" bgcolor="#FFFFFF" class="head">&nbsp;</td></tr>
    <tr>
      <td height="20" align="center" bgcolor="#FFFFFF" class="head"><textarea name="idea" cols="50" rows="8"></textarea>
&nbsp;&nbsp; <br>
<input name="submit" type="submit" value=" 确 定 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="submit2" type="button" value=" 取 消 " onClick="window.close()"></td>
    </tr>
  </form>
</table>
</body>
</html>