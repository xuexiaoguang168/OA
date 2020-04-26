<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>车辆信息编辑</title>
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
<%
String oldLicenseNo = ParamUtil.get(request, "licenseNo");
VehicleMgr vm = new VehicleMgr();
VehicleDb vd = null;
try {
	vd = vm.getVehicleDb(oldLicenseNo);
}
catch (ErrMsgException e) {
	out.print(SkinUtil.makeErrMsg(request, e.getMessage()));
	return;
}

String buyDate = DateUtil.format(vd.getBuyDate(), "yyyy-MM-dd");
%>
<%@ include file="vehicle_inc_menu_top.jsp"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "vehicle")) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<br>
<table width="70%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
    <tbody>
	  <tr>
		<td colspan="3" class="right-title">车辆信息</td>
	  </tr>
      <tr>
        <td noWrap width="80">车牌号：</td>
        <td><%=vd.getLicenseNo()%><input type="hidden" name="licenseNo" value="<%=vd.getLicenseNo()%>">
        <input type="hidden" name="oldLicenseNo" value="<%=oldLicenseNo%>"></td>
        <td width="250" rowSpan="6"><%if(vd.getImage().equals("")){%><center>暂无照片</center><%}else{%><img src="../<%=vd.getImage()%>"><%}%></td>
      </tr>
      <tr>
        <td noWrap>厂牌型号：</td>
        <td><%=vd.getBrand()%></td></tr>
      <tr>
        <td noWrap>发动机号：</td>
        <td><%=vd.getEngineNo()%></td></tr>
      <tr>
        <td noWrap>车辆类型：</td>
        <td><select name="type">
			<%
			  VehicleTypeDb vtd = new VehicleTypeDb();
			  String sql = "select id from vehicle_type";
			  Iterator ir = vtd.list(sql).iterator();
			  while (ir.hasNext()) {
			  	vtd = (VehicleTypeDb)ir.next();
			%>
			<option value="<%=vtd.getId()%>" <%if(vd.getType()==vtd.getId()){%> selected <%}%>><%=vtd.getDescription()%></option>
			<%}%>
          </select></td>
      </tr>
      <tr>
        <td noWrap>驾驶员：</td>
        <td><%=vd.getDriver()%></td></tr>
      <tr>
        <td noWrap>购买价格：</td>
        <td><%=vd.getPrice()%></td></tr>
      
      <tr>
        <td noWrap>购买日期：</td>
        <td colSpan="2"><%=buyDate%></td>  
      </tr>
      <tr>
        <td noWrap>当前状态：</td>
        <td colSpan="2"><select name="state">
            <option value="0" <%if(vd.getState() == 0){%> selected <%}%>>可用</option>
            <option value="1" <%if(vd.getState() == 1){%> selected <%}%>>损坏</option>
            <option value="2" <%if(vd.getState() == 2){%> selected <%}%>>报废</option>
          </select></td>
      </tr>
      <tr>
        <td noWrap>备注：</td>
        <td colSpan="2"><%=vd.getRemark()%></td>
      </tr>
    </tbody>
</table>
</body>
</html>
