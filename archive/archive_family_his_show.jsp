<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人事档案管理</title>
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

function setPerson(deptCode, deptName, user, userRealName)
{
	form1.userName.value = user;
	form1.userRealName.value = userRealName;
}
//-->
</script>
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	String userName = ParamUtil.get(request,"userName");
	if (!privilege.isUserPrivValid(request, "archive.his")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<%@ include file="archive_inc_his_menu_top.jsp"%>
<%
	String strId = ParamUtil.get(request, "id");
	if (!StrUtil.isNumeric(strId)) {
		out.println(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.module.archive","warn_id_err_archive")));
		return;
	}
	int id = Integer.parseInt(strId);
	
	UserFamilyHisDb ufhd = new UserFamilyHisDb();
	ufhd = ufhd.getUserFamilyHisDb(id);
	
	UserInfoHisDb uihd = new UserInfoHisDb();
	String userRealName = uihd.getUserRealName(ufhd.getUserName());	
	
	UserDb ud = new UserDb();
	ud = ud.getUserDb(ufhd.getOperator());
	String operator = ud.getRealName();
%>
<br>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
    <tbody>
	<tr>
		<td colspan="3" class="right-title">修改家庭信息</td>
	</tr>
	<tr>
		<td width="80" noWrap>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</td>
		<td colSpan="2"><%=userRealName%>
	</td>
	</tr>
	<tr>
		<td noWrap>称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;谓：</td>
		<td colSpan="2"><%=ufhd.getAppellation()%></td>
	</tr>
	<tr>
		<td noWrap>成员姓名：</td>
		<td colSpan="2"><%=ufhd.getName()%></td>
	</tr>
	<tr>
		<td noWrap>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：</td>
		<td colSpan="2"><%=ufhd.getAge()%></td>
	</tr>
	<tr>
		<td noWrap>政治面貌：</td>
		<td colSpan="2"><%=ufhd.getPolitic()%></td>
	</tr>
	<tr>
		<td noWrap>工作单位：</td>
		<td colSpan="2"><%=ufhd.getUnit()%></td>  
	</tr>
	<tr>
		<td noWrap>联系地址：</td>
		<td colSpan="2"><%=ufhd.getAddress()%></td>
	</tr>
	<tr>
		<td noWrap>联系电话：</td>
		<td colSpan="2"><%=ufhd.getPhone()%></td>
	</tr>
	<tr>
		<td noWrap>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
		<td colSpan="2"><%=ufhd.getRemark()%></td>
	</tr>
	<tr>
		<td class="TableContent" noWrap>操作人：</td>
		<td class="TableData"><%=operator%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作类型：</td>
	  <td class="TableData"><%=ufhd.getOperateType()%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作时间：</td>
	  <td class="TableData"><%=ufhd.getAddDate()%></td>
	</tr>
  </tbody>
</table>
</body>
</html>
