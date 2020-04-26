<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "java.util.Enumeration"%>
<%@ page import = "java.util.Iterator"%>
<%@ page import = "org.jdom.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../common.css" rel="stylesheet" type="text/css">
<title>基础数据维护</title>
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

<body> 
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	if (!privilege.isUserPrivValid(request, "archive.basicdata")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}


	String code = ParamUtil.get(request, "code");
	String name = ParamUtil.get(request, "name");
	String op = ParamUtil.get(request,"op");
	
	BasicDataMgr bdm = new BasicDataMgr("archive");
	String option = bdm.getOptionsStr(code);
	
	if(op.equals("addOption")){
%>
 <br>
 <form id="form1" name="form1" action="archive_basicdata_do.jsp?op=addOption" method=post>
	<table width="541" height="50" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
		<tr>
		  <td colspan="5" height="25" class="right-title"><span> &nbsp;添加基础数据字段</span></td>
		</tr>
		<tr>
		  <td width="91" height="25" align="center"><%=name%></td>
			<td width="77" align="left">
			  <select name="<%=code%>">
			   <%=option%>
			  </select>			
			</td>
		    <td width="80" align="center">添加数据</td>
		    <td width="164" align="center"><input type="text" name="optionValue"/></td>
		    <td width="127" align="center"><input type="hidden" name="itemCode" value="<%=code%>">
			<input type="submit" name="button1" value="添加" class="button1"/></td>
		</tr>
	</table>
  </form>
<%
   }else{
     if(op.equals("delOption")){
%>
  <br>
  <form id="form1" name="form1" action="archive_basicdata_do.jsp?op=delOption" method=post>
	<table width="541" height="50" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
		<tr>
		  <td colspan="3" height="25" class="right-title"><span> &nbsp;删除基础数据字段</span></td>
		</tr>
		<tr>
		  <td width="189" height="25" align="center"><%=name%></td>
			<td width="138" align="left">
			  <select name="<%=code%>">
			   <%=option%>
			  </select>			</td>
		    <td width="212" align="left"><input type="hidden" name="itemCode" value="<%=code%>">
			<input type="submit" name="button1" value="删除" class="button1"/></td>
		</tr>
	</table>
</form>
<%
     }else{
%>
  <br>
  <form id="form1" name="form1" action="archive_basicdata_do.jsp?op=setDefaultValue" method=post>
	<table width="541" height="50" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
		<tr>
		  <td colspan="3" height="25" class="right-title"><span> &nbsp;设置基础数据默认字段</span></td>
		</tr>
		<tr>
		  <td width="189" height="25" align="center"><%=name%></td>
			<td width="148" align="left">
			  <select name="<%=code%>">
			   <%=option%>
			  </select>			</td>
		    <td width="202" align="left"><input type="hidden" name="itemCode" value="<%=code%>">
			<input type="submit" name="button1" value="设置" class="button1"/></td>
		</tr>
	</table>
</form>
<% 
     }
   }
%>

</body>
</html>
