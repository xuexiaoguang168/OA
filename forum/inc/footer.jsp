<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.ad.*"%>
<%@ taglib uri="/WEB-INF/tlds/AdTag.tld" prefix="ad_footer"%>
<META http-equiv=Content-Type content="text/html;charset=utf-8">
<table width="98%" border="0" align="center">
  <tr>
    <td valign="bottom"><HR style="height:1px" color="#CCCCCC">
    </td>
  </tr>
  <tr>
    <td align="center" valign="bottom">
	<%
	String fCode = com.redmoon.forum.UserSession.getBoardCode(request);
	%>
	<ad_footer:AdTag type="<%=AdDb.TYPE_FOOTER%>" boardCode="<%=fCode%>"></ad_footer:AdTag>
	<span style="font-size: 11px; font-family: Tahoma, Arial">Powered by <b>CWBBS</b> <b style="COLOR: #ff9900"><%=Global.getVersion()%></b>&nbsp;    © 2005-2006&nbsp;<a href="http://www.cloudwebsoft.com" target="_blank">Cloud Web Soft</a></span><BR>
    <span style="font-size: 11px; font-family: Tahoma, Arial">Email:<a href="mailto:<%=Global.email%>"><%=Global.email%></a></span></td>
  </tr>
</table>
