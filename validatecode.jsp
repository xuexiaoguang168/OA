<%@ page contentType="image/jpeg" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*" %><%
int width = 60;
int charNum = 4;
try {
	String num = request.getParameter("charNum");
	if (num!=null) {
		charNum = Integer.parseInt(num);	
		width = charNum * 15;
	}
}
catch (Exception e) {
}
cn.js.fan.security.ValidateCodeCreator vcc = new cn.js.fan.security.ValidateCodeCreator();
// out.clear();
vcc.create(request, response, width, 20, charNum);
%>