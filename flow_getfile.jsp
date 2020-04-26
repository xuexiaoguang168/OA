<%@ page contentType="text/html;charset=gb2312"%><%@page import="cn.js.fan.util.*"%><%@page import="cn.js.fan.web.Global"%><%@page import="com.redmoon.oa.*"%><%@page import="com.redmoon.oa.flow.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="java.net.*"%><jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/><jsp:useBean id="fsecurity" scope="page" class="cn.js.fan.security.SecurityUtil"/><jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/><%
String priv = request.getParameter("priv");
if (priv==null)
	priv = "read";
if (!privilege.isUserPrivValid(request, priv))
{
	//response.setContentType("text/html;charset=gb2312"); 
	out.print("<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>");
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int flowId = ParamUtil.getInt(request, "flowId");
int attId = ParamUtil.getInt(request, "attachId");

WorkflowDb wf = new WorkflowDb();
wf = wf.getWorkflowDb(flowId);
Document doc = new Document();
doc = doc.getDocument(wf.getDocId());
Attachment att = doc.getAttachment(1, attId);

// response.setContentType(MIMEMap.get(StrUtil.getFileExt(att.getDiskName())));
// 濞达絽鐏濋褰掑箣妞嬪寒浼傞柣鈺佺摠鐢瓨绋夌€ｎ厽绁伴柨娑樺缁楀倿宕ｉ妷銈囩獥濞达絿绔窫闁革负鍔嶅﹢鎵玻濡も偓瑜版稒绋夐鐔封叺鐎殿喒鍋撻柡鍌氭矗濞嗐垽鏁嶇仦鑲╃憮闁告瑣鍎扮弧鍐╃▔閳ь剟寮介崙銈囩�?
response.setContentType("application/octet-stream");
response.setHeader("Content-disposition","attachment; filename="+StrUtil.GBToUnicode(att.getName()));

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