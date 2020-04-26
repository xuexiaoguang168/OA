<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="com.redmoon.oa.person.UserDb" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>职位</title>
<LINK href="common.css" type=text/css rel=stylesheet>
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

String op = ParamUtil.get(request, "op");
/*
if (op.equals("add")) {
	try {
		PostMgr jm = new PostMgr();
		jm.add(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (op.equals("move")) {
	try {
		PostMgr jm = new PostMgr();
		jm.move(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("modify")) {
	try {
		PostMgr jm = new PostMgr();
		if (jm.modify(request))
			out.print(StrUtil.Alert("修改成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
*/
%>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="frame_gray" style="height:100%">
  <tr>
    <td width="352" align="center" valign="top"><table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
      
      <%
	DeptUserDb du = new DeptUserDb();
	Vector v = du.list(deptCode);
	Iterator ir = v.iterator();
	while (ir.hasNext()) {
		du = (DeptUserDb)ir.next();
		UserDb ud = new UserDb();
		String userName = du.getUserName();
		String userRealName = "";	
		if (userName!=null) {
			ud = ud.getUserDb(userName);
			userRealName = ud.getRealName();
		}
	%>
      <tr>
        <td width="53%" height="22" align="left">&nbsp;&nbsp;<%=ud.isLoaded()?com.redmoon.oa.basic.RankDb.getRankName(ud.getRankCode()):""%>：<%=userRealName%>&nbsp;&nbsp;</td>
        <td width="47%" align="left"><img src="images/computer.gif" width="16" height="16" align="left">&nbsp;<a href="netdisk_frame.jsp?op=showDirShare&userName=<%=StrUtil.UrlEncode(userName)%>" target="_parent" class="dir">共享目录</a></td>
      </tr>
      <%}%>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
