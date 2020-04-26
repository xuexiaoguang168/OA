<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<HTML><HEAD><TITLE>组织机构图</TITLE>
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
  function updateResults(deptCode) {
    DWRUtil.removeAllRows("postsbody");
    DeptUserDb.list2DWR(fillTable, deptCode);
    $("resultTable").style.display = '';
  }
  
  var getCode = function(unit) { return unit.deptCode };
  var getName = function(unit) { return unit.deptName };
  var getUserRealName = function(unit) { return unit.userRealName };
  var getUserName = function(unit) { 
  	  var u = unit.userRealName;
	  if (u!=null && u!="")
		return "<a href=# onClick=\"setPerson('" + unit.deptCode + "', '" + unit.deptName + "', '" + unit.userName + "', '" + unit.userRealName + "')\">" + u + "</a>" 
	  else
	  	return "无";
  };
  
  function fillTable(apartment) {
    DWRUtil.addRows("postsbody", apartment, [ getName, getUserName ]);
  }

  function setPerson(deptCode, deptName, userName, userRealName) {
	dialogArguments.setPerson(deptCode, deptName, userName, userRealName);
	window.close();	
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

function window_onload() {
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
  </script>
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="window_onload()">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="24" colspan="3" align="center" class="right-title">组 织 机 构 图</td>
  </tr>
  <tr> 
    <td width="50" height="87">&nbsp;</td>
    <td width="423"><%
DeptMgr dm = new DeptMgr();
DeptDb dd = dm.getDeptDb(DeptDb.ROOTCODE);
DeptView tv = new DeptView(dd);
tv.ListFunc(out, "_self", "updateResults", "", "" );
%></td>
    <td width="491" align="center" valign="top" bgcolor="#E0E0E0">
	<div id="resultTable">
	  <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <thead>
        <tr>
          <th width="66" align="left" bgcolor="#B4D3F1">部门</th>
          <th width="69" align="left" bgcolor="#B4D3F1">职员</th>
        </tr>
      </thead>
      <tbody id="postsbody">
	  <tr>
	    <td colspan="2">请选择部门</td>
	  </tr>
      </tbody>
    </table>
	</div>
	</td>
  </tr>
  
  <tr align="center">
    <td height="28" colspan="3"><input type="button" name="cancelbtn" value=" 关 闭 " onClick="window.close()">    </td>
  </tr>
</table>
</BODY></HTML>
