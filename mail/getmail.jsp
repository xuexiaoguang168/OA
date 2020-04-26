<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="fan.mail.GetMail"%>
<%@ page import="fan.mail.MailMsg"%>
<%@ page import="fan.mail.Attachment"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>取邮件</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></head>
<%@ include file="../inc/nocache.jsp" %>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<jsp:useBean id="fnumber" scope="page" class="fan.util.FNumber"/>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="23" valign="bottom" background="../images/tab-b6-top.gif">　　　　　<span class="right-title">收 件 箱</span></td>
  </tr>
  <tr>
    <td height="281" valign="top" background="../images/tab-b-back.gif"> <br>
<%
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
GetMail getmail = new GetMail(mailserver,port,email_name,email_pwd_raw);
Vector maillist = getmail.receive("list");
String mailID = "";
if (maillist.size()==0)
{
	out.println(fchar.p_center("无邮件！"));
}
else {
%>
<form id=form1 name=form1 action="opmail.jsp" method="post">
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
        <%		
		java.util.Enumeration msglist = maillist.elements();
		while (msglist.hasMoreElements())
		{
		  MailMsg msg = (MailMsg)msglist.nextElement();
		  mailID = msg.getID();
%>
        <tr class="stable" align="center">
          <td class="stable"><input title="选择/不选" type="checkbox" value="<%=msg.getID()%>" name="mailids"></td>
          <td class="stable">&nbsp; </td>
            <td class="stable">&nbsp; </td>
          <td class="stable"><a href="sendmail.jsp?to=<%=msg.getFrom()%>"><%=msg.getFrom()%></a></td>
          <td class="stable"><a href="showmail.jsp?mailid=<%=msg.getID()%>"><%=msg.getSubject()%></a></td>
          <td class="stable"><%=fchar.formatDate(msg.getSentDate())%></td>
          <td class="stable"><%=fnumber.round((double)msg.getSize()/1000,2)%> k
              <%
				if (msg.hasAttachment()) {%>
              <img src="images/attach.gif">
          <%}
				%>          </td>
        </tr>
        <%		  
		}
%>
      </table>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center"><br><input type="hidden" name="op">
              <a href="javascript:form1.op.value='del';form1.submit()">删除所选邮件</a></td>
        </tr>
      </table></form> 
<%}%>	  
	  </td>
  </tr>
  <tr>
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>
