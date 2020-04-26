<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*,
				 cn.js.fan.db.*,
				 cn.js.fan.util.*,
				 cn.js.fan.web.*,
				 com.redmoon.forum.*,
				 org.jdom.*,
                 java.util.*"
%>
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
<%
XMLConfig cfg = new XMLConfig("config_cws.xml", false, "gb2312");
%>
<title>云网OA安装 - 配置环境变量</title>
<link rel="stylesheet" type="text/css" href="../common.css">
<jsp:useBean id="myconfig" scope="page" class="com.redmoon.oa.Config"/>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
body {
background-image:url();
}
-->
</style>
<table cellpadding="6" cellspacing="0" border="0" width="100%">
<tr>
<td width="1%" valign="top"></td>
<td width="99%" align="center" valign="top"><div align="left"><b>欢迎您使用云网OA 版本<%=cfg.get("Application.version")%></b></div>
  <hr size="0">
<%
		String op = ParamUtil.get(request, "op");
		PropertiesUtil pu = new PropertiesUtil(application.getRealPath("/") + "WEB-INF/log4j.properties");
		java.net.URL cfgURL = getClass().getClassLoader().getResource("cache.ccf");
		PropertiesUtil pucache = new PropertiesUtil(java.net.URLDecoder.decode(cfgURL.getFile()));
		ForumDb fd = new ForumDb();
		fd.setCreateDate(new java.util.Date());
		fd.save();
		if (op.equals("setup")) {
			try {
			Enumeration e = request.getParameterNames();
			while (e.hasMoreElements()) {
				String fieldName = (String)e.nextElement();
				if (fieldName.startsWith("Application") || fieldName.startsWith("i18n")) {
					String value = ParamUtil.get(request, fieldName);
					cfg.set(fieldName, value);
				}
			}
			cfg.writemodify();
			Global.init();	
			String filePath = ParamUtil.get(request, "log4j.appender.R.File");
			pu.setValue("log4j.appender.R.File", filePath);
			pu.saveFile(application.getRealPath("/").replaceAll("\\\\", "/") + "WEB-INF/log4j.properties");	
			String fp = ParamUtil.get(request, "jcs.auxiliary.DC.attributes.DiskPath");
			pucache.setValue("jcs.auxiliary.DC.attributes.DiskPath", fp);
			pucache.saveFile(java.net.URLDecoder.decode(cfgURL.getFile()));
			String value = ParamUtil.get(request, "Application.name");
			myconfig.put("enterprise",value);
			out.print(StrUtil.Alert("操作成功！"));
			}
			catch (Exception e) {
				out.print(StrUtil.Alert_Back(e.getMessage()));
				e.printStackTrace();
			}
		}
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<form name=form1 action="?op=setup" method=post>     
      <tr>
        <td height="25" colspan="2" align="left">配置环境变量：</td>
        </tr>

      <tr>
        <td height="24" align="right">OA名称：</td>
        <td>
          <input type="text" name="Application.name" value="<%=Global.AppName%>"/>&nbsp;
          <input name="Application.server" value="<%=request.getServerName()%>" type="hidden"/>
          <input type="hidden" name="Application.port" value="<%=request.getServerPort()%>"/>
          <input type="hidden" name="Application.title" value=""/>
          <input type="hidden" name="Application.desc" value=""/>
		  <%
			String vPath = request.getContextPath();
			if (!vPath.equals("")) {
				vPath = vPath.substring(1);
			}
			String realPath = application.getRealPath("/").replaceAll("\\\\", "/");
		  %> 
         <input type="hidden" name="Application.virtualPath" value="<%=vPath%>"/>
		 <input type="hidden" name="Application.realPath" value="<%=application.getRealPath("/").replaceAll("\\\\", "/")%>"/>
		 <input name="log4j.appender.R.File" type="hidden" value="<%=realPath + "log/oa.log"%>" size="50"/>
         <input name="jcs.auxiliary.DC.attributes.DiskPath" type="hidden" value="<%=realPath + "CacheTemp"%>" size="50"/></td>
      </tr>
      <tr>
        <td height="24" align="right">服务器request是否直接支持中文：</td>
        <td><select name="Application.isRequestSupportCN">
            <option value="true">是</option>
            <option value="false" selected="selected">否</option>
          </select>
        <script>
		var supobj = findObj("Application.isRequestSupportCN");
		supobj.value = "<%=Global.requestSupportCN%>";
		</script>
 ( Tomcat 选否，Resin选是，<span class="STYLE1">注意慎重选用，否则在提交后可能会出现乱码</span> )        </td>
      </tr>
	  <tr>
        <td height="24" align="right">是否启用博客：</td>
        <td><select name="Application.hasBlog">
            <option value="true">是</option>
            <option value="false">否</option>
          </select>
            <script>
		var obj = findObj("Application.hasBlog");
		obj.value = "<%=Global.hasBlog?"true":"false"%>";
		</script>        </td>
      </tr>
      <tr>
        <td height="24" align="right">SSL安全套接字连接：</td>
        <td><select name="Application.internetFlag">
            <option value="secure">是</option>
            <option value="no">否</option>
          </select>
            <script>
		var obj = findObj("Application.internetFlag");
		obj.value = "<%=Global.internetFlag%>";
		</script></td>
      </tr>
      <tr>
        <td height="24" align="right">默认时区：</td>
        <td>
		<select name="i18n.timeZone">
          <option value="GMT-11:00">(GMT-11.00)中途岛，萨摩亚群岛</option>
          <option value="GMT-10:00">(GMT-10.00)夏威夷</option>
          <option value="GMT-09:00">(GMT-9.00)阿拉斯加</option>
          <option value="GMT-08:00">(GMT-8.00)太平洋时间（美国和加拿大）；蒂华纳</option>
          <option value="GMT-07:00">(GMT-7.00)山地时间（美国和加拿大）</option>
          <option value="GMT-06:00">(GMT-6.00)中美洲</option>
          <option value="GMT-05:00">(GMT-5.00)波哥大，利马，基多</option>
          <option value="GMT-04:00">(GMT-4.00)加拉加斯，拉巴斯</option>
          <option value="GMT-03:00">(GMT-3.00)格陵兰</option>
          <option value="GMT-02:00">(GMT-2.00)中大西洋</option>
          <option value="GMT-01:00">(GMT-1.00)佛得角群岛</option>
          <option value="GMT">(GMT)格林威治标准时间，都柏林，爱丁堡，伦敦，里斯本</option>
          <option value="GMT+01:00">(GMT+1.00)阿姆斯特丹，柏林，伯尔尼，罗马，斯德哥尔摩，维也纳</option>
          <option value="GMT+02:00">(GMT+2.00)雅典，贝鲁特，伊斯坦布尔，明斯克</option>
          <option value="GMT+03:00">(GMT+3.00)莫斯科，圣彼得堡，伏尔加格勒</option>
          <option value="GMT+04:00">(GMT+4.00)阿布扎比，马斯喀特</option>
          <option value="GMT+04:30">(GMT+4.30)喀布尔</option>
          <option value="GMT+05:00">(GMT+5.00)叶卡捷琳堡</option>
          <option value="GMT+05:30">(GMT+5.30)马德拉斯，加尔各答，孟买，新德里</option>
          <option value="GMT+05:45">(GMT+5.45)加德满都</option>
		  <option value="GMT+06:00">(GMT+6.00)阿拉木图，新西伯利亚</option>
		  <option value="GMT+06:30">(GMT+6.30)仰光</option>		  
          <option value="GMT+07:00">(GMT+7.00)曼谷，河内，雅加达</option>
          <option value="GMT+08:00" selected="selected">(GMT+8.00)北京，台北，重庆，香港特别行政区，乌鲁木齐</option>
          <option value="GMT+09:00">(GMT+9.00)汉城，大坂，东京，札幌</option>
          <option value="GMT+09:30">(GMT+9.30)达尔文</option>
          <option value="GMT+10:00">(GMT+10.00)关岛，莫尔兹比港</option>
          <option value="GMT+11:00">(GMT+11.00)马加丹，索罗门群岛，新喀里多尼亚</option>
          <option value="GMT+12:00">(GMT+12.00)斐济，堪察加半岛，马绍尔群岛</option>
          <option value="GMT+13:00">(GMT+13.00)努库阿洛法</option>
        </select>
		<script>
			findObj("i18n.timeZone").value = "<%=Global.timeZone.getID()%>";
		</script>		</td>
      </tr>
	  </form>
    </table>
    <hr size="0">
    <div align="center">
    <input name="button22" type="button" onclick="window.location.href='setup2.jsp'" value="上一步" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="设 置" onClick="form1.submit()">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if (op.equals("setup")) {%>
	<input name="button2" type="button" onclick="window.location.href='<%=Global.getRootPath()%>/index.jsp'" value="进入OA" />
<%}%>
</td>
</tr>
</table>
