<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="../inc/inc.jsp" %>
<%@ page import="java.net.URL" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>���Ź���</title>
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
<!--�ض����� :<jsp:getProperty name="privilege" property="defaulturl"   />-->
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b5-top.gif">����������<span class="right-title">ϵ ͳ �� ��</span></td>
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
	out.print(fchar.p_center("���ݳɹ���"));
	String zipfilepath = despath+"/bak_file.zip";
    compress.zipDirectory(srcpath, zipfilepath);
	out.print(fchar.p_center("ѹ��ZIP�ļ��ɹ���"));
	
	//String zipfilepath = application.getRealPath("/")+"WEB-INF/classes/bak/bak_file.zip";
    //compress.zipDirectory(srcpath, zipfilepath);
	//��һЩWeb������containers���У���������е�request dispatchers���������ھ�̬����Դ�������̬��Դ����WEB-INF�£��������ã���	
	//��tomcat������ʱ�����Զ��õ���չ�������ļ�����
	//RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/classes/bak/bak_file.zip");
	//rd.forward(request, response);
	
	String rootpath = request.getContextPath();
		  %>
		  <a href="<%=rootpath%>/bak/bak_file.zip">����ZIP�ļ�</a>		  </td>
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
  