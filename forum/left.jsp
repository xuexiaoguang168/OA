<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.URLEncoder"%>

<html>
<head>
<title>菜单</title>
<%@ include file="inc/nocache.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script language="javascript">
<!--
function openWin(url,width,height)
{
  var newwin = window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,top=50,left=120,width="+width+",height="+height);
}

// Example: obj = findObj("image1");
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

function show(name)
{
	var tableobj = findObj("boardof"+name);
	var imgobj = findObj("imgclass"+name);
	var eggobj = findObj("egg"+name);
	if (!tableobj || !imgobj)
		return;
	if (tableobj.style.display=="none")
	{
		tableobj.style.display = "";
		imgobj.src = "images/lefttree/open.gif";
		if (eggobj!=null)
			eggobj.src = "images/join.gif";
	}
	else
	{
		tableobj.style.display = "none";
		imgobj.src = "images/lefttree/fold.gif";
		if (eggobj!=null)
			eggobj.src = "images/folder.gif";
	}
}
//-->
</script>
<style type="text/css">
<!--
body {
	background-color: #016DAC;
}
-->
</style></head>
<body text="#000000" leftmargin="0"  rightmargin="0" topmargin="0">
<IMG src="images/title_2.gif"> 
<%@ include file="inc/inc.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="struct" scope="page" class="com.redmoon.forum.Struct"/>
<%
String nick = privilege.getUser(request);
if (nick.equals("")) {
	nick = "*"+System.currentTimeMillis();
}
%>
<table id="mydir" name="mydir" style="cursor:hand" width="100%" border="0" cellspacing="0" cellpadding="0" onClick="show('mydir')">
  <tr>
    <td height="20"><img src="images/lefttree/fold.gif" width="18" height="16" align="absmiddle" id="imgclassmydir"><img src="images/lefttree/faverate.gif" width="16" height="16" align="absmiddle" >&nbsp;<font color="#FFFFFF">我的目录</font></td>
  </tr>
</table>
<table id="boardofmydir" name="boardofmydir" style="display:none" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="25" style="padding-bottom:0; padding-top:0">&nbsp; </td>
    <td height="18" style="padding-bottom:0; padding-top:0"><IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">&nbsp;<a href="myfavoriate.jsp" target="main" class="left">收&nbsp;&nbsp;藏&nbsp;&nbsp;夹</a> 
    </td>
  </tr>
  <tr> 
    <td width="25" style="padding-bottom:0; padding-top:0">&nbsp; </td>
    <td height="18" style="padding-bottom:0; padding-top:0"><IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">&nbsp;<a href="myfriend.jsp" target="main" class="left">我的好友</a> </td>
  </tr>
  <tr> 
    <td width="25" style="padding-bottom:0; padding-top:0">&nbsp;</td>
    <td height="18" style="padding-bottom:0; padding-top:0"> <IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">&nbsp;<a href="mytopic.jsp?action=mytopic" target="main" class="left">发的贴子</a> 
    </td>
  </tr>
  <tr> 
    <td width="25" style="padding-bottom:0; padding-top:0">&nbsp; </td>
    <td height="18" style="padding-bottom:0; padding-top:0"><IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">&nbsp;<a href="mytopic.jsp?action=myreply" target="main" class="left">参与贴子</a></td>
  </tr>
  <tr> 
    <td width="25" style="padding-bottom:0; padding-top:0">&nbsp;</td>
    <td height="18" style="padding-bottom:0; padding-top:0"> <IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">&nbsp;<a href="javascript:openWin('../message/message.jsp',320,260)" class="left">我的短信</a></td>
  </tr>
