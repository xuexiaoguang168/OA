<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发起流程</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
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
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int id = -1;

WorkflowMgr wm = new WorkflowMgr();
WorkflowDb wfd = null;
try {
	String flowTitle = ParamUtil.get(request, "flowTitle");
	String typeCode = ParamUtil.get(request, "typeCode");
	
	com.redmoon.oa.Config cfg = new com.redmoon.oa.Config();
	
	WorkflowPredefineDb wpd = new WorkflowPredefineDb();
	wpd = wpd.getDefaultPredefineFlow(typeCode);
	boolean isPredefined = wpd!=null && wpd.isLoaded();

	if (!isPredefined) {
		out.print(StrUtil.Alert_Back("预定义流程不存在!"));
		return;
	}	
	
	id = wm.create(request);
	
	if (id!=-1)	{
		wfd = wm.getWorkflowDb(id);

			// 不能修改流程,则直接套用流程
			// 如果预定义流程存在
			if (isPredefined) {
				int preId = wpd.getId();
				wpd = wpd.getWorkflowPredefineDb(preId);
				if (wpd!=null && wpd.isLoaded()) {
					String flowString = wpd.getFlowString();
					// System.out.println("flow_initiate1_do.jsp flowString=" + flowString);
					// 替换其中的“本人”、“本部门领导”节点
					flowString = wfd.regeneratePredefinedFlowString(privilege.getUser(request), flowString);				
					System.out.println("flow_initiate1_do.jsp flowString=" + flowString);
					try {
						long startActionId = wfd.createFromString(flowString);
						if (true) {
							response.sendRedirect("flow_dispose.jsp?myActionId=" + startActionId);
							return;
						}
					}
					catch (ErrMsgException e) {
						out.print(StrUtil.Alert_Back(e.getMessage()));
						return;
					}
				}
			}
	}
	else
		out.print(StrUtil.Alert_Back("发起流程失败！"));
}
catch (ErrMsgException e) {
	if (wfd!=null)
		wfd.del();
	out.print(fchar.Alert_Back(e.getMessage()));
}
%>
</body>
</html>
