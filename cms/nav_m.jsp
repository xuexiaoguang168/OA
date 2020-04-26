<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*" %>
<html>
<head>
<title>管理导航条</title>
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
<jsp:useBean id="navmgr" scope="page" class="cn.js.fan.module.nav.NavigationMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String op = StrUtil.getNullString(request.getParameter("op"));
if (op.equals("add")) {
	try {
		if (navmgr.add(request))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("edit")) {
	try {
		if (navmgr.update(request))
			out.print(StrUtil.Alert("修改成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("move")) {
	try {
		if (navmgr.move(request))
			out.print(StrUtil.Alert("移动成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("del")) {
	if (navmgr.del(request))
		out.print(StrUtil.Alert("删除成功！"));
	else
		out.print(StrUtil.Alert("删除失败！"));
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理导航条</td>
    </tr>
  </tbody>
</table>
<%
String sql = "select name,link,color from nav order by orders";
RMConn rmconn = new RMConn(Global.defaultDB);
ResultIterator ri = rmconn.executeQuery(sql);
ResultRecord rr = null;
String name;
String link,color;
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="24%">名称</td>
      <td class="thead" noWrap width="28%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">链接</td>
      <td class="thead" noWrap width="28%">颜色</td>
      <td width="48%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
int i=100;
while (ri.hasNext()) {
	i++;
 	rr = (ResultRecord)ri.next();
	name = rr.getString(1);
	link = rr.getString(2);
	color = StrUtil.getNullString(rr.getString(3));
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
	<form name="form<%=i%>" action="?op=edit" method="post">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<input name=newname value="<%=name%>"></td>
      <td><input name=link value="<%=link%>" size="30"><input name="name" value="<%=name%>" type="hidden"></td>
      <td><span class="stable">
      <select name="color" >
        <option value="" style="COLOR: black" selected>颜色（无）</option>
        <option style="BACKGROUND: #000088" value="#000088"></option>
        <option style="BACKGROUND: #0000ff" value="#0000ff"></option>
        <option style="BACKGROUND: #008800" value="#008800"></option>
        <option style="BACKGROUND: #008888" value="#008888"></option>
        <option style="BACKGROUND: #0088ff" value="#0088ff"></option>
        <option style="BACKGROUND: #00a010" value="#00a010"></option>
        <option style="BACKGROUND: #1100ff" value="#1100ff"></option>
        <option style="BACKGROUND: #111111" value="#111111"></option>
        <option style="BACKGROUND: #333333" value="#333333"></option>
        <option style="BACKGROUND: #50b000" value="#50b000"></option>
        <option style="BACKGROUND: #880000" value="#880000"></option>
        <option style="BACKGROUND: #8800ff" value="#8800ff"></option>
        <option style="BACKGROUND: #888800" value="#888800"></option>
        <option style="BACKGROUND: #888888" value="#888888"></option>
        <option style="BACKGROUND: #8888ff" value="#8888ff"></option>
        <option style="BACKGROUND: #aa00cc" value="#aa00cc"></option>
        <option style="BACKGROUND: #aaaa00" value="#aaaa00"></option>
        <option style="BACKGROUND: #ccaa00" value="#ccaa00"></option>
        <option style="BACKGROUND: #ff0000" value="#ff0000"></option>
        <option style="BACKGROUND: #ff0088" value="#ff0088"></option>
        <option style="BACKGROUND: #ff00ff" value="#ff00ff"></option>
        <option style="BACKGROUND: #ff8800" value="#ff8800"></option>
        <option style="BACKGROUND: #ff0005" value="#ff0005"></option>
        <option style="BACKGROUND: #ff88ff" value="#ff88ff"></option>
        <option style="BACKGROUND: #ee0005" value="#ee0005"></option>
        <option style="BACKGROUND: #ee01ff" value="#ee01ff"></option>
        <option style="BACKGROUND: #3388aa" value="#3388aa"></option>
        <option style="BACKGROUND: #000000" value="#000000"></option>
      </select>
	  <script>
	  form<%=i%>.color.value = "<%=color%>";
	  </script>
</span></td>
      <td>
	  [ <a href="javascript:form<%=i%>.submit()">编辑</a> ] [ <a onClick="if (!confirm('您确定要删除吗？')) return false" href="nav_m.jsp?op=del&name=<%=StrUtil.UrlEncode(name)%>">删除</a> ] [<a href="nav_m.jsp?op=move&direction=up&name=<%=StrUtil.UrlEncode(name)%>">上移</a>] [<a href="nav_m.jsp?op=move&direction=down&name=<%=StrUtil.UrlEncode(name)%>">下移</a>] </td>
	  </form>
    </tr>
<%}%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
	<form name="addform1" action="?op=add" method="post">
      <td style="PADDING-LEFT: 10px">
	  &nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;
	  <input name=name value="" size="15"></td>
      <td><input name=link value="" size="30"></td>
      <td><span class="stable">
        <SELECT name="color" onChange="if(this.value!='0')msg.style.color=colortable[this.value-1];else msg.style.color='';msg.focus();">
          <option value="" STYLE="COLOR: black" selected>颜色（无）</option>
          <option style="BACKGROUND: #000088" value="#000088"></option>
          <option style="BACKGROUND: #0000ff" value="#0000ff"></option>
          <option style="BACKGROUND: #008800" value="#008800"></option>
          <option style="BACKGROUND: #008888" value="#008888"></option>
          <option style="BACKGROUND: #0088ff" value="#0088ff"></option>
          <option style="BACKGROUND: #00a010" value="#00a010"></option>
          <option style="BACKGROUND: #1100ff" value="#1100ff"></option>
          <option style="BACKGROUND: #111111" value="#111111"></option>
          <option style="BACKGROUND: #333333" value="#333333"></option>
          <option style="BACKGROUND: #50b000" value="#50b000"></option>
          <option style="BACKGROUND: #880000" value="#880000"></option>
          <option style="BACKGROUND: #8800ff" value="#8800ff"></option>
          <option style="BACKGROUND: #888800" value="#888800"></option>
          <option style="BACKGROUND: #888888" value="#888888"></option>
          <option style="BACKGROUND: #8888ff" value="#8888ff"></option>
          <option style="BACKGROUND: #aa00cc" value="#aa00cc"></option>
          <option style="BACKGROUND: #aaaa00" value="#aaaa00"></option>
          <option style="BACKGROUND: #ccaa00" value="#ccaa00"></option>
          <option style="BACKGROUND: #ff0000" value="#ff0000"></option>
          <option style="BACKGROUND: #ff0088" value="#ff0088"></option>
          <option style="BACKGROUND: #ff00ff" value="#ff00ff"></option>
          <option style="BACKGROUND: #ff8800" value="#ff8800"></option>
          <option style="BACKGROUND: #ff0005" value="#ff0005"></option>
          <option style="BACKGROUND: #ff88ff" value="#ff88ff"></option>
          <option style="BACKGROUND: #ee0005" value="#ee0005"></option>
          <option style="BACKGROUND: #ee01ff" value="#ee01ff"></option>
          <option style="BACKGROUND: #3388aa" value="#3388aa"></option>
          <option style="BACKGROUND: #000000" value="#000000"></option>
        </SELECT>
      </span></td>
      <td><INPUT 
onclick="return addform1.submit()" type=image 
height=20 width=80 src="images/btn_add.gif"></td>
	</form>
    </tr>
  </tbody>
</table>
<HR noShade SIZE=1>
</body>
</html>