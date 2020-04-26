<%@ page contentType="text/html;charset=utf-8"
import = "cn.js.fan.util.*"
import = "cn.js.fan.web.*"
import = "com.redmoon.oa.pvg.*"
import = "com.redmoon.oa.flow.*"
import = "java.io.File"
%>
<html>
<head>
<title>预定义流程-do</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="common.css" type="text/css">
<script language="javascript">
<!--

//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "admin.flow";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

boolean isSuccess = false;
String typeCode = ParamUtil.get(request, "typeCode");
WorkflowPredefineMgr wpm = new WorkflowPredefineMgr();
String op = ParamUtil.get(request, "op");
if (op.equals("")) {
	try {
		isSuccess = wpm.create(request);
	}
	catch (ErrMsgException e) {
		out.println(fchar.Alert_Back(e.getMessage()));
	}
	if (isSuccess)
	{
		out.println(fchar.Alert_Redirect("预定义成功！", "flow_predefine_list.jsp?dirCode=" + StrUtil.UrlEncode(typeCode)));
	}
}
if (op.equals("edit")) {
	int id = ParamUtil.getInt(request, "id");
	try {
		isSuccess = wpm.modify(request);
	}
	catch (ErrMsgException e) {
		out.println(fchar.Alert_Back(e.getMessage()));
	}
	if (isSuccess)
	{
		out.println(fchar.Alert_Back("修改成功！"));
	}
}
%>
</body>
</html>


