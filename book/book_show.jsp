<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>图书信息</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<link href="../common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>

<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="Book";
if (!privilege.isUserPrivValid(request, priv)) {
	//out.println(fchar.makeErrMsg("对不起，您不具有发起流程的权限！"));
	//return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("show")) {
	BookMgr bm = new BookMgr();
	boolean re = false;
	try {
		re = bm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

int id = ParamUtil.getInt(request, "id");
BookDb bd = new BookDb();
bd = bd.getBookDb(id);
String pubDate = DateUtil.format(bd.getPubDate(), "yyyy-MM-dd");
   
BookTypeDb btdb = new BookTypeDb();
int typeId = bd.getTypeId();
BookTypeDb btd = btdb.getBookTypeDb(typeId);
%>
<table width="100%" height="180" border="1" align="center" cellpadding="4" cellspacing="0" bordercolorlight="#000000" bordercolordark="#ffffff" bgcolor="#FFFFFF">
  <tbody>
    <tr>
      <td  nowrap="nowrap"align="right" width="15%">图书名称：</td>
      <td  nowrap="nowrap"width="35%"><%=bd.getBookName()%></td>
      <td  nowrap="nowrap"align="right" width="15%">图书编号：</td>
      <td  nowrap="nowrap"width="35%"><%=bd.getBookNum()%></td>
    </tr>
    <tr>
      <td nowrap="nowrap" align="right">图书类别：</td>
      <td nowrap="nowrap"><%=btd.getName()%></td>
      <td nowrap="nowrap" align="right">作者：</td>
      <td nowrap="nowrap"><%=bd.getAuthor()%> </td>
    </tr>
    <tr>
      <td nowrap="nowrap" align="right">出版单位：</td>
      <td nowrap="nowrap"><%=bd.getPubHouse()%> </td>
      <td nowrap="nowrap" align="right">出版时间：</td>
      <td nowrap="nowrap"> <%=pubDate%></td>
    </tr>
    <tr>
      <td nowrap="nowrap" align="right">价格(￥)：</td>
      <td nowrap="nowrap"><%=bd.getPrice()%></td>
      <td colspan="2"> </td>
    </tr>
    <tr>
      <td height="62" align="right">内容简介：</td>
      <td colspan="3"> <%=bd.getBrief()%></td>
    </tr>
  </tbody>
</table>

</div>
</html>
