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
<br>
<form name="form1" method="post" action="archive_query_conditionvalue_modify.jsp">
  <table width="95%" border="0">
    <tr>
      <td>
<%
    int id = ParamUtil.getInt(request, "id");
    ArchiveQueryDb aqd = new ArchiveQueryDb();
    aqd = aqd.getArchiveQueryDb(id);	
    String tableFullCodeStr = aqd.getTableCode();
    String[] tableFullCodeArr = tableFullCodeStr.split(",");
	
	
	String[] tableCodeArr = null;	
	String sql = "",fieldCode = "";
	int i = 0;	
	TableInfoDb tid = new TableInfoDb();
	TableFieldInfoDb tfid = new TableFieldInfoDb();
	ArchiveQueryConditionDb aqcd = new ArchiveQueryConditionDb();
	
	while(i < tableFullCodeArr.length){
	   tableCodeArr = tableFullCodeArr[i].split(" ");
	   tid = tid.getTableInfoDb(tableCodeArr[0]);
	   
%>
      <table class="tableframe" cellSpacing="1" cellPadding="2" width="95%" align="center" border="0" bgcolor="#FFFFFF">
        <tbody>
          <tr>
            <td colspan="3" class="right-title"><%=tid.getTableDescription()%></td>
          </tr>
<%
	   sql = ArchiveSQLBuilder.getArchiveTableField(tid.getTableShortCode());
	      	   
	   Vector vt = tfid.list(sql);
	   Iterator ir = null;
	   ir = vt.iterator();
	   while (ir!=null && ir.hasNext()) {
		   tfid = (TableFieldInfoDb)ir.next();
		   fieldCode = 	tfid.getTableShortCode() + "." + tfid.getFieldCode();
%>
          <tr>
            <td noWrap width="109"><%=tfid.getFieldName()%></td>
            <td noWrap><input type="checkbox" name="fieldCode" value="<%=fieldCode%>"
			<%
			   sql = ArchiveSQLBuilder.getArchiveQueryCondition(id);
			   Vector vtCon = aqcd.list(sql);
			   Iterator irCon = null;
			   irCon = vtCon.iterator();
			   while (irCon!=null && irCon.hasNext()) {
				   aqcd = (ArchiveQueryConditionDb)irCon.next();
                   if(aqcd.getConditionFieldCode().equals(fieldCode)){
			%> 
			      checked 
		    <%
			      }
               }
			%>
			>			
              选择该查询条件字段</td>
          </tr>
<%
       }
%>
        </tbody>
      </table>
<%   
	   i++;
	}
%>
      </td>
    </tr>  
    <tr>
      <td align="center"><input value="填写查询条件字段" type="submit">
        <input type="hidden" name="id" value="<%=id%>">
		<input type="hidden" name="tableFullCodeStr" value="<%=tableFullCodeStr%>">
		 &nbsp;&nbsp;    </td>
    </tr>
  </table>
</form>
</body>
</html>
