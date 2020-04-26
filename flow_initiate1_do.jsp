<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int id = -1;

WorkflowMgr wm = new WorkflowMgr();

String flowTitle = ParamUtil.get(request, "title");
String typeCode = ParamUtil.get(request, "typeCode");
	
if (typeCode.equals("") || typeCode.equals("not")) {
	out.print(StrUtil.Alert_Back("编码不能为空！"));
	return;
}
	
if (flowTitle.equals("")) {
	out.print(StrUtil.Alert_Back("标题不能为空！"));
	return;
}	

long startActionId = -1;
try {
	startActionId = wm.initWorkflow(privilege.getUser(request), typeCode, flowTitle);
}
catch (ErrMsgException e) {
	out.print(fchar.Alert_Back(e.getMessage()));
	return;
}
response.sendRedirect("flow_dispose.jsp?myActionId=" + startActionId);
%>