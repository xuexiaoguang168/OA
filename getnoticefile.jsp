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
		//response.setContentType("text/html;charset=gb2312"); 
		out.print("<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>");
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
else
{
	if (!privilege.isUserPrivValid(user,fsecurity.MD5(pwd),priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
String id = request.getParameter("id");
String filename = fchar.UnicodeToGB(request.getParameter("filename"));
String extname = request.getParameter("extname");

if (filename==null) {
	out.print(fchar.p_center("缺少文件名！"));
	return;
}

filename = filename + "." + extname;

cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String noticefilepath = props.getProperty("noticefilepath");

response.setContentType("application/"+extname);
response.setHeader("Content-disposition","attachment; filename="+filename);

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

try {
bis = new BufferedInputStream(new FileInputStream(noticefilepath+filename));
bos = new BufferedOutputStream(response.getOutputStream());

byte[] buff = new byte[2048];
int bytesRead;

while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
bos.write(buff,0,bytesRead);
}

} catch(final IOException e) {
System.out.println ( "出现IOException." + e );
} finally {
if (bis != null)
bis.close();
if (bos != null)
bos.close();
}
%>



