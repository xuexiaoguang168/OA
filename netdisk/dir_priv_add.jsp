<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.netdisk.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="cn.js.fan.web.*"%>
<html>
<head>
<title>管理共享</title>
<link href="../admin/default.css" rel="stylesheet" type="text/css">
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
function setPerson(deptCode, deptName, userName, userRealName)
{
	form1.name.value = userName;
	form1.userRealName.value = userRealName;
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="usergroupmgr" scope="page" class="com.redmoon.oa.pvg.UserGroupMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String dirCode = ParamUtil.get(request, "dirCode");
Leaf leaf = new Leaf();
leaf = leaf.getLeaf(dirCode);
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">设置<%=leaf.getName()%>共享</td>
    </tr>
  </tbody>
</table>
<%
String code;
String desc;
UserGroupDb ugroup = new UserGroupDb();
Vector result = ugroup.list();
Iterator ir = result.iterator();
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="26%">用户组名称</td>
      <td class="thead" noWrap width="40%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
      <td width="34%" noWrap class="thead"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
while (ir.hasNext()) {
 	UserGroupDb ug = (UserGroupDb)ir.next();
	code = ug.getCode();
	desc = ug.getDesc();
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="../admin/../admin/images/arrow.gif" align="absmiddle">&nbsp;<%=code%></td>
      <td><%=desc%></td>
      <td>
	  <a href="dir_priv_m.jsp?op=add&dirCode=<%=StrUtil.UrlEncode(leaf.getCode())%>&name=<%=StrUtil.UrlEncode(code)%>&type=<%=LeafPriv.TYPE_USERGROUP%>">[ 添加 ]</a></td>
    </tr>
<%}%>
  </tbody>
</table>
<br>
<br>
<table width="489"  border="0" align="center" cellpadding="0" cellspacing="0"  style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid">
  <tr>
    <td width="329" class="thead">添加用户</td>
  </tr>
  <form name="form1" action="dir_priv_m.jsp?op=add" method=post>
  <tr>
    <td height="25" align="center">
	用户名：
	  
	  <input name="userRealName" value="" readonly>
	  <input type=hidden name=type value=1>
	  <input type=hidden name=dirCode value="<%=leaf.getCode()%>">
	  <input name="name" value="" type=hidden>
	  &nbsp;
	<INPUT type=image 
onclick="javascript:location.href='user_group_op.jsp';" src="../admin/../admin/images/btn_add.gif" align="middle" width=80 
height=20>
	<span class="p14">&nbsp;<a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:320px;status:no;help:no;')">选择用户</a></span></td>
  </tr></form>
</table>
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