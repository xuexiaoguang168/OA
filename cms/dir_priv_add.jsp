<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>管理文件柜权限</title>
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
function setPerson(deptCode, deptName, user, userRealName)
{
	form1.name.value = user;
	form1.userRealName.value = userRealName;
}

function setRoles(roles, descs) {
	formRole.roleCodes.value = roles;
	formRole.roleDescs.value = descs
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
      <td class="head">设置目录 <a href="dir_priv_m.jsp?dirCode=<%=StrUtil.UrlEncode(dirCode)%>"><%=leaf.getName()%></a> 权限</td>
    </tr>
  </tbody>
</table>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellspacing="0" cellpadding="3" width="50%" align="center">
  <form name="formRole" method="post" action="dir_priv_m.jsp?op=setrole">
    <tbody>
      <tr>
        <td width="88%" align="left" nowrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">角色</td>
      </tr>
      <%
RoleMgr roleMgr = new RoleMgr();		
LeafPriv lp = new LeafPriv();
Vector vrole = lp.getRolesOfLeafPriv(leaf.getCode());

String roleCode;
String roleCodes = "";
String descs = "";
Iterator irrole = vrole.iterator();
while (irrole.hasNext()) {
	RoleDb rd = (RoleDb)irrole.next();
	roleCode = rd.getCode();
	if (roleCodes.equals(""))
		roleCodes += roleCode;
	else
		roleCodes += "," + roleCode;
	if (descs.equals(""))
		descs += rd.getDesc();
	else
		descs += "," + rd.getDesc();
}
%>
      <tr class="row" style="BACKGROUND-COLOR: #ffffff">
        <td align="left"><textarea name=roleDescs cols="60" rows="3"><%=descs%></textarea>
            <input name="roleCodes" value="<%=roleCodes%>" type=hidden>
            <input name="dirCode" value="<%=dirCode%>" type=hidden></td>
      </tr>
      <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
        <td style="PADDING-LEFT: 10px"><input name="button2" type="button" class="singleboarder" onClick="showModalDialog('../role_multi_sel.jsp?roleCodes=<%=roleCodes%>',window.self,'dialogWidth:526px;dialogHeight:435px;status:no;help:no;')" value="选择角色">
          &nbsp;&nbsp;&nbsp;&nbsp;
          <input name="Submit3" type="submit" class="singleboarder" value=" 提 交 "></td>
      </tr>
    </tbody>
  </form>
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
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="50%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="26%">用户组名称</td>
      <td class="thead" noWrap width="40%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
      <td width="34%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
while (ir.hasNext()) {
 	UserGroupDb ug = (UserGroupDb)ir.next();
	code = ug.getCode();
	desc = ug.getDesc();
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<%=code%></td>
      <td><%=desc%></td>
      <td>
	  <a href="dir_priv_m.jsp?op=add&dirCode=<%=StrUtil.UrlEncode(leaf.getCode())%>&name=<%=StrUtil.UrlEncode(code)%>&type=<%=LeafPriv.TYPE_USERGROUP%>">[ 添加 ]</a></td>
    </tr>
<%}%>
  </tbody>
</table>
<br>
<table width="395"  border="0" align="center" cellpadding="0" cellspacing="0"  style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid">
  <tr>
    <td width="329" class="thead">添加用户</td>
  </tr>
  <form name="form1" action="dir_priv_m.jsp?op=add" method=post>
  <tr>
    <td height="25" align="center">
	用户名：
	  <input name="userRealName" value="" readonly>
	  <input name="name" value="" type="hidden"><input type=hidden name=type value=1>
	  <input type=hidden name=dirCode value="<%=leaf.getCode()%>">
	  &nbsp;
	<INPUT type=image 
onclick="javascript:location.href='user_group_op.jsp';" src="images/btn_add.gif" align="middle" width=80 
height=20>
	&nbsp;<a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择用户</a></td>
  </tr></form>
</table>
<br>
</body>
</html>