<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.mail.GetMail"%>
<%@ page import="cn.js.fan.mail.MailMsg"%>
<%@ page import="cn.js.fan.mail.Attachment"%>
<%@ page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>显示邮件</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 3px;
}
-->
</style></head>
<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr>
    <td width="100%" height="23" class="right-title">&nbsp;&nbsp;查 看 邮 件</td>
  </tr>
  <tr>
    <td valign="top">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String email = request.getParameter("email");
String mailserver = request.getParameter("mailserver");
String port = request.getParameter("port");
int intport = Integer.parseInt(port);
String email_name = request.getParameter("email_user");
String email_pwd_raw = request.getParameter("email_pwd");

String mailid = fchar.getNullStr(request.getParameter("mailid"));
if (!fchar.isNumeric(mailid)) {
	out.println(fchar.Alert_Back("邮件编号无效！"));
	return;
}
GetMail getmail = new GetMail(mailserver,intport,email_name,email_pwd_raw);//pub.zj.jsinfo.net","fgf163","1011");
MailMsg mailmsg = getmail.getMessageOfNum(Integer.parseInt(mailid));
if (mailmsg==null) {
	out.println(fchar.p_center("邮件为空！"));
	return;
}
String[] Recipients = mailmsg.getRecipients();
%>
<br>
    <table width="95%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr class="stable">
          <td width="13%" bgcolor="#C4DAFF" class="stable">发件人： </td>
          <td width="35%" bgcolor="#C4DAFF" class="stable"><a href="pop3_sendmail.jsp?to=<%=mailmsg.getSender()%>&email=<%=email%>"><%=mailmsg.getFrom()%></a></td>
          <td width="15%" bgcolor="#C4DAFF" class="stable"> 发送日期：</td>
          <td width="37%" bgcolor="#C4DAFF" class="stable"><%=(mailmsg.getSentDate()==null)?"":DateUtil.format(mailmsg.getSentDate(), "yyyy-MM-dd HH")%></td>
        </tr>
        <tr class="stable">
          <td bgcolor="#EEEEEE" class="stable">收件人：          </td>
          <td bgcolor="#EEEEEE" class="stable"><%
if (Recipients!=null) {
	int rl = Recipients.length;
	for (int i=0; i<rl; i++){
		out.print(Recipients[i]+"&nbsp;");
	}
}
%></td>
          <td bgcolor="#EEEEEE" class="stable">优先级：</td>
          <td bgcolor="#EEEEEE" class="stable">普通</td>
        </tr>
        <tr class="stable">
          <td bgcolor="#EEEEEE" class="stable">附 &nbsp;件：          </td>
          <td bgcolor="#EEEEEE" class="stable"><%
		  Vector attachs = mailmsg.getAttachments();
		  int size = attachs.size();
		  if (attachs!=null && size>0) {
			  Enumeration e = attachs.elements();
			  while (e.hasMoreElements()) {
				Attachment a = (Attachment)e.nextElement();
				out.print("<img src=images/attach.gif>");
				out.print("<a href='getattach.jsp?email=" + email + "&mailid="+mailmsg.getID()+"&attachnum="+a.getNum()+"'>"+a.getName()+"</a><BR>");
			  }
		  }
		  else
		  	out.print("无");
%></td>
          <td bgcolor="#EEEEEE" class="stable">抄　送：</td>
          <td bgcolor="#EEEEEE" class="stable">(无)</td>
        </tr>
        <tr bgcolor="#FFFFFF" class="stable">
          <td colspan="4" class="stable">主　题：<%=mailmsg.getSubject()%></td>
        </tr>
        <tr bgcolor="#FFFFFF" class="stable">
          <td colspan="4" class="stable">            <%=mailmsg.getContent()%> </td>
        </tr>
      </table>
      <p><br> 
 </p></td>
  </tr>
</table>
</body>
</html>
