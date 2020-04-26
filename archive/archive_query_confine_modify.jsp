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
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
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
<form name="form1" method="post" action="archive_query_do.jsp?op=modifyTableCode">
  <table width="95%" border="0">
    <tr>
      <td><table class="tableframe" cellSpacing="1" cellPadding="2" width="95%" align="center" border="0" bgcolor="#FFFFFF">
        <tbody>
          <tr>
            <td colspan="2" noWrap class="right-title">修改查询范围</td>
          </tr>
<%
   int id = ParamUtil.getInt(request, "id");
   
   ArchiveQueryDb aqd = new ArchiveQueryDb();
   aqd = aqd.getArchiveQueryDb(id);
   String table_full_code = aqd.getTableCode();
   String[] tableFullCodeArr = table_full_code.split(",");
   String[] tableCodeArr = null;
   
   String sql = ArchiveSQLBuilder.getArchiveTable(); 
   TableInfoDb tid = new TableInfoDb();
    
   Vector vt = tid.list(sql);
   Iterator ir = null;
   ir = vt.iterator();
   while (ir!=null && ir.hasNext()) {
       tid = (TableInfoDb)ir.next();
	   int i = 0;
%>		  	  
          <tr>
            <td width="6%" noWrap><%=tid.getTableDescription()%></td>
            <td><input type="checkbox" name="tableCode" value="<%=tid.getTableCode()%>"
			 <%
			  while(i < tableFullCodeArr.length){
	            tableCodeArr = tableFullCodeArr[i].split(" ");
			    if(tableCodeArr[0].equals(tid.getTableCode())){
			 %> 
				checked 
			 <%  
			    }
			    i++;
              }
			 %>
			 >选择该表
			</td>
          </tr>	
<%
  }
%>	  
        </tbody>
      </table></td>
    </tr>  
    <tr>
      <td align="center"><input value="保存查找范围" type="submit">
        <input type="hidden" name="id" value="<%=id%>">&nbsp;&nbsp;    </td>
    </tr>
  </table>
</form>
</body>
</html>
