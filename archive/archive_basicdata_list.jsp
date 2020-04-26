<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "java.util.Enumeration"%>
<%@ page import = "java.util.Iterator"%>
<%@ page import = "org.jdom.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>基础数据维护</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #FFFFFF}
.STYLE4 {
	color: #000000;
	font-weight: bold;
}
.STYLE5 {color: #FF0000}
.STYLE6 {color: #000000}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	if (!privilege.isUserPrivValid(request, "archive.basicdata")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<table width="90%" height="89" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">
	<tr>
	  <td width="98%" height="23" class="right-title"><span> &nbsp;基础数据维护管理</span></td>
	</tr>
	<tr>
	  <td width="98%" height="4"></td>
	</tr>
    <tr>
      <td align="center">
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
			  <tr>
				<td width="30%" height="25" align="center" bgcolor="#C4DAFF">基础数据名称</td>
				<td width="70%" height="25" align="center" bgcolor="#C4DAFF">操作</td>
			  </tr>
		</table>	
			<%
			  BasicDataMgr bdm = new BasicDataMgr("archive");
              Element root = bdm.getRootElement();
			  List childs = root.getChildren();
              Iterator ir = childs.iterator();
			  while (ir.hasNext()) {
                  Element e = (Element)ir.next();
              %>
			    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
				    <td width="30%" height="22" align="center"><%=e.getAttributeValue("name")%></td>
                    <td width="23%" height="22" align="center"><a href="archive_basicdata_modify.jsp?name=<%=StrUtil.UrlEncode(e.getAttributeValue("name"))%>&code=<%=e.getAttributeValue("code")%>&op=addOption">添加基础数据字段</a></td>
                    <td width="23%" height="22" align="center"><a href="archive_basicdata_modify.jsp?name=<%=StrUtil.UrlEncode(e.getAttributeValue("name"))%>&code=<%=e.getAttributeValue("code")%>&op=delOption">删除基础数据字段</a></td>
                    <td width="24%" height="22" align="center"><a href="archive_basicdata_modify.jsp?name=<%=StrUtil.UrlEncode(e.getAttributeValue("name"))%>&code=<%=e.getAttributeValue("code")%>&op=setDefaultValue">设置基础数据默认字段</a></td>
                  </tr>
                </table>	
			<%}%>
      </td>
    </tr>
</table>
<br>
<br>
</body>
</html>

