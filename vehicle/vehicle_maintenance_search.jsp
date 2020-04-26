<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
</head>

<body>
<table class="tableframe" cellSpacing="1" cellPadding="2" width="840" align="center" border="0">
  <form name="form1" action="vehicle_maintenance_list.jsp?op=search" method="post">
    <tbody>
      <tr>
        <td noWrap colSpan="2" class="right-title">请指定查询条件：</td>
      </tr>
      <tr>
        <td noWrap width="80">车&nbsp;&nbsp;牌&nbsp;&nbsp;号：</td>
        <td width="470"><select name="licenseNo">
<%
		VehicleDb vd = new VehicleDb();
		String sql = "select licenseNo from vehicle";
		Iterator ir = vd.list(sql).iterator();
		while (ir.hasNext()) {
			vd = (VehicleDb)ir.next();
%>
			<option value="<%=vd.getLicenseNo()%>"><%=vd.getLicenseNo()%></option>
<%}%>
        </select></td>
      </tr>
      <tr>
        <td noWrap>维护日期：</td>
        <td><input maxLength="10" size="20" name="beginDate"> 
          <img style="CURSOR: hand" onClick="SelectDate('beginDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 日期格式形如 1999-1-2 
          &nbsp;至 <input maxLength="10" size="20" name="endDate"><img style="CURSOR: hand" onClick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 日期格式形如 1999-1-2 </td>
      </tr>
      <tr>
        <td noWrap>维护类型：</td>
        <td><select name="type">
            <option value selected></option>
            <option value="0">维修</option>
            <option value="1">加油</option>
            <option value="2">洗车</option>
            <option value="3">年检</option>
            <option value="4">其它</option>
          </select></td>
      </tr>
      <tr>
        <td noWrap>维护原因：</td>
        <td><input maxLength="200" size="30" name="cause"></td>
      </tr>
      <tr>
        <td noWrap>经&nbsp;&nbsp;办&nbsp;&nbsp;人：</td>
        <td><input maxLength="200" size="20" name="transactor"></td>
      </tr>
      <tr>
        <td noWrap>维护费用：</td>
        <td><input maxLength="200" size="20" name="expense"></td>
      </tr>
      <tr>
        <td noWrap>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
        <td><input maxLength="200" size="30" name="remark"></td>
      </tr>
      <tr align="middle">
        <td noWrap colSpan="2"><input type="submit" value="查询">&nbsp;&nbsp; 
          <input type="reset" value="重填"></td>
      </tr>
    </tbody> 
  </FORM>
</table>
</body>
</html>
