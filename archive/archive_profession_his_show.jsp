<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加专业修改</title>
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

function chkContent(){
   if(form1.userName.value == ""){
     alert("用户名不能为空！")
	 form1.userName.focus();
	 return false
   }
}
function setPerson(deptCode, deptName, user, userRealName)
{
	form1.userName.value = user;
	form1.userRealName.value = userRealName;
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	String userName = ParamUtil.get(request,"userName");
	if (!privilege.isUserPrivValid(request, "archive.his")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%@ include file="archive_inc_his_menu_top.jsp"%>
<%
	String strId = ParamUtil.get(request, "id");
	if (!StrUtil.isNumeric(strId)) {
		out.println(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.module.archive","warn_id_err_archive")));
		return;
	}
	int id = Integer.parseInt(strId);
	
	UserProfessionHisDb udhb = new UserProfessionHisDb();
	udhb = udhb.getUserProfessionHisDb(id);
	
	UserInfoHisDb uihd = new UserInfoHisDb();
	String userRealName = uihd.getUserRealName(udhb.getUserName());	
	
	UserDb ud = new UserDb();
	ud = ud.getUserDb(udhb.getOperator());
	String operator = ud.getRealName();
%>
<br>
<table class="main" cellSpacing="1" cellPadding="2" width="600" align="center" border="0">
  <tbody>
    <tr>
      <td colspan="2" noWrap class="right-title">修改专业技能信息</td>
    </tr>
    <tr>
      <td width="12%" noWrap class="TableContent">用户名称：</td>
      <td width="88%" class="TableData"><%=userRealName%></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>专业技术职务：</td>
      <td class="TableData"><%=udhb.getProfession()%>
    </tr>
    <tr>
      <td class="TableContent" noWrap>证书名称：</td>
      <td class="TableData"><%=udhb.getName()%></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>证书编号：</td>
      <td class="TableData"><%=udhb.getCnum()%></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>获取时间：</td>
      <td class="TableData"><%=udhb.getMyDate()%></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>专长：</td>
      <td class="TableData"><%=udhb.getSpecial()%></td>
    </tr>   
    <tr>
      <td class="TableContent" noWrap>备注：</td>
      <td class="TableData"><%=udhb.getRemark()%></td>
    </tr>
		<tr>
		<td class="TableContent" noWrap>操作人：</td>
		<td class="TableData"><%=operator%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作类型：</td>
	  <td class="TableData"><%=udhb.getOperateType()%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作时间：</td>
	  <td class="TableData"><%=udhb.getAddDate()%></td>
	</tr>
  </tbody>
  </form>
</table>
</body>
</html>
