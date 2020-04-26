<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.fileark.*" %>
<%@ page import="cn.js.fan.module.cms.*" %>
<%@ page import="cn.js.fan.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<LINK href="../common.css" type=text/css rel=stylesheet>
<LINK href="default.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择邮箱</title>
<script>

</script>
</head>
<body>
<%
String sql;
String myname = privilege.getUser(request);
sql = "select id from email_pop3 where userName="+fchar.sqlstr(myname);
int i = 0;
String email = "",email_user="",email_pwd="",mailserver="";
int id,port;
EmailPop3Db epd = new EmailPop3Db();
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
          <a href="pop3_getmail_do.jsp">收邮件</a><br>
 发邮件<br>
 草稿箱          
 <div align="center"></div></td>
      <td width="22%" class="stable"><input name="Submit3" onClick="javascript:window.location.href='pop3_getmail_do.jsp?email=<%=email%>&mailserver=<%=mailserver%>&port=<%=port%>&email_user='+formadd<%=i%>.email_user.value+'&email_pwd='+formadd<%=i%>.email_pwd.value" type="button" class="singleboarder" value="收邮件">
        &nbsp; </td>
    </tr>
  </form>
</table>
<%
}
%>
</body>
</html>
