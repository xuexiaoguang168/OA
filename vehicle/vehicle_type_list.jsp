<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加车辆类型</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=150,left=220,width="+width+",height="+height);
}
//-->
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
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "vehicle")) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	VehicleTypeMgr vtm = new VehicleTypeMgr();
	boolean re = false;
	try {
		  re = vtm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.module.vehicletype", "success_add_vehicletype")));
}

if (op.equals("del")) {
	VehicleTypeMgr vtm = new VehicleTypeMgr();
	boolean re = false;
	try {
		re = vtm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.module.vehicletype", "success_del_vehicletype")));
}
%>
<form id="form1" name="form1" action="?op=add" method="post">
<table width="541" height="89" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
	<tr>
	  <td height="23" colspan="2" background="../images/top-right.gif" class="right-title"><span> &nbsp;车辆类型管理</span></td>
	</tr>
    <tr>
      <td colspan="2" align="center"><table width="88%" height="81"  border="0" cellpadding="0" cellspacing="0" class=" STYLE3 STYLE3">
          <tr>
            <td class="p14"><%
			  VehicleTypeDb vtd = new VehicleTypeDb();
			  String sql = "select id from vehicle_type";
			  Iterator ir = vtd.list(sql).iterator();
			  while (ir.hasNext()) {
			  	vtd = (VehicleTypeDb)ir.next();
			  %>
                <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
				    <td width="59%"><%=vtd.getDescription()%></td>
                    <td width="16%"><a href="vehicle_type_edit.jsp?id=<%=vtd.getId()%>">编辑</a></td>
                    <td width="11%"><a href="#" onClick="if (confirm('您确定要删除<%=vtd.getDescription()%>吗？')) window.location.href='?op=del&id=<%=vtd.getId()%>'">删除</a></td>
                  </tr>
                </table>
              <%}%>			 </td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td width="369" align="right"><span class="STYLE6">车辆类型编码(<span class="STYLE5">*</span>)</span><span class="STYLE4">：</span>
          <input name="typecode" width="200">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
      <td width="170" align="center">&nbsp;</td>
    </tr>
    <tr>
       <td align="right"><span class="STYLE6">车辆类型说明(<span class="STYLE5">*</span>)</span><span class="STYLE4">：</span>
          <input name="description" width="200">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
       <td align="left"><input name="submit" type=submit class="button1" value="添  加"></td>
    </tr>
</table>
</form>
<br>
<br>
</body>
</html>

