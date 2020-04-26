<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*" %>
<html>
<head>
<title>管理登录</title>
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
<jsp:useBean id="backup" scope="page" class="cn.js.fan.util.Backup"/>
<jsp:useBean id="cfg" scope="page" class="cn.js.fan.web.Config"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_BACKUP))
{
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">数据管理</td>
    </tr>
  </tbody>
</table>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">&nbsp;</TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><table width="470" border="0" align="center">
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td align="center"><p>
    <%
	String op = ParamUtil.get(request, "op");
	String rootpath = request.getContextPath();
	String srcpath = application.getRealPath("/") + "upfile/";
	String bakpath = cfg.getProperty("Application.bak_path");;
	if (op.equals("file")) {
		backup.copyDirectory(application.getRealPath("/")+bakpath+"/file",srcpath);//拷贝至file目录下
		out.print(StrUtil.p_center("拷贝文件成功！"));
		String zipfilepath = application.getRealPath("/")+bakpath+"/bak_file.zip";
		backup.generateZipFile(srcpath, zipfilepath);
		out.print(StrUtil.p_center("压缩ZIP文件成功！"));
		%>
		<a href="<%=rootpath+"/"+bakpath%>/bak_file.zip">下载ZIP文件</a>
	<%}
	if (op.equals("db")) {
		String dbfile = application.getRealPath("/") + bakpath + "/bak_db.bak";
		String dbname = "zjrj";
		if (backup.BackupDB(dbname, Global.defaultDB, dbfile))
			out.print(StrUtil.p_center("备份数据库成功！"));
		else
			out.print(StrUtil.p_center("备份数据库失败！"));
		%>
		<a href="<%=rootpath+"/"+bakpath%>/bak_db.bak">下载数据库备份文件</a>
	<%}%>
               </p>
              </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="37">&nbsp;</td>
          <td align="center">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
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