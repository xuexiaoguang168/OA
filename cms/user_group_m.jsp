<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="cn.js.fan.web.*"%>
<html>
<head>
<title>管理登录</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
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
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="usergroupmgr" scope="page" class="com.redmoon.oa.pvg.UserGroupMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN))
{
	out.println(StrUtil.makeErrMsg(privilege.MSG_INVALID,"red","green"));
	return;
}
%>
<%
String op = StrUtil.getNullString(request.getParameter("op"));
if (op.equals("add")) {
	try {
		if (usergroupmgr.add(request))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("del")) {
	if (usergroupmgr.del(request))
		out.print(StrUtil.Alert("删除成功！"));
	else
		out.print(StrUtil.Alert("删除失败！"));
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理用户组</td>
    </tr>
  </tbody>
</table>
<%
String code;
String desc;
UserGroup ugroup = new UserGroup();
Vector result = ugroup.list();
Iterator ir = result.iterator();
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="21%">名称</td>
      <td class="thead" noWrap width="31%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
      <td class="thead" noWrap width="13%">系统保留</td>
      <td width="35%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
while (ir.hasNext()) {
 	UserGroup ug = (UserGroup)ir.next();
	code = ug.getCode();
	desc = ug.getDesc();
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="user_group_op.jsp?op=edit&code=<%=StrUtil.UrlEncode(code)%>"><%=code%></a></td>
      <td><a href="user_group_op.jsp?op=edit&code=<%=StrUtil.UrlEncode(code)%>"><%=desc%></a></td>
      <td><%=ug.isSystem()?"是":"否"%></td>
      <td>
	  <a href="user_group_op.jsp?op=edit&code=<%=StrUtil.UrlEncode(code)%>">[ 编辑 ]</a> 
	  [ <a href="user_group_priv.jsp?group_code=<%=StrUtil.UrlEncode(code)%>&desc=<%=StrUtil.UrlEncode(desc)%>">权限</a> ] [ <a href="user_m.jsp?group_code=<%=StrUtil.UrlEncode(code)%>">用户</a> ]
	  <%if (!ug.isSystem()) {%>
[ <a onClick="if (!confirm('您确定要删除吗？确定后将删除所有的与之相关的权限！')) return false" href="user_group_m.jsp?op=del&code=<%=StrUtil.UrlEncode(code)%>">删除</a> ]
<%}%></td>
    </tr>
<%}%>
  </tbody>
</table>
<HR noShade SIZE=1>
<DIV style="WIDTH: 95%" align=right>
  <INPUT 
onclick="javascript:location.href='user_group_op.jsp';" type=image 
height=20 width=80 src="images/btn_add.gif">
</DIV>
</body>
<script language="javascript">
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.pwd.value!=form1.pwd_confirm.value)
		errmsg += "密码与确认密码不致，请检查！\n"
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}
//-->
</script>
</html>