<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.basic.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>职级修改</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--

//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE5 {color: #FF0000}
.STYLE6 {color: #000000}
-->
</style>
</head>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("modify")) {
	RankMgr rm = new RankMgr();
	boolean re = false;
	try {
		  re = rm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)	{  
	     out.print(StrUtil.Alert("操作成功"));
		//out.print(StrUtil.Alert_Redirect("操作成功！", "officeequip_type_list.jsp"));
%>
    <script>
		window.opener.location.reload();
		window.close();
	</script>
<%	}
}%>
<script>
function setPerson(deptCode, deptName, user, userRealName)
{
	form1.userRealName.value = userRealName;
	form1.userName.value = user;
}
</script>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, com.redmoon.oa.pvg.PrivDb.PRIV_ADMIN)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
    String code = ParamUtil.get(request, "code");
	RankDb adb = new RankDb();
	adb = adb.getRankDb(code);
%>
<TABLE border="0" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
   <form action="?op=modify" method="post" name="form1" id="form1" onSubmit="">
    <TBODY>
      <TR>
        <TD colspan="4" align="left" class="right-title">&nbsp;职级修改  </TD>
      </TR>
      <TR>
        <TD align="right">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</TD>
        <td width="272"><input  name="userName"  id="userName" value="<%=adb.getName()%>" size="20" >
        <input type="hidden" name="code" value="<%=adb.getCode()%>"></td>
      </TR>
      <TR>
        <TD height="26" align="right">序&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</TD>
        <td><input name="orders" id="orders" size="10" value="<%=adb.getOrders()%>"></td>
      </TR>
      
      <TR>
        <TD colspan="4" align="center"><input name="button" type="submit" class="button1"  value="修改职级"></TD>
      </TR>
    </TBODY>
  </FORM>
</TABLE>
</body>
</html>
