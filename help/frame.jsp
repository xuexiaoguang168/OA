<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "cn.js.fan.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>帮助手册</title>
</head>
<%
 String StrPage = ParamUtil.get(request,"page");
 if (StrPage.equals("")) 
     StrPage = "right.html";	 
%>
<frameset rows="*" cols="172,*" framespacing="0" frameborder="no" border="0">
  <frame src="left.html" name="leftFrame" id="leftFrame" />
  <frame src="<%=StrPage%>" name="mainHelpFrame" id="mainHelpFrame" />
</frameset>
<noframes><body>
</body>
</noframes></html>
