<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html xmlns="http://www.wk.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>表情列表</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>

<body>
<table width="100%" border="0" align="center">
			<%
			  int k=3;
			  int m = 0;
			  int n = 44;
			  for (int i=25; i<=n; i++) {
			  	if (m==0)
					out.print("<tr>");
			  %>
		        <td>
				<input type="radio" value="<%=i%>" name="expression" <%if (i==25) out.println("checked");%> onClick="setEmote(this)">
				<img src="images/brow/<%=i%>.gif">
				</td>
			  <%
			  	m ++;
			  	if (m==3) {
					out.print("</tr>");
					m = 0;
				}
				if (i==44) {
					n = 22;
					i = 1;
				}
			  }
			  if (m!=3)
			  	out.print("</tr>");
			  %>
</table>
<script>
  function setEmote(emoteObj) {
    window.parent.document.frmAnnounce.expression.value = emoteObj.value;
  }
</script>
</body>
</html>
