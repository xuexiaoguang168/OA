<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.netdisk.*" %>
<%@ page import="com.redmoon.oa.pvg.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网络硬盘</title>
</head>
<frameset rows="*" cols="180,*" framespacing="0" border="0">
<%
String op = ParamUtil.get(request, "op");
String userName = ParamUtil.get(request, "userName");
if (op.equals("showDirShare")) {
%>
  <frame src="netdisk_dir_share.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" name="leftFileFrame" >
<%}
else {
%>
<jsp:useBean id="dir" scope="page" class="com.redmoon.oa.netdisk.Directory"/>
<%
    Privilege privilege = new Privilege();
	String root_code = privilege.getUser(request);
	Leaf leaf = dir.getLeaf(root_code);
	if (leaf==null || !leaf.isLoaded()) {
		// 为用户初始化网盘
		leaf = new Leaf();
		leaf.initRootOfUser(root_code);
		leaf = leaf.getLeaf(root_code);
	}
%>
  <frame src="netdisk_left.jsp" name="leftFileFrame" >
<%}%>
  <frame src="netdisk_main.jsp?op=<%=op%>" name="mainFileFrame">
</frameset>
<noframes><body>
</body></noframes>
</html>
