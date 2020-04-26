<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.meeting.*"%>
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
<%@ include file="boardroom_inc_apply_top.jsp"%>
<%
String strFlowId = ParamUtil.get(request, "flowId");
int flowId = Integer.parseInt(strFlowId);


BoardroomApplyDb bad = new BoardroomApplyDb();
bad = bad.getBoardroomApplyDb(flowId);
String beginDate = "";
if(bad.getStart_date() == null){
  beginDate = "";
}else{
  beginDate = DateUtil.format(bad.getStart_date(), "yy-MM-dd HH:mm");
}

String endDate = "";

if(bad.getEnd_date() == null){
  endDate = "";
}else{
  endDate = DateUtil.format(bad.getEnd_date(), "yy-MM-dd HH:mm");
}

String applyDate = "";
if(bad.getApply_date() == null){
  applyDate = "";
}else{
  applyDate = DateUtil.format(bad.getApply_date(), "yy-MM-dd HH:mm");
}

String hyshi = "";
if(!bad.getHyshi().equals("")){
	BoardroomDb bd = new BoardroomDb();
	bd = bd.getBoardroomDb(Integer.parseInt(bad.getHyshi()));
	hyshi = bd.getName();
}
%>
<form action="vehicle_maintenance_do.jsp?op=modify" method="post" name="form1">
<table  width="840" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#FFFFFF" class="tableframe">
    <tbody>
      <tr>
        <td height="23" valign="middle" class="right-title" colspan="4"><span>&nbsp;会议详细信息</span></td>
      </tr>
      <tr>
        <td nowrap width="103">申&nbsp;&nbsp;请&nbsp;&nbsp;人：</td>
        <td width="344"><%=bad.getSqren()%></td>
        <td width="78">参会人数：</td>
        <td width="292"><%=bad.getChrs()%></td>
      </tr>
      <tr>
        <td nowrap width="103">会议名称：</td>
        <td colspan="3"><%=bad.getMeetingTitle()%></td>
      </tr>
      <tr>
        <td nowrap>会&nbsp;&nbsp;议&nbsp;&nbsp;室：</td>
        <td colspan="3"><%=hyshi%></td>
      </tr>
      <tr>
        <td nowrap>申请日期：</td>
        <td colspan="3"><%=applyDate%></td>
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
        <td nowrap width="103">会议内容：</td>
        <td colspan="3"><%=bad.getHycontent()%></td>
      </tr>
      <tr>
        <td nowrap width="103">参会人员:</td>
        <td colspan="3"><%=bad.getChrenyuan()%></td>
      </tr>
      <tr>
        <td nowrap>审批意见</td>
        <td colspan="3"><%=bad.getSpyjian()%></td>
      </tr>
      <tr>
        <td nowrap width="103">审批结果：</td>
        <td colspan="3"><%=bad.getResult()%></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
