<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<LINK href="../common.css" type=text/css rel=stylesheet>
<LINK href="default.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择邮箱</title>
<script>
function display(emailTable, img)  {
	if (emailTable.style.display=="") {
		emailTable.style.display = "none";
		img.src = "images/open.gif";
	}
	else {
		emailTable.style.display = "";
		img.src = "images/close.gif";
	}
}
</script>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String sql;
String myname = privilege.getUser(request);
sql = "select id from email_pop3 where userName=" + StrUtil.sqlstr(myname);
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
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr align="center">
      <td width="199" align="left" class="right-title">&nbsp;<img src="images/close.gif" width="11" height="11" align="absmiddle" onClick="display(emailTable<%=i%>, this)" style="cursor:hand">&nbsp;<%=email%>      </td>
    </tr>
	<tr><td bgcolor="#FFFFFF">
	  <table id="emailTable<%=i%>" name="email<%=i%>" width="100%" border="0" cellpadding="0" cellspacing="0" style="display:">
    <tr align="center">
      <td height="24" align="left">&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/icoInbox.gif" width="16" height="16" align="absmiddle"> <a target="mainMailFrame" href="pop3_getmail_do.jsp?id=<%=epd.getId()%>">收件箱</a></td>
    </tr>
    <tr align="center">
      <td height="24" align="left">&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/icoSendmail.gif" width="16" height="16" align="absmiddle">&nbsp;<a target="mainMailFrame" href="pop3_sendmail_html.jsp?email=<%=epd.getEmail()%>">发邮件</a></td>
    </tr>
    <tr align="center">
      <td height="24" align="left">&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/icoDraft.gif" width="16" height="16" align="absmiddle">&nbsp;<a target="mainMailFrame" href="mail_list.jsp?type=<%=MailMsgDb.TYPE_DRAFT%>&sender=<%=epd.getEmail()%>">草稿箱</a> </td>
    </tr>
	</table>
	</td></tr>
</table>
<%
}
%>
</body>
</html>
