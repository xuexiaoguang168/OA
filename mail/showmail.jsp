<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="fan.mail.GetMail"%>
<%@ page import="fan.mail.MailMsg"%>
<%@ page import="fan.mail.Attachment"%>
<%@ page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="23" valign="bottom" background="../images/tab-b6-top.gif">　　　　　<span class="right-title">查 看 邮 件</span></td>
  </tr>
  <tr>
    <td valign="top" background="../images/tab-b-back.gif">
      <p>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>		  
<%
cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String mailserver = props.getProperty("mailserver");
String[] r = userservice.getUserEmailNamePwd(privilege.getUser(request));
if (r==null) {
	out.println(fchar.p_center("你的请邮箱尚未开通，请向管理员申请！"));
	return;
}
String email_name = r[0];
String email_pwd_raw = r[1];

String mailid = fchar.getNullStr(request.getParameter("mailid"));
if (!fchar.isNumeric(mailid)) {
	out.println(fchar.Alert_Back("邮件编号无效！"));
	return;
}
GetMail getmail = new GetMail(mailserver,email_name,email_pwd_raw);//pub.zj.jsinfo.net","fgf163","1011");
MailMsg mailmsg = getmail.getMessageOfNum(Integer.parseInt(mailid));
if (mailmsg==null) {
	out.println(fchar.p_center("邮件为空！"));
	return;
}
String[] Recipients = mailmsg.getRecipients();
%>
</p><br>

      <table width="95%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr class="stable">
          <td width="13%" bgcolor="#C4DAFF" class="stable">发件人： </td>
          <td width="35%" bgcolor="#C4DAFF" class="stable"><a href="sendmail.jsp?to=<%=mailmsg.getFrom()%>"><%=mailmsg.getFrom()%></a></td>
          <td width="15%" bgcolor="#EEEEEE" class="stable"> 发送日期：</td>
          <td width="37%" bgcolor="#EEEEEE" class="stable"><%=fchar.formatDate(mailmsg.getSentDate())%></td>
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
				out.print("<a href='getattach.jsp?mailid="+mailmsg.getID()+"&attachnum="+a.getNum()+"'>"+a.getName()+"</a><BR>");
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
  <tr>
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>
