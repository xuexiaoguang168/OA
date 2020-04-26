<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>管理流程类型权限</title>
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
<jsp:useBean id="leafPriv" scope="page" class="com.redmoon.oa.flow.LeafPriv"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
//if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN)) {
//	out.print(StrUtil.Alert_Back(privilege.MSG_INVALID));
//	return;
//}
String op = ParamUtil.get(request, "op");
String dirCode = ParamUtil.get(request, "dirCode");

leafPriv.setDirCode(dirCode);
if (!(leafPriv.canUserSee(privilege.getUser(request)))) {
	out.print(StrUtil.Alert_Back(privilege.MSG_INVALID + " 用户需对该节点拥有管理的权限！"));
	return;
}

Leaf leaf = new Leaf();
leaf = leaf.getLeaf(dirCode);

if (op.equals("add")) {
	String name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		out.print(StrUtil.Alert_Back("名称不能为空！"));
		return;
	}
	int type = ParamUtil.getInt(request, "type");
	if (type==LeafPriv.TYPE_USER) {
		UserDb user = new UserDb();
		user = user.getUserDb(name);
		if (!user.isLoaded()) {
			out.print(StrUtil.Alert_Back("该用户不存在！"));
			return;
		}
	}
	try {
		if (leafPriv.add(name, type))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (op.equals("setrole")) {
	try {
		String roleCodes = ParamUtil.get(request, "roleCodes");
		String leafCode = ParamUtil.get(request, "dirCode");
		LeafPriv lp = new LeafPriv(leafCode);
		lp.setRoles(leafCode, roleCodes);
		out.print(StrUtil.Alert("操作成功！"));
	}
	catch (Exception e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (op.equals("modify")) {
	int id = ParamUtil.getInt(request, "id");
	int see = 0, append=0, del=0, modify=0, examine=0;
	String strsee = ParamUtil.get(request, "see");
	if (StrUtil.isNumeric(strsee)) {
		see = Integer.parseInt(strsee);
	}
	String strappend = ParamUtil.get(request, "append");
	if (StrUtil.isNumeric(strappend)) {
		append = Integer.parseInt(strappend);
	}
	String strmodify = ParamUtil.get(request, "modify");
	if (StrUtil.isNumeric(strmodify)) {
		modify = Integer.parseInt(strmodify);
	}
	String strdel = ParamUtil.get(request, "del");
	if (StrUtil.isNumeric(strdel)) {
		del = Integer.parseInt(strdel);
	}
	String strexamine = ParamUtil.get(request, "examine");
	if (StrUtil.isNumeric(strexamine)) {
		examine = Integer.parseInt(strexamine);
	}
	
	leafPriv.setId(id);
	leafPriv.setAppend(append);
	leafPriv.setModify(modify);
	leafPriv.setDel(del);
	leafPriv.setSee(see);
	leafPriv.setExamine(examine);
	if (leafPriv.save())
		out.print(StrUtil.Alert("修改成功！"));
	else
		out.print(StrUtil.Alert("修改失败！"));
}

if (op.equals("del")) {
	int id = ParamUtil.getInt(request, "id");
	LeafPriv lp = new LeafPriv();
	lp = lp.getLeafPriv(id);
	if (lp.del())
		out.print(StrUtil.Alert("删除成功！"));
	else
		out.print(StrUtil.Alert("删除失败！"));
}

%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理 <%=leaf.getName()%> 权限</td>
    </tr>
  </tbody>
</table>
<%
Vector result = leafPriv.list();
Iterator ir = result.iterator();
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="18%">用户</td>
      <td class="thead" noWrap width="13%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
      <td class="thead" noWrap width="45%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">权限</td>
      <td width="24%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
int i = 0;
while (ir.hasNext()) {
 	LeafPriv lp = (LeafPriv)ir.next();
	i++;
	%>
  <form id="form<%=i%>" name="form<%=i%>" action="?op=modify" method=post>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;
	  <%
	  if (lp.getType()==lp.TYPE_USER) {
	  	UserDb ud = new UserDb();
		ud = ud.getUserDb(lp.getName());
		out.print(ud.getRealName());
	  }else if (lp.getType()==lp.TYPE_ROLE) {
	    RoleDb rd = new RoleDb();
		rd = rd.getRoleDb(lp.getName());
	  	out.print(rd.getDesc());
	  }
	  else if (lp.getType()==lp.TYPE_USERGROUP) {
	  	UserGroupDb ug = new UserGroupDb();
		ug = ug.getUserGroupDb(lp.getName());
	  	out.print(ug.getDesc());
	  }
	  %>
	  <input type=hidden name="id" value="<%=lp.getId()%>">
      <input type=hidden name="dirCode" value="<%=lp.getDirCode()%>">
</td>
      <td><%=lp.getTypeDesc()%></td>
      <td>
	  <input name=see type=checkbox <%=lp.getSee()==1?"checked":""%> value="1">
	  管理流程&nbsp;
	  <input name=append type=hidden <%=lp.getAppend()==1?"checked":""%> value="1">
	  <input name=del type=hidden <%=lp.getDel()==1?"checked":""%> value="1">
	  <input name=modify type=hidden <%=lp.getModify()==1?"checked":""%> value="1">
	  <input name=examine type="hidden" <%=lp.getExamine()==1?"checked":""%> value="1"></td>
      <td>
	  <input type=submit value="修改">
&nbsp;<input type=button onClick="window.location.href='flow_dir_priv_m.jsp?op=del&dirCode=<%=StrUtil.UrlEncode(leaf.getCode())%>&id=<%=lp.getId()%>'" value=删除> </td>
    </tr></form>
<%}%>
  </tbody>
</table>
<br>
<HR noShade SIZE=1>
<DIV style="WIDTH: 95%" align=right>
  <INPUT 
onclick="javascript:location.href='flow_dir_priv_add.jsp?dirCode=<%=StrUtil.UrlEncode(leafPriv.getDirCode())%>';" type=image 
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