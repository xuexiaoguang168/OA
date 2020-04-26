<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.util.ErrMsgException"%>
<html>
<head>
<title>消息回复</title>
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
<% 
	return;
} %>
<%
  String title,receiver;
  title = ParamUtil.get(request, "title");
  receiver = ParamUtil.get(request, "receiver");
%>
<table width="320" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#99CCFF" class="9black" height="260">
  <form name="form1" method="post" action="myreplytodb.jsp" enctype="multipart/form-data">
  <tr> 
    <td bgcolor="#CEE7FF" height="23">
        <div align="center"> <b>消 息 回 复</b></div>
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
              <div align="center"><a href="mysend.jsp"><img src="images/m_outbox.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"><img src="images/newpm.gif" width="40" height="40" border="0"></div>
            </td>
            <td width="75"> 
              <div align="center"><img src="images/m_delete.gif" width="40" height="40"></div>
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr> 
      <td bgcolor="#FFFFFF" height="152" valign="top">
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black" height="6">
          <tr> 
            <td></td>
          </tr>
        </table>
        <table width="300" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
          <tr> 
            <td width="68" height="26"> 
              <div align="center">消息标题：</div>            </td>
            <td width="217" height="26"> 
              <input type="text" name="title" class="input1" size="30" value="<%=title %>">            </td>
          </tr>
          <tr> 
            <td width="68" height="26"> 
              <div align="center">接 收 者：</div>            </td>
            <td width="217" height="26"> 
			  	<%
				com.redmoon.oa.person.UserDb ud = new com.redmoon.oa.person.UserDb();
			  	ud = ud.getUserDb(receiver);
				String userRealName = ud.getRealName();
			    %>
              <input type="hidden" name="receiver" value="<%=receiver %>">
              <input type="text" readonly name="userRealName" class="input1" size="20" maxlength="20" value="<%=userRealName %>">
			  </td>
          </tr>
          <tr> 
            <td width="68" height="26"> 
              <div align="center">消息内容：</div>            </td>
            <td width="217" height="26"> 
              <textarea name="content" cols="26" rows="3"></textarea>            </td>
          </tr>
          <tr>
            <td height="26" align="center">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：</td>
            <td height="26"><input type="file" name="filename"></td>
          </tr>
          <tr> 
            <td colspan="2" height="26"> 
              <div align="center">
                <input type="submit" name="Submit" value="发送" class="button1">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <input type="reset" name="Submit2" value="重写" class="button1">
                &nbsp;&nbsp;
                <%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
&nbsp;&nbsp;
<input name="isToMobile" value="true" type="checkbox" checked>
短讯
<%}%>
              </div>            </td>
          </tr>
        </table>
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black" height="6">
          <tr> 
            <td></td>
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
