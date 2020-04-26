<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.emailpop3.*"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>邮件列表</title>
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
<%
if (!privilege.isUserLogin(request)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	boolean re = false;
	try {
		MailMsgMgr mmm = new MailMsgMgr();
		re = mmm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	}
}
%>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td width="100%" height="23" class="right-title">&nbsp;邮 
      件 列 表</td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <%
		String sql;
		String myname = privilege.getUser(request);
		String sender = ParamUtil.get(request, "sender");
		int type = ParamUtil.getInt(request, "type");
		sql = "select id from email where sender=" + fchar.sqlstr(sender) + " and type=" + type;
				
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		MailMsgDb mmd = new MailMsgDb();
		
		ListResult lr = mmd.listResult(sql, curpage, pagesize);
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
			找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %>		  &nbsp;</td>
        </tr>
      </table> 
      <table width="98%" height="8" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td></td>
        </tr>
      </table>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr bgcolor="#C4DAFF"> 
          <td width="59%" class="stable"> 
          <div align="center">标题</div></td>
          <td width="22%" align="center" class="stable">安排日期</td>
          <td width="11%" align="center" class="stable">编辑</td>
          <td width="8%" align="center" class="stable">删除</td>
        </tr>
      </table>
      <%	
	    int id;
		String mydate;
		while (ir!=null && ir.hasNext()) {
			mmd = (MailMsgDb)ir.next();
			id = mmd.getId();
			mydate = DateUtil.format(mmd.getMyDate(), "yyyy-MM-dd HH:mm:ss");
		%>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" class="line-st-1">
        <tr> 
          <td width="59%"> <a href="mail_show.jsp?id=<%=id%>"><%=mmd.getSubject()%></a></td>
          <td width="22%" align="center"><%=mydate%></td>
          <td width="11%" align="center"><a href="mail_edit.jsp?id=<%=id%>">编辑</a></td>
          <td width="8%" align="center"><a href="?op=del&type=<%=type%>&sender=<%=sender%>&id=<%=id%>">删除</a></td>
        </tr>
      </table>
<%}%>
      <br>
      <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td height="23" align="right">&nbsp;
          <%
				String querystr = "";
				out.print(paginator.getCurPageBlock("plan_list.jsp?"+querystr));
				%>
          &nbsp;&nbsp;</td>
        </tr>
      </table>
      <br>
      <br>
      <p><br>
        <br>
        <br>
        <br>
      </p></td>
  </tr>
</table>
</body>
</html>
