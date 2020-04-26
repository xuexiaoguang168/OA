<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发邮件</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<script>
function form1_onsubmit() {
	form1.content.value = getHtml();
	if (form1.content.value.length>3000) {
		// alert("您输入的数据太长，不允许超过3000字！");
		// return false;
	}
}

function saveDrafe() {
	form1.action = "pop3_draft_save.jsp";
	form1.content.value = getHtml();
	if (form1.content.value.length>3000) {
		// alert("您输入的数据太长，不允许超过3000字！");
		// return false;
	}
	form1.submit();
}
</script>
</head>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String op = ParamUtil.get(request, "op");
MailMsgMgr mmm = new MailMsgMgr();

int id = ParamUtil.getInt(request, "id");
MailMsgDb mmd = null;
try {
	mmd = mmm.getMailMsgDb(request, id);
}
catch (ErrMsgException e) {
	out.print(SkinUtil.makeErrMsg(request, e.getMessage()));
	return;
}
%>
<table width="" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="367" height="23" class="right-title">&nbsp;&nbsp;查 看 
      邮 件</td>
    <td width="127" class="right-title">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" valign="top" background="../images/tab-b-back.gif">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr> 
            <td align="right">邮　箱：</td>
            <td>
			<jsp:useBean id="userpop3setup" scope="page" class="com.redmoon.oa.emailpop3.UserPop3Setup"/>
			<%=mmd.getSender()%>
			</td>
          </tr>
          <tr> 
            <td width="11%" align="right">收件人：</td>
            <td width="89%"><%=mmd.getReceiver()%></td>
          </tr>
          <tr> 
            <td align="right">主　题：</td>
            <td><%=mmd.getSubject()%></td>
          </tr>
          
          <tr> 
            <td align="right">正&nbsp;&nbsp;&nbsp;&nbsp;文：</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2">
			<%=mmd.getContent()%>
			</td>
          </tr>
          <tr align="center">
            <td colspan="2" align="left">附件：
              <%
					  java.util.Iterator attir = mmd.getAttachments().iterator();
					  while (attir.hasNext()) {
					  	Attachment att = (Attachment)attir.next();
					  %>
                <li><img src="../images/attach.gif" width="17" height="17">&nbsp;<a target="_blank" href="email_getfile.jsp?id=<%=mmd.getId()%>&attachId=<%=att.getId()%>"><%=att.getName()%></a>&nbsp;&nbsp;&nbsp;<a href="?op=delattach&id=<%=mmd.getId()%>&attachId=<%=att.getId()%>"></a></li>
            <%}%></td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="button" class="button1" value=" 发 送 " onClick="window.location.href='mail_send_do.jsp?op=send&id=<%=mmd.getId()%>'">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="button" onClick="window.location.href='mail_edit.jsp?id=<%=mmd.getId()%>'" class="button1" value=" 修 改 ">            </td>
          </tr>
      </table> 
      <p>&nbsp;</p></td>
  </tr>
  <tr> 
    <td height="9" colspan="2"><img src="../images/tab-b-bot.gif" height="9"></td>
  </tr>
</table>
</body>
</html>
