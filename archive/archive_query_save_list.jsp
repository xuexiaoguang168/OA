<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
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
%>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">
  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;查询列表</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql = "";
		sql = ArchiveSQLBuilder.getArchiveQuery();
		String querystr = "";		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
				
		ArchiveQueryDb aqd = new ArchiveQueryDb();			
		ListResult lr = aqd.listResult(sql, curpage, pagesize);
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
	    <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0" >
          <tr align="center" bgcolor="#C4DAFF">
            <td width="20%" height="24" >查询名称</td>
            <td width="12%" bgcolor="#C4DAFF" >查询部门</td>
            <td width="12%" bgcolor="#C4DAFF" >显示字段</td>
            <td width="12%" bgcolor="#C4DAFF" >查询范围</td>
            <td width="12%" >条件字段</td>
            <td width="12%">排序字段</td>
            <td width="20%" >操作</td>
          </tr>
        </table>
	    <%	
		while (ir!=null && ir.hasNext()) {
			aqd = (ArchiveQueryDb)ir.next();	
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="20%" height="22"><%=aqd.getQueryName()%></td> 
          <td width="12%"><a href="archive_query_dept_modify.jsp?id=<%=aqd.getId()%>">编辑</a></td>
		  <td width="12%"><a href="archive_query_showfieldcode_modify.jsp?id=<%=aqd.getId()%>">编辑</a></td>
		  <td width="12%"><a href="archive_query_confine_modify.jsp?id=<%=aqd.getId()%>">编辑</a></td>
		  <td width="12%"><a href="archive_query_conditionfieldcode_modify.jsp?id=<%=aqd.getId()%>">编辑</a></td>
		  <td width="12%"><a href="archive_query_ordercode_modify.jsp?id=<%=aqd.getId()%>">编辑</a></td>
          <td width="7%"><a href="archive_query_user.jsp?id=<%=aqd.getId()%>">授权</a></td>
          <td width="7%"><a href="archive_query_list.jsp?id=<%=aqd.getId()%>&op=query">查询</a></td>
          <td width="6%"><a href="archive_query_do.jsp?id=<%=aqd.getId()%>&op=del">删除</a></td>
	    </tr>
      </table>
      <%}%>	 
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
</table>
</body>
</html>
