<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="../inc/inc.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ʼ�</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<script language=javascript>
function form1_onsubmit() {
	if (form1.pwd.value=="")
	{
		alert("���벻��Ϊ�գ�");
		return false;
	}
	if (form1.pwd.value!=form1.pwd1.value)
	{
		alert("������ȷ�����벻��������������룡");
		return false;
	}
}
</script>
<body leftmargin="0" topmargin="5">

<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="fsecurity" scope="page" class="fan.util.fsecurity"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<table width="" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b6-top.gif">����������<span class="right-title">�� 
      �� �� ��</span></td>
  </tr>
  <tr>
    <td height="301" valign="top" background="../images/tab-b-back.gif"> 
      <%
String priv="read";
String email_name = "";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = fchar.getNullStr(request.getParameter("op"));
if (!op.equals("")) {
    email_name = fchar.getNullStr(request.getParameter("email_name"));
    String email_pwd = fchar.getNullStr(request.getParameter("pwd"));
	if (userservice.modUserEmailPwd(email_name, email_pwd)) {
		out.println(fchar.p_center("<BR>��������ɹ���"));
	}
	else
		out.println(fchar.p_center("<BR><font color=red>��������ʧ�ܣ�</font>"));
}
else {//ȡ�ø��û�����������
	 String[] r = userservice.getUserEmailNamePwd(privilege.getUser(request));
	 if (r!=null) {
	 	email_name = fchar.getNullStr(r[0]);
	 }
	 else {
	 	email_name = "";	
	 }
}

if (email_name.equals("")) {
	out.print(fchar.p_center("<BR><BR><BR><BR>����������δ��ͨ���������Ա���룡<br><br><br><br><br><br>"));
}
else {

%>
	<table width="48%" border="0" align="center" cellpadding="0" cellspacing="2">
        <form id=form1 name="form1" action="setmail.jsp?op=set" method="post" onSubmit="return form1_onsubmit()">
          <tr> 
            <td align="right">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="28%" align="right">�û�����</td>
            <td width="72%"><%=email_name%><input name="email_name" type=hidden value="<%=email_name%>"></td>
          </tr>
          <tr> 
            <td align="right">��&nbsp;&nbsp;�룺</td>
            <td><input type=password class="p1" size="20" name="pwd"></td>
          </tr>
          <tr> 
            <td align="right">ȷ&nbsp;&nbsp;�ϣ�</td>
            <td><input type=password class="p1" size="20" name="pwd1"></td>
          </tr>
          <tr align="center"> 
            <td colspan="2"><br>
              <input type="submit" name="Submit" value="�ύ"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="reset" name="Submit2" value="����"> </td>
          </tr>
        </form>
      </table> 
<%}%>
</td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" height="9"></td>
  </tr>
</table>
</body>
</html>
