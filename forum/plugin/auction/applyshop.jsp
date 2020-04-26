<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.plugin.auction.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link href="../../<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<title><%=Global.AppName%> - 我要开店</title>
<style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
.style1 {
	font-size: 14px;
	font-weight: bold;
}

-->
</style></head>
<body>
<%@ include file="../../inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isUserLogin(request)) {
	out.print(StrUtil.makeErrMsg("请先登录！"));
	return;
}
%>
<table width="67%"  border="0" align="center"cellspacing="1" cellpadding="5" bgcolor="#666666">
<form name="form1" method="post" action="applyshop_do.jsp">
  <tr align="center" bgcolor="#F1EDF3">
    <td height="22" colspan="2"><span class="style1">我 要 开 店</span></td>
    </tr>
  <tr align="center">
    <td width="20%" height="22" bgcolor="#FFFFFF">店名</td>
    <td width="80%" align="left" bgcolor="#FFFFFF"><input name=shopName size=20></td>
  </tr>
  <tr align="center" bgcolor="#FFFFFF">
    <td height="22">地址</td>
    <td height="22" align="left"><input name=address size=40></td>
  </tr>
  <tr align="center" bgcolor="#FFFFFF">
    <td height="22">联系人</td>
    <td height="22" align="left"><input name=contacter size=16></td>
  </tr>
  <tr align="center" bgcolor="#FFFFFF">
    <td height="22">电话</td>
    <td height="22" align="left"><input name=tel size=16></td>
  </tr>
  <tr align="center" bgcolor="#FFFFFF">
    <td height="22">简介</td>
    <td height="22" align="left"><textarea name="desc" cols="36" rows="8"></textarea></td>
  </tr>
  <tr align="center" bgcolor="#FFFFFF">
    <td height="22" colspan="2"><input type="submit" name="Submit" value="提交">
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="reset" name="Submit" value="重置"></td>
  </tr></form>
</table>
<%@ include file="../../inc/footer.jsp"%>
</body>
</html>
