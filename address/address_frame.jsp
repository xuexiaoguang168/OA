<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.netdisk.*" %>
<%@ page import="com.redmoon.oa.pvg.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>通讯录框架</title>
</head>
<%
String type = ParamUtil.get(request, "type");
String mode = ParamUtil.get(request, "mode");
%>
<frameset rows="*" cols="180,*" framespacing="0" border="0">
  <frame src="address_left.jsp?type=<%=type%>&mode=<%=mode%>" name="leftAddressFrame" >
  <frame src="address.jsp?type=<%=type%>&mode=<%=mode%>" name="mainAddressFrame">
</frameset>
<noframes><body>
</body></noframes>
</html>
