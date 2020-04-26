<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.officeequip.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>办公用品入库登记</title>
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
<%
  String strTypeId = ParamUtil.get(request, "typeId");
  String strEquipId =ParamUtil.get(request, "equipId");
  String equipId1 = "";
  String officeN = "";
%>
<script>
var oldTypeId = "<%=strTypeId%>";
function getOfficeEquipOfType(typeId) {
	if (typeId=="") {
		alert("请选择类别");
		form1.typeId.value = oldTypeId;
		return;
	}	
	window.location.href = "?typeId=" + typeId + "&equipId=" + oldEquipId;
}

var oldEquipId = "<%=strEquipId%>";
function setEquipName(equipName) {
	form1.officeName.value = equipName;
}
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="officeequip";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	OfficeMgr bm = new OfficeMgr();
	boolean re = false;
	try {
		  re = bm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<%@ include file="officeequip_inc_menu_top.jsp"%>
<br>
<table width="559" border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
<form action="?op=add" name="form1" method="post">
<tr>
  <td colspan="4" class="right-title">办公用品入库登记</td>
  </tr>
<tr>
 <td width="64" bgcolor="#FFFFFF">用品类别：</td>
 <td width="163" bgcolor="#FFFFFF"><%
	  OfficeTypeDb otd = new OfficeTypeDb();
	  String opts = "";
	  Iterator ir = otd.list().iterator();
	  while (ir.hasNext()) {
	  	 otd = (OfficeTypeDb)ir.next();
	  	 opts += "<option value='" + otd.getId() + "'>" + otd.getName() + "</option>";
	  }
	  %>
   <select name="typeId" id="typeId" onChange="getOfficeEquipOfType(form1.typeId.value)" >
     <option selected>-----请选择-----</option>
     <%=opts%>
   </select>
   <script>
	  form1.typeId.value = "<%=strTypeId%>";
   </script>	
   <font color=red>*</font></td>
 <td width="99" bgcolor="#FFFFFF">办公用品名称：</td>
 <td width="215" bgcolor="#FFFFFF"><%
	  String opts1 = "";
	  int total =0 ;
	  OfficeDb od = new OfficeDb();
	  OfficeDb odb = new OfficeDb();
	  if (!strTypeId.equals("")) {
		  String sql = "select id from office_equipment where typeId=" + strTypeId;
		  Iterator ir1 = od.list(sql).iterator();
		  while (ir1.hasNext()) {
			 od = (OfficeDb)ir1.next();
			 opts1 += "<option value='" + od.getId() + "'>" + od.getOfficeName() + "</option>";
		     total += od.getStorageCount();
			 equipId1 = ParamUtil.get(request, "equipId") ; 
	       if (equipId1 == "")
	            equipId1 = Integer.toString(od.getId());
			odb = odb.getOfficeDb(StrUtil.toInt(equipId1));	
			officeN = odb.getOfficeName();	
		  }
	  }
	  %>
   <script>
	  </script>
   <font color=red>
   <input name="officeName" type="text" id="officeName" value="" size="10" maxlength="100" >
   </font>
     	  
   <font color=red>*   
   <select name="equipId" id="equipId" onChange="setEquipName(form1.equipId.options(form1.equipId.selectedIndex).text)">
     <option value = 0 selected>-----请选择-----</option>
     <%=opts1%>
   </select>
   </font></td>    	  
</tr>
<tr>
  <td bgcolor="#FFFFFF">计量单位：</td>
  <td bgcolor="#FFFFFF"><font color=red>
  <%
	  OfficeTypeDb otdb = new OfficeTypeDb();
	  String unitId = ParamUtil.get(request, "typeId") ; 
	  if (unitId == "")
	     unitId = "1";
	  otdb = otdb.getOfficeTypeDb(StrUtil.toInt(unitId));
	  String unit;
	  unit = otdb.getUnit();
	  if (unit ==null)
	    unit = "";
	%>
  <input name="measureUnit" type="text" id="measureUnit" value="<%=unit%>" size="10" maxlength="100">
  *  </font></td>
  <td bgcolor="#FFFFFF">用品数量：</td>
  <td bgcolor="#FFFFFF"><font color=red>
    <input name="storageCount" type="text" id="storageCount"value="" size="10" maxlength="100">
  *</font></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF">价格：(￥)</td>
  <td bgcolor="#FFFFFF"><input name="price" type="text" id="price" value="<%=od.getPrice()%>" size="10" maxlength="100">
    <font color=red>*</font></td>
 <td bgcolor="#FFFFFF">供&nbsp;&nbsp;应&nbsp;&nbsp;商：</td>
  <td bgcolor="#FFFFFF"><input name="buyPerson" type="text" id="buyPerson"value="" size="20" maxlength="100"></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF">购置时间：</td>
  <td bgcolor="#FFFFFF">
  <%
   Date d = new Date();
   String dt = DateUtil.format(d, "yyyy-MM-dd");
  %>
    <input name="buyDate" type="text" id="buyDate"value="<%=dt%>" size="10" maxlength="100">
    <img style="CURSOR: hand" onClick="SelectDate('buyDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
 <td bgcolor="#FFFFFF">&nbsp;</td>
  <td bgcolor="#FFFFFF">&nbsp;</td>
</tr><tr>
  
  <td colspan="4" align="center">
     <input name="submit" type="submit" class="button1"  value=" 确  定 " > 
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     <input type="reset" class="button1"  value=" 重  置 " >  </td>
</tr>
</form>
</table>
</body>
</html>
