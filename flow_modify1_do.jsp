<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改流程1</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

try {
	int flow_id = ParamUtil.getInt(request, "flowId");
	String typeCode = ParamUtil.get(request, "typeCode");
	String title = ParamUtil.get(request, "title");
	WorkflowMgr wm = new WorkflowMgr();
	WorkflowDb wf = wm.getWorkflowDb(flow_id);
	wf.setTypeCode(typeCode);
	wf.setTitle(title);
	if (wf.save())
	{
		com.redmoon.oa.Config cfg = new com.redmoon.oa.Config();
		String canUserModifyFlow = cfg.get("canUserModifyFlow");					
		if (canUserModifyFlow.equals("true"))
			// response.sendRedirect("flow_initiate2_notmodifyform.jsp?op=edit&id=" + wf.getDocId() + "&work=modify&flowId=" + flow_id);
			response.sendRedirect("flow_modify3.jsp?flowId=" + flow_id);
		else {
			out.print(StrUtil.Alert_Back("修改成功!"));
		}	
	}
	else
		out.print(StrUtil.Alert_Back("修改流程失败！"));
}
catch (ErrMsgException e) {
	out.print(fchar.Alert_Back(e.getMessage()));
}
%>
</body>
</html>
