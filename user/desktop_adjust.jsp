<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK href="../common.css" type=text/css rel=stylesheet>
<title>用户桌面设置</title>
<script language=javascript>
<!--

//-->
</script>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String strId = ParamUtil.get(request, "id");
if (!StrUtil.isNumeric(strId))
	return;
int id = ParamUtil.getInt(request, "id");
UserDesktopSetupDb usd = new UserDesktopSetupDb();
usd = usd.getUserDesktopSetupDb(id);

String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	usd.del();
	return;
}

int left = ParamUtil.getInt(request, "left");
int top = ParamUtil.getInt(request, "top");
int width = ParamUtil.getInt(request, "width");
int height = ParamUtil.getInt(request, "height");
int zIndex = ParamUtil.getInt(request, "zIndex");
usd.setLeft(left);
usd.setTop(top);
usd.setWidth(width);
usd.setHeight(height);
usd.setZIndex(zIndex);
out.print("id=" + strId);
out.print(usd.save());
%>
</body>
</html>
