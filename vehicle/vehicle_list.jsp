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
<%@ include file="vehicle_inc_menu_top.jsp"%>
<br>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">

  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;车辆管理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql = "",typeDescription = "",state = "";
		sql = "select licenseNo from vehicle" ;
		String querystr = "";		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		VehicleDb vd = new VehicleDb();		
		ListResult lr = vd.listResult(sql, curpage, pagesize);
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
      <form name="form1" action="vehicle_add.jsp" method="post">
	    <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0" >
          <tr align="center" bgcolor="#C4DAFF">
            <td width="19%" height="24" >车牌号</td>
            <td width="15%" bgcolor="#C4DAFF" >驾驶员</td>
            <td width="16%" bgcolor="#C4DAFF" >类型</td>
            <td width="14%" >购置日期</td>
            <td width="12%" >状态</td>
            <td width="24%" >操作</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		while (ir!=null && ir.hasNext()) {
			vd = (VehicleDb)ir.next();
			int type = vd.getType();
			VehicleTypeDb vtd = new VehicleTypeDb(type);
			typeDescription = vtd.getDescription();
			state = Integer.toString(vd.getState());
			
			if(state.equals("0")){
			   state = "可用";
			}else{
			   if(state.equals("1")){
			     state = "使用中";
			   }else{
			     if(state.equals("2")){
			        state = "损坏";
			     }else{
				    state = "报废";
				 }
			   }
			}
			
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="19%" height="22"><a href="vehicle_show.jsp?licenseNo=<%=StrUtil.UrlEncode(vd.getLicenseNo())%>"><%=vd.getLicenseNo()%></a></td> 
          <td width="15%"><%=vd.getDriver()%></td>
		  <td width="16%"><%=typeDescription%></td>
		  <td width="14%"><%=vd.getBuyDate()%></td>
		  <td width="12%"><%=state%></td>
          <td width="12%"><a href="vehicle_edit.jsp?licenseNo=<%=vd.getLicenseNo()%>">编辑</a></td>
		  <td width="12%"><a href="vehicle_do.jsp?licenseNo=<%=vd.getLicenseNo()%>&op=del">删除</a></td>
        </tr>
      </table>
      <%}%>	  
	  </form>
      <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
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
      <input name="button" type="submit" class="button1"  value="添加车辆" onClick="form1.submit()">
    </td>
  </tr>
</table>

</body>
</html>
