<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<HTML><HEAD><TITLE>选择用户</TITLE>
<link rel="stylesheet" href="common.css">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
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
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="shrink();initUsers();">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	// out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	// return;
}
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="24" colspan="4" align="center" class="right-title"><span>选 择 用 户</span></td>
  </tr>
  <tr> 
    <td width="8%" height="87">&nbsp;</td>
    <td colspan="2"><%
DeptMgr dm = new DeptMgr();
DeptDb dd = dm.getDeptDb(DeptDb.ROOTCODE);
DeptView tv = new DeptView(dd);
tv.ListFunc(out, "_self", "updateResults", "", "" );
%></td>
    <td width="63%" align="center" valign="top" bgcolor="#F3F3F3">
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
</table>
	</td>
  </tr>
  
  <tr align="center">
    <td height="63" colspan="2">已选职员</td>
    <td height="63" colspan="2" align="left">
	  <div id="users" name="users" style="display:none"></div>
	  <div id="userRealNames" name="userRealNames"></div>
	</td>
  </tr>
  <tr align="center">
    <td height="28" colspan="4">
<input type="button" name="okbtn" value=" 确 定 " onClick="setUsers()">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <input type="button" name="cancelbtn" value=" 取 消 " onClick="window.close()">    </td>
  </tr>
</table>
</BODY></HTML>
