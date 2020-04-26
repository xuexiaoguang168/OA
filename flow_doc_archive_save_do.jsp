<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.flow.WorkflowDb"%>
<%@ page import="com.redmoon.oa.flow.Render"%>
<%@ page import="com.redmoon.oa.flow.WorkflowMgr"%>
<%@ page import="com.redmoon.oa.flow.WorkflowActionDb"%>
<script>
</script>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
WorkflowMgr wfm = new WorkflowMgr();
try {
	boolean re = wfm.saveDocumentArchive(request);
	if (re) {
		// 重定向至文件的列表页
		String dirCode = ParamUtil.get(request, "dirCode");
		out.print(StrUtil.Alert_Redirect("操作成功！", "cms/document_list_m.jsp?dir_code=" + StrUtil.UrlEncode(dirCode)));
	}
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert_Back(e.getMessage()));
}
%>