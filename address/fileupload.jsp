<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>通讯录</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<%
	FileUpMgr fum = new FileUpMgr();
	boolean re = false;
	String op = ParamUtil.get(request, "op");
	String excelFile="";
	if (op.equals("add")) {
		try {
			excelFile = fum.uploadExcel(application, request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
	}
%>
</head>

<body>
<table width="754" border="0">
<form name="form1" action="?op=add" method="post" encType="multipart/form-data">
  <tr>
    <td width="257">&nbsp;</td>
    <td width="487"><input title="选择附件文件" type="file" size="30" name="image"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input name="submit" type="submit" value="确定"></td>
  </tr>
</form>  
</table>
</body> 
</html>
