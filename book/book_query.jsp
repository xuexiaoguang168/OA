<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询图书</title>
<link href="../common.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>

<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="bookadd";
if (!privilege.isUserPrivValid(request, priv)) {
	// out.println(fchar.makeErrMsg("对不起，您不具有发布工作计划的权限！"));
	// return;
}
%>
<%@ include file="book_inc_menu_top.jsp"%>
<br>
<table width="689" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
<form action="book_list.jsp?op=search" name="form1" method="post">
<tr>
  <td colspan="7" class="right-title">图书查询</td>
  </tr>
<tr>
  <td width="71">图书类别：</td>
  <td width="215"><%
	  BookTypeDb btd = new BookTypeDb();
	  String opts = "";
	  Iterator ir = btd.list().iterator();
	  while (ir.hasNext()) {
	  	 btd = (BookTypeDb)ir.next();
	  	 opts += "<option value='" + btd.getId() + "'>" + btd.getName() + "</option>";
	  }
	  %>
    <select name="typeId" id="typId" >
      <option value="all">全部</option>
      <%=opts%>
    </select></td>
  <td width="115">图书名称： </td>
  <td width="239"><input type="text" name="bookName" id="bookName" value="" maxlength="100"></td>
</tr>
<tr>

  <td>图书编号：  </td>
  <td><input type="text" name="bookNum" id="bookNum" value="" maxlength="100" ></td>
  <td>作者：</td>
  <td><input type="text" name="author" id="author" value="" maxlength="100"></td>
</tr>
<tr>

  <td>出版社：</td>
  <td><input type="text" name="pubHouse" id="pubHouse"value="" maxlength="100">    </td>
  <td>&nbsp;</td>
  <td><input name="submit" type="submit" class="button1"  value="查  询" ></td>
</tr>
</form>
</table>
</body>
</html>
