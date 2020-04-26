<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.netdisk.*" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="com.redmoon.oa.address.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<LINK href="../common.css" type=text/css rel=stylesheet>
<LINK href="default.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>通讯录框架-左侧</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.menutitle{
cursor:pointer;
margin-bottom: 5px;
background-color:#ECECFF;
color:#000000;
width:140px;
padding:2px;
text-align:center;
font-weight:bold;
/*/*/border:1px solid #000000;/* */
}

.submenu{
margin-bottom: 0.1em;
}
-->
</style>
</head>
<script type="text/javascript">

/***********************************************
* Switch Menu script- by Martial B of http://getElementById.com/
* Modified by Dynamic Drive for format & NS4/IE4 compatibility
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

var persistmenu="yes" //"yes" or "no". Make sure each SPAN content contains an incrementing ID starting at 1 (id="sub1", id="sub2", etc)
var persisttype="sitewide" //enter "sitewide" for menu to persist across site, "local" for this page only

if (document.getElementById){ //DynamicDrive.com change
document.write('<style type="text/css">\n')
document.write('.submenu{display: none;}\n')
document.write('</style>\n')
}

function SwitchMenu(obj){
	if(document.getElementById){
	var el = document.getElementById(obj);
	var ar = document.getElementById("masterdiv").getElementsByTagName("span"); //DynamicDrive.com change
		if(el.style.display != "block"){ //DynamicDrive.com change
			for (var i=0; i<ar.length; i++){
				if (ar[i].className=="submenu") //DynamicDrive.com change
				ar[i].style.display = "none";
			}
			el.style.display = "block";
		}else{
			el.style.display = "none";
		}
	}
}

function get_cookie(Name) { 
var search = Name + "="
var returnvalue = "";
if (document.cookie.length > 0) {
offset = document.cookie.indexOf(search)
if (offset != -1) { 
offset += search.length
end = document.cookie.indexOf(";", offset);
if (end == -1) end = document.cookie.length;
returnvalue=unescape(document.cookie.substring(offset, end))
}
}
return returnvalue;
}

function onloadfunction(){
if (persistmenu=="yes"){
var cookiename=(persisttype=="sitewide")? "switchmenu" : window.location.pathname
var cookievalue=get_cookie(cookiename)
if (cookievalue!="")
document.getElementById(cookievalue).style.display="block"
}
}

function savemenustate(){
var inc=1, blockid=""
while (document.getElementById("sub"+inc)){
if (document.getElementById("sub"+inc).style.display=="block"){
blockid="sub"+inc
break
}
inc++
}
var cookiename=(persisttype=="sitewide")? "switchmenu" : window.location.pathname
var cookievalue=(persisttype=="sitewide")? blockid+";path=/" : blockid
document.cookie=cookiename+"="+cookievalue
}

if (window.addEventListener)
window.addEventListener("load", onloadfunction, false)
else if (window.attachEvent)
window.attachEvent("onload", onloadfunction)
else if (document.getElementById)
window.onload=onloadfunction

if (persistmenu=="yes" && document.getElementById)
window.onunload=savemenustate

</script>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "read";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String strtype = ParamUtil.get(request, "type");
int type = AddressDb.TYPE_USER;
if (!strtype.equals(""))
	type = Integer.parseInt(strtype);
String mode = ParamUtil.get(request, "mode");
if (!mode.equals("show")) {	
	if (type==AddressDb.TYPE_PUBLIC) {
		if (!privilege.isUserPrivValid(request, "admin.address.public")) {
			out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
	}
}
%>
<table width="100%"  border="0">
  <tr>
    <td align="left"><div class="tableframe" id="masterdiv">
      <table width="100%" style="cursor:hand" border="0" cellpadding="0" cellspacing="1" onclick="SwitchMenu('sub1')">
        <tr>
          <td height="25" align="center" bgcolor="#5286BD"><strong><font color="#ffffff"><%=(type==AddressDb.TYPE_PUBLIC)?"公共":""%>通讯录分组</font></strong></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="submenu" id="sub1">
        <tr>
          <td height="22" align="center"><a href="address.jsp?groupType=0&type=<%=strtype%>&mode=<%=mode%>" target="mainAddressFrame">全部</a></td>
        </tr>
        <%
			String groupType = "";
			AddressTypeDb atd = new AddressTypeDb();
			String userName = privilege.getUser(request);
			if (type==AddressDb.TYPE_PUBLIC)
				userName = AddressTypeDb.PUBLIC;
			String sql1 = "select id from address_type where USER_NAME=" + StrUtil.sqlstr(userName);
			Iterator ir1 = atd.list(sql1).iterator();
		
			while (ir1.hasNext()) {
			atd = (AddressTypeDb)ir1.next();
			groupType = atd.getName();
			int typeId = atd.getId();
		  %>
        <tr>
          <td height="22" align="center"><a href="address.jsp?groupType=<%=typeId%>&type=<%=strtype%>&mode=<%=mode%>" target="mainAddressFrame"> <%=groupType%></a></td>
        </tr>
        <%}%>
      </table>
      <table width="100%" style="cursor:hand" border="0" cellpadding="0" cellspacing="1" onclick="SwitchMenu('sub2')">
        <tr>
          <td height="25" align="center" bgcolor="#5286BD"><strong><font color="#ffffff"><%=(type==AddressDb.TYPE_PUBLIC)?"公共":""%>通讯录管理</font></strong></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="submenu" id="sub2">
        <tr>
          <td height="22" align="center"><a href="address_add.jsp?type=<%=type%>" target="mainAddressFrame">添加</a></td>
        </tr>
		  <tr>
          <td height="22" align="center"><a href="address_search.jsp?type=<%=type%>" target="mainAddressFrame">查询</a></td>
         </tr>
		  <tr>
          <td height="22" align="center"><a href="address_type_list.jsp?type=<%=type%>" target="mainAddressFrame">类别管理</a></td>
        </tr>
      </table>
    </div>	</td>
  </tr>
</table>
</body>
</html>
