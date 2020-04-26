<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<HTML><HEAD><TITLE>选择用户</TITLE>
<link rel="stylesheet" href="common.css">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
#floater {
	position: absolute;
	left: 500;
	top: 146;
	width: 116px;
	visibility: visible;
	z-index: 10;
	height: 222px;
	background-color: #EAEAEA;
}

.style1 {
	font-size: 12pt;
	font-weight: bold;
}
-->
</style>
  <script src='dwr/interface/DeptUserDb.js'></script>
  <script src='dwr/engine.js'></script>
  <script src='dwr/util.js'></script>
  <script>
  var allUserOfDept="";
  var allUserRealNameOfDept = "";
  function updateResults(deptCode) {
    DWRUtil.removeAllRows("postsbody");
	allUserOfDept="";
	allUserRealNameOfDept = "";
    DeptUserDb.list2DWR(fillTable, deptCode);
    $("resultTable").style.display = '';
  }
  
  var getCode = function(unit) { return unit.deptCode };
  var getName = function(unit) { return unit.deptName };
  var getUserName = function(unit) { 
	  if (unit.userName!=null) {
		  if (allUserOfDept=="") {
			allUserOfDept = unit.userName;
			allUserRealNameOfDept = unit.userRealName;
		  }
		  else {
			allUserOfDept += "," + unit.userName;
			allUserRealNameOfDept += ","  + unit.userRealName;
		  }
	  }
  	  var u = unit.userRealName;
	  if (u!=null && u!="")
		return "<a href=# onClick=\"selPerson('" + unit.deptCode + "', '" + unit.deptName + "', '" + unit.userName + "','" + unit.userRealName + "')\">" + u + "</a>" 
	  else
	  	return "无";
  };
  
  var getCancelSelUser = function(unit) { 
  	  var u = unit.userName;
	  if (u!=null && u!="")
		return "[<a href=# onClick=\"cancelSelPerson('" + unit.deptCode + "', '" + unit.deptName + "', '" + unit.userName + "','" + unit.userRealName + "')\">取消选择</a>]" 
	  else
	  	return "无";
  }
  
  function fillTable(apartment) {
    DWRUtil.addRows("postsbody", apartment, [ getName, getUserName, getCancelSelUser ]);
  }
  
  function setUsers() {
	// window.returnValue = users.innerText;
	dialogArguments.setUsers(users.innerText, userRealNames.innerText);
  	window.close();
  }

  function initUsers() {
  	users.innerText = dialogArguments.getSelUserNames();
  	userRealNames.innerText = dialogArguments.getSelUserRealNames();

   // 初始化可以选择的部门
   try {
	   var depts = dialogArguments.getDept();
	   if (depts!="") {
		   var ary = depts.split(",");
		   var isFinded = true;
	   	   isFinded = false;
		   var len = document.all.tags('A').length;
		   for(var i=0; i<len; i++) {
		   		try {
					var aObj = document.all.tags('A')[i];
					var canSel = false;
					for (var j=0; j<ary.length; j++) {
						if (aObj.outerHTML.indexOf("'" + ary[j] + "'")!=-1) {
							canSel = true;
							// alert(canSel);
							break;
						}
					}
					if (!canSel) {
						aObj.innerHTML = "<font color='#888888'>" + aObj.innerText + "</font>";
						aObj.outerHTML = aObj.outerHTML.replace(/onClick/gi, "''");
					}
						
					isFinded = true;
				}
				catch (e) {}
		   }
	   }
   }
   catch (e) {}

  }

  function selPerson(deptCode, deptName, userName, userRealName) {
	// 检查用户是否已被选择
	if (users.innerText.indexOf(userName)!=-1) {
		alert("用户" + userRealName + "已被选择！");
		return;
	}
	if (users.innerText=="") {
		users.innerText += userName;
		userRealNames.innerText += userRealName;
	}
	else {
		users.innerText += "," + userName;
		userRealNames.innerText += "," + userRealName;
	}
  }
  
  function cancelSelPerson(deptCode, deptName, userName) {
	// 检查用户是否已被选择
	var strUsers = users.innerText;
	if (strUsers=="")
		return;
	if (strUsers.indexOf(userName)==-1) {
		return;
	}
	
	var strUserRealNames = userRealNames.innerText;
  	var ary = strUsers.split(",");
	var aryRealName = strUserRealNames.split(",");
	var len = ary.length;
	var ary1 = new Array();
	var aryRealName1 = new Array();
	var k = 0;
	for (i=0; i<len; i++) {
		if (ary[i]!=userName) {
			ary1[k] = ary[i];
			aryRealName1[k] = aryRealName[i];
			k++;
		}
	}
	var str = "";
	var str1 = "";
	for (i=0; i<k; i++) {
		if (str=="") {
			str = ary1[i];
			str1 = aryRealName1[i];
		}
		else {
			str += "," + ary1[i];
			str1 += "," + aryRealName1[i];
		}
	}
	users.innerText = str;
	userRealNames.innerText = str1;
  }
  
  function selAllUserOfDept() {
  	if (allUserOfDept=="")
		return;
	var allusers = users.innerText;
	var allUserRealNames = userRealNames.innerText;
	if (allusers=="") {
		allusers += allUserOfDept;
		allUserRealNames += allUserRealNameOfDept;
	}
	else {
		allusers += "," + allUserOfDept;
		allUserRealNames += "," + allUserRealNameOfDept;
	}
	// alert(allUserRealNames);
	var r = clearRepleatUser(allusers, allUserRealNames);
  	users.innerText = r[0];
	userRealNames.innerText = r[1];
  }
   
  function clearRepleatUser(strUsers, strUserRealNames) {
  	var ary = strUsers.split(",");
	var aryRealName = strUserRealNames.split(",");
	
	var len = ary.length;
	// 创建二维数组
	var ary1 = new Array();
	for (i=0; i<len; i++) {
		ary1[i] = new Array(2);
		ary1[i][0] = ary[i];
		ary1[i][1] = 0; // 1 表示重复
	}
	
	// 标记重复的用户
	for (i=0; i<len; i++) {
		var user = ary[i];
		for (j=i+1; j<len; j++) {
			if (ary1[j][1]==1)
				continue;
			if (ary[j]==user)
				ary1[j][1] = 1;
		}
	}

	// 重组为字符串
	var str = "";
	var str1 = "";
	for (i=0; i<len; i++) {
		if (ary1[i][1]==0) {
			u = ary1[i][0];
			if (str=="") {
				str = u;
				str1 = aryRealName[i];
			}
			else {
				str += "," + u;
				str1 += "," + aryRealName[i];
			}
		}
	}
	var retary = new Array();
	retary[0] = str;
	retary[1] = str1;
	return retary;
	
  }
 
  </script>
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

