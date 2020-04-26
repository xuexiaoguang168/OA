<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.officeequip.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加办公用品类别</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=150,left=220,width="+width+",height="+height);
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #FFFFFF}
.STYLE5 {color: #FF0000}
.STYLE6 {color: #000000}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="officeequip";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	OfficeTypeMgr btm = new OfficeTypeMgr();
	boolean re = false;
	try {
		  re = btm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "officeequip_type_list.jsp"));
}

if (op.equals("del")) {
	OfficeTypeMgr btm = new OfficeTypeMgr();
	boolean re = false;
	try {
		re = btm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<%@ include file="officeequip_inc_menu_top.jsp"%>
<br>
<table width="52%" border="0" align="center" cellpadding="3" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC" class="tableframe">
  <tr bgcolor="#00CCFF">
    <td align="center" bgcolor="#BBF1FF" class="right-title">用品类别名称</span></td>
    <td align="center" bgcolor="#BBF1FF" class="right-title">参考单位</td>
    <td align="center" bgcolor="#BBF1FF" class="right-title">备 注</td>
    <td width="20%" align="center" bgcolor="#BBF1FF" class="right-title">操 作</td>
  </tr>
  <%
					  OfficeTypeDb otd = new OfficeTypeDb();
					  String sql = "select id from office_equipment_type";
					  Iterator ir = otd.list(sql).iterator();
					  while (ir.hasNext()) {
						otd = (OfficeTypeDb)ir.next();
				    %>
  <tr>
    <td width="23%" bgcolor="#FFFFFF"><a href="officeequip_all_list.jsp?op=search&typeId=<%=otd.getId()%>"><%=otd.getName()%></a></td>
    <td width="23%" bgcolor="#FFFFFF"><%=otd.getUnit()%></td>
    <td width="34%" bgcolor="#FFFFFF"><% 
					String abstracts = "";
					if (otd.getAbstracts() == null)
					       abstracts = "";
					else	   
					       abstracts = otd.getAbstracts();
					%>
    <%=abstracts%> </td>
    <td align="center" bgcolor="#FFFFFF"><a href="officeequip_type_edit.jsp?id=<%=otd.getId()%>">编辑</a>&nbsp;&nbsp;<a href="#" onClick="if (confirm('您确定要删除<%=otd.getName()%>吗？')) window.location.href='?op=del&id=<%=otd.getId()%>'">删除</a></td>
  </tr>
  <%}%>
</table>
<p align="center"><input type="button" class="button1" onClick="openWin('officeequip_type_add.jsp?id=<%=otd.getId()%>',494,123)" value="添加类别">
</p>
</td>
</tr>
<tr> 
    <td height="9">&nbsp;</td>
</tr>
<br>
<br>
</body>
</html>

