<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>车辆管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<style type="text/css">
<!--
.STYLE2 {color: #0033FF}
.STYLE3 {color: #FF0000}
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
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">
  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;车辆维护管理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql = "";
		String op = ParamUtil.get(request, "op");
		String querystr = "";	
		if (op.equals("search")) {
		   try{
		      sql = VehicleSQLBuilder.getVehicleMaintenanceSearchSql(request);
		   }
		   catch (ErrMsgException e) {
		      out.print(StrUtil.Alert_Back(e.getMessage()));
		   }
		   querystr += "licenseNo=" + StrUtil.UrlEncode(ParamUtil.get(request, "licenseNo")) + "&beginDate=" + ParamUtil.get(request, "beginDate")
                    + "&endDate=" + ParamUtil.get(request, "endDate") + "&type=" + ParamUtil.get(request, "type") + "&cause=" + StrUtil.UrlEncode(ParamUtil.get(request, "cause")) 
					+ "&expense=" + StrUtil.UrlEncode(ParamUtil.get(request, "expense")) + "&transactor=" + StrUtil.UrlEncode(ParamUtil.get(request, "transactor")) + "&remark=" + StrUtil.UrlEncode(ParamUtil.get(request, "remark"));
		}else{
		   sql = "select id from vehicle_maintenance";
		}
		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		VehicleMaintenanceDb vmd = new VehicleMaintenanceDb();		
		ListResult lr = vmd.listResult(sql, curpage, pagesize);
		int total = lr.getTotal();
		Vector v = lr.getResult();
	    Iterator ir = null;
		
		if (v!=null)
			ir = v.iterator();
			
		paginator.init(total, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}

%>
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47">&nbsp;</td>
          <td align="right" backgroun="images/title1-back.gif">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></td>
        </tr>
      </table> 
      <form name="form1" action="vehicle_maintenance_add.jsp" method="post">
	    <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0" >
          <tr align="center" bgcolor="#C4DAFF">
            <td width="19%" height="24" >车牌号</td>
            <td width="15%" bgcolor="#C4DAFF" >维护开始日期</td>
            <td width="16%" bgcolor="#C4DAFF" >维护结束日期</td>
            <td width="14%" >维护类型</td>
            <td width="12%" >维护原因</td>
            <td width="24%" >操作</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		while (ir!=null && ir.hasNext()) {
			vmd = (VehicleMaintenanceDb)ir.next();
			String type = Integer.toString(vmd.getType());			
			if(type.equals("0")){
			   type = "维修";
			}else{
			   if(type.equals("1")){
			     type = "加油";
			   }else{
			     if(type.equals("2")){
			        type = "洗车";
			     }else{
				 	if(type.equals("3")){
			          type = "年检";
			        }else{
				      type = "其它";
					}
				 }
			   }
			}
			
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="19%" height="22"><%=vmd.getLicenseNo()%></td> 
          <td width="15%"><%=vmd.getBeginDate()%></td>
		  <td width="16%"><%=vmd.getEndDate()%></td>
		  <td width="14%"><%=type%></td>
		  <td width="12%"><%=vmd.getCause()%></td>
		  <td width="12%"><a href="vehicle_maintenance_edit.jsp?id=<%=vmd.getId()%>">编辑</a></td>
		  <td width="12%"><a href="vehicle_maintenance_do.jsp?id=<%=vmd.getId()%>&op=del">删除</a></td>
        </tr>
      </table>
      <%}%>	  
	  </form>
      <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center">
        <tr> 
          <td width="1%" height="23">&nbsp;</td>
          <td height="23" valign="baseline"> 
            <div align="right">
             <%
			   out.print(paginator.getCurPageBlock("?"+querystr));
			 %>
            &nbsp;</div></td>
        </tr>
      </table>    </td>
  </tr>
  <tr> 
    <td height="30" colspan="2" align="center">
      <input name="button" type="submit" class="button1"  value="添加车辆维护记录" onClick="form1.submit()">
    </td>
  </tr>
</table>

</body>
</html>
