<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
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
<%@ include file="vehicle_inc_apply_top.jsp"%>
<br>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">
  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;车辆使用管理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql = "";
		String op = ParamUtil.get(request, "op");
		String result = ParamUtil.get(request, "result");
		String querystr = "";	
	    
		if (op.equals("search")) {
		   try{
		      sql = VehicleSQLBuilder.getVehicleResultSearchSql(request);
		   }
		   catch (ErrMsgException e) {
		      out.print(StrUtil.Alert_Back(e.getMessage()));
		   }
		   querystr += "result=" + StrUtil.UrlEncode(ParamUtil.get(request, "result")) + "&licenseNo=" + StrUtil.UrlEncode(ParamUtil.get(request, "licenseNo")) + "&beginDate=" + ParamUtil.get(request, "beginDate")
                    + "&endDate=" + ParamUtil.get(request, "endDate") + "&person=" + StrUtil.UrlEncode(ParamUtil.get(request, "person")) + "&dept=" + StrUtil.UrlEncode(ParamUtil.get(request, "depts")) + "&applier=" + StrUtil.UrlEncode(ParamUtil.get(request, "applier"));
		}else{
		   if (result.equals(VehicleSQLBuilder.RESULT_APPLY)) {
		       sql = VehicleSQLBuilder.getVehicleApplySearchSql();
		   }else{
		   	   if (result.equals(VehicleSQLBuilder.RESULT_USED)) {
		           sql = VehicleSQLBuilder.getVehicleUsedSearchSql();
		       }else{
			   	   if (result.equals(VehicleSQLBuilder.RESULT_DISAGREE)) {
		              sql = VehicleSQLBuilder.getVehicleDisagreeSearchSql();
		           }else{
				      sql = VehicleSQLBuilder.getVehicleAgreeSearchSql();	   
		           }  
		       }   
		   }
		   if(result == VehicleSQLBuilder.RESULT_AGREE){
		      out.print("result="+result);
		   }
		}
		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		VehicleApplyDb vad = new VehicleApplyDb();		
		ListResult lr = vad.listResult(sql, curpage, pagesize);
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
            <td width="15%" bgcolor="#C4DAFF" >用车人</td>
            <td width="16%" bgcolor="#C4DAFF" >事由</td>
            <td width="14%" >开始时间</td>
            <td width="12%" >结束时间</td>
            <td width="24%" >操作</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		while (ir!=null && ir.hasNext()) {
			vad = (VehicleApplyDb)ir.next();
			String lno = vad.getLicenseNo(); 
			if (lno.equals(""))
				lno = "用户尚未选定";
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="19%" height="22"><%=lno%></td> 
          <td width="15%"><%=vad.getPerson()%></td>
		  <td width="16%"><%=vad.getReason()%></td>
		  <td width="14%"><%=DateUtil.format(vad.getBeginDate(), "yy-MM-dd HH:mm")%></td>
		  <td width="12%"><%=DateUtil.format(vad.getEndDate(), "yy-MM-dd HH:mm")%></td>
		  <td><a href="vehicle_apply_show.jsp?flowId=<%=vad.getFlowId()%>">详细信息</a></td>
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
</table>

</body>
</html>
