<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.module.photo.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String userName = ParamUtil.get(request, "userName");
if (userName.equals("")) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.list","not_name")));
	return;
}

UserConfigDb ucd = new UserConfigDb();
ucd = ucd.getUserConfigDb(userName);
if (!ucd.isLoaded()) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.list","activate_blog_fail")));
	return;	
}

String skinPath = "skin/" + ucd.getSkin();
%>
<html>
<head>
<title><%=ucd.getPenName()%> - <%=Global.AppName%></title>
<LINK href="<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@ include file="header.jsp"%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class=blog_table_main>
  <tr>
    <td width="220" valign="top"><%@ include file="left.jsp"%></td>
    <td valign="top" class="blog_td_main"><table width="100%" border="0" cellpadding="5">
      <tr>
        <td height="26">
		<%
		int id = ParamUtil.getInt(request, "id");
		PhotoDb pd = new PhotoDb();
		pd = pd.getPhotoDb(id);
		%>
		<%=pd.getTitle()%>&nbsp;&nbsp;&nbsp;&nbsp;<%=pd.getAddDate()%>		</td>
      </tr>
      <tr>
        <td height="86"><img src="<%=request.getContextPath()+"/"+pd.getImage()%>" onload="javascript:if(this.width>screen.width*0.4) this.width=screen.width*0.4"></td>
      </tr>
    </table></td>
  </tr>
</table>
<%@ include file="footer.jsp"%>
</body>
</html>