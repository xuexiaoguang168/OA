<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.blog.UserConfigDb"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<script language="JavaScript">
function hopenWin(url,width,height)
{
  var newwin = window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,top=50,left=120,width="+width+",height="+height);
}
</script>
<%
String rootpath = request.getContextPath(); // 当运用于hopenWin中时，rootpath会为空字符串
// String rootpath = Global.getRootPath();	// "http://" + Global.server + ":" + Global.port + "/" + Global.virtualPath; // "http://www.zjrj.cn";

if (userName.equals("")) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.header","not_name")));
	return;
}

com.redmoon.forum.Privilege hpvg = new com.redmoon.forum.Privilege();
com.redmoon.forum.person.UserMgr um = new com.redmoon.forum.person.UserMgr();
UserConfigDb headerucd = new UserConfigDb();
headerucd = headerucd.getUserConfigDb(userName);
if (!headerucd.isLoaded()) {
	String str = SkinUtil.LoadString(request,"res.label.blog.header", "activate_blog_fail");
	str = StrUtil.format(str, new Object[] {um.getUser(userName).getNick()});
%>
<table width="400" border="0" align="center">
  <tr>
    <td align="center"><a href="user/userconfig_add.jsp"><%=str%></a></td>
  </tr>
</table>
<%
	return;
}
if (!headerucd.isValid()) {
	String str = SkinUtil.LoadString(request,"res.label.blog.header", "blog_alert");
	str = StrUtil.format(str, new Object[] {um.getUser(userName).getNick()});
	out.print(StrUtil.makeErrMsg(str));
	return;
}%>
<table width="100%"  border="0" align="center" cellpadding="5" cellspacing="0" class="table_banner">
  <tr>
    <td width="51%" height="22" ><span class="text_bold_16"><%=headerucd.getTitle()%> ( <%=headerucd.getSubtitle()%> )</span></td>
    <td width="49%"><img src="<%=rootpath%>/blog/images/message.gif" border="0" /> <a href="javascript:hopenWin('<%=rootpath%>/message/send.jsp?receiver=<%=StrUtil.UrlEncode(userName)%>',320,260)"><lt:Label res="res.label.blog.header" key="message"/></a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=rootpath%>/blog/listphoto.jsp?userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.header" key="album"/></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=rootpath%>/blog/myblog.jsp?userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.header" key="return_column"/></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=rootpath%>/blog/user/frame.jsp?userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.header" key="manage"/></a>&nbsp;&nbsp;|&nbsp;&nbsp;
	<%if (hpvg.isUserLogin(request)) {%>
	<a href="../exit.jsp?privurl=<%=StrUtil.getUrl(request)%>"><lt:Label res="res.label.blog.header" key="exit"/></a>
	<%}else{%>
	<a href="../door.jsp?privurl=<%=StrUtil.getUrl(request)%>"><lt:Label res="res.label.blog.header" key="login"/></a>
	<%}%>
	&nbsp;<a href="<%=rootpath%>/blog/index.jsp"><lt:Label res="res.label.blog.header" key="blog_first_page"/></a></td>
  </tr>
  <tr>
    <td colspan="2"><span class="text_14"><%=headerucd.getNotice()%></span></td>
  </tr>
  <tr>
    <td height="22" colspan="2" class="blog_banner_space"></td>
  </tr>
</table>
