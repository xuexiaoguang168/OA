<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="cn.js.fan.mail.GetMail"%>
<%@ page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>邮件操作</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
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
    <td height="23" valign="bottom" class="right-title">&nbsp;删 
      除 邮 件</td>
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
String email = fchar.getNullStr(request.getParameter("email"));
String[] mailids = request.getParameterValues("mailids");
%>
<jsp:useBean id="userpop3setup" scope="page" class="com.redmoon.oa.emailpop3.UserPop3Setup"/>
<%
userpop3setup.getUserPop3Setup(privilege.getUser(request),email);
String mailserver = userpop3setup.getMailServer();
int port = userpop3setup.getPort();
String email_name = userpop3setup.getUser();
String email_pwd_raw = userpop3setup.getPwd();

//out.print(email+","+mailserver+","+port+","+email_name+","+email_pwd_raw);
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
	else
		out.print(fchar.Alert_Back("请选择要删除的邮件！"));
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
