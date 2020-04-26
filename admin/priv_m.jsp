<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*" %>
<html>
<head>
<title>管理登录</title>
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
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<jsp:useBean id="privmgr" scope="page" class="com.redmoon.oa.pvg.PrivMgr"/>
<%
String op = StrUtil.getNullString(request.getParameter("op"));
if (op.equals("add")) {
	try {
		if (privmgr.add(request))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("del")) {
	try {
		if (privmgr.del(request))
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
      <td class="head">管理权限</td>
    </tr>
  </tbody>
</table>
<%
String sql = "select priv,description,isSystem from privilege order by isSystem desc, priv asc";
RMConn rmconn = new RMConn(Global.defaultDB);
ResultIterator ri = rmconn.executeQuery(sql);
ResultRecord rr = null;
String priv;
String desc;
int isSystem = 0;
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="19%">编码</td>
      <td class="thead" noWrap width="44%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
      <td class="thead" noWrap width="21%">系统保留</td>
      <td width="16%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
while (ri.hasNext()) {
 	rr = (ResultRecord)ri.next();
	priv = rr.getString(1);
	desc = rr.getString(2);
	isSystem = rr.getInt(3);
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="priv_op.jsp?op=edit&priv=<%=StrUtil.UrlEncode(priv)%>"><%=priv%></a></td>
      <td><a href="priv_op.jsp?op=edit&priv=<%=StrUtil.UrlEncode(priv)%>"><%=desc%></a></td>
      <td>
	  <%
	  if (isSystem==1)
	  	out.print("是");
	  else
	  	out.print("否");
	  %>

</td>
      <td>
	  <a href="priv_op.jsp?op=edit&priv=<%=StrUtil.UrlEncode(priv)%>">[ 编辑 ]</a>
	  <%if (isSystem==0) {%>
	   [ <a onClick="if (!confirm('您确定要删除吗？')) return false" href="priv_m.jsp?op=del&priv=<%=StrUtil.UrlEncode(priv)%>">删除</a> ] 
	  <%}%>
      </td>
    </tr>
<%}%>
  </tbody>
</table>
<HR noShade SIZE=1>
<DIV style="WIDTH: 95%" align=right>
  <INPUT 
onclick="javascript:location.href='priv_op.jsp';" type=image 
height=20 width=80 src="images/btn_add.gif">
</DIV>
</body>
</html>