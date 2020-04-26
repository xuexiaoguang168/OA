<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.module.cms.*" %>
<%@ page import="cn.js.fan.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网络硬盘主窗口</title>
</head>
<body>
<jsp:useBean id="dir" scope="page" class="cn.js.fan.module.cms.Directory"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("showDirShare"))
	return;
String dir_code = ParamUtil.get(request, "dir_code");
if (dir_code.equals(""))
	dir_code = "template";
Leaf leaf = dir.getLeaf(dir_code);
int type = leaf.getType();
if (type==0) {
	response.sendRedirect("dir_list.jsp?op=editarticle&dir_code=" +
                      StrUtil.UrlEncode(privilege.getUser(request)));
}
else {
	response.sendRedirect("document_list_m.jsp?dir_code=" +
                      StrUtil.UrlEncode(leaf.getCode()) + "&dir_name=" +
                      StrUtil.UrlEncode(leaf.getName()));
}
%>
</body>
</html>
