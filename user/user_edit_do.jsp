<%@ page contentType="text/html;charset=utf-8"
import = "cn.js.fan.util.*"
import = "java.io.File"
%>
<html>
<head>
<title>更改用户信息</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script language="javascript">
<!--

//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="userMgr" scope="page" class="com.redmoon.oa.person.UserMgr" />
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

boolean isSuccess = false;
String name = ParamUtil.get(request, "name");
try {
	isSuccess = userMgr.modify(request);
}
catch (ErrMsgException e) {
	out.println(fchar.Alert_Back(e.getMessage()));
}
if (isSuccess)
{
	out.println(fchar.Alert_Redirect("修改成功！", "user_edit.jsp?name=" + StrUtil.UrlEncode(name)));
}
%>
</body>
</html>


