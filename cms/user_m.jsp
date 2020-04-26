<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*" %>
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
<jsp:useBean id="usermgr" scope="page" class="com.redmoon.oa.pvg.UserMgr"/>
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
		if (usermgr.add(request))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("del")) {
	try {
		if (usermgr.del(request))
			out.print(StrUtil.Alert("删除成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理用户</td>
    </tr>
  </tbody>
</table>
<%
String groupCode = ParamUtil.get(request, "group_code").trim();
String sql = "select name,realname,description from users order by name";
if (!groupCode.equals("")) {
	sql = "select u.name,u.realname,u.description from users as u,user_of_group as g where g.group_code=" + StrUtil.sqlstr(groupCode) + " and g.user_name=u.name";
}
RMConn rmconn = new RMConn(Global.defaultDB);
ResultIterator ri = rmconn.executeQuery(sql);
ResultRecord rr = null;
String name;
String realname;
String desc;
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="19%">用户名</td>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="22%">真实姓名</td>
      <td class="thead" noWrap width="42%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
      <td width="17%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
    <%
while (ri.hasNext()) {
 	rr = (ResultRecord)ri.next();
	name = rr.getString(1);
	realname = rr.getString(2);
	desc = rr.getString(3);
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>"><%=name%></a></td>
      <td style="PADDING-LEFT: 10px">&nbsp;&nbsp;<a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>"><%=realname%></a></td>
      <td><a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>"><%=realname%></a></td>
      <td><a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>">[ 编辑 ]</a> [ <a onClick="if (!confirm('您确定要删除吗？')) return false" href="user_m.jsp?op=del&name=<%=StrUtil.UrlEncode(name)%>">删除</a> ] </td>
    </tr>
    <%}%>
  </tbody>
</table>
<HR noShade SIZE=1>
<DIV style="WIDTH: 95%" align=right>
  <INPUT 
onclick="javascript:location.href='user_op.jsp';" type=image 
height=20 width=80 src="images/btn_add.gif">
</DIV>
</body>
</html>