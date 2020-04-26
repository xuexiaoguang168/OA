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
<style type="text/css">
<!--
.STYLE1 {color: #FFFFFF}
-->
</style>
</head>
<table width="80%" border="0" align="center" cellpadding="2" cellspacing="1" class="tableframe" >
	 <form action="address.jsp?op=search" name="form1" method="post">
    <tr>
      <td colspan="2" nowrap class="right-title"> 通讯录查询</td>
    </tr>
    <tr>
    <td nowrap bgcolor="#FFFFFF" >分组：</td>
    <td nowrap bgcolor="#FFFFFF" >
      <%
			  AddressTypeDb atd = new AddressTypeDb();
			  String opts = "";
			  int type = ParamUtil.getInt(request, "type");
			  String who = privilege.getUser(request);
			  if (type==AddressDb.TYPE_PUBLIC)
				who = AddressTypeDb.PUBLIC;	
			  String sql = "select id from address_type where USER_NAME=" + StrUtil.sqlstr(who);
			  Iterator ir = atd.list(sql).iterator();
			  while (ir.hasNext()) {
				 atd = (AddressTypeDb)ir.next();
				 opts += "<option value='" + atd.getId() + "'>" + atd.getName() + "</option>";
			  }
			%>
      &nbsp;
      <select name="typeId" id="typeId" >
	   <option value="0">全部</option>
        <%=opts%>
      </select><input name="type" value="<%=type%>" type="hidden">	  </td>
   </tr>
    <tr>
      <td nowrap bgcolor="#FFFFFF" >姓名：</td>
      <td bgcolor="#FFFFFF" >&nbsp;
      <input type="text" name="person" size="25"></td>
    </tr>
    <tr>
      <td nowrap bgcolor="#FFFFFF"> 昵称：</td>
      <td bgcolor="#FFFFFF">
      &nbsp;
      <input type="text" name="nickname" size="25" ><input name=mode value="show" type=hidden>      </td>
    </tr>
    <tr>
      <td nowrap bgcolor="#FFFFFF">QQ：</td>
      <td bgcolor="#FFFFFF">&nbsp;
      <input type="text" name="QQ" size="25" ></td>
    </tr>
    <tr>
      <td nowrap bgcolor="#FFFFFF">MSN：</td>
      <td bgcolor="#FFFFFF">&nbsp;
      <input type="text" name="MSN" size="25" ></td>
    </tr>
    <tr>
      <td nowrap bgcolor="#FFFFFF"> 公司名称：</td>
      <td bgcolor="#FFFFFF" >
      &nbsp;
      <input type="text" name="company" size="25" >      </td>
    </tr>
    <tr>
      <td nowrap bgcolor="#FFFFFF">地址：</td>
      <td bgcolor="#FFFFFF">
      &nbsp;
      <input type="text" name="address" size="25" class="BigInput">      </td>
    </tr>
    <tr>
      <td nowrap bgcolor="#FFFFFF">住宅所在地：</td>
      <td bgcolor="#FFFFFF">
      &nbsp;
      <input type="text" name="street" size="25">      </td>
    </tr>
    <tr>
      <td colspan="2" align="center" nowrap bgcolor="#FFFFFF"><span class="STYLE1">
        <input type="submit" value="查 询" title="进行查询" name="button">
      &nbsp; </span></td>
    </tr>
    </form>
</table>
