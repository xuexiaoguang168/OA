<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.*"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>日程列表</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language=javascript>
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}
//-->
</script>
</head>
<body background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td width="100%" height="23" class="right-title">&nbsp;<span>日 志 列 表</span></td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <%
		if (!privilege.isUserPrivValid(request, "admin")) {
			out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
		
		LogDb ld = new LogDb();
		String op = ParamUtil.get(request, "op");
		if (op.equals("del")) {
			int delid = ParamUtil.getInt(request, "id");
			LogDb ldb = ld.getLogDb(delid);
			if (ldb.del())
				out.print(StrUtil.Alert("操作成功	"));
			else
				out.print(StrUtil.Alert("操作失败"));
		}
		String sql;
		String myname = privilege.getUser(request);
		sql = "select ID from log order by ID desc";
		// out.print(sql);
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		
		ListResult lr = ld.listResult(sql, curpage, pagesize);
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
          <td align="right">
			找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %>		  </td>
        </tr>
      </table> 
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr bgcolor="#C4DAFF">
          <td width="15%" align="center" class="stable">日 期</td> 
          <td width="15%" align="center" class="stable">用户名</td>
          <td width="40%" align="center" class="stable">动 作</td>
          <td width="13%" align="center" class="stable">IP</td>
          <td width="9%" align="center" class="stable">类 型</td>
          <td width="8%" align="center" class="stable">操 作</td>
        </tr>
      </table>
      <%	
	    UserMgr um = new UserMgr();
		while (ir.hasNext()) {
			ld = (LogDb)ir.next();
			UserDb ud = um.getUserDb(ld.getUserName());
		%>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" class="line-st-1">
        <tr>
          <td width="15%" align="center"><%=DateUtil.format(ld.getDate(), "yyyy-MM-dd HH:mm:ss")%></td> 
          <td width="15%" align="center"><%=ud.getRealName()%></td>
          <td width="40%"><%=ld.getAction()%></td>
          <td width="13%" align="center"><%=ld.getIp()%></td>
          <td width="9%" align="center"><%=LogUtil.getTypeDesc(request, ld.getType())%></td>
          <td width="8%" align="center"><a href="?op=del&id=<%=ld.getId()%>">删除</a></td>
        </tr>
      </table>
<%}%>
      <br>
      <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td height="23" align="right">&nbsp;
          <%
				String querystr = "";
				out.print(paginator.getCurPageBlock("?"+querystr));
				%>
          &nbsp;&nbsp;</td>
        </tr>
      </table>
      <br>
      </td>
  </tr>
</table>
</body>
</html>
