<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
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
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "vehicle")) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<form action="vehicle_maintenance_do.jsp?op=add" method="post" name="form1">
  <table  width="602" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#FFFFFF" class="tableframe">
    <tbody>
      <tr>
        <td height="23" valign="middle" class="right-title" colspan="4"><span>&nbsp;车辆维护记录</span></td>
      </tr>
      <tr>
        <td nowrap width="103">车&nbsp;&nbsp;牌&nbsp;&nbsp;号：</td>
        <td width="150">
		<select name="licenseNo">
<%
		VehicleDb vd = new VehicleDb();
		String sql = "select licenseNo from vehicle";
		Iterator ir = vd.list(sql).iterator();
		while (ir.hasNext()) {
			vd = (VehicleDb)ir.next();
%>
			<option value="<%=vd.getLicenseNo()%>"><%=vd.getLicenseNo()%></option>
<%}%>
        </select>
		
		</td>
        <td width="60">维护类型：</td>
        <td width="266"><select name="type">
            <option value="0" selected>维修</option>
            <option value="1">加油</option>
            <option value="2">洗车</option>
            <option value="3">年检</option>
            <option value="4">其它</option>
        </select></td>
      </tr>
      <tr>
        <td nowrap width="103">维护开始日期：</td>
        <td colspan="3"><input name="beginDate" size="20">
            <img style="CURSOR: hand" onClick="SelectDate('beginDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td nowrap>维护结束日期：</td>
        <td colspan="3"><input name="endDate" size="20">
            <img style="CURSOR: hand" onClick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td nowrap width="103">维护原因：</td>
        <td colspan="3"><textarea name="cause" cols="60"></textarea>
        </td>
      </tr>
      <tr>
        <td nowrap width="103">经&nbsp;&nbsp;办&nbsp;&nbsp;人：</td>
        <td><input maxlength="100" size="20" name="transactor">
        </td>
        <td nowrap width="60">维护费用：</td>
        <td width="266"><input maxlength="25" size="20" name="expense">
        </td>
      </tr>
      <tr>
        <td nowrap width="103">备　　注：</td>
        <td colspan="3"><textarea name="remark" cols="60"></textarea>
        </td>
      </tr>
      <tr>
        <td nowrap align="center" colspan="4"><input name="submit" type="submit" value="保存">
          
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="reset" type="reset" value="重填">        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
