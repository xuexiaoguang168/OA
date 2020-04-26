<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
String userstr = SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "my_blog_add");
userstr = StrUtil.format(userstr, new Object[] {Global.AppName});
%>
<html>
<head>
<title><%=userstr%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="../../forum/<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
</head>
<body>
<%@ include file="../../forum/inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<p>&nbsp;</p>
<%
if (!privilege.isUserLogin(request)) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "err_not_login")));
	return;
}
String userName = privilege.getUser(request);
UserConfigDb ucd = new UserConfigDb();
ucd = ucd.getUserConfigDb(userName);
if (ucd.isLoaded()) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.user.userconfig", "activate_blog_success")));
	return;
}
%>
<table width="482" height="170" border="0" align="center" cellpadding="5" cellspacing="0" class="tableframe_gray">
<form id=form1 action="userconfig_do.jsp?op=add" method=post>
  <tr>
    <td colspan="2" align="center" class="td_title"><strong><lt:Label res="res.label.blog.user.userconfig" key="note_add"/></strong></td>
  </tr>
  <tr>
    <td width="140" height="22" bgcolor="#F2F2F2"><lt:Label res="res.label.blog.user.userconfig" key="column_title"/></td>
    <td width="322" height="22" bgcolor="#F2F2F2"><label>
      <input name="title" type="text" id="title">
    </label></td>
  </tr>
  <tr>
    <td height="22" bgcolor="#F2F2F2"><lt:Label res="res.label.blog.user.userconfig" key="deputy_title"/></td>
    <td height="22" bgcolor="#F2F2F2"><input name="subtitle" type="text" id="subtitle"></td>
  </tr>
  <tr>
    <td height="22" bgcolor="#F2F2F2"><lt:Label res="res.label.blog.user.userconfig" key="class"/></td>
    <td height="22" bgcolor="#F2F2F2"><select name="kind">
        <%
	com.redmoon.blog.LeafChildrenCacheMgr dlcm = new com.redmoon.blog.LeafChildrenCacheMgr("root");
	java.util.Vector vt = dlcm.getDirList();
	Iterator irv = vt.iterator();
	while (irv.hasNext()) {
		com.redmoon.blog.Leaf leaf = (com.redmoon.blog.Leaf) irv.next();
		String parentCode = leaf.getCode();
	%>
        <option style="BACKGROUND-COLOR: #f8f8f8" value="<%=leaf.getCode()%>"><%=leaf.getName()%></option>
        <%}%>
      </select>
    </td>
  </tr>
  <tr>
    <td height="22" bgcolor="#F2F2F2"><lt:Label res="res.label.blog.user.userconfig" key="pen_name"/></td>
    <td height="22" bgcolor="#F2F2F2"><input name="penName" type="text" id="penName">
      （<lt:Label res="res.label.blog.user.userconfig" key="article_title"/>）</td>
  </tr>
  <tr>
    <td height="22" bgcolor="#F2F2F2"><lt:Label res="res.label.blog.user.userconfig" key="skin"/></td>
    <td height="22" bgcolor="#F2F2F2"><%
com.redmoon.blog.ui.SkinMgr skmgr = new com.redmoon.blog.ui.SkinMgr();
Vector v = skmgr.getAllSkin();
Iterator ir = v.iterator();
String skinoptions = "";
while (ir.hasNext()) {
	com.redmoon.blog.ui.Skin skinb = (com.redmoon.blog.ui.Skin) ir.next();
	skinoptions += "<option value='" + skinb.getCode() + "'>" + skinb.getName() + "</option>";
}
%>
        <select name="skin">
          <%=skinoptions%>
    </select></td></tr>
  <tr>
    <td height="22" bgcolor="#F2F2F2"><lt:Label res="res.label.blog.user.userconfig" key="notice"/></td>
    <td height="22" bgcolor="#F2F2F2"><textarea name="notice" cols="50" rows="10" id="notice"></textarea></td>
  </tr>
  <tr>
    <td colspan="2" align="center" bgcolor="#F2F2F2"><label>
      <input type="submit" name="Submit" value="<lt:Label res="res.label.blog.user.userconfig" key="submit"/>">
      &nbsp;&nbsp;
      <input type="reset" name="Submit2" value="<lt:Label res="res.label.blog.user.userconfig" key="reset"/>">
    </label></td>
  </tr></form>
</table>
<p>&nbsp;</p>
<%@ include file="../../forum/inc/footer.jsp"%>
</body>
</html>