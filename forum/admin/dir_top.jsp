<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="com.redmoon.forum.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.module.pvg.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Board manage</title>
<LINK href="../common.css" type=text/css rel=stylesheet>
<LINK href="default.css" type=text/css rel=stylesheet>
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

function ShowChild(imgobj, name)
{
	var tableobj = findObj("childof"+name);
	if (tableobj.style.display=="none")
	{
		tableobj.style.display = "";
		if (imgobj.src.indexOf("i_puls-root-1.gif")!=-1)
			imgobj.src = "images/i_puls-root.gif";
		if (imgobj.src.indexOf("i_plus-1-1.gif")!=-1)
			imgobj.src = "images/i_plus2-2.gif";
		if (imgobj.src.indexOf("i_plus-1.gif")!=-1)
			imgobj.src = "images/i_plus2-1.gif";
	}
	else
	{
		tableobj.style.display = "none";
		if (imgobj.src.indexOf("i_puls-root.gif")!=-1)
			imgobj.src = "images/i_puls-root-1.gif";
		if (imgobj.src.indexOf("i_plus2-2.gif")!=-1)
			imgobj.src = "images/i_plus-1-1.gif";
		if (imgobj.src.indexOf("i_plus2-1.gif")!=-1)
			imgobj.src = "images/i_plus-1.gif";
	}
}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style></head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isMasterLogin(request))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<jsp:useBean id="dir" scope="page" class="com.redmoon.forum.Directory"/>
<%
String root_code = ParamUtil.get(request, "root_code");
if (root_code.equals("")) {
	root_code = "root";
}
%>
<Script>
var root_code = "<%=root_code%>";
// 使框架的bottom能得到此root_code
function getRootCode() {
	return root_code;
}
</Script>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("AddRootChild")) {
	try {
		dir.AddRootChild(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
if (op.equals("AddChild")) {
	try {
		dir.AddChild(application, request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
if (op.equals("del")) {
	String delcode = ParamUtil.get(request, "delcode");
	Leaf delleaf = dir.getLeaf(delcode);
	if (delleaf==null) {
	}
	else {
		try {
			dir.del(application, delcode);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert(e.getMessage()));
		}
	}
}
if (op.equals("move")) {
	try {
		dir.move(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
/*
if (op.equals("removecache")) {
	String curcode = ParamUtil.get(request, "code");
	LeafChildrenCacheMgr.remove(curcode);
	out.print(StrUtil.Alert(curcode + "缓存已被清除！"));
}
*/

Leaf leaf = dir.getLeaf(root_code);
if (op.equals("repair")) {
	dir.repairTree(leaf);
	leaf = dir.getLeaf(root_code);
}

String root_name = leaf.getName();
int root_layer = leaf.getLayer();
String root_description = leaf.getDescription();
boolean isHome = false;
%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">管理&nbsp;<%=root_name%></td>
  </tr>
</table>
<br>
<TABLE class="frame_gray"  
cellSpacing=0 cellPadding=0 width="95%" align=center>
  <TBODY>
    <TR>
      <TD height=200 valign="top" bgcolor="#FFFBFF">
<table class="tbg1" cellspacing=0 cellpadding=0 width="100%" align=center onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" 
border=0>
          <tbody>
            <tr>
              <td width="66%" height="13" align=left nowrap>              &nbsp;&nbsp;&nbsp;&nbsp;                             </td>
            <td width="34%" align=right nowrap>>>&nbsp;<a href="dir_top.jsp?op=repair&root_code=<%=root_code%>">修复</a>&nbsp;<%=root_name%>&nbsp;&nbsp;<a target="_parent" href="document_list_m.jsp?dir_code=<%=StrUtil.UrlEncode(root_code)%>&dir_name=<%=StrUtil.UrlEncode(root_name)%>"></a><a target=dirbottomFrame href="dir_bottom.jsp?parent_code=<%=StrUtil.UrlEncode(root_code, "utf-8")%>&parent_name=<%=StrUtil.UrlEncode(root_name, "utf-8")%>&op=AddChild">添子目录</a>
			<%if (!root_code.equals(Leaf.CODE_ROOT)) {%>
				<a target="dirbottomFrame" href="dir_bottom.jsp?op=modify&code=<%=StrUtil.UrlEncode(root_code, "utf-8")%>&name=<%=StrUtil.UrlEncode(root_name,"utf-8")%>&description=<%=StrUtil.UrlEncode(root_description,"utf-8")%>">修改</a>
		    <%}%>
			<!--<a target=_self href="#" onClick="if (window.confirm('您确定要删除<%=root_name%>吗?')) window.location.href='dir_top.jsp?op=del&delcode=<%=root_code%>'">删除</a>-->
			  </td>
            </tr>
          </tbody>
        </table>
<%
DirectoryView tv = new DirectoryView(request, leaf);
tv.list(out);
%></TD>
    </TR>
  </TBODY>
</TABLE>
</body>
</html>
