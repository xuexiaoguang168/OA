<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>车辆维护</title>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "vehicle")) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
	VehicleMgr vm = new VehicleMgr();
	boolean re = false;

	String op = ParamUtil.get(request, "op");
	if (op.equals("add")) {
		try {
			re = vm.create(application, request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
		    out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.vehicle", "success_add_vehicle")));
		}
	}
	if (op.equals("modify")) {
		try {
			re = vm.modify(application, request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
            out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.vehicle", "success_modify_vehicle"), "vehicle_edit.jsp?licenseNo=" + ParamUtil.get(request, "licenseNo")));
		}
		else
			out.print(StrUtil.Alert_Back("操作失败！"));
	}
	/*
	if (op.equals("delattach")) {
		try {
			re = vm.delAttachment(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("删除附件成功！", "workplan_edit.jsp?id=" + ParamUtil.getInt(request, "id")));
		}
	}
	*/
	if (op.equals("del")) {
		try {
			re = vm.del(application,request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.vehicle", "success_del_vehicle")));
		}
	}	
%>
</body>
</html>
