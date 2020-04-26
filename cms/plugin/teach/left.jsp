<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/DirListTag.tld" prefix="left_dirlist" %>
<%@ taglib uri="/WEB-INF/tlds/DocumentTag.tld" prefix="left_doc" %>
<html>
<head>
<title>左侧菜单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
-->
</style></head>
<body text="#000000">
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<table width="160" height="485" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
<tr><td valign="top" bgcolor="#E3ECE1"><br>
              <left_dirlist:DirListTag parentCode="teach">
			  <left_dirlist:DirListItemTag field="name" mode="detail" length="32">
			  <table width="100%" cellpadding="5" cellspacing="0">
			  <tr>
				  <td>&nbsp;&nbsp;<img src="images/r_icon_high.gif" align="absmiddle">&nbsp;
				  <a href="doc_list.jsp?dir_code=@code" title="#name" target="mainFrame">$name</a>				  </td>
			  </tr>
			  </table>
              </left_dirlist:DirListItemTag>
			  </left_dirlist:DirListTag>
</td>
  <td width="3" valign="top" bgcolor="#EFEFEF"></td>
</tr>
</table>			  
</body>
</html>