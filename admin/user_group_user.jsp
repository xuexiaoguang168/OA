<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*" %>
<html>
<head>
<title>管理用户</title>
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
<script>
var selUserNames = "";
var selUserRealNames = "";

function getSelUserNames() {
	return selUserNames;
}

function getSelUserRealNames() {
	return selUserRealNames;
}

function openWinUsers() {
	selUserNames = form1.users.value;
	selUserRealNames = form1.userRealNames.value;
	showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:600px;dialogHeight:480px;status:no;help:no;')
}

function setUsers(users, userRealNames) {
	form1.users.value = users;
	form1.userRealNames.value = userRealNames;
}

</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String op = StrUtil.getNullString(request.getParameter("op"));
String groupCode = ParamUtil.get(request, "group_code").trim();
String sql = "select name,realname,gender from users order by name";

String strWhat = "";
if (!groupCode.equals("")) {
	sql = "select u.name,u.realName,u.gender from users u,user_of_group g where g.group_code=" + StrUtil.sqlstr(groupCode) + " and g.user_name=u.name";
	UserGroupDb ugd = new UserGroupDb();
	ugd = ugd.getUserGroupDb(groupCode);
	strWhat = ugd.getDesc();
}

if (op.equals("add")) {
	String userNames = ParamUtil.get(request, "users");
	String[] users = StrUtil.split(userNames, ",");
	if (users==null) {
		out.print(StrUtil.Alert_Back("请选择用户！"));
		return;
	}
	else {
		UserGroupDb ugd = new UserGroupDb();
		ugd.addUsers(groupCode, users);
		out.print(StrUtil.Alert_Redirect("操作成功！", "user_group_user.jsp?group_code=" + StrUtil.UrlEncode(groupCode)));
		return;
	}
}

if (op.equals("del")) {
	String userName = ParamUtil.get(request, "userName");
	UserGroupDb ugd = new UserGroupDb();
	boolean re = ugd.delUser(groupCode, userName);
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "user_group_user.jsp?group_code=" + StrUtil.UrlEncode(groupCode)));
	else {
		out.print(StrUtil.Alert_Back("操作失败！"));
		return;
	}
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理<%=strWhat%>用户</td>
    </tr>
  </tbody>
</table>
<%
RMConn rmconn = new RMConn(Global.defaultDB);
ResultIterator ri = rmconn.executeQuery(sql);
ResultRecord rr = null;
String name;
String realname;
String genderdesc;
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="19%">用户名</td>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="22%">真实姓名</td>
      <td class="thead" noWrap width="42%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">性别</td>
      <td width="17%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
    <%
String userNames = "";
String userRealNames = "";	
while (ri.hasNext()) {
 	rr = (ResultRecord)ri.next();
	name = rr.getString(1);
	realname = rr.getString(2);
	if (userNames.equals("")) {
		userNames = name;
		userRealNames = realname;
	}
	else {
		userNames += "," + name;
		userRealNames += "," + realname;
	}

	genderdesc = rr.getInt(3)==0?"男":"女";
%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>"><%=name%></a></td>
      <td style="PADDING-LEFT: 10px"><a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>"><%=realname%></a></td>
      <td><a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>"><%=genderdesc%></a></td>
      <td><a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(name)%>">[ 管理 ]</a>&nbsp;&nbsp;[ <a href="user_group_user.jsp?op=del&group_code=<%=StrUtil.UrlEncode(groupCode)%>&userName=<%=StrUtil.UrlEncode(name)%>">删除</a> ]</td>
    </tr>
<%}%>
  </tbody>
</table>
<HR noShade SIZE=1>
<table width="80%" border="0" align="center">
<form name="form1" action="user_group_user.jsp?op=add" method="post">
  <tr>
    <td align="center"><input name="users" id="users" type="hidden" value="">
	<input name="group_code" type="hidden" value="<%=groupCode%>">
        <textarea name="userRealNames" cols="75" rows="5" readonly wrap="yes" id="userRealNames"></textarea>
        <span class="TableData">
        <input class="SmallButton" title="添加收件人" onClick="openWinUsers()" type="button" value="添 加" name="button2">
         &nbsp;
         <input class="SmallButton" title="清空收件人" onClick="form1.users.value='';form1.userRealNames.value=''" type="button" value="清 空" name="button">
      </span></td>
  </tr>
  <tr>
    <td align="center"><input name="submit" type="submit" value="确定"></td>
  </tr>
 </form>
</table>
</body>
</html>