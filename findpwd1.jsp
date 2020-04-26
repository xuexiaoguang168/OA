<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="cn.js.fan.util.*"%>
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
<title><%=Global.AppName%> - <lt:Label res="res.label.findpwd" key="findpwd"/>1</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="forum/<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.STYLE2 {color: #FFFFFF}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<p>&nbsp;</p>
<table width="46%" height="155"  border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="<%=skin.getTableBorderClr()%>">
  <tr>
    <td height="26" align="center" background="forum/<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.findpwd" key="user_service"/> - <lt:Label res="res.label.findpwd" key="findpwd"/></td>
  </tr>
  <tr>
    <td><table width="94%" border="0" align="center" cellpadding="1" cellspacing="0" class="p9">
      <form name=form1 action="findpwd2.jsp" method="post" onSubmit="return form1_onsubmit()">
        <tr>
          <td width="27%" height="22" align="right"><lt:Label res="res.label.findpwd" key="input_user_name"/>&nbsp;&nbsp;&nbsp;</td>
          <td width="59%" height="22"><input name="name" class="singleboarder" style="width:120">
            &nbsp;&nbsp;<a href="regist.jsp"><lt:Label res="res.label.findpwd" key="ask_not_regist"/></a> </td>
          <td width="14%"><input name="submit" type=submit value="<lt:Label res="res.label.findpwd" key="next"/>"></td>
        </tr>
      </form>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>
<%@ include file="forum/inc/footer.jsp"%>
</body>
<script language="javascript">
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.name.value=="")
		errmsg += "<lt:Label res="res.label.findpwd" key="need_user_name"/>\n"
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}
//-->
</script>
</html>