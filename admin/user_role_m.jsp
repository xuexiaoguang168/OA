<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>管理角色</title>
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
<jsp:useBean id="roleMgr" scope="page" class="com.redmoon.oa.pvg.RoleMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.role")) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String op = StrUtil.getNullString(request.getParameter("op"));
if (op.equals("add")) {
	try {
		if (roleMgr.add(request))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("del")) {
	if (roleMgr.del(request))
		out.print(StrUtil.Alert("删除成功！"));
	else
		out.print(StrUtil.Alert("删除失败！"));
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理角色</td>
    </tr>
  </tbody>
</table>
<%
String code;
String desc;
RoleDb roleDb = new RoleDb();
Vector result = roleDb.list();
Iterator ir = result.iterator();
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="8%">顺序</td>
      <td class="thead" noWrap width="25%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
      <td class="thead" noWrap width="10%"><span class="thead" style="PADDING-LEFT: 10px"><img src="images/tl.gif" align="absMiddle" width="10" height="15"></span>系统保留</td>
      <td width="31%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
while (ir.hasNext()) {
 	RoleDb rd = (RoleDb)ir.next();
	code = rd.getCode();
	desc = rd.getDesc();
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px"><%=rd.getOrders()%></td>
      <td><a href="user_role_op.jsp?op=edit&code=<%=StrUtil.UrlEncode(code)%>"><%=desc%></a></td>
      <td><%=rd.isSystem()?"是":"否"%></td>
      <td>
	  <a href="user_role_op.jsp?op=edit&code=<%=StrUtil.UrlEncode(code)%>">[ 编辑 ]</a> 
	  [ <a href="user_role_priv.jsp?roleCode=<%=StrUtil.UrlEncode(code)%>&desc=<%=StrUtil.UrlEncode(desc)%>">权限</a> ] [ <a href="user_role_user.jsp?role_code=<%=StrUtil.UrlEncode(code)%>">用户</a> ]
	  <%if (!rd.isSystem()) {%>
[ <a onClick="if (!confirm('您确定要删除吗？确定后将删除所有的与之相关的权限！')) return false" href="?op=del&code=<%=StrUtil.UrlEncode(code)%>">删除</a> ]
<%}%></td>
    </tr>
<%}%>
  </tbody>
</table>
<HR noShade SIZE=1>
<DIV style="WIDTH: 95%" align=right>
  <INPUT 
onclick="javascript:location.href='user_role_op.jsp';" type=image 
height=20 width=80 src="images/btn_add.gif">
</DIV>
</body>
<script language="javascript">
<!--
//-->
</script>
</html>