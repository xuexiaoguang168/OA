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
	
	UserStudyHisDb ushd = new UserStudyHisDb();
	ushd = ushd.getUserStudyHisDb(id);
	
	UserInfoHisDb uihd = new UserInfoHisDb();
	String userRealName = uihd.getUserRealName(ushd.getUserName());	
	
	UserDb ud = new UserDb();
	ud = ud.getUserDb(ushd.getOperator());
	String operator = ud.getRealName();
%>
<br>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
    <tbody>
	  <tr>
		<td colspan="3" class="right-title">修改教育信息</td>
	  </tr>
      <tr>
        <td width="80" noWrap>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</td>
        <td colSpan="2"><%=userRealName%>
        </td>
      </tr>
      <tr>
        <td noWrap>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历：</td>
        <td colSpan="2"><%=ushd.getGrade()%></td>
      </tr>
      <tr>
        <td noWrap>毕业院校：</td>
        <td colSpan="2"><%=ushd.getCollege()%></td>
      </tr>
      <tr>
        <td noWrap>院校简称：</td>
        <td colSpan="2"><%=ushd.getSCollege()%></td>
      </tr>
      <tr>
        <td noWrap>专&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：</td>
        <td colSpan="2"><%=ushd.getSpecialty()%></td>
      </tr>
      <tr>
        <td noWrap>专业简称：</td>
        <td colSpan="2"><%=ushd.getSSpecialty()%></td>  
      </tr>
      <tr>
        <td noWrap>是否在职：</td>
        <td colSpan="2"><%=ushd.getIsJob()%>
		</td>
      </tr>
      <tr>
        <td noWrap>开始时间：</td>
        <td colSpan="2"><%=DateUtil.format(ushd.getBeginDate(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>结束时间：</td>
        <td colSpan="2"><%=DateUtil.format(ushd.getEndDate(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：</td>
        <td colSpan="2"><%=ushd.getDegree()%>
		</td>
      </tr>
      <tr>
        <td noWrap>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
        <td colSpan="2"><%=ushd.getRemark()%></td>
      </tr>
	  	<tr>
		<td class="TableContent" noWrap>操作人：</td>
		<td class="TableData"><%=operator%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作类型：</td>
	  <td class="TableData"><%=ushd.getOperateType()%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作时间：</td>
	  <td class="TableData"><%=ushd.getAddDate()%></td>
	</tr>
    </tbody>
  </FORM>
</table>
</body>
</html>
