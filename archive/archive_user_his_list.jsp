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
<% 
    if (!privilege.isUserPrivValid(request, "archive.his")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<%@ include file="archive_inc_his_menu_top.jsp"%>
<br>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">

  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;用户信息管理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql = "",sex = "",userRealName = "",userName = "";
		sql = ArchiveSQLBuilder.getUserInfoHis();
		String querystr = "";		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		UserInfoHisDb uihd = new UserInfoHisDb();		
		ListResult lr = uihd.listResult(sql, curpage, pagesize);
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
            <td width="19%" height="24" >姓名</td>
            <td width="15%" bgcolor="#C4DAFF" >性别</td>
            <td width="16%" bgcolor="#C4DAFF" >出生日期</td>
            <td width="14%" >参加工作时间</td>
            <td width="12%" >文化程度</td>
            <td width="24%" >操作</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		while (ir!=null && ir.hasNext()) {
			uihd = (UserInfoHisDb)ir.next();			
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="19%" height="22"><%=uihd.getUserRealName()%></td> 
          <td width="15%"><%=uihd.getSex()%></td>
		  <td width="16%"><%=DateUtil.format(uihd.getBirthday(),"yyyy-MM-dd")%></td>
		  <td width="14%"><%=DateUtil.format(uihd.getJoinWorkDate(),"yyyy-MM-dd")%></td>
		  <td width="12%"><%=uihd.getCulture()%></td>
          <td width="24%"><a href="archive_user_his_show.jsp?id=<%=uihd.getId()%>">查看</a></td>
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
  <tr> 
    <td height="30" colspan="2" align="center">
    </td>
  </tr>
</table>
</body>
</html>
