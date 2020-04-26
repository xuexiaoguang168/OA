<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "fan.util.ErrMsgException"%>
<html>
<head>
<title>增加日程</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="common.css" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="email" scope="page" class="com.redmoon.oa.Email"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String id = request.getParameter("document_id");
if (id==null || id.equals(""))
{
	out.print(fchar.Alert_Back("标识不能为空！"));
	return;
}
%>
<jsp:useBean id="doc" scope="page" class="com.redmoon.oa.document.Document"/>
<%
boolean re = false;
try {
	re = doc.del(request);
}
catch (ErrMsgException e) {
	out.println(e.getMessage());
}
if (re)
	out.println(fchar.Alert_Back("删除文件成功！"));
%>
</body>
</html>