<%@ page language="java"  contentType="text/html; charset=utf-8" %>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<HTML><HEAD><TITLE>计划</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link rel="stylesheet" href="common.css" type="text/css">
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY text=#000000 bgColor=#ffffff >
<%@ include file="plan_inc_menu_top.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int id = ParamUtil.getInt(request, "id");

String username="",title="",content="",mydate="",zdrq="";
PlanDb pd = new PlanDb();
pd = pd.getPlanDb(id);

username = pd.getUserName();
content = pd.getContent();
title = pd.getTitle();
mydate = DateUtil.format(pd.getMyDate(), "yyyy-MM-dd HH:mm:ss");
zdrq = DateUtil.format(pd.getZdrq(), "yyyy-MM-dd");
%>
<br>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <tr> 
    <td width="100%" height="23" class="right-title"> &nbsp;查 
      看 日 程</td>
  </tr>
  <tr> 
    <td height="280" align="center" valign="top"><br>
      <table width="90%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr bgcolor="#3399FF"> 
          <td width="19%" bgcolor="#C4DAFF" class="stable">标&nbsp;&nbsp;&nbsp;&nbsp;题：</td>
          <td colspan="3" bgcolor="#C4DAFF" class="stable"><%=title%></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td class="stable">制定日期：</td>
          <td width="35%" class="stable"><%=zdrq%></td>
          <td width="17%" class="stable">办理时间：</td>
          <td width="29%" align="center" bgcolor="#FFFFFF" class="stable"><%=mydate%></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td valign="top" bgcolor="#FFFFFF" class="stable">内 &nbsp;&nbsp;&nbsp;容：</td>
          <td colspan="3" class="stable"><%=content%> </td>
        </tr>
      </table>
      <p><a href="plan_del.jsp?id=<%=id%>">删除日程</a> </p></td>
  </tr>
</table>
</BODY>
</HTML>
