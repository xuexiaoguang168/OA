<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.plugin.auction.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
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
	font-size: 10pt;
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

String shopName = "";
String desc = "";
String tel = "";
String address = "";
String contacter = "";
try {
	shopName = ParamUtil.get(request, "shopName");
	if (shopName.equals(""))
		throw new ErrMsgException("店名不能为空！");
	desc = ParamUtil.get(request, "desc");
	if (desc.equals(""))
		throw new ErrMsgException("简介不能为空！");
	tel = ParamUtil.get(request, "tel");
	if (tel.equals(""))
		throw new ErrMsgException("电话不能为空！");
	address = ParamUtil.get(request, "address");
	if (address.equals(""))
		throw new ErrMsgException("地址不能为空！");
	contacter = ParamUtil.get(request, "contacter");
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert(e.getMessage()));
	return;
}

boolean re = false;
AuctionShopDb as = new AuctionShopDb();
try {
	as = as.getAuctionShopDb(privilege.getUser(request));
	if (as.isLoaded()) {
		out.print(StrUtil.Alert_Back("您的店铺已存在,不能申请!"));
	}
	else {
		as.setShopName(shopName);
		as.setAddress(address);
		as.setTel(tel);
		as.setDesc(desc);
		as.setUserName(privilege.getUser(request));
		as.setContacter(contacter);
		re = as.create();
	}
}
catch (ResKeyException e) {
	out.print(StrUtil.Alert_Back(e.getMessage(request)));
	return;
}
if (re) {%>
<table width="98%"  border="0" align="center" cellpadding="5">
  <tr>
    <td height="36">“<%=Global.AppName%>”祝贺您建店成功！请注意交易的诚信和安全！您的每笔订单都将会保存在社区的数据库中，请收藏管理店铺的地址。<br>
    <br>      
    &gt;&gt; <a href="shop.jsp?id=<%=as.getId()%>">查看我的店铺</a><br>
    <br>
    &gt;&gt;&nbsp;<a href="manager/index.jsp?userName=<%=StrUtil.UrlEncode(privilege.getUser(request))%>">管理我的店铺</a></td>
  </tr>
</table>
<%}%>
</body>
</html>
