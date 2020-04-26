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
  var getUserName = function(unit) { 
  	  var u = unit.userRealName;
	  if (u!=null && u!="")
		return "<a href=# onClick=\"setPerson('" + unit.deptCode + "', '" + unit.deptName + "', '" + unit.userName + "')\">" + u + "</a>" 
	  else
	  	return "无";
  };
  
  var getOperate = function(unit) { 
  	  var u = unit.userName;
	  if (u!=null && u!="")
		// return "<a href=# onClick=\"showWork('" + u + "')\">工作</a>&nbsp;&nbsp;<a href=# onClick=\"showKaoqin('" + u + "')\">考勤</a>&nbsp;&nbsp;<a href=# onClick=\"showDiskShare('" + u + "')\">共享</a>" 
		return "<a href=# onClick=\"showWork('" + u + "')\">工作</a>&nbsp;&nbsp;<a href=# onClick=\"showKaoqin('" + u + "')\">考勤</a>&nbsp;&nbsp;<a href=# onClick=\"showDiskShare('" + u + "')\">共享</a>&nbsp;<a href=# onClick=\"showInfo('" + u + "')\">信息</a>" 
	  else
	  	return "无";
  };
  
  function fillTable(apartment) {
    DWRUtil.addRows("postsbody", apartment, [ getName, getUserName, getOperate ]);
  }

  function setPerson(deptCode, deptName, userName) {
	// dialogArguments.setPerson(deptCode, deptName, userName);
	// window.close();	
  }
  
  function showWork(userName) {
  	form1.userName.value = userName;
  	form1.action = "admin/mywork.jsp";
	form1.submit();
  }
  
  function showKaoqin(userName) {
  	form1.userName.value = userName;
  	form1.action = "admin/kaoqin.jsp";
	form1.submit();
  }
  
  function showDiskShare(userName) {
  	form1.userName.value = userName;
  	form1.action = "netdisk/netdisk_frame.jsp?op=showDirShare";
	form1.submit();
  }
  
  function showBlog(userName) {
  	form1.userName.value = userName;
  	form1.action = "blog/myblog.jsp";
	form1.submit();
  }
  
  function showInfo(userName) {
  	form1.userName.value = userName;
  	form1.action = "user_info.jsp";
	form1.submit();
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
  </script>
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="580" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr> 
    <td height="24" colspan="3" align="center" class="right-title">组 织 机 构 图</td>
  </tr>
  <tr> 
    <td width="48" height="87">&nbsp;</td>
    <td width="296">
<%
DeptMgr dm = new DeptMgr();
DeptDb dd = dm.getDeptDb(DeptDb.ROOTCODE);
DeptView tv = new DeptView(dd);
tv.ListFunc(out, "_self", "updateResults", "", "" );
%>
</td>
    <td width="597" align="center" valign="top">
	<div id="resultTable">
	  <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <thead>
        <tr>
          <th width="82" align="left" bgcolor="#B4D3F1">部门</th>
          <th width="75" align="left" bgcolor="#B4D3F1">职员</th>
          <th width="85" align="left" bgcolor="#B4D3F1">查看</th>
        </tr>
      </thead>
      <tbody id="postsbody">
	  <tr>
	    <td colspan="3">请选择部门</td>
	  </tr>
      </tbody>
    </table>
	</div>
	</td>
  </tr>
  <form name="form1" action="" method="post" target="_blank">
  <tr align="center">
    <td height="28" colspan="3">&nbsp;<input name="userName" type="hidden"></td>
  </tr>
  </form>
</table>
</BODY></HTML>
