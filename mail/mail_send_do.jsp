<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发邮件</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String op = ParamUtil.get(request, "op");
MailMsgMgr mmm = new MailMsgMgr();

int id = ParamUtil.getInt(request, "id");
MailMsgDb mmd = null;
boolean re = false;
SendMail sm = new SendMail();
try {
	mmd = mmm.getMailMsgDb(request, id);
	sm.getMailInfo(request, mmd);
	re = sm.send();
}
catch (ErrMsgException e) {
	out.print(SkinUtil.makeErrMsg(request, e.getMessage()));
	return;
}
%>
<table width="80%" height="174" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td width="74%" height="23" class="right-title">&nbsp;&nbsp;发 送 
      邮 件</td>
    <td width="26%" class="right-title">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" valign="top" bgcolor="#FFFFFF"><p>
	<%
	if (re)
		out.print(StrUtil.p_center("发送成功！"));
	else {
	   out.println("邮件发送失败，原因是："+sm.geterrinfo());
	}	
	%>
	</p></td>
  </tr>
  <tr> 
    <td height="9" colspan="2">&nbsp;</td>
  </tr>
</table>
</body>
</html>
