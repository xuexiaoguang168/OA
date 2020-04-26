<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>人事档案管理</title>
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
<%
if (!privilege.isUserPrivValid(request, "archive.query")&&!archivePrivilege.canQuery(request)) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<br>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="200%">
<form name="form1" action="archive_excel.jsp" method="post">
  <tr> 
    <td height="23" valign="middle" class="right-title"><span>&nbsp;综合查询</span></td>
  </tr>
  <tr align="right"> 
    <td align="right" valign="top" background="images/tab-b-back.gif">
<%
        String op = "",sql = "",conditionFieldSql = "",conditionFieldCode = "",condition_type = "",condition_field_code = "",show_field_code = "";
		int id = -1;
		
		ArchiveQueryDb aqd = new ArchiveQueryDb();
		ArchiveQueryConditionDb aqcd = new ArchiveQueryConditionDb();
		
		id = ParamUtil.getInt(request, "id");
		aqd = aqd.getArchiveQueryDb(id);
		conditionFieldSql = ArchiveSQLBuilder.getArchiveQueryCondition(id);
		Vector cvt = aqcd.list(conditionFieldSql);
		Iterator cir = null;
		cir = cvt.iterator();
		while (cir!=null && cir.hasNext()) {
			aqcd = (ArchiveQueryConditionDb)cir.next();
			if(!aqcd.getConditionType().equals("SELECTED") && condition_type.equals("SELECTED")){
			   conditionFieldCode += ")";
			}
			if(!condition_type.equals("") && condition_type.equals("SELECTED") && condition_field_code.equals(aqcd.getConditionFieldCode())){
				conditionFieldCode += " or ";
			}else{
				if(!condition_field_code.equals(""))
				   conditionFieldCode += " and ";
			}
			if(aqcd.getConditionType().equals("SELECTED") && !condition_type.equals("SELECTED")){
				conditionFieldCode += "(";
			}
			
			conditionFieldCode += aqcd.getConditionFieldCode() + " " + aqcd.getConditionSign() + " " + aqcd.getConditionValue();
			condition_type = aqcd.getConditionType();
			condition_field_code = aqcd.getConditionFieldCode();
		}	
		if(condition_type.equals("SELECTED")){
			conditionFieldCode += ")";
		}
		
		
		sql = "select AUS.USERNAME," + aqd.getShowFieldCode() + " from " + aqd.getTableCode() + " where "  + conditionFieldCode + " and AUS.DEPTCODE in (" + aqd.getDeptCode() + ")";
		if(!aqd.getOrderFieldCode().equals("")){
			sql += " order by " + aqd.getOrderFieldCode();
		}
		show_field_code = aqd.getShowFieldCode();
		//out.print("sql=" + sql);

		
		String querystr = "";	
		querystr = "id=" + id;	
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		ResultIterator ri = null;		
		try {
			ri = aqd.getResultIterator(sql, curpage, pagesize);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "warn_query_err_table")));
		}		
		if (ri==null) {
			out.print(" 查询结果为空！");
			return;
		}
		ResultRecord rr = null;
		long total = ri.getTotal();
			
		paginator.init(total, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
      <table border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td> 	  
	  <table border="0" align="left" cellpadding="0" cellspacing="0" >
        <tr bgcolor="#C4DAFF">
<%	
        String[] showFieldCodeArr = show_field_code.split(",");
		String[] showAFieldCodeArr = null;
		String[] showFieldType = new String[showFieldCodeArr.length];
		String showFieldName = "";
		String fieldCode = "",tableCode = "",showFieldSQL = "",temp = "";
		int i = 0;	
		TableFieldInfoDb tfid = new TableFieldInfoDb(); 
		while(i < showFieldCodeArr.length){	    
			showAFieldCodeArr = showFieldCodeArr[i].split("\\.");
		    showFieldSQL = ArchiveSQLBuilder.getArchiveTableField(showAFieldCodeArr[0],showAFieldCodeArr[1]);	  		 
	        Vector vt = tfid.list(showFieldSQL);
	        Iterator ir = null;
		    ir = vt.iterator();
	        if (ir!=null && ir.hasNext()) {
		       tfid = (TableFieldInfoDb)ir.next();			   
%>
            <td height="24" align="center" width="120"><%=tfid.getFieldName()%></td>          
<%               
			   showFieldName += tfid.getFieldName();
			   showFieldType[i] = tfid.getFieldType();
			}
			if(i < showFieldCodeArr.length -1)
				showFieldName += ",";
		    i++;	   
		}
%>
        </tr>

<%
		while (ri!=null && ri.hasNext()) {
		   	rr = (ResultRecord)ri.next();
			int j = 1;
%>
       <tr>
<%          
            while(j <= i){ 
			    if(j == 1) {			   
%>
          <td height="22" align="center" width="120"><a href="archive_user_modify.jsp?userName=<%=StrUtil.getNullStr(rr.getString(j))%>"><%=StrUtil.getNullStr(rr.getString(j+1))%></a></td> 
<% 
                }else{
					if(showFieldType[j-1].equals("2"))
						temp = DateUtil.format(rr.getDate(j+1),"yyyy-MM-dd");						
					else
						temp = StrUtil.getNullStr(rr.getString(j+1));					
%>
          <td height="22" align="center" width="120"><%=temp%></td> 
<%
			    }             
            j++;         
            }
%>
        </tr>
<%}%>	
      </table>
    </td>
  </tr>
  <tr> 
    <td align="left"><input type="submit" name="Submit" value="输出到Excel">
      <input type="hidden" name="showFieldName" value="<%=showFieldName%>">
      <input type="hidden" name="sql" value="<%=sql%>"></td>
  </tr>
</form>
  <tr> 
    <td align="right">  
      <table border="0" cellspacing="1" cellpadding="3" class="9black">
        <tr> 
          <td width="1%" height="23">&nbsp;</td>
          <td height="23" valign="baseline" align="right"> 
            <div>
             <%
			   out.print(paginator.getCurPageBlock("?"+querystr));
			 %>
            &nbsp;</div></td>
        </tr>
      </table>    
	</td>
  </tr>
</table>
</body>
</html>
