<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.asset.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资产查询</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%@ include file="asset_inc_menu_top.jsp"%>
<br>
<table width="689" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <form action="asset_list.jsp?op=search" name="form1" method="post">
    <tr>
      <td colspan="7" class="right-title">资产查询</td>
    </tr>
    <tr>
      <td width="71">资产类别：</td>
      <TD bordercolor="#CCCCCC"><%
	  AssetTypeDb atd = new AssetTypeDb();
	  String opts = "";
	  Iterator ir = atd.list().iterator();
	  while (ir.hasNext()) {
	  	 atd = (AssetTypeDb)ir.next();
	  	 opts += "<option value='" + atd.getId() + "'>" + atd.getName() + "</option>";
	  }
	  %>
          <select name="typeId" id="typeId" >
            <option selected value="all">---请选择---</option>
            <%=opts%>
          </select>
      </TD>
      <td width="115">资产名称： </td>
      <td width="239"><input type="text" name="name" id="name" value="" maxlength="100" ></td>
    </tr>
    <tr>
      <td>资产编号： </td>
      <td><input type="text" name="number" id="number" value="" maxlength="100" ></td>
    </tr>
    <tr>
    
      <td>&nbsp;</td>
      <td align = "right"><input name="submit" type="submit" class="button1"  value="  查  询 " ></td>
    </tr>
  </form>
</table>
</body>
</html>

