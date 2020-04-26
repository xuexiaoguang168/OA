<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>OA登录</title>
<%@ include file="inc/nocache.jsp"%>
<link href="css.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
var restrictpcinoffice = "no";
//-->
</script>
</head>

<body bgcolor="#043DA4" onLoad="javascript:form1.name.focus()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
String isopennew = fchar.getNullString(request.getParameter("isopernew"));
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><div align="center">
        <table width="351" height="222" border="0" cellpadding="0" cellspacing="0" background="images/login.jpg">
          <tr> 
            <td width="103">&nbsp;</td>
            <td width="248" valign="top">
<p>&nbsp;</p>
              <table width="197" height="117" border="0" align="center" cellpadding="0" cellspacing="0" background="images/logintab.gif">
			    <form name=form1 action="login_oa.jsp" method="post" onSubmit="return form1_onsubmit()">
                <tr> 
                  <td width="80" height="53" valign="bottom"><div align="center"> 
                    </div></td>
                  <td width="117" valign="bottom"><input name="name" type="text" class="fblank" size="12" style="width:90px" value="admin" onKeyDown="name_presskey()"></td>
                </tr>
                <tr> 
                  <td height="25"><div align="center"></div></td>
                  <td height="25"><input name="pwd" type="password" class="fblank" size="12" style="width:90px"></td>
                </tr>
                <tr> 
                  <td> <div align="right"></div></td>
                  <td><div align="center">  
				    <input name="imageField2" type="image" src="images/blogin.gif" width="62" height="19" border="0">
				    <input type=hidden name="pcinfo" value="">
                      </div></td>
                </tr></form>
              </table></td>
          </tr>
        </table>
        </div></td>
  </tr>
</table>
</body>
<script language="javascript">
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.name.value=="")
		errmsg += "请输入用户名！\n"
	if (form1.pwd.value=="")
		errmsg += "请输入密码！\n"
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}

function name_presskey() {
	if (window.event.keyCode==13) {
		window.event.keyCode = 9;
	}
}
//-->
</script>
</html>
