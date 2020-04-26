<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
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
//-->
</script>
</head>

<body>
<%@ include file="vehicle_inc_apply_top.jsp"%>
<%
String strFlowId = ParamUtil.get(request, "flowId");
int flowId = Integer.parseInt(strFlowId);


VehicleApplyDb vad = new VehicleApplyDb();
vad = vad.getVehicleApplyDb(flowId);
String beginDate = "",endDate = "";

if(vad.getBeginDate() == null){
  beginDate = "";
}else{
  beginDate = DateUtil.format(vad.getBeginDate(), "yyyy-MM-dd HH:mm:ss");
}

if(vad.getEndDate() == null){
  endDate = "";
}else{
  endDate = DateUtil.format(vad.getEndDate(), "yyyy-MM-dd HH:mm:ss");
}

DeptDb dd = new DeptDb();
dd = dd.getDeptDb(vad.getDept());
String dept = dd.getName();
%>
<br>
<table  width="840" border="0" align="center" cellpadding="2" cellspacing="1" class="main">
    <tbody>
      <tr>
        <td height="23" valign="middle" class="right-title" colspan="4"><span>&nbsp;车辆申请详细信息</span></td>
      </tr>
      <tr>
        <td nowrap width="103">车辆牌照：</td>
        <td width="298"><%=vad.getLicenseNo()%></td>
        <td width="69">司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</td>
        <td width="347"><%=vad.getDriver()%></td>
      </tr>
      <tr>
        <td nowrap width="103">用&nbsp;&nbsp;车&nbsp;&nbsp;人：</td>
        <td><%=vad.getPerson()%></td>
        <td>用车部门：</td>
        <td><%=dept%></td>
      </tr>
      <tr>
        <td nowrap>开始日期：</td>
        <td colspan="3"><%=beginDate%></td>
      </tr>
      <tr>
        <td nowrap>结束日期：</td>
        <td colspan="3"><%=endDate%></td>
      </tr>
      <tr>
        <td nowrap width="103">目&nbsp;&nbsp;的&nbsp;&nbsp;地：</td>
        <td colspan="3"><%=vad.getTarget()%></td>
      </tr>
      <tr>
        <td nowrap width="103">里&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;程：</td>
        <td colspan="3"><%=vad.getKilometer()%></td>
      </tr>
      <tr>
        <td nowrap>申&nbsp;&nbsp;请&nbsp;&nbsp;人：</td>
        <td colspan="3"><%=vad.getApplier()%></td>
      </tr>
      <tr>
        <td nowrap>事&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由：</td>
        <td colspan="3"><%=vad.getReason()%></td>
      </tr>
      <tr>
        <td nowrap>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
        <td colspan="3"><%=vad.getRemark()%></td>
      </tr>
      <tr>
        <td nowrap width="103">是否同意：</td>
        <td colspan="3"><%=vad.getResult()%></td>
      </tr>
    </tbody>
</table>
</body>
</html>
