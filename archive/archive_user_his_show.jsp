<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "cn.js.fan.security.*"%>
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

function getDept() {
	return form1.dept.value;
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

	UserInfoHisDb uihd = new UserInfoHisDb();
	uihd = uihd.getUserInfoHisDb(id);
	
	String operator = "";
    UserDb ud = new UserDb();
    if(uihd.getOperator()!=null){
	ud = ud.getUserDb(uihd.getOperator());
	operator = ud.getRealName();
	}
%>
<br>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
    <tbody>
	  <tr>
		<td colspan="3" class="right-title">修改用户信息</td>
	  </tr>
      
      <tr>
        <td width="165" noWrap>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
        <td><%=uihd.getUserRealName()%></td>
        <td width="246" rowspan="7"><%if(uihd.getImage().equals("")){%>
          <center>
            暂无照片
          </center>
          <%}else{%>
          <img src="../<%=uihd.getImage()%>">
        <%}%></td>
      </tr>
      <tr>
        <td noWrap>编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
        <td><%=uihd.getAccount()%></td>
      </tr>
      <tr>
        <td noWrap>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
        <td width="452"><%=uihd.getSex()%></td>
      </tr>
      <tr>
        <td noWrap>出生日期：</td>
        <td><%=DateUtil.format(uihd.getBirthday(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯：</td>
        <td><%=uihd.getNation()%></td>
      </tr>
      <tr>
        <td noWrap>出&nbsp;&nbsp;生&nbsp;&nbsp;地：</td>
        <td><%=uihd.getBorn()%></td>
      </tr>
      <tr>
        <td noWrap>入党时间：</td>
        <td><%=DateUtil.format(uihd.getJoinPartyDate(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>参加工作时间：</td>
        <td colSpan="3"><%=DateUtil.format(uihd.getJoinWorkDate(),"yyyy-MM-dd")%></td>
      </tr>
	        <tr>
        <td noWrap>加入本单位时间：</td>
        <td colSpan="2"><%=DateUtil.format(uihd.getJoinDepartmentDate(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>在职情况：</td>
        <td colSpan="2"><%=uihd.getInActiveService()%></td>
      </tr>
      <tr>
        <td noWrap>健康状况：</td>
        <td colSpan="3"><%=uihd.getHealthState()%></td>
      </tr>
      <tr>
        <td noWrap>文化程度：</td>
        <td colSpan="3"><%=uihd.getCulture()%></td>
      </tr>
      <tr>
        <td noWrap>后备干部级别：</td>
        <td colSpan="3"><%=uihd.getInsupportCadreLevel()%></td>
      </tr>
      <tr>
        <td noWrap>定为后备干部的时间：</td>
        <td colSpan="3"><%=DateUtil.format(uihd.getInsupportCadreDate(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>政治面貌：</td>
        <td colSpan="3"><%=uihd.getPolity()%></td>  
      </tr>
      <tr>
        <td noWrap>其它党派加入时间：</td>
        <td colSpan="3"><%=DateUtil.format(uihd.getJoinClanDate(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>编制情况：</td>
        <td colSpan="3"><%=uihd.getTypeOfWork()%></td>
      </tr>
	  <tr>
        <td noWrap>干部来源</td>
        <td colSpan="3"><%=uihd.getCadresSource()%></td>
      </tr>
      <tr>
        <td noWrap>过渡时间</td>
        <td colSpan="3"><%=DateUtil.format(uihd.getTransitionDate(),"yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>备注：</td>
        <td colSpan="3"><%=uihd.getRemark()%></td>
      </tr>
	  	  	<tr>
		<td class="TableContent" noWrap>操作人：</td>
		<td class="TableData"><%=operator%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作类型：</td>
	  <td class="TableData"><%=uihd.getOperateType()%></td>
	</tr>
	<tr>
	  <td class="TableContent" noWrap>操作时间：</td>
	  <td class="TableData"><%=uihd.getAddDate()%></td>
	</tr>
    </tbody>
  </FORM>
</table>
</body>
</html>
