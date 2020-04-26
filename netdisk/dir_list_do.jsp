<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.redmoon.oa.netdisk.*"%>
<%@ page import="cn.js.fan.util.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="docmanager" scope="page" class="com.redmoon.oa.netdisk.DocumentMgr"/>
<%
if (!privilege.isUserLogin(request)) {
	// out.print("对不起，请先登录！");
	// return;
}
String op = ParamUtil.get(request, "op");
if (op.equals("changeattachname")) {
	boolean re = false;
	try {
		re = docmanager.updateAttachmentName(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		out.print(StrUtil.Alert_Back("修改成功！"));
		%>
		<script>
		// window.parent.location.reload(true);
		</script>
		<%
	}
	
	return;
}

if (op.equals("delAttach")) {
	boolean re = false;
	try {
		re = docmanager.delAttachment(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		%>
		<script>
		// window.alert("删除成功！");
		window.parent.location.reload(true);
		</script>
		<%
	}
	
	return;
}

boolean re = false;
//String isuploadfile = StrUtil.getNullString(request.getParameter("isuploadfile"));
try {
	//if (isuploadfile.equals("false"))
		//re = docmanager.UpdateWithoutFile(request);
	//else
		re = docmanager.Operate(application, request, privilege);
}
catch(ErrMsgException e) {
	//if (isuploadfile.equals("false")) {
	//	out.print(StrUtil.Alert(e.getMessage()));
	//}
	//else
		out.print(e.getMessage());
}
if (re) {
	out.print("操作成功！");
}
%>