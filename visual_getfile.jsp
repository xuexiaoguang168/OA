<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="cn.js.fan.util.*"%>
<%@page import="cn.js.fan.web.Global"%>
<%@page import="com.redmoon.oa.visual.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "read";
if (!privilege.isUserPrivValid(request, priv))
{
	//response.setContentType("text/html;charset=gb2312"); 
	out.print("<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>");
	out.println(fchar.makeErrMsg("鏉冮檺闈炴硶"));
	return;
}

int id = ParamUtil.getInt(request, "attachId");
Attachment att = new Attachment(id);

// 鐢ㄤ笅鍙ヤ細浣縄E鍦ㄦ湰绐楀彛涓墦寮€鏂囦欢
response.setContentType(MIMEMap.get(StrUtil.getFileExt(att.getDiskName())));
response.setHeader("Content-disposition","filename="+att.getName());
// 浣垮鎴风鐩存帴涓嬭浇锛屼笂鍙ヤ細浣縄E鍦ㄦ湰绐楀彛涓墦寮€鏂囦欢锛屼笅鍙ヤ篃涓€鏍凤紝鏅?
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
	System.out.println( "IOException: " + e );
} finally {
	if (bis != null)
		bis.close();
	if (bos != null)
		bos.close();
}
%>



