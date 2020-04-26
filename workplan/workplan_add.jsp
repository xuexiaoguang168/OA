<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.workplan.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工作计划类型管理</title>
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

var selUserNames = "";
var selUserRealNames = "";

function getSelUserNames() {
	return selUserNames;
}

function getSelUserRealNames() {
	return selUserRealNames;
}

var doWhat = "";

function openWinUsers() {
	doWhat = "users";
	selUserNames = form1.users.value;
	selUserRealNames = form1.userRealNames.value;
	showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:600px;dialogHeight:480px;status:no;help:no;')
}

function setUsers(users, userRealNames) {
	if (doWhat=="users") {
		form1.users.value = users;
		form1.userRealNames.value = userRealNames;
	}
	if (doWhat=="principal") {
		form1.principal.value = users;
		form1.principalRealNames.value = userRealNames;
	}
}

function openWinPrincipal() {
	doWhat = "principal";
	selUserNames = form1.principal.value;
	selUserRealNames = form1.principalRealNames.value;
	showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:600px;dialogHeight:480px;status:no;help:no;')
}

function openWinDepts() {
	var ret = showModalDialog('../dept_multi_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')
	if (ret==null)
		return;
	form1.deptNames.value = "";
	form1.depts.value = "";
	for (var i=0; i<ret.length; i++) {
		if (form1.deptNames.value=="") {
			form1.depts.value += ret[i][0];
			form1.deptNames.value += ret[i][1];
		}
		else {
			form1.depts.value += "," + ret[i][0];
			form1.deptNames.value += "," + ret[i][1];
		}
	}
	if (form1.depts.value.indexOf("<%=DeptDb.ROOTCODE%>")!=-1) {
		form1.depts.value = "<%=DeptDb.ROOTCODE%>";
		form1.deptNames.value = "全部";
	}
}

function getDepts() {
	return form1.depts.value;
}
//-->
</script>
<script src="../inc/calendar.js"></script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%@ include file="workplan_inc_menu_top.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="workplan";
if (!privilege.isUserPrivValid(request, priv)) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<br>
<table class="main" cellSpacing="1" cellPadding="2" width="600" align="center" border="0">
<form action="workplan_do.jsp?op=add" name="form1" method="post" enctype="multipart/form-data">
  <tbody>
    <tr>
      <td colspan="2" noWrap class="right-title">添加计划</td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划名称：</td>
      <td class="TableData"><input name="title" id="title" size="36" maxLength="200"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划内容：</td>
      <td class="TableData"><textarea name="content" cols="45" rows="5" wrap="yes" class="BigINPUT" id="content"></textarea></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>有效期：</td>
      <td class="TableData">开始日期：
		<input readonly type="text" id="beginDate" name="beginDate" size="10" onClick="showcalendar(event, this)" onFocus="showcalendar(event, this);if(this.value=='0000-00-00') this.value=''" value="0000-00-00">
		<br>
        结束日期： 
		<input readonly type="text" id="endDate" name="endDate" size="10" onClick="showcalendar(event, this)" onFocus="showcalendar(event, this);if(this.value=='0000-00-00') this.value=''" value="0000-00-00"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划类型：</td>
      <td class="TableData">
	  <%
	  WorkPlanTypeDb wptd = new WorkPlanTypeDb();
	  String opts = "";
	  Iterator ir = wptd.list().iterator();
	  while (ir.hasNext()) {
	  	wptd = (WorkPlanTypeDb)ir.next();
	  	opts += "<option value='" + wptd.getId() + "'>" + wptd.getName() + "</option>";
	  }
	  %>
	  <select name="typeId" id="typeId">
	  <%=opts%>
      </select>	  </td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>发布范围（部门）：</td>
      <td class="TableData"><input type="hidden" name="depts">
          <textarea name="deptNames" cols="45" rows="5" readOnly wrap="yes" id="deptNames"></textarea>
        &nbsp;
        <input class="SmallButton" title="添加部门" onClick="openWinDepts()" type="button" value="添 加" name="button">
        &nbsp;
        <input class="SmallButton" title="清空部门" onClick="form1.deptNames.value='';form1.depts.value=''" type="button" value="清 空" name="button"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>参与人：</td>
      <td class="TableData"><input name="users" id="users" type="hidden">
        <textarea name="userRealNames" cols="45" rows="3" readOnly wrap="yes" id="userRealNames"></textarea>
        &nbsp;
        <input class="SmallButton" title="添加收件人" onClick="openWinUsers()" type="button" value="添 加" name="button">
        &nbsp;
        <input class="SmallButton" title="清空收件人" onClick="form1.users.value=''" type="button" value="清 空" name="button"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>负责人：</td>
      <td class="TableData"><input name="principal" type="hidden" id="principal">
        <textarea name="principalRealNames" cols="45" rows="3" readOnly wrap="virtual" id="principalRealNames"></textarea>
        &nbsp;
        <input class="SmallButton" title="添加收件人" onClick="openWinPrincipal()" type="button" value="添 加" name="button">
        &nbsp;
        <input class="SmallButton" title="清空收件人" onClick="form1.principal.value=''" type="button" value="清 空" name="button"></td>
    </tr>
    
    <tr>
      <td class="TableContent" noWrap>附件上传：</td>
      <td class="TableData"><input title="选择附件文件" type="file" size="30" name="attachment"></td>
    </tr>
    
    <tr>
      <td class="TableContent" noWrap>备注：</td>
      <td class="TableData"><textarea name="remark" cols="45" rows="3" wrap="yes" class="BigINPUT" id="remark"></textarea></td>
    </tr>
    <tr>
      <td class="TableData" noWrap>提醒：</td>
      <td class="TableData"><input id="smsRemind" type="checkbox" CHECKED name="isMessageRemind" value="true">
          <label for="SMS_REMIND">使用内部短信提醒用户&nbsp;
          <%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
          <input name="isToMobile" value="true" type="checkbox" checked />
短讯提醒
<%}%>
          </label></td>
    </tr>
    <tr class="TableControl" align="middle">
      <td colSpan="2" align="center" noWrap><input name="submit" type="submit" class="BigButton" value=" 提 交 ">
        &nbsp;&nbsp;
        <input name="button" type="reset" class="BigButton" value=" 重 填 ">
        &nbsp;&nbsp;</td></tr>
  </tbody>
  </form>
</table>
</body>
<script>
function getDept() {
	return form1.depts.value;
}
</script>
</html>
