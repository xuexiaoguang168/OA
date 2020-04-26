<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="fan.mail.GetMail"%>
<%@ page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>邮件操作</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
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
    <td height="23" valign="bottom" background="../images/tab-b6-top.gif">　　　　　<span class="right-title">删 
      除 邮 件</span></td>
  </tr>
  <tr> 
    <td height="300" valign="top" background="../images/tab-b-back.gif"> 
      <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td align="center"><br>
<%
String op = fchar.getNullStr(request.getParameter("op"));
String[] mailids = request.getParameterValues("mailids");

cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String mailserver = props.getProperty("mailserver");
String pop3_port = props.getProperty("pop3_port");
String[] r = userservice.getUserEmailNamePwd(privilege.getUser(request));
if (r==null) {
	out.println(fchar.p_center("你的请邮箱尚未开通，请向管理员申请！"));
	return;
}
int port = Integer.parseInt(pop3_port);
String email_name = r[0];
String email_pwd_raw = r[1];

if (op.equals("del")) {
	if (mailids!=null) {
        //GetMail getmail = new GetMail("202.102.4.20","welcome@zjpages.com","tengtu818");
		GetMail getmail = new GetMail(mailserver,port,email_name,email_pwd_raw);
		if (getmail.delMessageOfNum(mailids)) {
			out.println(fchar.Alert_Back("删除邮件成功！"));
		}
		else {
			out.println(fchar.Alert_Back("删除邮件未能成功！"));
		}
	}
}
%>
                  <br> </td>
              </tr>
            </table></td>
        </tr>
      </table>
      <p></p></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" height="9"></td>
  </tr>
</table>
</body>
</html>
