<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.util.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:setProperty name="privilege" property="defaulturl" value="../index.jsp"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("changeattachname")) {
	int doc_id = ParamUtil.getInt(request, "doc_id");
	int attach_id = ParamUtil.getInt(request, "attach_id");
	String newname = ParamUtil.get(request, "newname");
	Document doc = new Document();
	doc = doc.getDocument(doc_id);
	boolean re = doc.updateAttachmentName(attach_id, newname);
	if (re) {
		out.print(StrUtil.Alert("修改成功！"));
		%>
		<script>
		window.parent.location.reload(true);
		</script>
		<%
	}
	else
		out.print(StrUtil.Alert("修改失败！"));
	
	return;
}

if (op.equals("delAttach")) {
	int doc_id = ParamUtil.getInt(request, "doc_id");
	int attach_id = ParamUtil.getInt(request, "attach_id");
	Document doc = new Document();
	doc = doc.getDocument(doc_id);
	boolean re = doc.delAttachment(attach_id);
	if (re) {
		%>
		<script>
		if (window.confirm("删除成功！点击确定可刷新页面"))
			window.parent.location.reload(true);
		</script>
		<%
	}
	else
		out.print(StrUtil.Alert("删除失败！"));
	
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
	//if (isuploadfile.equals("false")) {
	//	out.print(StrUtil.Alert_Back(privilege.getUser(request) + "is修改成功！"));
	//}
	//else
		out.print("操作成功！");
}
%>