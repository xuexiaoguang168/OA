<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.module.cms.plugin.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Vector"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<HTML><HEAD><TITLE>title</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="../admin/default.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.3790.259" name=GENERATOR></HEAD>
<BODY bgColor=#9aadcd leftMargin=0 topMargin=0>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<BR>
<%
String rootpath = request.getContextPath();
String userName = privilege.getUser(request);
if (userName.equals("")) {
	out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.frame", "not_name_menu")));
	return;
}
%>
<table width="100%" border="0" cellpadding="5">
  <tr>
    <td><img src="../../images/arrow.gif">&nbsp;<a href="../myblog.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" target="_blank"><lt:Label res="res.label.blog.user.frame" key="my_blog"/></a></td>
  </tr>
  <tr>
    <td><img src="../../images/arrow.gif">&nbsp;<a href="dir_m.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" target="mainFrame"><lt:Label res="res.label.blog.user.frame" key="manage"/></a></td>
  </tr>
  <tr>
    <td><img src="../../images/arrow.gif">&nbsp;<a href="listtopic.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" target="mainFrame"><lt:Label res="res.label.blog.user.frame" key="all_article"/></a></td>
  </tr>
  <tr>
    <td><img src="../../images/arrow.gif">&nbsp;<a href="userconfig_edit.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" target="mainFrame"><lt:Label res="res.label.blog.user.frame" key="config_info"/></a></td>
  </tr>
  
  <tr>
    <td><img src="../../images/arrow.gif">&nbsp;<a href="photo.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" target="mainFrame"><lt:Label res="res.label.blog.user.frame" key="album"/></a></td>
  </tr>
  <tr>
    <td><img src="../../images/arrow.gif">&nbsp;<a href="../comment.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" target="mainFrame"><lt:Label res="res.label.blog.user.frame" key="all_comment"/></a></td>
  </tr>
  <tr>
    <td><img src="../../images/arrow.gif">&nbsp;<a href="link.jsp?userName=<%=StrUtil.UrlEncode(userName)%>" target="mainFrame"><lt:Label res="res.label.blog.user.frame" key="link"/></a></td>
  </tr>
</table>
</BODY></HTML>
