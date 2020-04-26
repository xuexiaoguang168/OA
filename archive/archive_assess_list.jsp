<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>考核信息管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<% 
	String userName = StrUtil.getNullStr(ParamUtil.get(request,"userName"));
    if (!privilege.isUserPrivValid(request, "archive.assess")||!archivePrivilege.canAdminUser(request,userName)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<%@ include file="archive_inc_menu_top.jsp"%>
<br>
<%
	String op = ParamUtil.get(request, "op");
	if (op.equals("del")) {
	   UserAssessMgr uam = new UserAssessMgr();
	   boolean re = false;
	   try {  
		 re = uam.del(request);
	   }
	   catch(ErrMsgException e){
		 out.print(StrUtil.Alert(e.getMessage()));
	   }
	   if (re) {
		 out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.module.archive", "success_del_assess")));
	   } 
	}
%>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr> 
    <td height="23" valign="middle" class="right-title">考核信息管理</td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql;
		String userRealName = "";
		String myname = privilege.getUser(request);
		if(userName.equals("")){
			sql = "select id from archive_assess";
		}else{
			sql = "select id from archive_assess where userName = " + StrUtil.sqlstr(userName);
		}
		String querystr = "";
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		UserAssessDb uad = new UserAssessDb();
		
		ListResult lr = uad.listResult(sql, curpage, pagesize);
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
	 <form name="form1" action="archive_assess_add.jsp" method="post">
      <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0">
        <tr align="center" bgcolor="#C4DAFF"> 
          <td width="16%">姓名</td>
          <td width="15%" bgcolor="#C4DAFF">考核年度</td>
          <td width="12%" bgcolor="#C4DAFF">考核情况</td>
          <td width="12%" bgcolor="#C4DAFF">考核结果</td>
          <td width="9%">审批时间</td>
          <td width="13%">备注</td>
          <td width="11%">操作</td>
        </tr>
      </table>
      <%	
	  	int i = 0;
		UserInfoDb uid = new UserInfoDb();
		while (ir!=null && ir.hasNext()) {
			uad = (UserAssessDb)ir.next();
			i++;
			int id = uad.getId();
			uid = uid.getUserInfoDb(uad.getUserName());
			userRealName = uid.getUserRealName();
			String myDate = DateUtil.format(uad.getMyDate(), "yyyy-MM-dd");
	 %>
      <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0">
        <tr align="center"> 
          <td width="16%"><%=userRealName%></td>
          <td width="15%"><%=uad.getAssessYear()%></td>
          <td width="12%"><%=uad.getInfo()%> </td>
          <td width="12%"><%=uad.getResult()%></td>
          <td width="9%"><%=myDate%></td>
          <td width="13%"><%=uad.getRemark()%></td>
          <td width="11%"><a href="archive_assess_edit.jsp?id=<%=id%>&userName=<%=StrUtil.UrlEncode(userName)%>">编辑</a>&nbsp;&nbsp;<a href="?op=del&id=<%=id%>&userName=<%=StrUtil.UrlEncode(userName)%>">删除</a></td>
        </tr>
      </table>
      <%}%>
	 <input type="hidden" name="userName" value="<%=userName%>">
	 </form>
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
    <td height="30" colspan="2" align="center">
      <input name="button" type="submit" class="button1"  value="添加考核信息" onClick="form1.submit()">
    </td>
  </tr>
</table>
</body>
</html>