</table>
<%
	Element root = struct.getRootElement(); //得到根元素
	java.util.List classlist = root.getChild("struct").getChildren();
	
	Iterator ir = classlist.iterator();
	String code = "", boardcode="", name="",description="",sort="",expire="";
	while (ir.hasNext())
	{
		Element myclass = (Element)ir.next(); //得到第i个field元素
		code = myclass.getAttribute("code").getValue();
		name = myclass.getAttribute("name").getValue();
		description = myclass.getAttribute("description").getValue();
		sort = myclass.getAttribute("sort").getValue();
		%>
<table id="<%=code%>" style="cursor:hand;" name="<%=code%>" width="100%" border="0" cellpadding="0" cellspacing="0" onClick="show('<%=code%>')">
  <tr>
    <td height="18"> <img src="images/lefttree/fold.gif" width="18" height="16" align="absmiddle" id="imgclass<%=code%>"><IMG src="images/folder.gif" width="16" height="16" align="absmiddle" id="egg<%=code%>">&nbsp;<font color="#FFFFFF"><%=name%></font></td>
  </tr>
</table>
<table id="boardof<%=code%>" style="display:none" name="boardof<%=code%>" width="100%" border="0" cellspacing="0" cellpadding="0">
  <%if (code.equals("chat")) {%>
  <tr> 
    <td width="25" style="padding-bottom:0; padding-top:0">&nbsp;</td>
    <td height="18" style="padding-bottom:0; padding-top:0"> <IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">&nbsp;<a href="../../rmforum/chat/chatservlet?mode=listroom&user=<%=nick%>" target="main" class="left"><font color="#FF9900">聊天广场</font></a></td>
  </tr>
  <%}%>
  <%
		java.util.List boardlist = myclass.getChildren();
		Iterator ir1 = boardlist.iterator();
		int size = boardlist.size();
		int k = 0;
		while (ir1.hasNext())
		{
			Element board = (Element)ir1.next();
			k++;
			boardcode = board.getChild("code").getText();
			name = board.getChild("name").getText();
			description = board.getChild("description").getText();
			expire = board.getChild("expire").getText();
		%>
  <tr> 
    <td width=25 height="18" style="paddingTop:0;paddingBottom:0">&nbsp; </td>
    <td height="18" style="paddingTop:0;paddingBottom:0"> 
	<% if (k!=size) { %> 
	<IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">	<% } else { %>
	   <IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">	   <% } %> 
	<a href="listtopic.jsp?boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(name,"utf-8")%>" target="main" class="left"><%=name%></a> </td>
  </tr>
  <% } %>
  <%if (code.equals("manage")) {%>
  <tr> 
    <td width="25" style="padding-bottom:0; padding-top:0">&nbsp;</td>
    <td height="18" style="padding-bottom:0; padding-top:0"> <IMG src="images/line.gif" height=18 
      border=0 align="absmiddle">&nbsp;<a href="../prison.jsp" target="main" class="left"><font color="#66CC33">社区监狱</font></a></td>
  </tr>
  <%}%></table>
  
<% } %>
<script language="JavaScript1.2">
<!--
/**
* Get cookie routine by Shelley Powers 
* (shelley.powers@ne-dev.com)
*/

function get_cookie(Name) {
	var search = Name + "="
	var returnvalue = "";
	if (document.cookie.length > 0) {
		offset = document.cookie.indexOf(search)
		// if cookie exists
		if (offset != -1) { 
			offset += search.length
			// set index of beginning of value
			end = document.cookie.indexOf(";", offset);
			// set index of end of cookie value
			if (end == -1) end = document.cookie.length;
			returnvalue=unescape(document.cookie.substring(offset, end))
		}
	}
	return returnvalue;
}

if (get_cookie(window.location.pathname) != ''){
	var openresults=get_cookie(window.location.pathname).split(" ")
	for (i=0 ; i < openresults.length ; i++){
		var obj = findObj(openresults[i]);
		if (!obj)
			continue;
		obj.style.display = "";
		var classcode = obj.id.substr(7,obj.id.length-7);
		var imgobj = findObj("imgclass"+classcode);
		var eggobj = findObj("egg"+classcode);
		if (imgobj) {
			imgobj.src = "images/lefttree/open.gif";
			if (eggobj)
				eggobj.src = "images/join.gif";
		}
	}
}

function check(){
	var ids ="",openones = "";
	var tables = document.all.tags("table");
	
	if (tables!=null)
	{
	    for (i=0; i<tables.length; i++) 
		{
			var tbl = tables[i];
			var tblid = tbl.id;
			var first6 = tblid.substr(0,7)
			var classcode = tblid.substr(7,tbl.id.length-7);
			if (first6=="boardof" && classcode!="")
			{
				if (tbl.style.display!="none")	
					openones=openones + " " + tblid//利用cookie记录下呈打开状foldinglist的编号
			}
		}
	}
	else
		return;
	var expdate = new Date();
	var expday = 60
	expdate.setTime(expdate.getTime() +  (24 * 60 * 60 * 1000 * expday));
	
	document.cookie=window.location.pathname+"="+openones+" ;expires="+expdate.toGMTString();
}

if (document.all)
	document.body.onunload=check

//-->
</script>
</body>
</html>