<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>搜索档案</title>
<link rel="stylesheet" type="text/css" href="../common.css">
</head>
<body class="bodycolor">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="50%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#FFFFFF" class="tableframe">
<form action="user_archive_list.jsp?op=search" method="post">
  <tr>
    <td height="24" colspan="3" class="right-title">&nbsp;&nbsp;查询档案</td>
    </tr>
  <tr>
    <td height="22" colspan="2">&nbsp;姓名</td>
    <td width="70%"><input type="text" name="name" size="20" maxlength="25" class="BigInput" value=""></td>
  </tr>
  <tr>
    <td height="22" colspan="2">&nbsp;身份证</td>
    <td><input type="text" name="IDCard" size="20" maxlength="25" class="BigInput" value=""></td>
  </tr>
  <tr>
    <td height="22" colspan="2">&nbsp;出生日期</td>
    <td><input type="text" name="birthday" size="20" maxlength="25" class="BigInput" value=""></td>
  </tr>
  <tr>
    <td height="22" colspan="2">&nbsp;学历</td>
    <td><select name="xueLi" class="BigSelect">
          <option value="">全部</option>
          <option value="1">小学</option>
          <option value="2">初中</option>
          <option value="3">高中</option>
          <option value="4">中专</option>
          <option value="5">大专</option>
          <option value="6">大本</option>
          <option value="7">硕士</option>
          <option value="8">博士</option>
          <option value="9">博士后</option>
        </select></td>
  </tr>
  <tr>
    <td height="22" colspan="2">&nbsp;职务</td>
    <td><input type="text" name="zhiWu" size="15" maxlength="100" class="BigInput" value=""></td>
  </tr>
  <tr>
    <td width="7%">&nbsp;</td>
    <td width="23%" height="22">&nbsp;</td>
    <td height="30"><input type="submit" name="Submit" value=" 查 询 "></td>
  </tr>
</form>
</table>
</body>
</html>
