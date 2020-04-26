<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "com.cloudwebsoft.framework.base.*"%>
<%@ page import = "com.redmoon.oa.kernel.*"%>
<%@ page import = "com.redmoon.oa.workplan.*"%>
<%@ page import = "com.redmoon.oa.kernel.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<html>
<head>
<title>处理工作计划</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	String priv="read";
	if (!privilege.isUserPrivValid(request, priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	
	WorkPlanMgr am = new WorkPlanMgr();
	boolean re = false;

	String op = ParamUtil.get(request, "op");
	if (op.equals("add")) {
		try {
			re = am.create(application, request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("添加成功！", "workplan_list.jsp"));
		}
	}
	if (op.equals("modify")) {
		int id = ParamUtil.getInt(request, "id");
		try {
			re = am.modify(application, request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("修改成功！", "workplan_edit.jsp?id=" + id));
		}
	}
	if (op.equals("delattach")) {
		try {
			re = am.delAttachment(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("删除附件成功！", "workplan_edit.jsp?id=" + ParamUtil.getInt(request, "id")));
		}
	}
	if (op.equals("del")) {
		try {
			re = am.del(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back("删除成功！"));
		}
	}
	
if (op.equals("addJob")) {
	QObjectMgr qom = new QObjectMgr();
	JobUnitDb ju = new JobUnitDb();
	int id = ParamUtil.getInt(request, "id");
	try {
		if (qom.create(request, ju, "scheduler_add"))
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "workplan_edit.jsp?id=" + id ));
		else
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "info_op_fail")));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (op.equals("editJob")) {
	QObjectMgr qom = new QObjectMgr();
	int planId = ParamUtil.getInt(request, "planId");
	int jobId = ParamUtil.getInt(request, "id");
	JobUnitDb ju = new JobUnitDb();
	ju = (JobUnitDb)ju.getQObjectDb(jobId);
	try {
	if (qom.save(request, ju, "scheduler_edit"))
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "workplan_edit.jsp?id=" + planId));
	else
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "info_op_fail")));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (op.equals("delJob")) {
	JobUnitDb jud = new JobUnitDb();
	int delid = ParamUtil.getInt(request, "id");
	int planId = ParamUtil.getInt(request, "planId");	
	JobUnitDb ldb = (JobUnitDb)jud.getQObjectDb(new Integer(delid));
	if (ldb.del())
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "workplan_edit.jsp?id=" + planId));
	else
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "info_op_fail")));
}
%>
</body>
</html>