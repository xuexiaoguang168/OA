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
<%@ include file="../inc/nocache.jsp"%>
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
  <table width="95%" border="0" align="center" class="tableframe">
<form name="form1" method="post" action="archive_query_conditionfieldcode.jsp">
    <tr>
      <td class="right-title">&nbsp;选择查询结果中将要显示的字段</td>
    </tr>
    <tr>
      <td>
<%
	String deptCodeStr = ParamUtil.get(request,"deptCodeStr");
	if(deptCodeStr.equals("")){
	   out.print(StrUtil.Alert_Back("请选择查询部门！"));
	   return;
	}
	
	String[] tableCodeArr = ParamUtil.getParameters(request,"tableCode");
		
	int i = 0;
	String sql = "",tableFullCodeStr = "",tableCodeStr = "",fieldFullCode = "",tableShortCodeStr = "";
	
	TableInfoDb tid = new TableInfoDb();	
	while(i < tableCodeArr.length){
	   tid = tid.getTableInfoDb(tableCodeArr[i]);
	   //生成表archive_query中table_code字段
	   tableFullCodeStr += tid.getTableCode() + " " + tid.getTableShortCode();
	   tableCodeStr += tid.getTableCode();
	   if(i < tableCodeArr.length - 1){
		   tableFullCodeStr += ",";
		   tableCodeStr += ",";
	   }
%>
      <table class="tableframe" cellSpacing="1" cellPadding="2" width="95%" align="center" border="0" bgcolor="#FFFFFF">
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
            <td noWrap>
<%
			if (tfid.getFieldCode().equalsIgnoreCase("REALNAME")) {%>
			<input type="checkbox" name="fieldFullCode" value="<%=fieldFullCode%>" disabled checked>
			<input name="fieldFullCode" type="hidden" value="<%=fieldFullCode%>">
			<%}
			else {
			%>
			<input type="checkbox" name="fieldFullCode" value="<%=fieldFullCode%>">			
			<%}%>
              选择该字段显示</td>
          </tr>
<%
       }
%>
        </tbody>
      </table>
<%   
	   i++;
	}
%>      </td>
    </tr>  
    <tr>
      <td align="center"><input value="下一步 &#8594; 选择查询时使用的条件字段" type="submit">
        <input type="hidden" name="tableFullCodeStr" value="<%=tableFullCodeStr%>">
        <input type="hidden" name="tableCodeStr" value="<%=tableCodeStr%>"> 
		<input type="hidden" name="deptCodeStr" value="<%=deptCodeStr%>">
	  </td>
    </tr>
</form>
</table>
</body>
</html>
