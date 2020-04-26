<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.security.*"%>
<html>
<head>
<title>用户信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="common.css" type="text/css">
<%@ include file="inc/nocache.jsp" %>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="3">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<div id="newdiv" name="newdiv">
<%
String username = ParamUtil.get(request, "userName");
UserMgr um = new UserMgr();
UserDb user = um.getUserDb(username);
if (user==null || !user.isLoaded()) {
	out.print(StrUtil.Alert_Back("该用户已不存在！"));
	return;
}
%>
<table width=98% align=center cellspacing=0 cellpadding=0 border=0>
  <Form method="POST" action="user_edit_do.jsp"  name="memberform">
    <tr>
      <td bgcolor=#D3D3D3><table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor="#CCCCCC">
        <tr>
          <td align=center bgcolor="#FFFFFF"><table width=100% border=0 cellpadding=0 cellspacing=0>
                  <tr>
                    <td height=24 bgcolor="#C4DAFF" class="stable"><b>　<%=user.getRealName()%></b>&nbsp;个人资料&nbsp;&nbsp;
					</td>
                  </tr>
              </table>
            <table width=100% border=0 cellpadding=2 cellspacing=0>
                  <tr>
                    <td width=102 height="25" align=right bgcolor="#eeeeee" class="stable"><div align="right">性别</div></td>
                    <td width="297" height="25" class="stable"><% 
				  String strGender = "";
				  if (user.getGender()==0)
				  	strGender = "男";
				  else
				  	strGender = "女";
				  %>
				  <%=strGender%>				  </td>
                    <td width="115" height="28" bgcolor="#eeeeee" class="stable"><div align="right">婚姻状况</div></td>
                    <td width="202" height="28" class=stable><%=user.getMarriaged()%></td>
                  </tr>
                  <tr>
                    <td width=102 height="28" align=right bgcolor="#eeeeee" class="stable"><div align="right">出生日期</div></td>
                    <td height="28" class="stable"><%
				Date bd = user.getBirthday();
				out.print(DateUtil.format(bd, "yyyy-MM-dd"));
				  %>
					</td>
                    <td width="115" height="25" align="right" bgcolor="#eeeeee" class="stable"><div align="right">QQ</div></td>
                    <td height="25" align="left" class=stable><%=user.getQQ()%>                    </td>
                  </tr>
                  <tr>
                    <td width=102 height="25" align=right bgcolor="#eeeeee" class="stable"><div align="right">E-mail</div></td>
                    <td height="25" class="stable"><%=StrUtil.getNullString(user.getEmail())%>                    </td>
                    <td width=115 height="25" align="right" bgcolor="#eeeeee" class="stable">MSN</td>
                    <td class=stable height="25"><%=StrUtil.getNullString(user.getMSN())%></td>
                  </tr>
                  <tr>
                    <td width=102 height="25" align=right bgcolor="#eeeeee" class="stable"><div align="right">电话</div></td>
                    <td height="25" class="stable"><%=StrUtil.getNullString(user.getPhone())%>                    </td>
                    <td width=115 height="25" align="right" bgcolor="#eeeeee" class="stable"><div align="right">手机号码</div></td>
                    <td class=stable height="25"><%=user.getMobile()%>                    </td>
                  </tr>
                  <tr>
                    <td width=102 height="27" align=right bgcolor="#eeeeee" class="stable">省份</td>
                    <td height="27" valign="top" class="stable">
                        <%=StrUtil.getNullString(user.getState())%>					</td>
                    <td width="115" align="right" valign="top" bgcolor="#eeeeee" class="stable">城市<br></td>
                    <td valign="top" class="stable"><%=StrUtil.getNullString(user.getCity())%></td>
                  </tr>
                  <tr>
                    <td width=102 height="25" align=right bgcolor="#eeeeee" class="stable">地址/邮政地址</td>
                    <td height="25" valign="top" class="stable"><%=StrUtil.getNullString(user.getAddress())%> </td>
                    <td width="115" align="right" valign="top" bgcolor="#eeeeee" class="stable">邮政编码</td>
                    <td valign="top" class="stable"><%=user.getPostCode()%></td>
                  </tr>
                  <tr>
                    <td width=102 height="25" align=right bgcolor="#eeeeee" class="stable">身份证号码</td>
                    <td height="25" class="stable"><%=StrUtil.getNullString(user.getIDCard())%></td>
                    <td width="115" align="right" valign="top" bgcolor="#eeeeee" class="stable"> 兴趣爱好</td>
                    <td valign="top" class="stable"><%=StrUtil.getNullString(user.getHobbies())%></td>
                  </tr>
              </table></td>
        </tr>
        
      </table></td>
    </tr>
  </form>
</table>
</body>
<SCRIPT>
function VerifyInput()
{
var newDateObj = new Date()
if (document.memberform.username.value == "")
{
alert("请输入您的用户名");
document.memberform.username.focus();
return false;
}

if (document.memberform.userpass.value == "")
{
alert("请输入您的密码");
document.memberform.userpass.focus();
return false;
}
if (document.memberform.userpass2.value == "")
{
alert("请重复您的密码");
document.memberform.userpass2.focus();
return false;
}
if (document.memberform.userpass.value != document.memberform.userpass2.value)
{
alert("两遍输入的口令不一致");
document.memberform.userpass.focus();
return false;
}

if (document.memberform.usermail.value == "")
{
alert("请输入您的EMAIL地址");
document.memberform.usermail.focus();
return false;
}

if (document.memberform.question.value == "")
{
alert("请输入提示问题");
document.memberform.question.focus();
return false;
}

if (document.memberform.answer.value == "")
{
alert("请输入答案");
document.memberform.answer.focus();
return false;
}

if (document.memberform.birthyear.value > 0)  {
if (isNaN(document.memberform.birthyear.value) || document.memberform.birthyear.value > newDateObj.getFullYear()  || document.memberform.birthyear.value < 1900)
{
alert("请输入正确的出生年份");
document.memberform.birthyear.focus();
return false;
}}

return true;
}
</SCRIPT>
</html>