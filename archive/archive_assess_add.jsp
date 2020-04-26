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
<title>考核添加</title>
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
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<% 
	String userName = StrUtil.getNullStr(ParamUtil.get(request,"userName"));
    if (!privilege.isUserPrivValid(request, "archive.assess")||!archivePrivilege.canAdminUser(request,userName)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	
	String op = ParamUtil.get(request,"op");
	if (op.equals("add")) {
	   UserAssessMgr uam = new UserAssessMgr();
	   boolean re = false;
	   try {  
		 re = uam.create(request);
	   }
	   catch(ErrMsgException e){
		 out.print(StrUtil.Alert(e.getMessage()));
	   }
	   if (re) {
		 out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_add_assess"),"archive_assess_list.jsp?userName=" + userName));
	   } 
	}
%>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%@ include file="archive_inc_menu_top.jsp"%>
<%
	UserInfoDb uid = new UserInfoDb();
	uid = uid.getUserInfoDb(userName);
	String userRealName = uid.getUserRealName();
	
	BasicDataMgr bdm = new BasicDataMgr("archive");
	String options = "";
%>
<br>
<table class="main" cellSpacing="1" cellPadding="2" width="600" align="center" border="0">
<form action="?op=add" name="form1" method="post">
  <tbody>
    <tr>
      <td colspan="2" noWrap class="right-title">添加考核信息</td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>用户名称：</td>
        <td colSpan="2"><input maxLength="100" name="userRealName" size="20" readonly value="<%=userRealName%>"><input name="userName" type="hidden" value="<%=userName%>"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>考核年度：</td>
      <td class="TableData"><input name="assessYear" id="assessYear" size="36" maxlength="200"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>考核情况：</td>
      <td class="TableData"><input name="info" id="info" size="36" maxLength="200"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>审批时间：</td>
      <td class="TableData"><input name="myDate" id="myDate" size="20" readonly>
        <img style="CURSOR: hand" onClick="SelectDate('myDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">日期格式形如 1999-1-2</td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>考核结果：</td>
      <td class="TableData">
	  <%options = bdm.getOptionsStr("result");%>
	  <select name="result">
	  <%=options%>
      </select>
	  </td>
    </tr>
    
    <tr>
      <td class="TableContent" noWrap>备注：</td>
      <td class="TableData"><textarea name="remark" cols="45" rows="3" wrap="yes" class="BigINPUT" id="remark"></textarea></td>
    </tr>
    <tr class="TableControl" align="middle">
      <td colSpan="2" align="center" noWrap><input name="submit" type="submit" class="BigButton" value="提交" onClick="return chkContent()">
        &nbsp;&nbsp;
          <input name="button" type="reset" class="BigButton" value="重填">
        &nbsp;&nbsp;</td>
    </tr>
  </tbody>
  </form>
</table>
</body>
</html>
