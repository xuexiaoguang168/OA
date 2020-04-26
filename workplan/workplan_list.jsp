<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.workplan.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工作计划列表</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%
String priv = "read";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%@ include file="workplan_inc_menu_top.jsp"%>
<br>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr> 
    <td height="23" valign="middle" class="right-title"><span>&nbsp;工作计划</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql;
		String myname = privilege.getUser(request);
		sql = "select p.id from work_plan p, work_plan_user u where u.workPlanId=p.id and u.userName=" + StrUtil.sqlstr(privilege.getUser(request));
		String querystr = "";

		String op = ParamUtil.get(request, "op");
		if (op.equals("search")) {
			String title = ParamUtil.get(request, "title");
			String content = ParamUtil.get(request, "content");
			String beginDate = ParamUtil.get(request, "beginDate");
			String endDate = ParamUtil.get(request, "endDate");
			String typeId = ParamUtil.get(request, "typeId");
			if (!title.equals(""))
				sql += " and p.title like " + StrUtil.sqlstr("%" + title + "%");
			if (!content.equals(""))
				sql += " and p.content like " + StrUtil.sqlstr("%" + content + "%");
			if (!beginDate.equals(""))
				sql += " and p.beginDate>=" + StrUtil.sqlstr(beginDate);
			if (!endDate.equals(""))
				sql += " and p.endDate<=" + StrUtil.sqlstr(endDate);
			if (!typeId.equals("all"))
				sql += " and p.typeId=" + typeId;
			querystr += "op=search&title=" + StrUtil.UrlEncode(title) + "&content=" + StrUtil.UrlEncode(content) + "&beginDate=" + beginDate + "&endDate=" + endDate + "&typeId=" + typeId;
		}
		
		if (op.equals("mine"))
			sql = "select id from work_plan where author=" + StrUtil.sqlstr(privilege.getUser(request));
		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		WorkPlanDb wpd = new WorkPlanDb();
		
		ListResult lr = wpd.listResult(sql, curpage, pagesize);
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

      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
        <tr align="center" bgcolor="#C4DAFF"> 
          <td width="26%" bgcolor="#C4DAFF">标题</td>
          <td width="20%" bgcolor="#C4DAFF">拟定者</td>
          <td width="21%" bgcolor="#C4DAFF">开始日期</td>
          <td width="16%" bgcolor="#C4DAFF">结束日期</td>
          <td width="17%" bgcolor="#C4DAFF">操作</td>
        </tr>
      <%	
	  	int i = 0;
		UserMgr um = new UserMgr(); 
		while (ir!=null && ir.hasNext()) {
			wpd = (WorkPlanDb)ir.next();
			i++;
			int id = wpd.getId();
			String beginDate = DateUtil.format(wpd.getBeginDate(), "yyyy-MM-dd");
			String endDate = DateUtil.format(wpd.getEndDate(), "yyyy-MM-dd");
		%>
        <tr align="center" bgcolor="#EEEEEE"> 
          <td width="26%" bgcolor="#EEEEEE"> <a href=workplan_show.jsp?id=<%=id%>><%=wpd.getTitle()%></a></td>
          <td width="20%" bgcolor="#EEEEEE"><%=um.getUserDb(wpd.getAuthor()).getRealName()%></td>
          <td width="21%" bgcolor="#EEEEEE"><%=beginDate%></td>
          <td width="16%" bgcolor="#EEEEEE"><%=endDate%></td>
          <td width="17%" bgcolor="#EEEEEE"><a href="workplan_edit.jsp?id=<%=id%>">编辑</a>&nbsp;&nbsp;<a href="workplan_do.jsp?op=del&id=<%=id%>">删除</a></td>
        </tr>
      <%
		}

%>      </table>

      <br>
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
      </table>
    </td>
  </tr>
  <tr> 
    <td height="9">&nbsp;</td>
  </tr>
</table>
</body>
</html>
