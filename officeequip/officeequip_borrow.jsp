<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.SkinUtil"%>
<%@ page import = "com.redmoon.oa.officeequip.*"%>
<%
String strTypeId = ParamUtil.get(request, "typeId");
String strEquipId =ParamUtil.get(request, "equipId");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用品领用</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #313031}
-->
</style>
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
if (op.equals("chageStorageCount")) {
	OfficeMgr om = new OfficeMgr();
	OfficeOpMgr oo = new OfficeOpMgr();
	boolean re = false;
	boolean fe = false;
	try {
		  re = om.chageStorageCount(request);
		  fe = oo.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (fe && re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "officeequip_receive.jsp"));
}
Date d = new Date();
String dt = DateUtil.format(d, "yyyy-MM-dd");
%>
<%@ include file="officeequip_inc_menu_top.jsp"%>
<br>
<table width="360" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
<form action="?op=chageStorageCount" name="form1" method="post">
<tr>
  <td width="938" colspan="4" class="right-title" > &nbsp;&nbsp;用品借出登记 </td>
</tr>
<tr>
  <td colspan="4" ><table width="357" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#8F95CF" bgcolor="#9CCFCE"  >
    <tr>
      <td width="95" align="center" bgcolor="#FFFFFF">用品类别：</td>
      <td width="251" align="left" bgcolor="#FFFFFF" ><%
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
      </select>
        <input name=type type="hidden" value="<%=1%>">
      </td>
      </tr>	
    <tr>
      <td align="center" bgcolor="#FFFFFF" >用品名称：</td>
      <td align="left" bgcolor="#FFFFFF"><%
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
        <option value="" selected>-----请选择-----</option>
        <%=opts1%>
      </select></td>
      </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF" >库存数量：</td>
      <td align="left" bgcolor="#FFFFFF"><%
	  if (!strEquipId.equals("")) {
	  	int equipId = Integer.parseInt(strEquipId);
	  	od = od.getOfficeDb(equipId);
		total = od.getStorageCount();
	  }
	  %>
        <%=total%> </td>
      </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF" ><script>
	  form1.typeId.value = "<%=strTypeId%>";
	  </script>	    	  
      借用数量：</td>
      <td align="left" bgcolor="#FFFFFF"><script>
	  form1.equipId.value = "<%=strEquipId%>";
	  </script>	  <input name="storageCount" type="text" id="storageCount" size="20"></td>
      </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF" >借&nbsp;&nbsp;用&nbsp;&nbsp;人：</td>
      <td align="left" bgcolor="#FFFFFF"><input name="person" type="text" id="person" size="20">
        &nbsp;<a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择用户</a></td>
      </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF" >借出时间：</td>
      <td align="left" bgcolor="#FFFFFF"><input  name="opDate" type="text" value="<%=dt%>" size="20">
        <img style="CURSOR: hand" onClick="SelectDate('opDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
      </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF" >备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
      <td align="left" bgcolor="#FFFFFF"><textarea  name="abstracts"  id="abstracts" style="width:90%" rows="5"></textarea></td>
    </tr>
  </table></td>
  </tr>

 <tr> 
  <td colspan="4" align="center">
     <input name="submit" type="submit" class="button1"  value="提  交" > 
     &nbsp;</td>
</tr>
</form>
</table>
</body>
</html>
