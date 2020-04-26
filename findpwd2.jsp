<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<html>
<head>
<title><%=Global.AppName%> - <lt:Label res="res.label.findpwd" key="findpwd"/>2</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="forum/<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.STYLE2 {color: #FFFFFF}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="sendmail" scope="page" class="cn.js.fan.mail.SendMail"/>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
String name = ParamUtil.get(request, "name");
if (name.equals("")) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.label.findpwd", "need_user_name")));
	return;
}
UserDb user = new UserDb();
user = user.getUserDbByNick(name);
if (user==null || !user.isLoaded()) {
	String str = SkinUtil.LoadString(request, "res.label.findpwd", "user_not_exist");
	str = StrUtil.format(str, new Object[] {name} );
	out.print(SkinUtil.makeErrMsg(request, str));
	return;
}

String answer = ParamUtil.get(request, "answer");
if (!answer.equals("")) {
	if (answer.equals(user.getAnswer())) {
		String to = user.getEmail();
		// to = "dsfadasfasfasfd@bndsfdafsadff.com";
		String mailserver = Global.smtpServer;
		int smtp_port = Global.smtpPort;
		String smtpname = Global.smtpUser;
		String pwd_raw = Global.smtpPwd;
		sendmail.initSession(mailserver, smtpname, pwd_raw);		
		String senderName = Global.AppName;
		senderName = StrUtil.GBToUnicode(senderName);
		senderName = senderName + "<" + Global.email + ">";		
		String subject = StrUtil.format(SkinUtil.LoadString(request, "res.label.findpwd", "subject"), new Object[] { Global.AppName });
		String content = StrUtil.format(SkinUtil.LoadString(request, "res.label.findpwd", "content"), new Object[] { user.getRawPwd() }); // "您的密码为：" + user.getRawPwd();
		sendmail.initMsg(to, senderName, subject, content, true);
		// out.print(to + " " + mailserver + " " + smtp_port + " " + smtpname + " " + pwd_raw + " senderName=" + senderName + " Global.email=" + Global.email + subject + " " + content);
		if ( sendmail.send())
			out.println(SkinUtil.makeInfo(request, SkinUtil.LoadString(request, "res.label.findpwd", "sended") + to));
		else
		{
		    out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "res.label.findpwd", "fail_reason") + sendmail.getErrMsg()));
		}
		sendmail.clear();		
		return;
	}
	else {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "res.label.findpwd", "err_answer")));
	}
}
%>
<p>&nbsp;</p>
<table width="46%" height="155"  border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="<%=skin.getTableBorderClr()%>">
  <tr>
    <td height="26" align="center" background="forum/<%=skinPath%>/images/bg1.gif" class="text_title">
	<lt:Label res="res.label.findpwd" key="answer_question"/></td>
  </tr>
  <tr>
    <td><table width="88%" border="0" align="center" cellpadding="1" cellspacing="0" class="p9">
      <form name=form1 action="findpwd2.jsp" method="post" onSubmit="return form1_onsubmit()">
        <tr>
          <td height="22" align="center"><lt:Label res="res.label.findpwd" key="user_name"/></td>
          <td height="22"><%=name%><input name="name" type=hidden value="<%=name%>"></td>
        </tr>
        <tr>
          <td height="22" align="center"><lt:Label res="res.label.findpwd" key="question"/></td>
          <td height="22"><%=user.getQuestion()%></td>
        </tr>
        <tr>
          <td width="28%" height="22" align="center"><lt:Label res="res.label.findpwd" key="answer"/></td>
          <td width="72%" height="22"><input name="answer" style="width:120">
            &nbsp;</td>
        </tr>
        <tr align="center">
          <td height="35" colspan="3"><input type=submit value="<lt:Label key="ok"/>">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
      </form>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>
<%@ include file="forum/inc/footer.jsp"%>
</body>
<script language="javascript">
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.answer.value=="")
		errmsg += "<lt:Label res="res.label.findpwd" key="need_answer"/>\n"
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}
//-->
</script>
</html>