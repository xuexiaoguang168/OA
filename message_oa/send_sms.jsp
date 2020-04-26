<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.sms.*"%>
<LINK href="../common.css" type=text/css rel=stylesheet>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String name = privilege.getUser(request);
String mobile = ParamUtil.get(request, "mobile");
String op = ParamUtil.get(request, "op");
boolean re = false;
if (op.equals("send")) {
    IMsgUtil imu = SMSFactory.getMsgUtil();
	String content = ParamUtil.get(request, "content");
	if (imu!=null) {
		imu.send(mobile, content, name);
		out.print(StrUtil.Alert_Back("发送成功！"));
		return;
	}
	else {
		out.print(StrUtil.Alert_Back("短讯发送功能未开通！"));
	}
	return;
}
%>
<html><head>
<title>撰写消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language=javascript>
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.mobile.value=="")
		errmsg += "请填写手机号码！\n"
	if (form1.content.value=="")
		errmsg += "请填写内容！\n"
	if (form1.content.value.length>70)
		errmsg += "请不要超过70个字符！\n";
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
if (!privilege.isUserLogin(request))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}%>
<br>
<table width="320" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#99CCFF" class="9black" height="230">
  <form action="?op=send" method="post" name="form1" onSubmit="return form1_onsubmit()"><tr> 
    <td bgcolor="#CEE7FF" height="23">
        <div align="center"> <b>撰 写 手 机 短 讯</b><strong></strong></div>    </td>
  </tr>
  <tr> 
      <td bgcolor="#FFFFFF" height="100" valign="top">
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black" height="6">
          <tr> 
            <td></td>
          </tr>
        </table>
        <table width="300" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
          <tr> 
            <td width="68" height="27"> 
              <div align="center">手机号码：</div>            </td>
            <td width="217" height="27"><input type="text" name="mobile" size="20" maxlength="12" value="<%=mobile%>"></td>
          </tr>
          
          <tr> 
            <td width="68" height="26"> 
              <div align="center">短讯内容：</div>            </td>
            <td width="217" height="26"> 
              <textarea name="content" cols="28" rows="5"></textarea>            </td>
          </tr>
          
          <tr> 
            <td colspan="2" height="26"> 
              <div align="center">
                <input type="submit" name="Submit" value="发送" class="button1">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <input type="reset" name="Submit2" value="重写" class="button1">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>            </td>
          </tr>
        </table>
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black" height="6">
          <tr> 
            <td></td>
          </tr>
      </table>      </td>
  </tr>
  <tr> 
    <td bgcolor="#CEE7FF" height="6"></td>
  </tr></form>
</table>
</body>
</html>
