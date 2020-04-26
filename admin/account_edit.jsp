<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.account.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工号修改</title>
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
	AccountMgr am = new AccountMgr();
	boolean re = false;
	try {
		  re = am.modify(request);
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
    String name = ParamUtil.get(request, "name");
	AccountDb adb = new AccountDb();
	adb = adb.getAccountDb(name);
	String userName = StrUtil.getNullString(adb.getUserName());
	String userRealName = "";
	if (!userName.equals("")) {
		UserMgr um = new UserMgr();
		UserDb user = um.getUserDb(userName);
		if (user==null || !user.isLoaded()) {
			out.print(StrUtil.Alert("该用户已不存在！"));
		}
		else
			userRealName = user.getRealName();
	}
%>
<TABLE border="0" cellspacing="0" bordercolor="#CCCCCC">
   <form action="?op=modify" method="post" name="form1" id="form1" onSubmit="">
    <TBODY>
      <TR>
        <TD colspan="4" align="left" class="right-title">&nbsp;工号修改  </TD>
      </TR>
      <TR>
        <TD align="right" width="112">工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</TD>
        <TD width="272"><INPUT name="name" id="name" value="<%=adb.getName()%>" maxLength="255" readonly="">
            <span class="STYLE5"> *</span></TD>
      </TR>
      <TR>
        <TD align="right">姓 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</TD>
        <td width="272"><input readonly name="userRealName" type="text" id="userRealName" value="<%=userRealName%>" size="20" >          
          <input type=hidden name="userName" size=20 value="<%=userName%>">
        <a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择用户</a></td>
      </TR>
      
      <TR>
        <TD colspan="4" align="center"><input name="button" type="submit" class="button1"  value="修改工号"></TD>
      </TR>
    </TBODY>
  </FORM>
</TABLE>
</body>
</html>
