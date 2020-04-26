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
<LINK href="default.css" type=text/css rel=stylesheet>
<script>
function setPerson(user, userRealName)
{
	form1.userName.value = user;
	form1.userRealName.value = userRealName;
}

function ShowTableAddPost() {
	tableAddPost.style.display = "";
}

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,top=50,left=120,width="+width+",height="+height);
}
</script>
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
%>
</body>
</html>
