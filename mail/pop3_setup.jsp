<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发邮件</title>
<%@ include file="../inc/nocache.jsp"%>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<script language=javascript>
function form1_onsubmit() {
	if (form1.email.value=="")
	{
		alert("邮箱不能为空！");
		return false;
	}
}
</script>
<body leftmargin="0" topmargin="5">
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
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <tr> 
    <td width="100%" height="23" valign="bottom" class="right-title">&nbsp;POP3 
      邮 箱 设 置</td>
  </tr>
  <tr>
    <td height="301" valign="top">
<%
	String op = fchar.getNullString(request.getParameter("op"));
	if (op.equals("add")) {
	boolean re = false;
		try {
			EmailPop3Mgr epm = new EmailPop3Mgr();
			re = epm.create(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert(e.getMessage()));
		}
		if (re)
			out.print(StrUtil.Alert("操作成功！"));
	}

	String sql;
	String myname = privilege.getUser(request);
	sql = "select id from email_pop3 where userName="+fchar.sqlstr(myname);
			
	EmailPop3Db epd = new EmailPop3Db();
	Iterator ir = epd.list(sql).iterator();
		
	int i = 0;
	String email = "",email_user="",email_pwd="",mailserver="";
	int id,port;
%>
      <table width="90%" height="5" border="0" align="center">
        <tr> 
          <td></td>
        </tr>
      </table>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0">
        <tr align="center" bgcolor="#C4DAFF" class="stable"> 
          <td width="21%"> 邮箱名称</td>
          <td>邮箱设置</td>
          <td width="22%">操作 </td>
        </tr>
      </table>
      <%	
		while (ir.hasNext()) {
		epd = (EmailPop3Db)ir.next();
		i++;
		email = epd.getEmail();
		email_user = epd.getEmailUser();
		email_pwd = epd.getEmailPwd();
		id = epd.getId();
		mailserver = epd.getServer();
		port = epd.getPort();
		%>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
        <form id=formadd<%=i%> action="pop3_setup_do.jsp?op=edit" method=post>
          <tr align="center" bgcolor="#EEEEEE" class="stable"> 
            <td width="21%" rowspan="5"> <div align="left"><%=email%> 
                <input name=email type=hidden value="<%=email%>"><input type="hidden" name="id" value="<%=id%>">
              </div>
            <div align="center"></div></td>
            <td width="17%">用户名 </td>
            <td width="40%"><input name=emailUser class="singleboarder" id="emailUser" value="<%=email_user%>" size=25>            </td>
            <td width="22%" rowspan="5"> <input name="Submit3" type="submit" class="button1" value="修改"> 
            &nbsp; <input name="Submit4" type="button" class="button1" value="删除" onClick="javascript:window.location.href='pop3_setup_do.jsp?op=del&id=<%=id%>&email=<%=email%>'"></td>
          </tr>
          <tr align="center" bgcolor="#EEEEEE" class="stable">
            <td>密&nbsp;&nbsp;&nbsp; 码</td>
            <td><input name=emailPwd type=password class="singleboarder" id="emailPwd" value="<%=email_pwd%>" size=25></td>
          </tr>
          <tr align="center" bgcolor="#EEEEEE" class="stable"> 
            <td>邮件服务器</td>
            <td><input name=server class="singleboarder" id="server" value="<%=mailserver%>" size=25></td>
          </tr>
          <tr align="center" bgcolor="#EEEEEE" class="stable"> 
            <td>smtp端口</td>
            <td><input name=smtpPort class="singleboarder" value="<%=epd.getSmtpPort()%>" size=25></td>
          </tr>
          <tr align="center" bgcolor="#EEEEEE" class="stable">
            <td>pop3端口</td>
            <td><input name=port class="singleboarder" value="<%=port%>" size=25></td>
          </tr>
        </form>
      </table>
      <%
		}
%>
      <br>
      <table width="58%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#E1E6EC" class="tableframe">
        <form id=form1 name="form1" action="?op=add" method="post" onSubmit="return form1_onsubmit()">
          <tr align="center"> 
            <td colspan="2" class="right-title"><strong>增加邮箱</strong></td>
          </tr>
          <tr> 
            <td align="right">邮&nbsp;&nbsp;&nbsp;&nbsp;箱：</td>
            <td><input type=text class="singleboarder" size="20" name="email"></td>
          </tr>
          <tr> 
            <td width="28%" align="right">用户名：</td>
            <td width="72%"><input name="emailUser" type=text class="singleboarder" id="emailUser" size="20">            </td>
          </tr>
          <tr> 
            <td align="right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
            <td><input name="emailPwd" type=password class="singleboarder" id="emailPwd" size="20"></td>
          </tr>
          <tr> 
            <td align="right">邮件服务器：</td>
            <td><input name="server" type=text class="singleboarder" id="server" size="20"></td>
          </tr>
          <tr>
            <td align="right">smtp端&nbsp;口：</td>
            <td><input type=text class="singleboarder" size="20" name="smtpPort"></td>
          </tr>
          <tr>
            <td align="right">pop3端口：</td>
            <td><input type=text class="singleboarder" size="20" name="port"></td>
          </tr>
          <tr align="center"> 
            <td colspan="2"><br> <input name="Submit" type="submit" class="singleboarder" value="提交"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input name="Submit2" type="reset" class="singleboarder" value="重置">            </td>
          </tr>
        </form>
      </table>    
      <br></td>
  </tr>
</table>
</body>
</html>