// 折叠目录
function shrink() {
   for(var i=0; i<document.images.length; i++) {
		var imgObj = document.images[i];
		try {
			if (imgObj.tableRelate!="") {
				ShowChild(imgObj, imgObj.tableRelate);
			}
		}
		catch (e) {
		}
   }
}
  </script>
  
<script LANGUAGE="JavaScript">
// -----------实现floater-------------------
self.onError=null;
currentX = currentY = 0; 
whichIt = null; 
lastScrollX = 0; lastScrollY = 0;
NS = (document.layers) ? 1 : 0;
IE = (document.all) ? 1: 0;
<!-- STALKER CODE -->
function heartBeat() {
if(IE) { diffY = document.body.scrollTop; diffX = document.body.scrollLeft; }
if(NS) { diffY = self.pageYOffset; diffX = self.pageXOffset; }
if(diffY != lastScrollY) {
percent = .1 * (diffY - lastScrollY);
if(percent > 0) percent = Math.ceil(percent);
else percent = Math.floor(percent);
if(IE) document.all.floater.style.pixelTop += percent;
if(NS) document.floater.top += percent; 
lastScrollY = lastScrollY + percent;
}
if(diffX != lastScrollX) {
percent = .1 * (diffX - lastScrollX);
if(percent > 0) percent = Math.ceil(percent);
else percent = Math.floor(percent);
if(IE) document.all.floater.style.pixelLeft += percent;
if(NS) document.floater.left += percent;
lastScrollX = lastScrollX + percent;
} 
}
<!-- /STALKER CODE -->
<!-- DRAG DROP CODE -->
function checkFocus(x,y) { 
stalkerx = document.floater.pageX;
stalkery = document.floater.pageY;
stalkerwidth = document.floater.clip.width;
stalkerheight = document.floater.clip.height;
if( (x > stalkerx && x < (stalkerx+stalkerwidth)) && (y > stalkery && y < (stalkery+stalkerheight))) return true;
else return false;
}
function grabIt(e) {
if(IE) {
whichIt = event.srcElement;
while (whichIt.id.indexOf("floater") == -1) {
whichIt = whichIt.parentElement;
if (whichIt == null) { return true; }
}
whichIt.style.pixelLeft = whichIt.offsetLeft;
whichIt.style.pixelTop = whichIt.offsetTop;
currentX = (event.clientX + document.body.scrollLeft);
currentY = (event.clientY + document.body.scrollTop); 
} else { 
window.captureEvents(Event.MOUSEMOVE);
if(checkFocus (e.pageX,e.pageY)) { 
whichIt = document.floater;
StalkerTouchedX = e.pageX-document.floater.pageX;
StalkerTouchedY = e.pageY-document.floater.pageY;
} 
}
return true;
}
function moveIt(e) {
if (whichIt == null) { return false; }
if(IE) {
newX = (event.clientX + document.body.scrollLeft);
newY = (event.clientY + document.body.scrollTop);
distanceX = (newX - currentX); distanceY = (newY - currentY);
currentX = newX; currentY = newY;
whichIt.style.pixelLeft += distanceX;
whichIt.style.pixelTop += distanceY;
if(whichIt.style.pixelTop < document.body.scrollTop) whichIt.style.pixelTop = document.body.scrollTop;
if(whichIt.style.pixelLeft < document.body.scrollLeft) whichIt.style.pixelLeft = document.body.scrollLeft;
if(whichIt.style.pixelLeft > document.body.offsetWidth - document.body.scrollLeft - whichIt.style.pixelWidth - 20) whichIt.style.pixelLeft = document.body.offsetWidth - whichIt.style.pixelWidth - 20;
if(whichIt.style.pixelTop > document.body.offsetHeight + document.body.scrollTop - whichIt.style.pixelHeight - 5) whichIt.style.pixelTop = document.body.offsetHeight + document.body.scrollTop - whichIt.style.pixelHeight - 5;
event.returnValue = false;
} else { 
whichIt.moveTo(e.pageX-StalkerTouchedX,e.pageY-StalkerTouchedY);
if(whichIt.left < 0+self.pageXOffset) whichIt.left = 0+self.pageXOffset;
if(whichIt.top < 0+self.pageYOffset) whichIt.top = 0+self.pageYOffset;
if( (whichIt.left + whichIt.clip.width) >= (window.innerWidth+self.pageXOffset-17)) whichIt.left = ((window.innerWidth+self.pageXOffset)-whichIt.clip.width)-17;
if( (whichIt.top + whichIt.clip.height) >= (window.innerHeight+self.pageYOffset-17)) whichIt.top = ((window.innerHeight+self.pageYOffset)-whichIt.clip.height)-17;
return false;
}
return false;
}
function dropIt() {
whichIt = null;
if(NS) window.releaseEvents (Event.MOUSEMOVE);
return true;
}
<!-- DRAG DROP CODE -->
if(NS) {
window.captureEvents(Event.MOUSEUP|Event.MOUSEDOWN);
window.onmousedown = grabIt;
window.onmousemove = moveIt;
window.onmouseup = dropIt;
}
if(IE) {
document.onmousedown = grabIt;
document.onmousemove = moveIt;
document.onmouseup = dropIt;
}
if(NS || IE) action = window.setInterval("heartBeat()",1);
</script>  
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="shrink();initUsers();" style="overflow:auto">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	// out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	// return;
}
%>
<div ID="floater" style="left: 471px; top: 27px;">
  <table width="100%" height="100%">
    <tr><td height="23" align="center" bgcolor="#BEC7D3"><strong>已选职员</strong></td>
    </tr>
  <tr><td height="200" valign="top">
  <div id="users" name="users" style="display:none"></div>
	  <div id="userRealNames" name="userRealNames"></div>
   </td>
  </tr><tr><td height="31" align="right">
  <input type="button" name="okbtn" value="    确 定    " onClick="setUsers()"></td></tr>
   <tr>
     <td align="right"><input type="button" name="cancelbtn" value="    取 消    " onClick="window.close()"></td>
   </tr>
  </table>
