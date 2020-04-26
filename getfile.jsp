<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="cn.js.fan.util.*"%>
<%@page import="cn.js.fan.web.Global"%>
<%@page import="com.redmoon.oa.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="fsecurity" scope="page" class="cn.js.fan.security.SecurityUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = request.getParameter("priv");
if (priv==null)
	priv = "read";
String user = ParamUtil.get(request, "user");
String pwd = request.getParameter("pwd");
if (user==null)
{
	if (!privilege.isUserPrivValid(request, priv))
	{
		//response.setContentType("text/html;charset=gb2312"); 
		out.print("<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>");
		out.println(fchar.makeErrMsg("警告非法用户，你无访问此页的权限！"));
		return;
	}
}
else
{
	// if (!privilege.isUserPrivValid(user,fsecurity.MD5(pwd),priv))
	// {
	//	out.println(fchar.makeErrMsg("警告非法用户，你无访问此页的权限！"));
	//	return;
	//}
}

String filename = ParamUtil.get(request, "filename");
String extname = request.getParameter("extname");
String prop = request.getParameter("prop");
if (filename==null) {
	out.print(fchar.p_center("缺少文件名！"));
	return;
}

filename = filename + "." + extname;

Config cfg = new Config();
String noticefilepath = cfg.get(prop);

response.setContentType("application/"+extname);
response.setHeader("Content-disposition","attachment; filename="+filename);

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

try {
bis = new BufferedInputStream(new FileInputStream(Global.getRealPath() + "/" + noticefilepath+"/" +filename));
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



