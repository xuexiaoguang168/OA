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
<form name="form1" method="post" action="archive_query_do.jsp?op=modifyOrderFieldCode">
  <table width="95%" border="0">
    <tr>
      <td>
<%
    int id = ParamUtil.getInt(request, "id");
    ArchiveQueryDb aqd = new ArchiveQueryDb();
    aqd = aqd.getArchiveQueryDb(id);	
    String tableFullCodeStr = aqd.getTableCode();
    String[] tableFullCodeArr = tableFullCodeStr.split(",");
    String orderFieldCodeStr = aqd.getOrderFieldCode();
	String[] orderFieldCodeArr = orderFieldCodeStr.split(",");
	String[] orderFieldArr = null;
	
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
	      
	   tfid = new TableFieldInfoDb();
	   Vector vt = tfid.list(sql);
	   Iterator ir = null;
	   ir = vt.iterator();
	   while (ir!=null && ir.hasNext()) {
		   tfid = (TableFieldInfoDb)ir.next();
		   fieldCode = 	tfid.getTableShortCode() + "." + tfid.getFieldCode();
		   int j = 0;
		   String asc = "",desc = "";
		   while(j < orderFieldCodeArr.length){
		      if(orderFieldCodeArr[j].equals(fieldCode +" ASC")){
                 asc = "selected";
			  }
			  if(orderFieldCodeArr[j].equals(fieldCode +" DESC")){
			     desc = "selected";
			  }
		      j++;
		   }
%>
          <tr>
            <td noWrap width="109"><%=tfid.getFieldName()%></td>
            <td noWrap>
			  <select name="fieldCode">
			    <option value=""></option>
			    <option value="<%=fieldCode%> ASC" <%if(!asc.equals("")){out.print(asc);}%>>升续</option>
			    <option value="<%=fieldCode%> DESC" <%if(!desc.equals("")){out.print(desc);}%>>降续</option>
			  </select> 			
			</td>
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
      <td align="center"><input value="保存排序字段" type="submit">
		<input type="hidden" name="id" value="<%=id%>"> 
		&nbsp;&nbsp;    </td>
    </tr>
  </table>
</form>
</body>
</html>
