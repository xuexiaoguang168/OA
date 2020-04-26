<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>职位</title>
<LINK href="../admin/default.css" type=text/css rel=stylesheet>
</head>
<body>
<%
String deptCode = ParamUtil.get(request, "deptCode");
if (deptCode.equals(DeptDb.ROOTCODE)) {
	out.print(SkinUtil.makeErrMsg(request, "请选择某个部门！"));
	return;
}

if (deptCode.equals("")) {
	return;
}

DeptDb dd = new DeptDb();
dd = dd.getDeptDb(deptCode);
if (dd==null || !dd.isLoaded()) {
	out.print(StrUtil.Alert("部门" + deptCode + "不存在！"));
	return;
}

%>
<table width="356" border="0" align="center" cellpadding="0" cellspacing="1" class="frame_gray" style="height:100%">
  <tr>
    <td width="352" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" align="center" bgcolor="#88B5FF"><%=dd.getName()%>用户档案维护</td>
      </tr>
    </table>
      <table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" align="center" bgcolor="#C4DAFF">职级</td>
        <td align="center" bgcolor="#C4DAFF">姓名</td>
        <td height="24" align="center" bgcolor="#C4DAFF">操作</td>
        </tr>
      <%
	DeptUserDb du = new DeptUserDb();
	Vector v = du.list(deptCode);
	Iterator ir = v.iterator();
	UserDb user;
	UserMgr um = new UserMgr();
	while (ir.hasNext()) {
		du = (DeptUserDb)ir.next();
		user = um.getUserDb(du.getUserName());
	%>
      <tr>
        <td width="31%" height="22"><%=com.redmoon.oa.basic.RankDb.getRankName(user.getRankCode())%></td>
        <td width="34%" height="22"><%=StrUtil.getNullString(user.getRealName())%></td>
        <td height="22" align="center"><a href="user_archive_modify.jsp?op=create&name=<%=StrUtil.UrlEncode(du.getUserName())%>">维护</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="user_archive_show.jsp?name=<%=StrUtil.UrlEncode(du.getUserName())%>">查看</a></td>
        </tr>
      <%}%>
    </table>
      <br></td>
  </tr>
</table>
</body>
</html>
