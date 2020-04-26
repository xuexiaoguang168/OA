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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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

function selIsMostGrade()
{ 
	if(form1.isCMostGrade.checked){
		form1.isMostGrade.value = "1";
	}else{
		form1.isMostGrade.value = "0";
	}
}
//-->
</script>
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<%  
	String userName = ParamUtil.get(request,"userName");
	if (!privilege.isUserPrivValid(request, "archive.study")||!archivePrivilege.canAdminUser(request,userName)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<%@ include file="archive_inc_menu_top.jsp"%>
<%
	UserInfoDb uid = new UserInfoDb();
	uid = uid.getUserInfoDb(userName);
	String userRealName = uid.getUserRealName();
	
	BasicDataMgr bdm = new BasicDataMgr("archive");
	String options = "";
%>
<br>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
  <form name="form1" action="archive_study_do.jsp?op=add" method="post">
    <tbody>
	  <tr>
		<td colspan="3" class="right-title">添加教育信息</td>
	  </tr>
      <tr>
        <td width="80" noWrap>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</td>
        <td colSpan="2"><input maxLength="100" name="userRealName" size="20" readonly value="<%=userRealName%>"><input name="userName" type="hidden" value="<%=userName%>">
          <input type="hidden" name="isMostGrade" value="0">
          <input type="checkbox" name="isCMostGrade" onClick="selIsMostGrade()">
        是否是最高学历</td>
      </tr>
      <tr>
        <td noWrap>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历：</td>
        <td colSpan="2">
		  <%options = bdm.getOptionsStr("grade");%>
		  <select name="grade">
		  <%=options%>
          </select>
		  </td>
      </tr>
      <tr>
        <td noWrap>毕业院校：</td>
        <td colSpan="2"><input maxLength="100" name="college" size="20"></td>
      </tr>
      <tr>
        <td noWrap>院校简称：</td>
        <td colSpan="2"><input maxLength="100" name="sCollege" size="20"></td>
      </tr>
      <tr>
        <td noWrap>专&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：</td>
        <td colSpan="2"><input maxLength="100" name="specialty" size="20"></td>
      </tr>
      <tr>
        <td noWrap>专业简称：</td>
        <td colSpan="2"><input maxLength="100" name="sSpecialty" size="20"></td>  
      </tr>
      <tr>
        <td noWrap>是否在职：</td>
        <td colSpan="2"><select name="isJob">
		<option value="否">否</option>
		<option value="是" selected>是</option>
        </select></td>
      </tr>
      <tr>
        <td noWrap>开始时间：</td>
        <td colSpan="2"><input maxLength="100" name="beginDate" size="20" readonly><img style="CURSOR: hand" onClick="SelectDate('beginDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>结束时间：</td>
        <td colSpan="2"><input maxLength="100" name="endDate" size="20" readonly><img style="CURSOR: hand" onClick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</td>
        <td colSpan="2">
		<%options = bdm.getOptionsStr("degree");%>
		 <select name="degree">
		<%=options%>
        </select></td>
      </tr>
      <tr>
        <td noWrap>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
        <td colSpan="2"><textarea name="remark" cols="45" rows="3" wrap="yes" class="BigINPUT" id="remark"></textarea></td>
      </tr>
      <tr>
        <td noWrap align="middle" colSpan="3"><input value="保存" type="submit">&nbsp;&nbsp; 
          <input type="reset" value="重填">&nbsp;&nbsp;</td>
      </tr>
    </tbody>
  </FORM>
</table>
</body>
</html>
