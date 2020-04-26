<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="com.redmoon.blog.ui.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<html>
<head>
<title><lt:Label res="res.label.blog.user.userconfig" key="title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="../../common.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
.STYLE1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<p>&nbsp;</p>
<%
if (!privilege.isUserLogin(request)) {
	out.print(SkinUtil.LoadString(request, "err_not_login"));
	return;
}
String userName = privilege.getUser(request);
if (userName.equals(""))
	userName = privilege.getUser(request);
UserConfigDb ucd = new UserConfigDb();
ucd = ucd.getUserConfigDb(userName);
if (!ucd.isLoaded()) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "activate_blog_fail")));
	return;
}
%>
<table width="482" height="170" border="0" align="center" cellpadding="5" cellspacing="0" class="tableframe_gray">
<form id=form1 action="userconfig_do.jsp?op=modify" method=post>
  <tr>
    <td height="24" colspan="2" align="center" bgcolor="#617AA9"><span class="STYLE1"><lt:Label res="res.label.blog.user.userconfig" key="note_edit"/></span></td>
  </tr>
  <tr>
    <td width="67" height="22"><lt:Label res="res.label.blog.user.userconfig" key="column_title"/></td>
    <td width="393" height="22"><label>
      <input name="title" type="text" id="title" value="<%=ucd.getTitle()%>">
    </label></td>
  </tr>
  <tr>
    <td height="22"><lt:Label res="res.label.blog.user.userconfig" key="deputy_title"/></td>
    <td height="22"><input name="subtitle" type="text" id="subtitle" value="<%=ucd.getSubtitle()%>"></td>
  </tr>
  <tr>
    <td height="22"><lt:Label res="res.label.blog.user.userconfig" key="class"/></td>
    <td height="22"><select name="kind">
        <%
	LeafChildrenCacheMgr dlcm = new LeafChildrenCacheMgr("root");
	java.util.Vector vt = dlcm.getDirList();
	Iterator irv = vt.iterator();
	while (irv.hasNext()) {
		Leaf leaf = (Leaf) irv.next();
	%>
        <option style="BACKGROUND-COLOR: #f8f8f8" value="<%=leaf.getCode()%>"><%=leaf.getName()%></option>
        <%}%>
      </select>
        <script>
	 form1.kind.value = "<%=ucd.getKind()%>";
	 </script>
    </td>
  </tr>
  <tr>
    <td height="22"><lt:Label res="res.label.blog.user.userconfig" key="pen_name"/></td>
    <td height="22"><input name="penName" type="text" id="penName" value="<%=ucd.getPenName()%>">
      <input name="userName" id="userName" value="<%=userName%>" type=hidden>
（<lt:Label res="res.label.blog.user.userconfig" key="article_title"/>）</td>
  </tr>
  <tr>
    <td height="22"><lt:Label res="res.label.blog.user.userconfig" key="skin"/></td>
    <td height="22">
<%
SkinMgr skmgr = new SkinMgr();
Vector v = skmgr.getAllSkin();
Iterator ir = v.iterator();
String skinoptions = "";
while (ir.hasNext()) {
	Skin skin = (Skin) ir.next();
	skinoptions += "<option value='" + skin.getCode() + "'>" + skin.getName() + "</option>";
}
%>	
<select name="skin">
<%=skinoptions%>
</select>
<script>
form1.skin.value = "<%=ucd.getSkin()%>";
</script></td>
  </tr>
  <tr>
    <td height="22"><lt:Label res="res.label.blog.user.userconfig" key="notice"/></td>
    <td height="22"><textarea name="notice" cols="50" rows="10" id="notice"><%=ucd.getNotice()%></textarea></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><label>
      <input type="submit" name="Submit" value="<lt:Label res="res.label.blog.user.userconfig" key="modify"/>">
      &nbsp;&nbsp;
      <input type="reset" name="Submit2" value="<lt:Label res="res.label.blog.user.userconfig" key="reset"/>">
    </label></td>
  </tr></form>
</table>
<p>&nbsp;</p>
</body>
</html>