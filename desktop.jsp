<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="com.redmoon.oa.ui.*" %>
<html>
<head>
<title>Desktop</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="common.css" rel="stylesheet" type="text/css">
<style type='text/css'>
<!--
body{font-size:12px;}
a:visited{text-decoration:none;color:#000000;}
a:hover{text-decoration:underline;color:red;}
a:link{text-decoration:none;color:#000000;}
ul {
	list-style:none;
	margin-left: 0px;
	line-height:200%;
	margin-bottom:0px;
}

.title a:visited{text-decoration:none;color:#ffffff;}
.title a:hover{text-decoration:underline;color:yellow;}
.title a:link{text-decoration:none;color:#ffffff;}
-->
</style>
<script src="inc/common.js"></script>
<script language=JScript>
<!--
var x0=0,y0=0,x1=0,y1=0;
var offx=6,offy=6;
var moveable=false;
var hover='orange',normal='#848684';//color;336699
var fontColor = "#000000";
var index=100;//z-index;
//开始拖动;
function startDrag(obj)
{
	if(event.button==1)
	{
		//锁定标题栏;
		obj.setCapture();
		//定义对象;
		var win = obj.parentNode;
		var sha = win.nextSibling;
		//记录鼠标和层位置;
		x0 = event.clientX;
		y0 = event.clientY;
		x1 = parseInt(win.style.left);
		y1 = parseInt(win.style.top);
		win.style.zIndex += 1; 
		//记录颜色;
		normal = obj.style.backgroundColor;
		//改变风格;
		obj.style.backgroundColor = hover;
		win.style.borderColor = hover;
		obj.nextSibling.style.color = hover;
		sha.style.left = x1 + offx;
		sha.style.top  = y1 + offy;
		moveable = true;
	}
}
// 拖动;
function drag(obj)
{
	if(moveable)
	{
		var win = obj.parentNode;
		var sha = win.nextSibling;
		win.style.left = x1 + event.clientX - x0;
		win.style.top  = y1 + event.clientY - y0;
		sha.style.left = parseInt(win.style.left) + offx;
		sha.style.top  = parseInt(win.style.top) + offy;
	}
}
// 停止拖动;
function stopDrag(obj, id)
{
	if(moveable)
	{
		var win = obj.parentNode;
		var sha = win.nextSibling;
		var msg = obj.nextSibling;
		win.style.borderColor     = normal;
		obj.style.backgroundColor = normal;
		msg.style.color           = normal;
		sha.style.left = obj.parentNode.style.left;
		sha.style.top  = obj.parentNode.style.top;
		obj.releaseCapture();
		moveable = false;
		hidFrame.location.href = "user/desktop_adjust.jsp?id=" + id + "&left=" + win.offsetLeft + "&top=" + win.offsetTop + "&width=" + win.offsetWidth + "&height=" + win.offsetHeight + "&zIndex=" + win.style.zIndex;
	}
}
// 获得焦点;
function getFocus(obj)
{
	if(obj.style.zIndex!=index)
	{
		// index = index + 2;
		// var idx = index;
		var idx = obj.style.zIndex + 1;
		obj.style.zIndex=idx;
		obj.nextSibling.style.zIndex=idx-1;
	}
}
// 最小化;
function min(obj)
{
	var win = obj.parentNode.parentNode;
	var sha = win.nextSibling;
	var tit = obj.parentNode;
	var msg = tit.nextSibling;
	var flg = msg.style.display=="none";
	if(flg)
	{
		win.style.height  = parseInt(msg.style.height) + parseInt(tit.style.height) + 2*2;
		sha.style.height  = win.style.height;
		msg.style.display = "block";
		obj.innerHTML = "0";
	}
	else
	{
		win.style.height  = parseInt(tit.style.height) + 2*2;
		sha.style.height  = win.style.height;
		obj.innerHTML = "2";
		msg.style.display = "none";
	}
}

// 创建一个对象;
function xWin(id,l,t,w,h,tit,msg, index, pageList)
{
	// index = index+2;
	this.id      = id;
	this.width   = w;
	this.height  = h;
	this.left    = l;
	this.top     = t;
	this.zIndex  = index;
	this.title   = tit;
	this.message = msg;
	this.obj     = null;
	this.bulid   = bulid;
	this.pageList = pageList;
	this.bulid();
}

// 初始化
function bulid()
{
	var str = ""
		+ "<div class='resizeMe' id=xMsg" + this.id + " "
		+ "style='"
		+ "z-index:" + this.zIndex + ";"
		+ "width:" + this.width + ";"
		+ "height:" + this.height + ";"
		+ "left:" + this.left + ";"
		+ "top:" + this.top + ";"
		+ "background-color:" + normal + ";"
		+ "color:" + fontColor + ";"
		+ "font-size:8pt;"
		+ "font-family:Tahoma;"
		+ "position:absolute;"
		+ "cursor:default;"
		+ "border:2px solid " + normal + ";"
		+ "' "
		+ "onmousedown='getFocus(this)'>"
			+ "<div class='title'"
			+ "style='"
			+ "background-color:" + normal + ";background-image:url(images/top-right.gif);"
			+ "width:" + (this.width-2*2) + ";"
			+ "height:24;"
			+ "color:white;"
			+ "' "
			+ "onmousedown='startDrag(this)' "
			+ "onmouseup='stopDrag(this, " + this.id + ")' "
			+ "onmousemove='drag(this)' "
			+ "ondblclick='min(this.childNodes[1])'"
			+ ">"
				 + "<span style='width:" + (this.width-2*12-4) + ";padding-left:3px;'><img src='images/icon.gif' align='absmiddle'>&nbsp;&nbsp;<a href='" + this.pageList + "'>" + this.title + "</a></span>"
				 + "<span style='width:12;border-width:0px;color:white;font-family:webdings;' onclick='min(this)'>0</span>"
				 + "<span style='width:12;border-width:0px;color:white;font-family:webdings;' onclick='ShowHide(\""+this.id+"\",null)'>r</span>"
			+ "</div>"
				+ "<div style='"
				+ "width:100%;"
				+ "height:" + (this.height-20-4) + ";"
				+ "background-color:white;"
				+ "line-height:14px;"
				+ "word-break:break-all;"
				+ "padding:3px;"
				+ "'>" + this.message + "</div>"
		+ "</div>"
		+ "<div id=xMsg" + this.id + "bg style='"
		+ "width:" + this.width + ";"
		+ "height:" + this.height + ";"
		+ "top:" + this.top + ";"
		+ "left:" + this.left + ";"
		+ "z-index:" + (this.zIndex-1) + ";"
		+ "position:absolute;"
		+ "background-color:black;"
		+ "filter:alpha(opacity=40);"
		+ "'></div>";
	document.body.insertAdjacentHTML("beforeEnd",str);
}
// 显示隐藏窗口
function ShowHide(id,dis){
	var bdisplay = (dis==null)?((document.getElementById("xMsg"+id).style.display=="")?"none":""):dis
	document.getElementById("xMsg"+id).style.display = bdisplay;
	document.getElementById("xMsg"+id+"bg").style.display = bdisplay;
	if (bdisplay=="none") {
		hidFrame.location.href = "user/desktop_adjust.jsp?op=del&id=" + id;
	}
}
//modify by haiwa @ 2005-7-14 
//http://www.51windows.Net
//-->
</script>
<SCRIPT language=javascript>
/////////////////////////////////////////////////////////////////////////
// Generic Resize by Erik Arvidsson                                    //
//                                                                     //
// You may use this script as long as this disclaimer is remained.     //
// See www.dtek.chalmers.se/~d96erik/dhtml/ for mor info               //
//                                                                     //
// How to use this script!                                             //
// Link the script in the HEAD and create a container (DIV, preferable //
// absolute positioned) and add the class="resizeMe" to it.            //
/////////////////////////////////////////////////////////////////////////

var theobject = null; // This gets a value as soon as a resize start

function resizeObject() {
	this.el        = null; //pointer to the object
	this.dir    = "";      //type of current resize (n, s, e, w, ne, nw, se, sw)
	this.grabx = null;     //Some useful values
	this.graby = null;
	this.width = null;
	this.height = null;
	this.left = null;
	this.top = null;
}
	
//Find out what kind of resize! Return a string inlcluding the directions
function getDirection(el) {
	var xPos, yPos, offset, dir;
	dir = "";

	xPos = window.event.offsetX;
	yPos = window.event.offsetY;

	offset = 8; //The distance from the edge in pixels

	if (yPos<offset) dir += "n";
	else if (yPos > el.offsetHeight-offset) dir += "s";
	if (xPos<offset) dir += "w";
	else if (xPos > el.offsetWidth-offset) dir += "e";

	return dir;
}

function doDown() {
	var el = getReal(event.srcElement, "className", "resizeMe");

	if (el == null) {
		theobject = null;
		return;
	}		

	dir = getDirection(el);
	if (dir == "") return;

	theobject = new resizeObject();
		
	theobject.el = el;
	theobject.dir = dir;

	theobject.grabx = window.event.clientX;
	theobject.graby = window.event.clientY;
	theobject.width = el.offsetWidth;
	theobject.height = el.offsetHeight;
	theobject.left = el.offsetLeft;
	theobject.top = el.offsetTop;

	window.event.returnValue = false;
	window.event.cancelBubble = true;
}

function doUp() {
	if (theobject != null) {
		var win = theobject.el;
		var id = win.id.substring(4, win.id.length);
		hidFrame.location.href = "user/desktop_adjust.jsp?id=" + id + "&left=" + win.offsetLeft + "&top=" + win.offsetTop + "&width=" + win.offsetWidth + "&height=" + win.offsetHeight + "&zIndex=" + win.style.zIndex;
		theobject = null;
	}
}

function rebuildWin(win) {
try {
	var shadow = win.nextSibling;
	shadow.style.left = win.style.left;
	shadow.style.top  = win.style.top;
	shadow.style.width = win.style.width;
	shadow.style.height = win.style.height;
	
	var divTitle = win.childNodes(0);
	divTitle.style.width = parseInt(win.style.width)-2*2;
	var spanTitle = divTitle.childNodes(0);
	spanTitle.style.width = parseInt(win.style.width)-2*12-4
	
	var divMsg = divTitle.nextSibling;
	divMsg.style.width = divTitle.style.width;
	divMsg.style.height = parseInt(win.style.height) - 20 - 2*2;
}
catch (e) {
}
}

function doMove() {
	var el, xPos, yPos, str, xMin, yMin;
	xMin = 8; //The smallest width possible
	yMin = 8; //             height

	el = getReal(event.srcElement, "className", "resizeMe");

	if (el.className == "resizeMe") {
		str = getDirection(el);
		// Fix the cursor	
		if (str == "")
			str = "default";
		else
			str += "-resize";
		el.style.cursor = str;
	}
	
    // Dragging starts here
	if(theobject != null) {
		if (dir.indexOf("e") != -1)
			theobject.el.style.width = Math.max(xMin, theobject.width + window.event.clientX - theobject.grabx) + "px";
	
		if (dir.indexOf("s") != -1)
			theobject.el.style.height = Math.max(yMin, theobject.height + window.event.clientY - theobject.graby) + "px";

		if (dir.indexOf("w") != -1) {
			theobject.el.style.left = Math.min(theobject.left + window.event.clientX - theobject.grabx, theobject.left + theobject.width - xMin) + "px";
			theobject.el.style.width = Math.max(xMin, theobject.width - window.event.clientX + theobject.grabx) + "px";
		}
		if (dir.indexOf("n") != -1) {
			theobject.el.style.top = Math.min(theobject.top + window.event.clientY - theobject.graby, theobject.top + theobject.height - yMin) + "px";
			theobject.el.style.height = Math.max(yMin, theobject.height - window.event.clientY + theobject.graby) + "px";
		}
		
		rebuildWin(theobject.el);
		
		window.event.returnValue = false;
		window.event.cancelBubble = true;
	} 
}

function getReal(el, type, value) {
	temp = el;
	while ((temp != null) && (temp.tagName != "BODY")) {
		if (eval("temp." + type) == value) {
			el = temp;
			return el;
		}
		temp = temp.parentElement;

	}
	return el;
}

document.onmousedown = doDown;
document.onmouseup   = doUp;
document.onmousemove = doMove;
</SCRIPT>
</head>
<!--<base target="_blank">-->
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String userName = privilege.getUser(request);
UserDesktopSetupDb udsd = new UserDesktopSetupDb();
String sql = "select id from " + udsd.getTableName() + " where user_name=" + StrUtil.sqlstr(userName);
Vector v = udsd.list(sql);
Iterator ir = v.iterator();
DesktopMgr dm = new DesktopMgr();
while (ir.hasNext()) {
	udsd = (UserDesktopSetupDb) ir.next();
	DesktopUnit du = dm.getDesktopUnit(udsd.getModuleCode());
%>
<div id='div_cont_<%=udsd.getId()%>' style='display:none'><%=du.getIDesktopUnit().display(request, udsd)%></div>
<%}%>
<script>
function initialize()
{
<%
ir = v.iterator();
while (ir.hasNext()) {
	udsd = (UserDesktopSetupDb) ir.next();
	DesktopUnit du = dm.getDesktopUnit(udsd.getModuleCode());
%>
	new xWin("<%=udsd.getId()%>", <%=udsd.getLeft()%>, <%=udsd.getTop()%>, <%=udsd.getWidth()%>, <%=udsd.getHeight()%>, "<%=udsd.getTitle()%>", div_cont_<%=udsd.getId()%>.innerHTML, <%=udsd.getZIndex()%>, "<%=du.getIDesktopUnit().getPageList(request, udsd)%>");
<%}%>
}
</script>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<iframe id="hidFrame" src="user/desktop_adjust.jsp" width="0" height="0"></iframe>
</body>
<script language='JScript'>
<!--
window.onload = initialize;
//-->
</script>
</html>