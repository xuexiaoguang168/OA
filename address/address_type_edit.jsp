<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>类别编辑</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--

//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE5 {color: #FF0000}
.STYLE6 {color: #000000}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%

String op = ParamUtil.get(request, "op");
if (op.equals("modify")) {
	AddressTypeMgr atm = new AddressTypeMgr();
	boolean re = false;
	try {
		re = atm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		 out.print(StrUtil.Alert("编辑成功！"));	
	}
}

int id = ParamUtil.getInt(request, "id");
AddressTypeDb atd = new AddressTypeDb();
atd = atd.getAddressTypeDb(id);
%>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" valign="bottom" background="../images/top-right.gif" class="right-title">&nbsp;<span> 通迅录分组编辑 </span></td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  <form action="?op=modify" method=post> 
      <tr>
        <td height="69" align="center">名称<span class="STYLE6">(<span class="STYLE5">*</span>)</span>：
		  <input name="name" value="<%=atd.getName()%>">
		  <input name="id" value="<%=id%>" type=hidden>
		  &nbsp;
		  <input name="submit" type=submit value="确定">&nbsp;</td>
      </tr>
	  </form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
