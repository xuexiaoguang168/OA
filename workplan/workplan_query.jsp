<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.workplan.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工作计划类型管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
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

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);
	GetDate = showModalDialog("../util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%@ include file="workplan_inc_menu_top.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="workplan";
if (!privilege.isUserPrivValid(request, priv)) {
	// out.println(fchar.makeErrMsg("对不起，您不具有发布工作计划的权限！"));
	// return;
}
%>
<br>
<table class="main" cellSpacing="1" cellPadding="2" width="600" align="center" border="0">
<form action="workplan_list.jsp?op=search" name="form1" method="post">
  <tbody>
    <tr>
      <td colspan="2" noWrap class="right-title">查询计划</td>
    </tr>
    <tr>
      <td width="15%" noWrap class="TableContent">计划名称：</td>
      <td width="85%" class="TableData"><input name="title" id="title" size="26" maxLength="80"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划内容：</td>
      <td class="TableData"><input name="content" id="content" size="36" maxLength="200"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>有效期：</td>
      <td class="TableData">开始日期：
           <input name="beginDate" id="beginDate" size="10">
           <img style="CURSOR: hand" onClick="SelectDate('beginDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">之后（为空表示不限制）<br>
        结束日期： 
        <input name="endDate" id="endDate" size="10">
        <img style="CURSOR: hand" onClick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">之前（为空表示不限制）</td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划类型：</td>
      <td class="TableData">
	  <%
	  WorkPlanTypeDb wptd = new WorkPlanTypeDb();
	  String opts = "";
	  Iterator ir = wptd.list().iterator();
	  while (ir.hasNext()) {
	  	wptd = (WorkPlanTypeDb)ir.next();
	  	opts += "<option value='" + wptd.getId() + "'>" + wptd.getName() + "</option>";
	  }
	  %>
	  <select name="typeId" id="typeId">
	  <option value="all">全部</option>
	  <%=opts%>
      </select>	  </td>
    </tr>
    
    <tr class="TableControl" align="middle">
      <td colSpan="2" align="center" noWrap><input name="submit" type="submit" value="提交">
        &nbsp;&nbsp;
          <input name="button" type="reset" value="重填">
        &nbsp;&nbsp;</td>
    </tr>
  </tbody>
  </form>
</table>
</body>
</html>
