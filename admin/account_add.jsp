<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.account.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>创建帐号</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	AccountMgr am = new AccountMgr();
	boolean re = false;
	try {
		  re = am.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "account_add.jsp"));

}
%>
<script>
 function setPerson(deptCode, deptName, user, userRealName)
{
	form1.person.value = userRealName;
	form1.userName.value = user;
	
}
</script>
<style type="text/css">
<!--
.STYLE5 {color: #FF0000}
-->
</style>
</head>
<body>
<TABLE width="45%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="tableframe">
  <FORM name="form1" action="?op=add" method="post">
    <TBODY>
      <TR>
        <TD colspan="4" align="left" class="right-title">&nbsp;添加工号</TD>
      </TR>
      <TR>
        <TD height="26" align="right">工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;号：</TD>
        <TD><INPUT name="name" id="name" maxLength="255">
        <span class="STYLE5"> *</span> </TD>
      </TR>
      <TR>
        <TD height="26" align="right">姓 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</TD>
        <td><input name="person" type="text" id="person" size="20" readonly>&nbsp;<a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择用户</a><input type="hidden" name="userName"></td>
      </TR>
      
      <TR>
        <TD height="30" colspan="4" align="center"><input name="button" type="submit" class="button1"  value="创建工号 ">
          &nbsp;&nbsp;&nbsp;&nbsp;
        <input name="button2" type="button" class="button1"  value="返回列表" onClick="window.location.href='account_list.jsp'"></TD>
      </TR>
    </TBODY>
  </FORM>
</TABLE>
</body>
</html>
