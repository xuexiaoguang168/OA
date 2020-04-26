<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../common.css" rel="stylesheet" type="text/css">
<title>管理车辆类型</title>
<%@ include file="../inc/nocache.jsp"%>
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #FFFFFF}
.STYLE4 {
	color: #000000;
	font-weight: bold;
}
.STYLE5 {color: #FF0000}
.STYLE6 {color: #000000}
-->
</style>
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
String op = ParamUtil.get(request, "op");
if (op.equals("edit")) {
	VehicleDriverMgr vdm = new VehicleDriverMgr();
	boolean re = false;
	try {
		  re = vdm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.module.vehicledriver", "success_modify_vehicledriver")));
}
int id = 0;
try {
	id = ParamUtil.getInt(request, "id");
}
catch (ErrMsgException e) {
	out.println(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.vehicledriver", "warn_id_err_vehicledriver")));
}
VehicleDriverDb vtd = new VehicleDriverDb(id);
String userName = vtd.getUserName();
%>
 <form id=form1 name="form1" action="?op=edit" method=post>
	<table width="541" height="52" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
		<tr>
		  <td colspan="2" height="23" background="../images/top-right.gif" class="right-title"><span> &nbsp;车辆驾驶员管理</span></td>
		</tr>
		<tr>
			<td width="369" align="right"><span class="STYLE6">驾驶员姓名(<span class="STYLE5">*</span>)</span><span class="STYLE4">：</span>
				  <input name="userName" width="200" value="<%=userName%>">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		  <td width="170" align="left"><input name="submit" type=submit class="button1" value="修  改">
		    <input type="hidden" name="id" value="<%=id%>" /></td>
		</tr>
	</table>
</form>
</body>
</html>
