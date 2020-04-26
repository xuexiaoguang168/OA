<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="../inc/inc.jsp" %>
<%@ page import="java.net.URL" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>部门管理</title>
<link rel="stylesheet" href="../common.css">
<script language="JavaScript">
<!--

//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<body bgcolor="#FFFFFF" topmargin='5' leftmargin='0'>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<jsp:useBean id="compress" scope="page" class="fan.util.Compress"/>
<jsp:useBean id="ffile" scope="page" class="fan.util.FFile"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:setProperty name="privilege" property="defaulturl" value="../index.jsp"/>
<!--重定向至 :<jsp:getProperty name="privilege" property="defaulturl"   />-->
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b5-top.gif">　　　　　<span class="right-title">系 统 备 份</span></td>
  </tr>
  <tr> 
    <td height="310" valign="top" background="../images/tab-b-back.gif">
		        <%
String priv="admin.bak";
if (!privilege.isUserPrivValid(request,priv))
{
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>

<table width="470" border="0" align="center">
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td align="center">
		  <%
    String srcpath = application.getRealPath("/") + "upfile/";
	cfgparser.parse("config.xml");
    Properties props = cfgparser.getProps();
    String despath = props.getProperty("bak_path");
	ffile.copyDirectory(despath+"/file",srcpath);
	out.print(fchar.p_center("备份成功！"));
	String zipfilepath = despath+"/bak_file.zip";
    compress.zipDirectory(srcpath, zipfilepath);
	out.print(fchar.p_center("压缩ZIP文件成功！"));
	
	//String zipfilepath = application.getRealPath("/")+"WEB-INF/classes/bak/bak_file.zip";
    //compress.zipDirectory(srcpath, zipfilepath);
	//在一些Web容器（containers）中，下面代码中的request dispatchers并不能用于静态的资源（如果静态资源不在WEB-INF下，它可以用）。	
	//在tomcat中下载时则不能自动得到扩展名，即文件类型
	//RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/classes/bak/bak_file.zip");
	//rd.forward(request, response);
	
	String rootpath = request.getContextPath();
		  %>
		  <a href="<%=rootpath%>/bak/bak_file.zip">下载ZIP文件</a>		  </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
	  <br>
    </td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>

</body>                                        
</html>                            
  