<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="cn.js.fan.mail.GetMail"%>
<%@ page import="cn.js.fan.mail.MailMsg"%>
<%@ page import="cn.js.fan.mail.Attachment"%>
<%@page import="java.util.*"%>
<%@page import="cn.js.fan.util.*"%>
<%@page import="com.redmoon.oa.emailpop3.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<%
String priv = request.getParameter("priv");
if (priv==null)
	priv = "read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(fchar.makeErrMsg("权限非法"));
	return;
}

String username = privilege.getUser(request);
String email = ParamUtil.get(request, "email");

UserPop3Setup userpop3setup = new UserPop3Setup();
userpop3setup.getUserPop3Setup(username, email);
String mailserver = userpop3setup.getMailServer();
String email_name = userpop3setup.getUser();
String email_pwd_raw = userpop3setup.getPwd();

System.out.println("getattach.jsp mailserver=" + mailserver + " email_name=" + email_name + " email_pwd_raw=" + email_pwd_raw);

GetMail getmail = new GetMail(mailserver,email_name,email_pwd_raw);
String mailid="",attachnum="";
mailid = request.getParameter("mailid");
String errmsg = "";
if (mailid==null)
	errmsg += "mailid不能为空！\\n";
if (!fchar.isNumeric(mailid))
	errmsg += "mailid必须为数字！\\n";
attachnum = request.getParameter("attachnum");
if (attachnum==null)
	errmsg += "附件标识不能为空！\\n";
if (!fchar.isNumeric(attachnum))
	errmsg += "附件标识必须为数字！\\n";
if (!errmsg.equals(""))
{
	out.println(fchar.Alert_Back(errmsg));
	return;
}

int intmailid = Integer.parseInt(mailid);
int intattachnum = Integer.parseInt(attachnum);

Attachment a = getmail.getAttachment(intmailid, intattachnum);
if (a==null)
{
	out.println("取附件失败！");
	return;
}
//cfgparser.parse("config.xml");
//Properties props = cfgparser.getProps();
//String documentpath = props.getProperty("documentpath");

String ext = a.getExt();
MIMEMap m = new MIMEMap();
response.setContentType((String)m.get(ext));
response.setHeader("Content-disposition","attachment; filename="+fchar.GBToUnicode(a.getName()));//תISO-8859-1ɸ       ퟟ���   ȷ ļ 

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

try {
bis = new BufferedInputStream(a.getInputStream());
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