</div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="24" colspan="5" align="center" class="right-title"><span>选 择 用 户</span></td>
  </tr>
  <tr> 
    <td width="2%" height="87">	</td>
    <td colspan="2"><%
DeptMgr dm = new DeptMgr();
DeptDb dd = dm.getDeptDb(DeptDb.ROOTCODE);
DeptView tv = new DeptView(dd);
tv.ListFunc(out, "_self", "updateResults", "", "" );
%></td>
    <td width="50%" align="center" valign="top" bgcolor="#F3F3F3">
	<div id="resultTable">
	  <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <thead>
        <tr>
          <th width="98" align="left" bgcolor="#B4D3F1">部门</th>
          <th width="91" align="left" bgcolor="#B4D3F1">职员</th>
          <th width="74" align="left" bgcolor="#B4D3F1">&nbsp;</th>
        </tr>
      </thead>
      <tbody id="postsbody">
	  <tr>
	    <td colspan="3">请选择部门</td>
	  </tr>
      </tbody>
    </table>
	</div><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" align="center"><input type="button" value="选择该部门所有用户" onClick="selAllUserOfDept()"></td>
  </tr>
</table>	</td>
    <td width="21%" align="center" valign="top" bgcolor="#F3F3F3">&nbsp;</td>
  </tr>
</table>
</BODY></HTML>
