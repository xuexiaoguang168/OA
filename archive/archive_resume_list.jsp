<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
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
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<%
	String userName = ParamUtil.get(request,"userName");
	if (!privilege.isUserPrivValid(request, "archive.resume")||!archivePrivilege.canAdminUser(request,userName)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<%@ include file="archive_inc_menu_top.jsp"%>
<br>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">

  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;履历信息管理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
	String sql = "",userRealName = "";
	if(userName.equals("")){
		sql = ArchiveSQLBuilder.getUserResume();
	}else{
		sql = ArchiveSQLBuilder.getUserResume(userName);
	}
	String querystr = "";		
	int pagesize = 10;
	Paginator paginator = new Paginator(request);
	int curpage = paginator.getCurPage();
		
	UserResumeDb urd = new UserResumeDb();		
	ListResult lr = urd.listResult(sql, curpage, pagesize);
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
	  <form name="form1" action="archive_resume_add.jsp" method="post">
	    <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0" >
          <tr align="center" bgcolor="#C4DAFF">
            <td width="19%" height="24" >姓名</td>
            <td width="15%" bgcolor="#C4DAFF" >单位名称</td>
            <td width="16%" bgcolor="#C4DAFF" >担任工作</td>
            <td width="14%" >开始时间</td>
            <td width="12%" >结束时间</td>
            <td width="24%" >操作</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		UserInfoDb uid = new UserInfoDb();
		while (ir!=null && ir.hasNext()) {
			urd = (UserResumeDb)ir.next();
			uid = uid.getUserInfoDb(urd.getUserName());
			userRealName = uid.getUserRealName();		 	
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="19%" height="22"><%=userRealName%></td> 
          <td width="15%"><%=urd.getCompany()%></td>
		  <td width="16%"><%=urd.getJob()%></td>
		  <td width="14%"><%=DateUtil.format(urd.getBeginDate(),"yyyy-MM")%></td>
		  <td width="12%"><%=DateUtil.format(urd.getEndDate(),"yyyy-MM")%></td>
          <td width="12%"><a href="archive_resume_modify.jsp?id=<%=urd.getId()%>&userName=<%=StrUtil.UrlEncode(userName)%>">编辑</a></td>
		  <td width="12%"><a href="archive_resume_do.jsp?id=<%=urd.getId()%>&op=del&userName=<%=StrUtil.UrlEncode(userName)%>">删除</a></td>
        </tr>
      </table>
      <%}%>	  
	  <input type="hidden" name="userName" value="<%=userName%>"> 
	  </form>
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
  <tr> 
    <td height="30" colspan="2" align="center">
      <input name="button" type="submit" class="button1"  value="添加履历信息" onClick="form1.submit()">
    </td>
  </tr>
</table>
</body>
</html>
