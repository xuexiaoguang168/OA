<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.workplan.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工作计划类型管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--

//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="workplan";
if (!privilege.isUserPrivValid(request, priv)) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%@ include file="workplan_inc_menu_top.jsp"%>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	WorkPlanTypeMgr wptm = new WorkPlanTypeMgr();
	boolean re = false;
	try {
		re = wptm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

if (op.equals("del")) {
	WorkPlanTypeMgr wptm = new WorkPlanTypeMgr();
	boolean re = false;
	try {
		re = wptm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<br>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" valign="bottom" background="../images/top-right.gif" class="right-title">&nbsp;&nbsp;<span> 工作计划类型 </span></td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<form id=form1 name="form1" action="?op=add" method=post>
      <tr>
        <td height="100" align="center" class="p14"><table width="88%" height="81"  border="0" cellpadding="0" cellspacing="0" class="p14">
            <tr>
              <td class="p14">			  </td>
            </tr>
            <tr>
              <td class="p14">
			  <%
			  WorkPlanTypeDb wptd = new WorkPlanTypeDb();
			  String sql = "select id from work_plan_type";
			  Iterator ir = wptd.list(sql).iterator();
			  while (ir.hasNext()) {
			  	wptd = (WorkPlanTypeDb)ir.next();%>
			  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="71%"><%=wptd.getName()%></td>
                  <td width="17%"><a href="workplantype_edit.jsp?id=<%=wptd.getId()%>">编辑</a></td>
                  <td width="12%"><a href="?op=del&id=<%=wptd.getId()%>">删除</a></td>
                </tr>
              </table>
			  	
				<%}%>			  </td>
            </tr>
          </table>
          <br>          </td>
      </tr></form>
	  <form action="?op=add" method=post> 
      <tr>
        <td align="center">
		类型名称：
		  <input name="name" maxlength="30">
		  &nbsp;
		  <input name="submit" type=submit value="创建新类型"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
	  </form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
