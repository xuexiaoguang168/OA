<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.io.File"%>
<%@ page import = "java.util.Calendar"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="plan" scope="page" class="com.redmoon.oa.person.PlanMgr"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>日程安排</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link rel="stylesheet" href="common.css" type="text/css">
<%@ include file="inc/nocache.jsp" %>
<%
out.print(plan.changeCld_Script("plan.jsp"));
%>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=3 marginheight="3" marginwidth="0">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	if (!privilege.isUserLogin(request))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<%@ include file="plan_inc_menu_top.jsp"%>
<br>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" class="right-title">&nbsp;日 
      程 安 排</td>
  </tr>
  <tr> 
    <td align="center" valign="top"> <p><br>
<%

	int displayYear = 0;
	int displayMonth = 0;
	String stryear = request.getParameter("displayYear");
	String strmonth = request.getParameter("displayMonth");
	try {
		if (stryear!=null)
			displayYear = Integer.parseInt(stryear);
		if (strmonth!=null)
			displayMonth = Integer.parseInt(strmonth);
	}
	catch (Exception e){
		out.println(e.getMessage());
		return;
	}
	
	Calendar cal = Calendar.getInstance();
	int year = 0;
	int month = 0;
	if (stryear==null)
		year = cal.get(cal.YEAR);
	else
		year = displayYear;
	if (strmonth==null)
		month = cal.get(cal.MONTH);
	else
		month = displayMonth;
	String caltable = plan.newCalendar(privilege.getUser(request),year,month);
	out.print(caltable);
%>
        <br>
        &nbsp;&nbsp; 
      </p></td>
  </tr>
</table>
<div align="center"></div>
</BODY>
</HTML>
