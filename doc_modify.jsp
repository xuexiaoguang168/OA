<%@ page contentType="text/html;charset=gb2312"
import = "java.io.File"
import="java.io.*"
import="java.util.*"
import="java.sql.*"
import="java.net.URLEncoder"
%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="TheBean" scope="page" class="fan.util.FileUploadBean" />
<jsp:useBean id="document" scope="page" class="com.redmoon.oa.document.Document"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

java.util.Date currentTime = new java.util.Date();
long inserttime = currentTime.getTime();
String filenm = String.valueOf(inserttime);
String[] extnames = {"jpg","gif","zip","rar","doc","rm","avi","bmp","swf"};
TheBean.setValidExtname(extnames);//   ϴ ļ  
TheBean.setDefaultFileSize(1500);//  1500K
int ret = TheBean.doUpload(request,filenm);
if (ret==-3)
{
  out.print("   ļ ,    󰴡   1500K  !");
  return;
}
if (ret==-4)
{
  out.print("  ");
  return;
}

String filename,document_id;
String errMsg = "";
filename = fchar.getNullStr(TheBean.getFieldValue("filename"));
if (filename.equals(""))
	errMsg += "    գ\n";
document_id = fchar.getNullStr(TheBean.getFieldValue("document_id"));
if (document_id.equals(""))
	errMsg += "  ʶ Ϊգ\n";

if (!errMsg.equals(""))
{
	out.print(errMsg);
	return;
}

String user = fchar.getNullStr(TheBean.getFieldValue("user"));
String pwd = fchar.getNullStr(TheBean.getFieldValue("pwd"));
String priv = "department";//  

String department_id = ""+userservice.getDepartmentID(user);

if (!document.canModifyDoc(document_id,department_id) && !privilege.isUserPrivValid(user,pwd,priv))
{
	out.println(fchar.makeErrMsg("���     ʴ   "));
	return;
}

cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String documentpath = props.getProperty("documentpath");
TheBean.setSavePath(documentpath);//  Ŀ¼
/*
File upfile = new File(documentpath+filename);
if (upfile!=null) {
	boolean exists = upfile.exists();
	if (exists) {
		// File or directory exists
		upfile.delete();//   ڣ ɾ 4 ļ
	}
}
*/

//  
if (ret==1)
{	
	if (TheBean.writeToFile(documentpath+filename))
		out.print("   ");
	else
		out.print("༭  ܣ");
}
%>


