<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="fsecurity" scope="page" class="fan.util.fsecurity"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="email" scope="page" class="com.redmoon.oa.Email"/>
<%
String priv = request.getParameter("priv");
if (priv==null)
	priv = "read";
String user = fchar.UnicodeToGB(request.getParameter("user"));
String pwd = request.getParameter("pwd");
// FOAShell  ퟀ��� cookie Ϣᶪʧ
if (!privilege.isUserPrivValid(user,pwd,priv))
{
	out.println(fchar.makeErrMsg("     ʴ   "));
	return;
}

String id = request.getParameter("id");
String filename = fchar.UnicodeToGB(request.getParameter("filename"));
String extname = request.getParameter("extname");

if (filename==null) {
	out.print(fchar.p_center("ȱ   "));
	return;
}
if (!email.isEmailOfUser(id,user))
{
	out.print(fchar.p_center("      ļ"));
	return;
}

filename = filename + "." + extname;

cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String emailfilepath = props.getProperty("emailfilepath");

response.setContentType("application/"+extname);
response.setHeader("Content-disposition","attachment; filename="+filename);

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

try {
bis = new BufferedInputStream(new FileInputStream(emailfilepath+filename));
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



