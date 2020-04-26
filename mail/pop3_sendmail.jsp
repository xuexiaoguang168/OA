<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发邮件</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<script>
function saveDrafe() {
	form1.action = "pop3_draft_save.jsp";
	form1.submit();
}
</script>
</head>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String to = fchar.getNullStr(fchar.UnicodeToGB(request.getParameter("to")));
String email = fchar.getNullString(request.getParameter("email"));
%>
<table width="" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="291" height="23" class="right-title">&nbsp;&nbsp;<span>发 
      邮 件&nbsp;</span></td>
    <td width="165" align="right" class="right-title"><a href="pop3_sendmail_html.jsp?email=<%=email%>" class="title_white">HTML方式</a>&nbsp;&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" valign="top" background="../images/tab-b-back.gif">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="2">
        <form id=form1 enctype="MULTIPART/FORM-DATA" name="form1" action="pop3_sendmail_do.jsp" method="post">
          <tr> 
            <td align="right">邮　箱：</td>
            <td>
			<jsp:useBean id="userpop3setup" scope="page" class="com.redmoon.oa.emailpop3.UserPop3Setup"/>
			<%
			String[] emails = userpop3setup.getUserEmails(privilege.getUser(request));
			String options = "";
			int len = 0;
			if (emails!=null)
				len = emails.length;
			for (int i=0; i<len; i++) {
				options += "<option value='"+emails[i]+"'>"+emails[i]+"</option>";
			}
			%>
			<select name="email">
				<%=options%>
              </select>
			  <input name=username type="hidden" value="<%=privilege.getUser(request)%>">
			  <%
			  if (!email.equals("")) { %>
			  <script language="JavaScript">
			  form1.email.value = "<%=email%>"
			  </script>
			  <%}
			  %>		    </td>
          </tr>
          <tr> 
            <td width="11%" align="right">收件人：</td>
            <td width="89%"><input class="p1" size="40" name="to" value="<%=to%>"></td>
          </tr>
          <tr> 
            <td align="right">主　题：</td>
            <td><input class="p1" size="40" name="subject"></td>
          </tr>
          <tr> 
            <td align="right">附　件：</td>
            <td><input id="filename1" type=file size=40 name=filename2></td>
          </tr>
          <tr> 
            <td align="right">&nbsp;</td>
            <td><input id="filename2" type=file size=40 name=filename22></td>
          </tr>
          <tr> 
            <td align="right">&nbsp;</td>
            <td><input id="filename3" type=file size=40 name=filename23></td>
          </tr>
          <tr> 
            <td align="right">正&nbsp;&nbsp;&nbsp;&nbsp;文：</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2"><textarea class="p1" name="content" rows="20" wrap="physical" cols="65"></textarea></td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="submit" class="button1" value=" 发 送 ">
              &nbsp;&nbsp;&nbsp;&nbsp;
              <input type="button" class="button1" value=" 存草稿 " onClick="saveDrafe()">              &nbsp;&nbsp;&nbsp; 
              <input type="reset" class="button1" value=" 重 写 ">            </td>
          </tr>
        </form>
      </table> 
      <p>&nbsp;</p></td>
  </tr>
  <tr> 
    <td height="9" colspan="2"><img src="../images/tab-b-bot.gif" height="9"></td>
  </tr>
</table>
</body>
</html>
