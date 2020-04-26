<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.asset.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资产类别管理</title>
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
String priv="oa.asset";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	AssetTypeMgr atm = new AssetTypeMgr();
	boolean re = false;
	try {
		re = atm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<%@ include file="asset_inc_menu_top.jsp"%>
<br>
<table width="89%" border="0" align="center" cellpadding="3" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC" class="tableframe">
  <tr bgcolor="#00CCFF">
    <td align="center" bgcolor="#BBF1FF" class="right-title">资产类别名称</span></td>
    <td align="center" bgcolor="#BBF1FF" class="right-title">净残值率</td>
    <td align="center" bgcolor="#BBF1FF" class="right-title">折旧年限</td>
    <td align="center" bgcolor="#BBF1FF" class="right-title">备 注</td>
    <td width="12%" align="center" bgcolor="#BBF1FF" class="right-title">操 作</td>
  </tr>
  <%
					  AssetTypeDb atd = new AssetTypeDb();
					  String sql = "select id from asset_type_info";
					  Iterator ir = atd.list(sql).iterator();
					  while (ir.hasNext()) {
						atd = (AssetTypeDb)ir.next();
				    %>
  <tr>
    <td width="30%" bgcolor="#FFFFFF"><a href="#" class="STYLE2" onClick="window.open('asset_type_edit.jsp?id=<%=atd.getId()%>','','height=170, width=494, top=200,left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no')"><%=atd.getName()%></a></td>
    <td width="18%" bgcolor="#FFFFFF"><%=atd.getDepreciationRate()%></td>
    <td width="18%" bgcolor="#FFFFFF"><%=atd.getDepreciationYears()%></td>
    <td width="22%" bgcolor="#FFFFFF"><% 
					String abstracts = "";
					if (atd.getAbstracts() == null)
					       abstracts = "";
					else	   
					       abstracts = atd.getAbstracts();
					%>
    <%=abstracts%> </td>
    <td align="center" bgcolor="#FFFFFF"><a href="#" onClick="if (confirm('您确定要删除<%=atd.getName()%>吗？')) window.location.href='?op=del&id=<%=atd.getId()%>'">删除</a></td>
  </tr>
  <%}%>
</table>
<p align="center"><input type="button" class="button1" onClick="openWin('asset_type_add.jsp?id=<%=atd.getId()%>',494,170)" value="添加类别">
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

