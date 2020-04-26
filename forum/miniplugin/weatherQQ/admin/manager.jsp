<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../../../inc/inc.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.Conn"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.miniplugin.*"%>
<%@ page import="com.redmoon.forum.miniplugin.weather.*"%>
<%@ page import="com.redmoon.forum.*"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<LINK href="../../../admin/default.css" type=text/css rel=stylesheet>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>插件管理</title>
<script language="JavaScript">
<!--

//-->
</script>
<body bgcolor="#FFFFFF" topmargin='0' leftmargin='0'>
<jsp:useBean id="privilege" scope="page" class="cn.js.fan.module.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "forum.plugin"))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">管理插件-<%=WeatherSkin.LoadString(request, "name")%></td>
  </tr>
</table>
<br>
<table width="98%" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="left" class="thead">管理 - <%=WeatherSkin.LoadString(request, "name")%>&nbsp;&nbsp;<a href="?op=create">生成</a></td>
  </tr>
  <tr> 
    <td valign="top"><%
String op = StrUtil.getNullString(request.getParameter("op"));
String content = "";
QQWeatherUtil wu = new QQWeatherUtil();
content = wu.getWeather();
// content = wu.gather("http://weather.news.qq.com/inc/ss59.htm");

if (op.equals("create")) {
	wu.createIncFile(content, "");
	out.print(StrUtil.Alert("操作完成！"));
}
%></td>
  </tr>
</table>
</td> </tr>             
      </table>                                        
       </td>                                        
     </tr>                                        
 </table>                                        
                               
 <%=content%>
</body>                                        
</html>                            
  