<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<html>
<head>
<title>增加日程</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="common.css" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="admin";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String op = fchar.getNullStr(request.getParameter("op"));
String name = fchar.UnicodeToGB(fchar.getNullStr(request.getParameter("name")));
String department_id = fchar.getNullStr(request.getParameter("department_id"));
String sql = "";
if (op.equals("setadmin"))
{
	sql = "insert user_admin_department (name,department_id) values ("+fchar.sqlstr(name)+","+department_id+")";
}
else if (op.equals("deladmin"))
{
	sql = "delete user_admin_department where name="+fchar.sqlstr(name)+" and department_id="+department_id;
}
else
{
	out.println(fchar.Alert("缺少操作符！"));
	return;
}
%>
<jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/>
<jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/>
<%
if (conn.executeUpdate(sql)>0)
{
	out.println(fchar.Alert_Back("操作成功！"));
}
else
{
	out.println(fchar.Alert_Back("操作失败！"));
}
if (conn!=null)
{
	conn.close();
	conn = null;
}
%>
</body>
</html>