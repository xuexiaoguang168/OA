<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发邮件</title>
<%@ include file="../inc/nocache.jsp"%>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<script language=javascript>
function form1_onsubmit() {
	if (form1.email.value=="")
	{
		alert("邮箱不能为空！");
		return false;
	}
}
</script>
<body leftmargin="0" topmargin="5">

<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" class="right-title">　　　　　POP3 
      邮 箱 设 置</td>
  </tr>
  <tr>
    <td height="301" valign="top" background="../images/tab-b-back.gif">
<%
String sql;
String myname = privilege.getUser(request);
sql = "select id from email_pop3 where userName="+fchar.sqlstr(myname);
int i = 0;
String email = "",email_user="",email_pwd="",mailserver="";
int id,port;
EmailPop3Db epd = new EmailPop3Db();
%>
      <table width="90%" height="5" border="0" align="center">
        <tr> 
          <td></td>
        </tr>
      </table>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr align="center" bgcolor="#C4DAFF" class="stable"> 
          <td width="21%" class="stable"> 邮箱名称</td>
          <td width="30%" class="stable">用户名</td>
          <td width="27%" class="stable">密 码</td>
          <td width="22%" class="stable">操作 </td>
        </tr>
      </table>
      <%	
	  	Iterator ir = epd.list(sql).iterator();
		while (ir.hasNext()) {
			epd = (EmailPop3Db)ir.next();
			i++;
			email = epd.getEmail();
			email_user = epd.getEmailUser();
			email_pwd = epd.getEmailPwd();
			id = epd.getId();
			mailserver = epd.getServer();
			port = epd.getPort();
		%>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <form id=formadd<%=i%> action="pop3_getmail_do.jsp" method=post>
          <tr align="center" bgcolor="#EEEEEE" class="stable"> 
            <td width="21%" class="stable"><%=email%>
              <input name=email type=hidden value="<%=email%>">
<div align="center"></div></td>
            <td width="30%" class="stable"> <input name=email_user class="singleboarder" value="<%=email_user%>" size=20> 
              <input type=hidden name=mailserver class="singleboarder" value="<%=mailserver%>" size=20></td>
            <td width="27%" class="stable"> <input name=email_pwd type=password class="singleboarder" value="<%=email_pwd%>" size=18> 
              <input type=hidden name=port class="singleboarder" value="<%=port%>" size=18></td>
            <td width="22%" class="stable"> <input name="Submit3" onClick="javascript:window.location.href='pop3_getmail_do.jsp?email=<%=email%>&mailserver=<%=mailserver%>&port=<%=port%>&email_user='+formadd<%=i%>.email_user.value+'&email_pwd='+formadd<%=i%>.email_pwd.value" type="button" class="singleboarder" value="收邮件"> 
              &nbsp; </td>
          </tr>
        </form>
      </table>
      <%
		}
%>
      <br>
    </td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" height="9"></td>
  </tr>
</table>
</body>
</html>
