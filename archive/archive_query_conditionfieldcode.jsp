<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户档案查询</title>
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
   <form name="form1" method="post" action="archive_query_conditionvalue.jsp">
    <tr>
      <td class="right-title">&nbsp;选择查询时使用的条件字段</td>
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
	String tableFullCodeStr = ParamUtil.get(request,"tableFullCodeStr");
	String[] fieldFullCodeArr = ParamUtil.getParameters(request,"fieldFullCode");
	String[] tableCodeArr = tableCodeStr.split(",");
	
	
	String showFieldCodeStr = "",sql = "",fieldFullCode = "";
	
	
	//获得显示字段
	int i = 0;
	while(i < fieldFullCodeArr.length){
		showFieldCodeStr += fieldFullCodeArr[i];
		if(i < fieldFullCodeArr.length - 1){
		   showFieldCodeStr += ",";
		}
		i++;
	}
	
	
	int j = 0;	
	TableInfoDb tid = new TableInfoDb();
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
	   TableFieldInfoDb tfid = new TableFieldInfoDb();
	   sql = ArchiveSQLBuilder.getArchiveTableField(tid.getTableShortCode());      	   
	   Vector vt = tfid.list(sql);
	   Iterator ir = null;
	   ir = vt.iterator();
	   while (ir!=null && ir.hasNext()) {
		   tfid = (TableFieldInfoDb)ir.next();
		   fieldFullCode = 	tfid.getTableShortCode() + "." + tfid.getFieldCode();
%>
          <tr>
            <td noWrap width="109"><%=tfid.getFieldName()%></td>
            <td noWrap><input type="checkbox" name="fieldFullCode" value="<%=fieldFullCode%>">			
              选择该查询条件字段</td>
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
      <td height="30" align="center"><input value="下一步 &#8594; 设置查询条件" type="submit">
        <input type="hidden" name="tableFullCodeStr" value="<%=tableFullCodeStr%>">
        <input type="hidden" name="tableCodeStr" value="<%=tableCodeStr%>"> 
        <input type="hidden" name="showFieldCodeStr" value="<%=showFieldCodeStr%>">
		<input type="hidden" name="deptCodeStr" value="<%=deptCodeStr%>">
		 </td>
    </tr>
</form>  </table>

</body>
</html>
