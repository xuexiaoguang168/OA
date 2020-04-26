<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="document" scope="page" class="com.redmoon.oa.document.Document"/>
<%
String department_id = privilege.getDepartmentID(request);
String document_id = request.getParameter("document_id");
String priv = "department";//  
String user = fchar.UnicodeToGB(request.getParameter("user"));
String pwd = request.getParameter("pwd");
if (!document.canModifyDoc(document_id,department_id) && !privilege.isUserPrivValid(user,pwd,priv))
{
	out.println(fchar.makeErrMsg("í¾¯     Ê´   "));
	return;
}

String filename = fchar.UnicodeToGB(request.getParameter("filename"));
//System.out.println("filename="+filename);
if (filename==null) {
	out.print(fchar.p_center("È±   "));
	return;
}

cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String documentpath = props.getProperty("documentpath");

response.setContentType("application/msword");
response.setHeader("Content-disposition","attachment; filename="+filename);

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

try {
	bis = new BufferedInputStream(new FileInputStream(documentpath+ filename));
	bos = new BufferedOutputStream(response.getOutputStream());
	
	byte[] buff = new byte[2048];
	int bytesRead;
	
	while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
		bos.write(buff,0,bytesRead);
	}
} catch(final IOException e) {
	System.out.println ( "  IOException." + e + "---" + documentpath + filename);
} finally {
	if (bis != null)
		bis.close();
	if (bos != null)
		bos.close();
}
%>



