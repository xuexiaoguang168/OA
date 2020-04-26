<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.basic.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加职级</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	RankMgr rm = new RankMgr();
	boolean re = false;
	try {
		  re = rm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "rank_add.jsp"));

}
%>
<style type="text/css">
<!--
.STYLE5 {color: #FF0000}
-->
</style>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, com.redmoon.oa.pvg.PrivDb.PRIV_ADMIN)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<TABLE width="45%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="tableframe">
  <FORM name="form1" action="?op=add" method="post">
    <TBODY>
      <TR>
        <TD colspan="4" align="left" class="right-title">&nbsp;添加职级</TD>
      </TR>
      <TR>
        <TD height="26" align="right">名 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</TD>
        <td><input name="userName" id="userName" size="30" >          &nbsp;
        <input type="hidden" name="code" value="<%=cn.js.fan.util.RandomSecquenceCreator.getId(20)%>"></td></TR>
      <TR>
        <TD height="26" align="right">序&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</TD>
        <td><input name="orders"  id="orders" size="10" ></td>
      </TR>
      
      <TR>
        <TD height="30" colspan="4" align="center"><input name="button" type="submit" class="button1"  value="创建职级 ">
          &nbsp;&nbsp;&nbsp;&nbsp;
        <input name="button2" type="button" class="button1"  value="返回列表" onClick="window.location.href='rank_list.jsp'"></TD>
      </TR>
    </TBODY>
  </FORM>
</TABLE>
</body>
</html>
