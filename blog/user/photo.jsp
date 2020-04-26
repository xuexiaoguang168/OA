<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.photo.*"%>
<%@ page import="cn.js.fan.module.pvg.*" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<html>
<head>
<title><lt:Label res="res.label.blog.user.photo" key="title"/></title>
<link href="../../common.css" rel="stylesheet" type="text/css">
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
String userName = ParamUtil.get(request, "userName");

PhotoMgr lm = new PhotoMgr();
PhotoDb ld = new PhotoDb();

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
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_fail")));
}

if (userName.equals("")) {
	userName = StrUtil.getNullString(lm.getUserName());
	if (userName.equals("")) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.photo", "not_name")));
		return;
	}
}

String user = privilege.getUser(request);
if (!userName.equals(user)) {
	if (!privilege.isMasterLogin(request)) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.photo", "not_priv")));
		return;
	}
}
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="21%"><lt:Label res="res.label.blog.user.photo" key="name"/></td>
      <td class="thead" noWrap width="25%"><lt:Label res="res.label.blog.user.photo" key="pic"/></td>
      <td width="32%" noWrap class="thead"><lt:Label res="res.label.blog.user.photo" key="operate"/></td>
    </tr>
<%
String sql = "select id from " + ld.getTableName() + " where userName=" + StrUtil.sqlstr(userName) + " and kind=" + StrUtil.sqlstr(ld.KIND_USER_BLOG_PHOTO) + " order by sort";
Iterator ir = ld.list(sql).iterator();
int i=100;
while (ir.hasNext()) {
	i++;
 	ld = (PhotoDb)ir.next();
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
	  <form name="form<%=i%>" action="?op=edit" method="post" enctype="MULTIPART/FORM-DATA">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="../../forum/images/readme.gif" align="absmiddle">&nbsp;<input name=title value="<%=ld.getTitle()%>"></td>
      <td>
        <input name="filename" type="file" style="width: 200px">		</td>
      <td>
	  [ <a href="javascript:form<%=i%>.submit()"><lt:Label res="res.label.blog.user.photo" key="modify"/></a> ] [ <a onClick="if (!confirm('<lt:Label res="res.label.blog.user.photo" key="del_confirm"/>')) return false" href="?op=del&id=<%=ld.getId()%>&kind=<%=ld.KIND_USER_BLOG_PHOTO%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.user.photo" key="del"/></a> ] [<a href="?op=move&direction=up&id=<%=ld.getId()%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.user.photo" key="move_up"/></a>] [<a href="?op=move&direction=down&id=<%=ld.getId()%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.user.photo" key="move_down"/></a>] 
	  <input name="id" value="<%=ld.getId()%>" type="hidden">
	  <input name="userName" value="<%=userName%>" type="hidden">
	  <input name="kind" value="<%=ld.KIND_USER_BLOG_PHOTO%>" type="hidden">	  </td>
	  </form>
    </tr>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td colspan="3" style="PADDING-LEFT: 10px">
	  <%if (ld.getImage()==null || ld.getImage().equals("")) {%>
	  <%}else{%>
	  <img src="<%=request.getContextPath()+"/"+ld.getImage()%>">
	  <%}%>	  </td>
    </tr>
<%}%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
	<form action="?op=add" method="post" enctype="multipart/form-data" name="addform1">
      <td style="PADDING-LEFT: 10px">
	  &nbsp;<img src="../../forum/images/readme.gif" align="absmiddle">&nbsp;
	  <input name=title value="" size="15"></td>
      <td><span class="stable">
        <input type="file" name="filename" style="width: 200px">
      </span></td>
      <td><INPUT type=submit height=20 width=80 value="<lt:Label res="res.label.blog.user.photo" key="add"/>">
        <input name="userName" value="<%=userName%>" type="hidden">
        <input name="kind" value="<%=ld.KIND_USER_BLOG_PHOTO%>" type="hidden">        </td>
	</form>
    </tr>
    <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
      <td colspan="3" style="PADDING-LEFT: 10px">(<lt:Label res="res.label.blog.user.photo" key="modify_pic_description"/>)</td>
    </tr>
  </tbody>
</table>
<HR noShade SIZE=1>
</body>
</html>