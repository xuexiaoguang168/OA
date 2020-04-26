<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.message.*"%>
<%@ page import = "com.redmoon.oa.sms.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.*"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>短讯列表</title>
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
</head>
<body background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
if (!privilege.isUserPrivValid(request, "admin")) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<br>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td width="100%" height="23" class="right-title">&nbsp;<span>短讯列表</span></td>
  </tr>
  <tr> 
    <td valign="top"><br>
<%		
        String op = ParamUtil.get(request, "op");
		String sql = "";
		if(op.equals("search")){
			sql = SMSSendRecordMgr.getSearchSendSMS(request);
		}else{
			sql = SMSSendRecordMgr.getSearchSendSMS();
		}
		
	    String querystr = "";	
		if(op.equals("search")){
		    querystr += "op=" + op + "userName=" + StrUtil.UrlEncode(ParamUtil.get(request, "userName")) + "&sendMobile=" + StrUtil.UrlEncode(ParamUtil.get(request, "sendMobile")) + "&fromSendTime=" + ParamUtil.get(request, "fromSendTime")
			+ "&toSendTime=" + ParamUtil.get(request, "toSendTime") + "&msgText=" + StrUtil.UrlEncode(ParamUtil.get(request, "msgText"));
		}
		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		SMSSendRecordDb ssrd = new SMSSendRecordDb();
		ListResult lr = ssrd.listResult(sql, curpage, pagesize);
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
          <td width="15%" align="center" class="stable">发送时间</td> 
          <td width="15%" align="center" class="stable">发送者</td>
          <td width="15%" align="center" class="stable">手机号码</td>
          <td width="55%" align="center" class="stable">内容</td>
        </tr>
      </table>
      <%	
	    UserMgr um = new UserMgr();
		while (ir.hasNext()) {
			ssrd = (SMSSendRecordDb)ir.next();
			String userRealName = "";
			UserDb ud = um.getUserDb(ssrd.getUserName());
			if (!ssrd.getUserName().equals(MessageDb.SENDER_SYSTEM))
				userRealName = ud.getRealName();
			else
				userRealName = MessageDb.SENDER_SYSTEM;
	  %>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" class="line-st-1">
        <tr>
          <td width="15%" align="center"><%=DateUtil.format(ssrd.getSendTime(), "yyyy-MM-dd HH:mm:ss")%></td> 
          <td width="15%" align="center"><%=userRealName%></td>
          <td width="15%"><%=ssrd.getSendMobile()%></td>
          <td width="55%" align="left"><%=ssrd.getMsgText()%></td>
        </tr>
      </table>
<%}%>
      <br>
      <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td height="23" align="right">&nbsp;
          <%
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
