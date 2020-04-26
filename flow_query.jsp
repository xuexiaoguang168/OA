<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="common.css">
<title>流程查询</title>
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

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);
	GetDate = showModalDialog("util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}
</script>
</head>
<body>
<%
String dirCode = ParamUtil.get(request, "dirCode");
if (dirCode.equals("")) {
	out.print(StrUtil.p_center("请选择流程类型！"));
	return;
}
Leaf lf = new Leaf();
lf = lf.getLeaf(dirCode);
if (lf==null || !lf.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "节点不存在！"));
	return;
}
if (lf.getType()==lf.TYPE_NONE)
	return;
FormDb fd = new FormDb();
fd = fd.getFormDb(lf.getFormCode());
%>
<table class="main" cellSpacing="1" width="98%" align="center" border="0">
  <form name="form1" action="flow_query_result.jsp?op=queryFlow" method="post">
    <tbody>
      <tr>
        <td noWrap colSpan="3" class="right-title"><b>工作流程基本信息</b></td>
      </tr>
      <tr>
        <td width="136" noWrap><b>流程类型：</b></td>
        <td colSpan="2">
		  <%=lf.getName()%><input type="hidden" name="typeCode" value="<%=lf.getCode()%>" />		  </td>
      </tr>
      <tr>
        <td noWrap><b>工作流状态：</b></td>
        <td colSpan="2"><select name="status">
            <option value="1000" selected>所有</option>
            <option value="<%=WorkflowDb.STATUS_NOT_STARTED%>">未开始</option>
            <option value="<%=WorkflowDb.STATUS_STARTED%>">处理中</option>
            <option value="<%=WorkflowDb.STATUS_FINISHED%>">已完成</option>
            <option value="<%=WorkflowDb.STATUS_DISCARDED%>">已放弃</option>
          </select></td>
      </tr>
      <tr>
        <td noWrap><b>流程名称：</b></td>
        <td width="89" noWrap><select name="title_cond">
            <option value="0" selected>包含</option>
            <option value="1">等于</option>
        </select></td>
        <td width="253"><input maxLength="100" size="30" name="title"></td>
      </tr>
      <tr>
        <td noWrap><b>流程开始日期：</b></td>
        <td colSpan="2">
		  从 <input size="10" name="fromDate"><img style="CURSOR: hand" onclick="SelectDate('fromDate', 'yyyy-MM-dd')" src="images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 
          至 <input size="10" name="toDate"><img style="CURSOR: hand" onclick="SelectDate('toDate', 'yyyy-MM-dd')" src="images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">		</td>
      </tr>
      <tr>
        <td noWrap><b>流程结束日期：</b></td>
        <td colSpan="2">从
          <input size="10" name="fromEndDate" />
          <img style="CURSOR: hand" onclick="SelectDate('fromEndDate', 'yyyy-MM-dd')" src="images/form/calendar.gif" align="absmiddle" border="0" width="26" height="26" /> 至
          <input size="10" name="toEndDate" />
        <img style="CURSOR: hand" onclick="SelectDate('toEndDate', 'yyyy-MM-dd')" src="images/form/calendar.gif" align="absmiddle" border="0" width="26" height="26" /> </td>
      </tr>
      
      <tr class="TableControl" align="middle">
        <td colSpan="3" align="center" noWrap><input class="BigButton"  type="submit" value="查询">&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="reset" value="重设" name="back1"></td>
      </tr>
  </form>
	  <form method="post" name=form2 action="flow_query_result.jsp?op=queryForm">
      <tr>
        <td class="TableHeader" noWrap colSpan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr class="TableLine2">
		    <td colspan="3"><b>表单数据信息（表单名称：<%=fd.getName()%>）</b>   		  	</td>
	      </tr>
            <%
			Iterator ir = fd.getFields().iterator();
			while (ir.hasNext()) {
				FormField ff = (FormField)ir.next();
			%>
		  <tr class="TableLine2">
            <td width="29%"><%=ff.getTitle()%>：</td>
		    <td width="19%" nowrap="nowrap">
			  <%if (ff.getType().equals(ff.TYPE_DATE) || ff.getType().equals(ff.TYPE_DATE_TIME)) {%>
				从 <input size="10" name="<%=ff.getName()%>FromDate"><img style="CURSOR: hand" onclick="SelectDate('<%=ff.getName()%>FromDate', 'yyyy-MM-dd')" src="images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 
		  	  <%}else{%>
				<select name="<%=ff.getName()%>_cond">
				  <option value="1">等于</option>
				  <%if (ff.getType().equals(ff.TYPE_TEXTFIELD) || ff.getType().equals(ff.TYPE_TEXTAREA) || ff.getType().equals(ff.TYPE_MACRO)) {%>
				  <option value="0" selected>包含</option>
				  <%}%>
				</select>
			 <%}%>			</td>
		    <td width="52%">
			<%if (ff.getType().equals(ff.TYPE_DATE) || ff.getType().equals(ff.TYPE_DATE_TIME)) {%>
          		至 <input size="10" name="<%=ff.getName()%>ToDate"><img style="CURSOR: hand" onclick="SelectDate('<%=ff.getName()%>ToDate', 'yyyy-MM-dd')" src="images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">
			<%}else{%>
				<input name="<%=ff.getName()%>" />
			<%}%>
		    (<%=ff.getTypeDesc()%>)			</td>
	      </tr>
		  <%}%>
        </table></td>
      </tr>
      <tr class="TableControl" align="middle">
        <td colSpan="3" align="center" noWrap><input class="BigButton"  type="submit" value="查询">&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="hidden" name="typeCode" value="<%=lf.getCode()%>" /></td>
      </tr>
    </tbody>
  </form>
</table>
</body>
</html>
