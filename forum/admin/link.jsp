<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.nav.*"%>
<%@ page import="cn.js.fan.module.pvg.*" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><lt:Label res="res.label.forum.admin.link" key="link_manage"/></title>
<link href="default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style4 {
	color: #FFFFFF;
	font-weight: bold;
}
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
LinkMgr lm = new LinkMgr();
LinkDb ld = new LinkDb();
String userName = ld.USER_SYSTEM;

String op = StrUtil.getNullString(request.getParameter("op"));

if (op.equals("add")) {
	try {
		if (lm.add(application, request))
			out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("edit")) {
	try {
		if (lm.modify(application, request))
			out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
if (op.equals("move")) {
	try {
		if (lm.move(request))
			out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("del")) {
	if (lm.del(application, request))
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	else
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_del")));
}

if (userName.equals("")) {
	userName = StrUtil.getNullString(lm.getUserName());
	if (userName.equals("")) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "res.label.forum.admin.link", "user_name_empty")));
		return;
	}
}

String user = privilege.getUser(request);
if (!userName.equals(user)) {
	if (!privilege.isMasterLogin(request)) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head"><lt:Label res="res.label.forum.admin.link" key="link_manage"/></td>
    </tr>
  </tbody>
</table>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="21%"><lt:Label res="res.label.forum.admin.link" key="name"/></td>
      <td class="thead" noWrap width="22%"><img src="images/tl.gif" align="absMiddle" width="10" height="15"><lt:Label res="res.label.forum.admin.link" key="link"/></td>
      <td class="thead" noWrap width="30%"><lt:Label res="res.label.forum.admin.link" key="image"/></td>
      <td width="27%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15"><lt:Label key="op"/></td>
    </tr>
<%
String sql = "select id from " + ld.getTableName() + " where userName=" + StrUtil.sqlstr(userName) + " and kind=" + StrUtil.sqlstr(ld.KIND_DEFAULT) + " order by sort";
Iterator ir = ld.list(sql).iterator();
int i=100;
while (ir.hasNext()) {
	i++;
 	ld = (LinkDb)ir.next();
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
	  <form name="form<%=i%>" action="?op=edit" method="post" enctype="MULTIPART/FORM-DATA">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<input name=title value="<%=ld.getTitle()%>"></td>
      <td><input name=url value="<%=ld.getUrl()%>" size="30"></td>
      <td>
        <input name="filename" type="file" style="width: 200px">
		</td>
      <td>
	  [ <a href="javascript:form<%=i%>.submit()"><lt:Label key="op_edit"/></a> ] [ <a onClick="if (!confirm('<lt:Label key="confirm_del"/>')) return false" href="?op=del&id=<%=ld.getId()%>&kind=<%=ld.KIND_SHOP%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label key="op_del"/></a> ] [<a href="?op=move&direction=up&id=<%=ld.getId()%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.forum.admin.link" key="move_up"/></a>] [<a href="?op=move&direction=down&id=<%=ld.getId()%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.forum.admin.link" key="move_down"/></a>] 
	  <input name="id" value="<%=ld.getId()%>" type="hidden">
	  <input name="userName" value="<%=ld.USER_SYSTEM%>" type="hidden">
	  <input name="kind" value="<%=ld.KIND_DEFAULT%>" type="hidden">
	  </td>
	  </form>
    </tr>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td colspan="4" style="PADDING-LEFT: 10px">
	  <%if (ld.getImage()==null || ld.getImage().equals("")) {%>
	  <%}else{%>
	  <img src="<%=request.getContextPath()+"/"+ld.getImage()%>">
	  <%}%>
	  </td>
    </tr>
<%}%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
	<form action="?op=add" method="post" enctype="multipart/form-data" name="addform1">
      <td style="PADDING-LEFT: 10px">
	  &nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;
	  <input name=title value="" size="15"></td>
      <td><input name=url value="" size="30"></td>
      <td><span class="stable">
        <input type="file" name="filename" style="width: 200px">
      </span></td>
      <td><INPUT type=submit height=20 width=80 value="<lt:Label key="op_add"/>">
        <input name="userName" value="<%=ld.USER_SYSTEM%>" type="hidden">
        <input name="kind" value="<%=ld.KIND_DEFAULT%>" type="hidden">
        </td>
	</form>
    </tr>
    <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
      <td colspan="4" style="PADDING-LEFT: 10px"><lt:Label res="res.label.forum.admin.link" key="howto_del"/></td>
    </tr>
  </tbody>
</table>
</body>
</html>