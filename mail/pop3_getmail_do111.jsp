<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.mail.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<html>
<head>
<title>取邮件</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<%@ include file="../inc/nocache.jsp" %>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<jsp:useBean id="fnumber" scope="page" class="cn.js.fan.util.NumberUtil"/>
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserLogin(request))
{
	out.println(SkinUtil.makeInfo(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
int id = -1;
try {
	id = ParamUtil.getInt(request, "id");
}
catch (ErrMsgException e) {
	out.print(SkinUtil.makeErrMsg(request, "请选择邮箱！"));
	return;
}
%>
<br>
<%
EmailPop3Db epd = new EmailPop3Db();
epd = epd.getEmailPop3Db(id);
if (!epd.getUserName().equals(privilege.getUser(request))) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
}
String email = epd.getEmail();
String mailserver = epd.getServer();
int port = epd.getPort();
String email_name = epd.getEmailUser();
String email_pwd_raw = epd.getEmailPwd();
GetMail getmail = new GetMail(mailserver,port,email_name,email_pwd_raw);
Message[] msgs = null;
String type = "list";
try { 
	msgs = getmail.receive(type);
}
catch (ErrMsgException e) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, e.getMessage()));
	return;
}
String mailID = "";
if (msgs==null)
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, "无邮件！"));
}
else {
%>
<form id=form1 name=form1 action="pop3_opmail.jsp" method="post">
  <table width="96%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
    <tr align="middle" bgcolor="#C4DAFF" class="stable">
      <td width="6%" class="stable">&nbsp;</td>
      <td width="8%" align="center" nowrap class="stable">优 先</td>
      <td width="8%" align="center" nowrap class="stable">状 态</td>
      <td width="21%" align="center" nowrap class="stable">发件人</td>
      <td width="22%" align="center" nowrap class="stable">主 题</td>
      <td width="19%" align="center" nowrap class="stable">日 期</td>
      <td width="16%" align="center" nowrap class="stable">大 小</td>
    </tr>
  </table>
  <%		
		int len = msgs.length;
        for(int msgNum = 0; msgNum < len; msgNum++) {
           MailMsg msg = getmail.getMessage(msgs[msgNum]);
           if (msg.getMessage().isSet(Flags.Flag.DELETED))
               ;//logger.error("It is deleted");
		   boolean isShow = false;
           if (type.equals(type)) {
              if (!msg.isDeleted())
                  isShow = true;
           }
           else if (type.equals("dustbin")) {
              if (msg.isDeleted())
                 isShow = true;
           }
           else
           	  isShow = true;
	      if (isShow) {
		  mailID = msg.getID();
		  java.util.Date senddate = msg.getSentDate();
		  String d = senddate==null?"":DateUtil.format(senddate, "yyyy-MM-dd HH:mm:ss");
%>
  <table width="96%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#C6DBFF">
    <tr class="stable" align="center">
      <td width="6%" bgcolor="#FFFFFF"><input title="选择/不选" type="checkbox" value="<%=msg.getID()%>" name="mailids"></td>
      <td width="8%" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="8%" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="21%" bgcolor="#FFFFFF"><a href="pop3_sendmail_html.jsp?to=<%=msg.getSender()%>&email=<%=email%>"><%=msg.getFrom()%></a></td>
      <td width="22%" bgcolor="#FFFFFF"><a href="pop3_showmail.jsp?mailid=<%=msg.getID()%>&email=<%=email%>&mailserver=<%=mailserver%>&port=<%=port%>&email_user=<%=email_name%>&email_pwd=<%=email_pwd_raw%>"><%=msg.getSubject()%></a></td>
      <td width="19%" bgcolor="#FFFFFF"><%=d%></td>
      <td width="16%" bgcolor="#FFFFFF"><%=fnumber.round((double)msg.getSize()/1000,2)%> k
        <%
				if (msg.hasAttachment()) {%>
          <img src="images/attach.gif">
          <%}
				%>
      </td>
    </tr>
  </table>
  <%		  
		}
	}
getmail.close();	
%>
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td align="center"><br>
          <input type="hidden" name="op">
          <input type="hidden" name="email" value="<%=email%>">
        <a href="javascript:form1.op.value='del';form1.submit()">删除所选邮件</a></td>
    </tr>
  </table>
</form>
<%}%>
</body>
</html>
