<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*,
				 java.text.*,
				 cn.js.fan.kernel.*,
				 cn.js.fan.util.*,
				 cn.js.fan.module.cms.*,
				 cn.js.fan.cache.jcs.*,
				 cn.js.fan.web.*,
				 com.redmoon.oa.pvg.*"
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
<%
Vector v = Scheduler.getInstance().getUnits();
Iterator ir = v.iterator();
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">������Ϣ</td>
    </tr>
  </tbody>
</table>
<br>
<table align="center">
<tr>
  <td width="376" height="22">�������еĶ���</td>
</tr>
<%while (ir.hasNext()) {%>
<tr><td>
	<%=ir.next()%>
</td></tr>
<%}%>
</table>
<br>
<table align="center">
  <tr>
    <td width="376" height="22">��������еĶ���</td>
  </tr>
  <%
  v = RMCache.getInstance().getCacheMgrs();
  while (ir.hasNext()) {%>
  <tr>
    <td><%=ir.next()%> </td>
  </tr>
  <%}%>
</table>
