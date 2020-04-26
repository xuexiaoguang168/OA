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
	VehicleMaintenanceMgr vmm = new VehicleMaintenanceMgr();
	boolean re = false;

	String op = ParamUtil.get(request, "op");
	if (op.equals("add")) {
		try {
			re = vmm.create(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.vehiclemaintenance", "success_add_vehiclemaintenance")));
		}
	}
	if (op.equals("modify")) {
		try {
			re = vmm.modify(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.vehiclemaintenance", "success_modify_vehiclemaintenance")));
		}
	}
	if (op.equals("del")) {
		try {
			re = vmm.del(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.vehiclemaintenance", "success_del_vehiclemaintenance")));
		}
	}	
%>
</body>
</html>
