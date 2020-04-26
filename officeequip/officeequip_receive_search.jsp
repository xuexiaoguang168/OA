<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.SkinUtil"%>
<%@ page import = "com.redmoon.oa.officeequip.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%
String strTypeId = ParamUtil.get(request, "typeId");
String strEquipId =ParamUtil.get(request, "equipId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>办公用品领用查询</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #313031}
.STYLE4 {color: #0033FF}
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

function setPerson(deptCode, deptName, user)
{
	form1.person.value = user;
}
//-->
</script>
<script>
var oldTypeId = "<%=strTypeId%>";
function getOfficeEquipOfType(typeId) {
	if (typeId=="") {
		alert("请选择类别");
		form1.typeId.value = oldTypeId;
		return;
	}	
	window.location.href = "?typeId=" + typeId;
}

var oldEquipId = "<%=strEquipId%>";
function getEquipOfType(equipId) {
	if (equipId=="") {
		alert("请选择类别");
		form1.equipId.value = oldEquipId;
		return;
	}	
	window.location.href = "?equipId=" + equipId + "&typeId=" + oldTypeId;
}
</script>
</head>
<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "officeequip";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%@ include file="officeequip_inc_menu_top.jsp"%>
<br>
<table width="787" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
<form action="officeequip_receive_list.jsp?op=search" name="form1" method="post">
<tr>
  <td colspan="4" class="right-title" > &nbsp;&nbsp;办公领用查询 </td>
</tr>
<tr align="left">
  <td colspan="4" ><table width="805" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#8F95CF" bgcolor="#9CCFCE"  >
    <tr align="left">
      <td width="84" bgcolor="#FFFFFF">用品类别：</td>
      <td width="171" bgcolor="#FFFFFF" ><%
	  OfficeTypeDb otd = new OfficeTypeDb();
	  String opts = "";
	  Iterator ir = otd.list().iterator();
	  while (ir.hasNext()) {
	  	 otd = (OfficeTypeDb)ir.next();
	  	 opts += "<option value='" + otd.getId() + "'>" + otd.getName() + "</option>";
	  }
	  %>
        <select name="typeId" id="typeId" onChange="getOfficeEquipOfType(form1.typeId.value)">
          <option value="" selected>-----请选择-----</option>
          <%=opts%>
        </select></td>
      <td width="99" bgcolor="#FFFFFF" >用品名称：</td>
      <td width="165" bgcolor="#FFFFFF"><%
	  String opts1 = "";
	  int total =0 ;
	  OfficeDb od = new OfficeDb();
	  if (!strTypeId.equals("")) {
		  String sql = "select id from office_equipment where typeId=" + strTypeId;
		  Iterator ir1 = od.list(sql).iterator();
		  while (ir1.hasNext()) {
			 od = (OfficeDb)ir1.next();
			 opts1 += "<option value='" + od.getId() + "'>" + od.getOfficeName() + "</option>";
		     total += od.getStorageCount();
		  }
	  }
	  %>
        <select name="equipId" id="equipId" onChange="getEquipOfType(form1.equipId.value)">
        <option selected>-----请选择-----</option>
        <%=opts1%>
      </select></td>
      <td width="68" bgcolor="#FFFFFF">领用人：</td>
      <td width="187" bgcolor="#FFFFFF"><input name="person" type="text" id="person" size="20">
        &nbsp;<a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择用户</a></td>
    </tr>	
    <tr align="left">
      <td bgcolor="#FFFFFF" ><script>
	  form1.typeId.value = "<%=strTypeId%>";
	  </script>
	     开始时间：</td>
      <td bgcolor="#FFFFFF"  ><input  name="beginDate" type="text"size="20">
        &nbsp;&nbsp;<img style="CURSOR: hand" onClick="SelectDate('beginDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
      <td bgcolor="#FFFFFF"><script>
	  form1.equipId.value = "<%=strEquipId%>";
	  </script>	  
       结束时间：</td>
      <td bgcolor="#FFFFFF" ><input name="endDate" type="text" id="endDate" size="20">
        <img style="CURSOR: hand" onClick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  </table></td>
  </tr>

 <tr> 
  <td colspan="4" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input name="submit" type="submit" class="button1"  value=" 查 询 " ></td>
</tr>
</form>
</table>
</body>
</html>
