<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>
发送邮件
</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="sendmail" scope="page" class="fan.mail.SendMail" />
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<table width="" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b6-top.gif">　　　　　<span class="right-title">发 
      邮 件</span></td>
  </tr>
  <tr> 
    <td valign="top" background="../images/tab-b-back.gif">
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td> 
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="176" align="center">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>				
				<br>
<%
cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String mailserver = props.getProperty("mailserver");
String smtp_port = props.getProperty("smtp_port");
String[] r = userservice.getUserEmailNamePwd(privilege.getUser(request));
if (r==null) {
	out.println(fchar.p_center("你的请邮箱尚未开通，请向管理员申请！"));
	return;
}
String email_name = r[0];
String email_pwd_raw = r[1];
sendmail.initSession(mailserver,smtp_port,email_name,email_pwd_raw);
sendmail.setFrom(email_name+"@"+mailserver);
//sendmail.setmailFooterHTML("<br>--镇江商城!--");
sendmail.getMailInfo(application, request);
if ( sendmail.send())
   out.println("邮件发送成功！");
else
{
   out.println("邮件发送失败，原因是："+sendmail.geterrinfo());
 }
%>
                  <br>
                </td>
              </tr>
            </table> </td>
  </tr>
</table>
      </p></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" height="9"></td>
  </tr>
</table>
</body>
</html>
