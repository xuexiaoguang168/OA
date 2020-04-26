<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "fan.util.ErrMsgException"%>
<html>
<head>
<title>修改文件信息</title>
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
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<jsp:useBean id="doc" scope="page" class="com.redmoon.oa.document.Document"/>
<%
//out.print("id="+doc.getID());
boolean re = false;
try {
	re = doc.modifyinfo(request);
}
catch (ErrMsgException e) {
	out.println(fchar.Alert_Redirect(e.getMessage(),"doc_open.jsp?document_id="+doc.getID()));
}
if (re)
	out.println(fchar.Alert_Redirect("修改文件信息成功！","doc_open.jsp?document_id="+doc.getID()));
%>
</body>
</html>