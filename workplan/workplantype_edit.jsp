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
	out.println(fchar.makeErrMsg("对不起，您不具有发起流程的权限！"));
	return;
}
%>
<%@ include file="workplan_inc_menu_top.jsp"%>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("modify")) {
	WorkPlanTypeMgr wptm = new WorkPlanTypeMgr();
	boolean re = false;
	try {
		re = wptm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

int id = ParamUtil.getInt(request, "id");
WorkPlanTypeDb wptd = new WorkPlanTypeDb();
wptd = wptd.getWorkPlanTypeDb(id);
%>
<br>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" valign="bottom" background="../images/top-right.gif" class="right-title">&nbsp;&nbsp;<span> 工作计划类型 </span></td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  <form action="?op=modify" method=post> 
      <tr>
        <td height="69" align="center">
		类型名称：
		  <input name="name" value="<%=wptd.getName()%>" maxlength="30">
		  <input name="id" value="<%=id%>" type=hidden>
		  &nbsp;
		  <input name="submit" type=submit value="修改类型"></td>
      </tr>
	  </form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
