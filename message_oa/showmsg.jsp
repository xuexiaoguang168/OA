<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="../inc/nocache.jsp"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.message.*"%>
<html>
<head>
<title>查看消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="../common.css" type=text/css rel=stylesheet>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserLogin(request))
{ %>
<table width="320" border="0" cellspacing="0" cellpadding="0" align="center" class="9black">
  <tr> 
    <td><li>您的登录已过期，请重新登录，如果不是会员请先注册。</td>
  </tr>
</table>
<% } %>
<jsp:useBean id="Msg" scope="page" class="com.redmoon.oa.message.MessageMgr"/>
<%
int id = ParamUtil.getInt(request, "id");
MessageDb md = Msg.getMessageDb(id);
if (md==null || !md.isLoaded()) {
	out.print(StrUtil.Alert_Redirect("该消息已不存在！", "message.jsp"));
	return;
}
String title,content,rq,receiver,sender;
int type;
boolean isreaded;
id = md.getId();
title = md.getTitle();
content = md.getContent();
type = md.getType();
rq = md.getRq();
receiver = md.getReceiver();
sender = md.getSender();
isreaded = md.isReaded();

if (!md.isDraft()) {
	md.setReaded(true);
	md.save();
}
%>
<table width="320" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#99CCFF" class="9black" height="260">
  <form name="form1" method="post" action="myreply.jsp?id=<%=id%>">
  <tr> 
    <td bgcolor="#CEE7FF" height="23">
        <div align="center"> <b>查 看 消 息</b></div>
    </td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF" height="50"> 
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td width="75"> 
              <div align="center"><a href="message.jsp?page=1"><img src="images/inboxpm.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"><a href="listdraft.jsp"><img src="images/m_draftbox.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"><a href="send.jsp"><img src="images/newpm.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"> 
                <a href="delmsg.jsp?ids=<%=id%>"><img src="images/m_delete.gif" width="40" height="40" border="0"></a> </div>
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr> 
      <td bgcolor="#FFFFFF" height="152" valign="top">
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black">
          <tr> 
            <td> 
              <div align="center"><font color="#05006C"><b><%=title%></b></font></div>
            </td>
          </tr>
          <tr>
            <td align="center">
			<%=sender%> <%=rq%> <input type="hidden" name="title" value="<%="RE:"+title%>">
			<input name="receiver" value="<%=sender%>" type="hidden"></td>
          </tr>
        </table>
        <hr size="1" width="300">
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black">
          <tr> 
            <td height="91" valign="top">
			<%
			String body = content; // StrUtil.toHtml(content);
			%>
			<%=StrUtil.ubb(request, content, true)%>
			<br><br>
			<%
			Iterator ir = md.getAttachments().iterator();
			while (ir.hasNext()) {
				Attachment att = (Attachment)ir.next();
			%>
			<img src="../images/attach.gif" align="absmiddle" />				<a href="getfile.jsp?attachId=<%=att.getId()%>&msgId=<%=md.getId()%>" target="_blank"><%=att.getName()%></a>
				<BR>
			<%}%>
			</td>
          </tr>
        </table>
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black">
          <tr> 
            <td> 
              <div align="center">
			  <%if (md.isDraft()) {%>
                <input type="button" name="Button" value="发送消息" class="button1" onClick="window.location.href='send_do.jsp?op=sendDraft&id=<%=md.getId()%>'">
			  <%}else{
			  	if (type != MessageDb.TYPE_SYSTEM) {
			  %>
                <input type="submit" name="Button" value="回复消息" class="button1">
			  <%}
			  }%>
              </div>
            </td>
          </tr>
        </table>
      </td>
  </tr>
  <tr> 
    <td bgcolor="#CEE7FF" height="6"></td>
  </tr></form>
</table>
</body>
</html>
