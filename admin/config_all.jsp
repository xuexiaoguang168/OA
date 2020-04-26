<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.jdom.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>系统配置管理</title>
<%@ include file="../inc/nocache.jsp" %>
<LINK href="default.css" type=text/css rel=stylesheet>
<script>
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style><body bgcolor="#FFFFFF">
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
<jsp:useBean id="myconfig" scope="page" class="com.redmoon.forum.Config"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "admin";
if (!privilege.isUserPrivValid(request, priv)) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
    <TR>
      <TD class=head>系统环境</TD>
    </TR>
  </TBODY>
</TABLE>
<br>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe" style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" >
  <tr> 
    <td width="100%" height="23" class="thead"> 环 境 变 量</td>
  </tr>
  <tr class=row style="BACKGROUND-COLOR: #fafafa"> 
    <td valign="top" bgcolor="#FFFFFF">
<%
XMLConfig cfg = new XMLConfig("config_cws.xml", false, "gb2312");
String op = ParamUtil.get(request, "op");
if (op.equals("setup")) {
	Enumeration e = request.getParameterNames();
	while (e.hasMoreElements()) {
		String fieldName = (String)e.nextElement();
		if (fieldName.startsWith("Application")) {
			String value = ParamUtil.get(request, fieldName);
			cfg.set(fieldName, value);
		}
	}
	cfg.writemodify();
	Global.init();
	out.print(StrUtil.Alert("操作成功！"));
}
%>
<table cellpadding="6" cellspacing="0" border="0" width="105%">
<tr>
<td width="1%" valign="top"></td>
<td width="100%" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0">
	<form name=form1 action="?op=setup" method=post>
      
      <tr>
        <td width="33%" height="24" align="right">服&nbsp;务&nbsp;器：</td>
        <td width="67%" align="left"><input name="Application.server" value="<%=Global.server%>"/></td>
      </tr>
      
      <tr>
        <td height="24" align="right">端口：</td>
        <td align="left"><input name="Application.port" value="<%=Global.port%>"/></td>
      </tr>
      
      <tr>
        <td height="24" align="right">描述：</td>
        <td align="left"><input type="text" name="Application.desc" value="<%=Global.desc%>"/>
          ( 描述：用在RSS中 )</td>
      </tr>
      <tr>
        <td height="24" align="right">虚拟路径：</td>
        <td align="left"><input type="text" name="Application.virtualPath" value="<%=Global.virtualPath%>"/></td>
      </tr>
      <tr>
        <td height="24" align="right">真实路径：</td>
        <td align="left"><input type="text" name="Application.realPath" value="<%=Global.getRealPath()%>"/>
        ( 请使用 / 符号 )</td>
      </tr>
      
      <tr>
        <td height="24" align="right">备份路径：</td>
        <td align="left"><input type="text" name="Application.bak_path" value="<%=cfg.get("Application.bak_path")%>"/>&nbsp;( 相对目录，如：bak )</td>
      </tr>
      <tr>
        <td height="24" align="right">浏览器上传时单个文件的最大尺寸：</td>
        <td align="left"><input type="text" name="Application.FileSize" value="<%=Global.FileSize%>"/> 
          ( 单位：K ) </td>
      </tr>
      <tr>
        <td height="24" align="right">WebEdit控件上传时的最大尺寸：</td>
        <td align="left"><input type="text" name="Application.WebEdit.MaxSize" value="<%=cfg.get("Application.WebEdit.MaxSize")%>"/>
          ( 单位：字节，含HTML代码和附件总的大小 )</td>
      </tr>
      <tr>
        <td height="24" align="right">服务器端接收上传文件的最大并发数：</td>
        <td align="left"><input type="text" name="Application.WebEdit.maxUploadingFileCount" value="<%=cfg.get("Application.WebEdit.maxUploadingFileCount")%>"/>
          ( WebEdit控件断点上传时 )</td>
      </tr>
      <tr>
        <td height="24" align="right">服务器是否直接支持中文：</td>
        <td align="left"><select name="Application.isRequestSupportCN">
            <option value="true">是</option>
            <option value="false" selected="selected">否</option>
          </select>
            <script>
		var supobj = findObj("Application.isRequestSupportCN");
		supobj.value = "<%=Global.requestSupportCN%>";
		    </script>
          ( Tomcat 选否，Resin选是，<span class="STYLE1">注意慎重选用，否则在提交后可能会出现乱码</span> ) </td>
      </tr>
      <tr>
        <td height="24" align="right">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
	  </form>
    </table>
    <input type="button" value=" 确 定 " onClick="form1.submit()"></td></tr>
</table>    </td>
  </tr>
  <tr class=row style="BACKGROUND-COLOR: #fafafa">
    <td valign="top" bgcolor="#FFFFFF" class="thead">&nbsp;</td>
  </tr>
</table> 
</body>                                        
</html>                            
  