<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>
发送邮件
</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="sendmail" scope="page" class="com.redmoon.oa.emailpop3.SendMail" />
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<table width="564" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" class="right-title">&nbsp;&nbsp;发 
      邮 件</td>
  </tr>
  <tr> 
    <td valign="top"></p></td>
  </tr>
  <tr> 
    <td height="9"><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="tableframe">
      <tr>
        <td height="176" align="center" bgcolor="#FFFFFF"><jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
          
            <%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
            <%
sendmail.getMailInfo(application, request);
if (sendmail.send())
   out.println("邮件发送成功！");
else
{
   out.println("邮件发送失败，原因是："+sendmail.geterrinfo());
}
%>
            <br>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
