<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.SkinUtil"%>
<%@ page import = "com.redmoon.oa.officeequip.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../common.css" rel="stylesheet" type="text/css">
<title>办公用品归还</title>
</head>
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
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "officeequip";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

  int id = ParamUtil.getInt(request, "id");
  OfficeOpDb ood = new OfficeOpDb();
  ood = ood.getOfficeOpDb(id);
  int officeId = ood.getOfficeId();
  OfficeDb odb = new OfficeDb();
  odb = odb.getOfficeDb(officeId);
  int typeId = odb.getTypeId();
  OfficeTypeDb otd = new OfficeTypeDb();
  otd = otd.getOfficeTypeDb(typeId);
%>
<%      
        OfficeOpMgr oom = new OfficeOpMgr();
		OfficeMgr   om = new OfficeMgr();
		String op = ParamUtil.get(request, "op");
		boolean re = false;
		boolean fe = false;
		if (op.equals("return")) {
			try {
				re = oom.returnOfficeEquip(request);
				fe = om.returnChageStorageCount(request);	
			}
			catch (ErrMsgException e) {
				out.print(StrUtil.Alert_Back(e.getMessage()));
			}
			if (fe) {
%>			
	<script>
	  window.close();
	  window.opener.location.reload();
	</script>
<%	
			}
		}
%>	
<form method="post" action="?op=return" name="form1" >
<table width="100%" height="180" border="1" align="center" cellpadding="4" cellspacing="0" bordercolorlight="#000000" bordercolordark="#ffffff">
  <tbody>
    <tr>
      <td  nowrap="nowrap"align="right" width="15%">用品类别：</td>
      <td  nowrap="nowrap"width="35%"><%=odb.getOfficeName()%><input name="id" value="<%=ood.getId()%>" type=hidden></td>
      <td  nowrap="nowrap"align="right" width="15%">用品名称：</td>
      <td  nowrap="nowrap"width="35%"><%=otd.getName()%></td>
    </tr>
    <tr>
      <td nowrap="nowrap" align="right">数量：</td>
      <td nowrap="nowrap"><%=ood.getCount()%><input name="officeId" value="<%=ood.getOfficeId()%>" type=hidden>
        <input name="count" value="<%=ood.getCount()%>" type="hidden" /></td>
      <td nowrap="nowrap" align="right">借用时间：</td>
      <td nowrap="nowrap"><%=ood.getOpDate()%></td>
    </tr>
    <tr>
      <td nowrap="nowrap" align="right">借用人：</td>
      <td nowrap="nowrap"> <%=ood.getPerson()%></td>
      <td nowrap="nowrap" align="right">归还时间：</td>
      <td nowrap="nowrap"> 
	  <%
	  Date d = new Date();
	  String dt = DateUtil.format(d, "yyyy-MM-dd");;
     %>
        <input name="endDate" type="text" id="endDate" size="20" value = "<%=dt%>"/>
        <img style="CURSOR: hand" onclick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absmiddle" border="0" width="26" height="26" /></td>
    </tr>
    <tr>
      <td height="62" align="right">备注：</td>
      <td colspan="3"><textarea  name="abstracts"  id="abstracts" style="width:100%" rows="8"></textarea></td>
    </tr>
  </tbody>
</table>

<p align="center"><input name="submit" type="submit" class="button1"  value="提  交" ></p>
</form>
</body>
</html>
