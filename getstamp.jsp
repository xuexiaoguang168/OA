<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="fsecurity" scope="page" class="fan.util.fsecurity"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = request.getParameter("priv");
if (priv==null)
	priv = "read";
String user = fchar.UnicodeToGB(request.getParameter("user"));
String pwd = request.getParameter("pwd");
if (user==null)
{
	if (!privilege.isUserPrivValid(request,priv))
	{
		out.println(fchar.makeErrMsg("     ʴ   "));
		return;
	}
}
else
{
	if (!privilege.isUserPrivValid(user,fsecurity.MD5(pwd),priv))
	{
		out.println(fchar.makeErrMsg("     ʴ   "));
		return;
	}
}

String filename = fchar.UnicodeToGB(request.getParameter("filename"));
if (filename==null) {
	//out.print(fchar.p_center("ȱ   "));
	//return;
	filename = user+".bmp";
}
filename = user+".bmp";

cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String documentpath = props.getProperty("documentpath");

response.setContentType("application/bmp");
response.setHeader("Content-disposition","attachment; filename="+filename);

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

try {
bis = new BufferedInputStream(new FileInputStream(documentpath+"stamp/"+filename));
bos = new BufferedOutputStream(response.getOutputStream());

byte[] buff = new byte[2048];
int bytesRead;

while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
bos.write(buff,0,bytesRead);
}

} catch(final IOException e) {
System.out.println ( "  IOException." + e );
} finally {
if (bis != null)
bis.close();
if (bos != null)
bos.close();
}
%>



