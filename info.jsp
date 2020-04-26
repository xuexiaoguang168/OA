<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<html>
<head>
<title><%=Global.AppName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="forum/<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="forum/inc/header.jsp"%>
<%
String info = ParamUtil.get(request, "info");
String op = ParamUtil.get(request, "op");
String privurl = ParamUtil.get(request, "privurl");
Privilege privilege = new Privilege();
%>
<br>
<br>
<table width=532 height="218" border=0 align="center" cellpadding=5 cellspacing=1>
  <tr align="center" valign="middle">
    <td height="25" colspan="4" background="forum/<%=skinPath%>/images/bg1.gif" class="text_title"><%=Global.AppName%> - <lt:Label res="res.label.info" key="info"/></td>
  </tr>
  <tr valign="middle"> 
    <td colspan="4" align=left valign="top" bgcolor="#EFEFEF" style="line-height:150%"><table width="100%" border="0" align="center">
      <tr>
        <td><ul><li><%=info%></li>
		<%if (info.trim().equals(SkinUtil.LoadString(request, "pvg_invalid"))) {%>
			<BR><strong><lt:Label res="res.label.info" key="reason"/></strong><BR>
			<%if (!privilege.isUserLogin(request)) {%>
				<lt:Label res="res.label.info" key="not_login"/><BR>
			<%}%>
			   <lt:Label res="res.label.info" key="user_pvg_invalid"/><BR>
		<%}%>	
		</ul></td>
      </tr>
    </table>
      <%if (op.equals("login") || !privilege.isUserLogin(request)) {%>
      <table width="90%" border="0" align="center" cellpadding="1" cellspacing="0" class="p9">
        <form name=form1 action="login.jsp" method="post" onSubmit="return form1_onsubmit()" style="">
          <tr>
            <td width="20%" height="22" align="left"><lt:Label res="res.label.door" key="user_name"/></td>
            <td width="80%" height="22"><input name="name" style="width:120"></td>
          </tr>
          <tr>
            <td height="22" align="left"><lt:Label res="res.label.door" key="pwd"/></td>
            <td height="22"><input name=pwd type=password style="width:120">
                <input name="privurl" type="hidden" value="<%=privurl%>">
            </td>
          </tr>
          <tr>
            <td height="22" align="left"><lt:Label res="res.label.door" key="validate_code"/></td>
            <td height="22"><input name="validateCode" type="text" size="1">
                <img src='validatecode.jsp' border=0 align="absmiddle" onClick="this.src='validatecode.jsp'" style="cursor:hand"></td>
          </tr>
          <tr>
            <td height="22" align="left"><lt:Label res="res.label.door" key="save"/></td>
            <td height="22"><select name="loginSaveDate">
              <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_NONE%>" selected>
                <lt:Label res="res.label.door" key="not_save"/>
                </option>
              <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_DAY%>">
                <lt:Label res="res.label.door" key="save_one_day"/>
                </option>
              <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_MONTH%>">
                <lt:Label res="res.label.door" key="save_one_month"/>
                </option>
              <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_YEAR%>"><lt:Label res="res.label.door" key="save_one_year"/></option>
            </select>              &nbsp; </td>
          </tr>
          <tr>
            <td height="22" align="left"><lt:Label res="res.label.forum.index" key="login_hide"/></td>
            <td height="22"><select name=covered>
              <option value=0 selected type='checkbox' checked>
                <lt:Label res="res.label.forum.index" key="login_not_hide"/>
                </option>
              <option value=1>
                <lt:Label res="res.label.forum.index" key="login_hide"/>
                </option>
            </select></td>
          </tr>
          <tr align="center">
            <td height="35" colspan="3"><input name="submit" type=submit value="<lt:Label res="res.label.forum.index" key="commit"/>">              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input name="button" type="button" onClick="window.location.href='regist.jsp'" value="<lt:Label res="res.label.door" key="regist"/>"></td>
          </tr>
        </form>
      </table>
      <%}else{%>
      <table width="100%" border="0">
        <tr>
          <td><ul>
              <li><a href="forum/index.jsp"><lt:Label res="res.label.info" key="back_to_home"/></a></li>
          </ul></td>
        </tr>
      </table>
    <%}
%></td>
  </tr>
</table>
<br>
<%@ include file="forum/inc/footer.jsp"%>
</body>
<script language="javascript">
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.name.value=="")
		errmsg += "<lt:Label res="res.label.door" key="input_name"/>\n"
	if (form1.pwd.value=="")
		errmsg += "<lt:Label res="res.label.door" key="input_pwd"/>\n"
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}
//-->
</script>
</html>