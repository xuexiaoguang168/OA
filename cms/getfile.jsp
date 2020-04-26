<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="cn.js.fan.util.*"%>
<%@page import="cn.js.fan.web.Global"%>
<%@page import="com.redmoon.oa.*"%>
<%@page import="cn.js.fan.module.cms.*"%>
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
if (!privilege.isUserPrivValid(request, priv))
{
	//response.setContentType("text/html;charset=gb2312"); 
	out.print("<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>");
	out.println(fchar.makeErrMsg("权限非法"));
	return;
}

int docId = ParamUtil.getInt(request, "docId");
int attId = ParamUtil.getInt(request, "attachId");

Document doc = new Document();
doc = doc.getDocument(docId);
Attachment att = doc.getAttachment(1, attId);

response.setContentType(MIMEMap.get(StrUtil.getFileExt(att.getDiskName())));
response.setHeader("Content-disposition","filename="+StrUtil.GBToUnicode(att.getName())); // 需加GBToUnicode，否则会打不开文件
// response.setHeader("Content-disposition","filename="+att.getDiskName());
// 使客户端直接下载，上句会使IE在本窗口中打开文件，下句也一样，晕
// response.setContentType("application/octet-stream");
// response.setHeader("Content-disposition","attachment; filename="+att.getName());

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

try {
	bis = new BufferedInputStream(new FileInputStream(att.getFullPath()));
	bos = new BufferedOutputStream(response.getOutputStream());
	
	byte[] buff = new byte[2048];
	int bytesRead;
	
	while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
		bos.write(buff,0,bytesRead);
	}
} catch(final IOException e) {
	System.out.println( "IOException." + e );
} finally {
	if (bis != null)
		bis.close();
	if (bos != null)
		bos.close();
}
%>



