<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.pvg.*" %>
<html>
<head>
<title>备份</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style2 {color: #FFFFFF}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="cfg" scope="page" class="cn.js.fan.web.Config"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_BACKUP)) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String rootpath = request.getContextPath();
String bakpath = cfg.getProperty("Application.bak_path");
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">数据管理</td>
    </tr>
  </tbody>
</table>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">数据库及文件备份      </TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><table width="353" border="0" align="center">
        <tr>
          <td height="28">&nbsp;</td>
          <td height="22"><img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="bak_do.jsp?op=file">备份文件</a></td>
          <td>&nbsp;</td>
        </tr>
		<!--
        <tr>
          <td height="33">&nbsp;</td>
          <td height="22"><img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="bak_do.jsp?op=db">备份数据库</a></td>
          <td>&nbsp;</td>
        </tr>
		-->
        <tr>
          <td height="33">&nbsp;</td>
          <td height="22"><img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="<%=rootpath+"/"+bakpath%>/bak_file.zip">下载ZIP文件</a></td>
          <td>&nbsp;</td>
        </tr><!--
        <tr>
          <td height="24">&nbsp;</td>
          <td height="22"><img src="images/arrow.gif" align="absmiddle">&nbsp;<a href="<%=rootpath+"/"+bakpath%>/bak_db.bak">下载数据库备份文件</a></td>
          <td>&nbsp;</td>
        </tr>-->
      </table></TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
</body>
<script language="javascript">
<!--

//-->
</script>
</html>