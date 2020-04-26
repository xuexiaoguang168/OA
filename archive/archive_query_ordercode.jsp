<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="../inc/nocache.jsp"%>
<title>选择查询结果中用来排序的字段</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "archive.query")) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
<form name="form1" method="post" action="archive_query_name.jsp">
    <tr>
      <td class="right-title">&nbsp;选择查询结果中用来排序的字段</td>
    </tr>
    <tr>
      <td>
<%
	String deptCodeStr = ParamUtil.get(request,"deptCodeStr");
	if(deptCodeStr.equals("")){
	   out.print(StrUtil.Alert_Back("请选择查询部门！"));
	   return;
	}

	String tableCodeStr = ParamUtil.get(request,"tableCodeStr");
    String showFieldCodeStr = ParamUtil.get(request,"showFieldCodeStr");
	String tableFullCodeStr = ParamUtil.get(request,"tableFullCodeStr");
	String[] tableCodeArr = tableCodeStr.split(",");
	String fieldCode = "",conditionFieldCodeStr = "",sql = "";
	
	ArchiveQueryConditionMgr aqcm = new ArchiveQueryConditionMgr();
	try{
		conditionFieldCodeStr = aqcm.getQueryCondition(request);
	}catch(ErrMsgException e){
		out.print(StrUtil.Alert_Back("填写日期参数格式错误！"));
	}
	
	TableInfoDb tid = new TableInfoDb();	
	TableFieldInfoDb tfid = new TableFieldInfoDb(); 
	int j = 0;	
	while(j < tableCodeArr.length){
	   tid = tid.getTableInfoDb(tableCodeArr[j]);	   
%>
<br>
<table class="tableframe" cellSpacing="0" cellPadding="2" width="95%" align="center" border="0" bgcolor="#FFFFFF">
        <tbody>
          <tr>
            <td colspan="3" class="right-title"><%=tid.getTableDescription()%></td>
          </tr>
<%
	   sql = ArchiveSQLBuilder.getArchiveTableField(tid.getTableShortCode());	
	      
	   tfid = new TableFieldInfoDb();
	   Vector vt = tfid.list(sql);
	   Iterator ir = null;
	   ir = vt.iterator();
	   while (ir!=null && ir.hasNext()) {
		   tfid = (TableFieldInfoDb)ir.next();
		   fieldCode = 	tfid.getTableShortCode() + "." + tfid.getFieldCode();
%>
          <tr>
            <td noWrap width="109"><%=tfid.getFieldName()%></td>
            <td noWrap>
			  <select name="fieldCode">
			    <option value="" selected></option>
			    <option value="<%=fieldCode%> ASC">升续</option>
			    <option value="<%=fieldCode%> DESC">降续</option>
			  </select>			</td>
          </tr>
<%
       }
%>
        </tbody>
      </table>
<%   
	   j++;
	}
%>      </td>
    </tr>  
    <tr>
      <td height="30" align="center"><input value="下一步 &#8594; 填写查询名称" type="submit">
        <input type="hidden" name="showFieldCodeStr" value="<%=showFieldCodeStr%>">
		<input type="hidden" name="conditionFieldCodeStr" value="<%=conditionFieldCodeStr%>">
		<input type="hidden" name="tableCodeStr" value="<%=tableCodeStr%>"> 
		<input type="hidden" name="deptCodeStr" value="<%=deptCodeStr%>">
		<input type="hidden" name="tableFullCodeStr" value="<%=tableFullCodeStr%>">
	  &nbsp;&nbsp;    </td>
    </tr>
</form> 
</table>

</body>
</html>
