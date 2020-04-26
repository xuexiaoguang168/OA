<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.workplan.*"%>
<%@ page import = "com.redmoon.oa.kernel.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工作计划编辑</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<script src="../inc/common.js"></script>
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

var doWhat = "";

function openWinUsers() {
	doWhat = "users";
	selUserNames = form1.users.value;
	selUserRealNames = form1.userRealNames.value;
	showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:600px;dialogHeight:480px;status:no;help:no;')
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
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request, priv)) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int id = ParamUtil.getInt(request, "id");
WorkPlanMgr wpm = new WorkPlanMgr();
WorkPlanDb wpd = null;
// 由这里来检查权限
try {
	wpd = wpm.getWorkPlanDb(request, id, "edit");
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert_Back(e.getMessage()));
	return;
}

String beginDate = DateUtil.format(wpd.getBeginDate(), "yyyy-MM-dd");
String endDate = DateUtil.format(wpd.getEndDate(), "yyyy-MM-dd");
%>
<%@ include file="workplan_inc_menu_top.jsp"%>
<br>
<table class="main" cellSpacing="1" cellPadding="2" width="600" align="center" border="0">
<form action="workplan_do.jsp?op=modify&id=<%=id%>" name="form1" method="post" enctype="multipart/form-data">
  <tbody>
    <tr>
      <td colspan="2" noWrap class="right-title">修改计划</td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划名称：</td>
      <td class="TableData"><input name="title" id="title" size="36" maxLength="200" value="<%=wpd.getTitle()%>">
	  <input type=hidden name="id" value="<%=wpd.getId()%>">
	  </td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划内容：</td>
      <td class="TableData"><textarea name="content" cols="45" rows="5" wrap="yes" id="content"><%=wpd.getContent()%></textarea></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>有效期：</td>
      <td class="TableData">开始日期：
		<input readonly type="text" id="beginDate" name="beginDate" size="10" onClick="showcalendar(event, this)" onFocus="showcalendar(event, this);if(this.value=='0000-00-00') this.value=''" value="<%=beginDate%>">
           为空则立即生效<br>
        结束日期： 
		<input readonly type="text" id="endDate" name="endDate" size="10" onClick="showcalendar(event, this)" onFocus="showcalendar(event, this);if(this.value=='0000-00-00') this.value=''" value="<%=endDate%>"></td>
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
      </select>
	  <script>
	  form1.typeId.value = "<%=wpd.getTypeId()%>";
	  </script>	  </td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>发布范围（部门）：</td>
      <td class="TableData">
	  <%
	  String[] arydepts = wpd.getDepts();
	  String[] aryusers = wpd.getUsers();
	  String depts = "";
	  String deptNames = "";
	  String users = "";
	  String userRealNames = "";
	  String principal = "";
	  String principalRealNames = "";
	  
	  int len = 0;
	  if (arydepts!=null) {
	  	len = arydepts.length;
		DeptDb dd = new DeptDb();
	  	for (int i=0; i<len; i++) {
			if (depts.equals("")) {
				depts = arydepts[i];
				dd = dd.getDeptDb(arydepts[i]);
				deptNames = dd.getName();
			}
			else {
				depts += "," + arydepts[i];
				dd = dd.getDeptDb(arydepts[i]);
				deptNames += "," + dd.getName();
			}
		}
	  }
	  
	  if (aryusers!=null) {
	  	len = aryusers.length;
		//DeptDb dd = new DeptDb();
	  	for (int i=0; i<len; i++) {
			if (users.equals("")) {
				users = aryusers[i];
				UserDb ud = new UserDb();
				ud = ud.getUserDb(aryusers[i]);
				userRealNames = ud.getRealName();
			}
			else {
				users += "," + aryusers[i];
				UserDb ud = new UserDb();
				ud = ud.getUserDb(aryusers[i]);
				userRealNames += "," + ud.getRealName();
			}
		}
	  }
	  %>
	  	  <input type="hidden" name="depts" value="<%=depts%>">
          <textarea name="deptNames" cols="45" rows="5" readOnly wrap="yes" id="deptName"><%=deptNames%></textarea>
        &nbsp;
        <input class="SmallButton" title="添加部门" onClick="openWinDepts()" type="button" value="添 加" name="button">
        &nbsp;
        <input class="SmallButton" title="清空部门" onClick="form1.deptNames.value='';form1.depts.value=''" type="button" value="清 空" name="button"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>参与人：</td>
      <td class="TableData">
          <textarea name="userRealNames" cols="45" rows="3" readOnly wrap="yes" id="userRealNames"><%=userRealNames%></textarea>
		  <input name="users" id="users" type="hidden" value="<%=users%>">
        &nbsp;
        <input class="SmallButton" title="添加收件人" onClick="openWinUsers()" type="button" value="添 加" name="button">
        &nbsp;
        <input class="SmallButton" title="清空收件人" onClick="form1.users.value='';form1.userRealNames.value=''" type="button" value="清 空" name="button"></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>负责人：</td>
      <td class="TableData">
	  <%	   
		 if(StrUtil.getNullStr(wpd.getPrincipal()).equals("")){
		    principalRealNames = "";
		 }else{
		    String[] principalArray = wpd.getPrincipal().split(",");
			if(principalArray == null){
			   UserDb ud = new UserDb();
		       ud = ud.getUserDb(principal);
			   principalRealNames = ud.getRealName();
			}else{
			   len = principalArray.length;			   
			   for (int i=0; i<len; i++) {	
			   	  if(principal.equals("")){	 
				    principal = principalArray[i]; 
					UserDb ud = new UserDb();
		            ud = ud.getUserDb(principalArray[i]);
			        principalRealNames = ud.getRealName();
				  }else{
				    principal += "," + principalArray[i] ; 
					UserDb ud = new UserDb();
		            ud = ud.getUserDb(principalArray[i]);
			        principalRealNames += "," + ud.getRealName();
				  }	
			   }	
			}
		 }
	  %>
	  <textarea name="principalRealNames" cols="45" rows="3" readOnly wrap="virtual" id="principalRealNames"><%=principalRealNames%></textarea>
	                        <input name="principal" type="hidden" id="principal" value="<%=principal%>">
        &nbsp;
        <input class="SmallButton" title="添加收件人" onClick="openWinPrincipal()" type="button" value="添 加" name="button">
        &nbsp;
        <input class="SmallButton" title="清空收件人" onClick="form1.principal.value='';form1.principalRealNames.value=''" type="button" value="清 空" name="button"></td>
    </tr>
    
    <tr>
      <td class="TableContent" noWrap>附件上传：</td>
      <td class="TableData"><input title="选择附件文件" type="file" size="30" name="attachment"></td>
    </tr>
    
    <tr>
      <td class="TableContent" noWrap>备注：</td>
      <td class="TableData"><textarea name="remark" cols="45" rows="3" wrap="yes" id="remark"><%=wpd.getRemark()%></textarea></td>
    </tr>
    <tr>
      <td class="TableData" noWrap>提醒：</td>
      <td class="TableData"><input id="smsRemind" type="checkbox" CHECKED name="isMessageRemind" value="true">
          <label for="SMS_REMIND">使用内部短信提醒用户
          <%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
          <input name="isToMobile" value="true" type="checkbox" checked />
短讯提醒
<%}%>
</label></td>
    </tr>
    <tr class="TableControl" align="middle">
      <td colSpan="2" align="left" noWrap>
附件：
                      <%
					  java.util.Iterator attir = wpd.getAttachments().iterator();
					  while (attir.hasNext()) {
					  	Attachment att = (Attachment)attir.next();
					  %>
                        <li><img src="../images/attach.gif" width="17" height="17">&nbsp;<a target="_blank" href="workplan_getfile.jsp?workPlanId=<%=wpd.getId()%>&attachId=<%=att.getId()%>"><%=att.getName()%></a>&nbsp;&nbsp;&nbsp;<a href="workplan_do.jsp?op=delattach&workPlanId=<%=wpd.getId()%>&attachId=<%=att.getId()%>">删除</a></li>
                        <%}%>	  
	  </td>
    </tr>
    <tr class="TableControl" align="middle">
      <td colSpan="2" align="center" noWrap><input name="submit" type="submit" value=" 提 交 ">
        &nbsp;&nbsp;
          <input name="button" type="reset" value=" 重 填 ">
        &nbsp;&nbsp;</td>
    </tr>
  </tbody>
  </form>
</table>
<%
JobUnitDb ju = new JobUnitDb();
int jobId = ju.getJobId("com.redmoon.oa.job.WorkplanJob", "" + id);
if (jobId!=-1) {
	ju = (JobUnitDb)ju.getQObjectDb(new Integer(jobId));
%>	
<table width="81%" border="0" align="center" class="main">
  <form name="form2" action="workplan_do.jsp?op=editJob" method="post" onsubmit="return form2_onsubmit()">
    <tr>
      <td align="left"><strong>调度计划&nbsp;&nbsp;<a href="workplan_do.jsp?op=delJob&id=<%=ju.get("id")%>&planId=<%=id%>">删除</a></strong></td>
    </tr>
    <tr>
      <td align="left"><input name="job_class" type="hidden" value="com.redmoon.oa.job.WorkplanJob">
          <input name="map_data" type="hidden" value="<%=id%>">
        名称：
        <input name="job_name" value="<%=ju.getString("job_name")%>">
        &nbsp;每月：
        <input name="month_day" size="2" value="<%=ju.getString("month_day")%>">
      号</td>
    </tr>
    <tr>
      <td align="left"> 开始时间
        <%
String cron = ju.getString("cron");
String[] ary = cron.split(" ");
if (ary[0].length()==1)
	ary[0] = "0" + ary[0];
if (ary[1].length()==1)
	ary[1] = "0" + ary[1];
if (ary[2].length()==1)
	ary[2] = "0" + ary[2];
String t = ary[2] + ":" + ary[1] + ":" + ary[0];
%>
          <input style="WIDTH: 50px" name="time" size="20" value="<%=t%>">
        &nbsp;<img style="CURSOR: hand" onclick="SelectDateTime('time')" src="../images/form/clock.gif" align="absMiddle" width="18" height="18"> 在
        <input name="weekDay" type="checkbox" value="1">
        星期日
        <input name="weekDay" type="checkbox" value="2">
        星期一
        <input name="weekDay" type="checkbox" value="3">
        星期二
        <input name="weekDay" type="checkbox" value="4">
        星期三
        <input name="weekDay" type="checkbox" value="5">
        星期四
        <input name="weekDay" type="checkbox" value="6">
        星期五
        <input name="weekDay" type="checkbox" value="7">
        星期六
        <input name="submit3" type="submit" value=" 确 定 ">
        <input name="planId" type="hidden" value="<%=id%>">
        <input name="id" type="hidden" value="<%=ju.getInt("id")%>">
        <input name="cron" type="hidden">
        <input name="data_map" type="hidden">
		<input name="user_name" value="<%=privilege.getUser(request)%>" type="hidden">
        <%
String[] w = ary[5].split(",");
for (int i=0; i<w.length; i++) {
%>
        <script>
setCheckboxChecked("weekDay", "<%=w[i]%>");
</script>
        <%
}
%>
      </td>
    </tr>
  </form>
</table>
<%}
else {
%>
<table class="main" width="600" border="0" align="center">
<form name="form2" action="workplan_do.jsp?op=addJob" method="post" onsubmit="return form2_onsubmit()">
  <tr>
    <td align="left"><strong>调度计划</strong></td>
  </tr>
  <tr>
    <td align="left"><input name="job_class" type="hidden" value="com.redmoon.oa.job.WorkplanJob">
      &nbsp;每月：
      <input name="month_day" size="2">
      号<input name="job_name" type="hidden" value="<%=wpd.getTitle()%>"></td>
  </tr>
  <tr>
    <td align="left"> 开始时间
      <input style="WIDTH: 50px" value="12:00:00" name="time" size="20">
      &nbsp;<img style="CURSOR: hand" onClick="SelectDateTime('time')" src="../images/form/clock.gif" align="absMiddle" width="18" height="18"> 在
      <input name="weekDay" type="checkbox" value="1">
      星期日
      <input name="weekDay" type="checkbox" value="2">
      星期一
      <input name="weekDay" type="checkbox" value="3">
      星期二
      <input name="weekDay" type="checkbox" value="4">
      星期三
      <input name="weekDay" type="checkbox" value="5">
      星期四
      <input name="weekDay" type="checkbox" value="6">
      星期五
      <input name="weekDay" type="checkbox" value="7">
      星期六
      <input name="submit2" type="submit" value=" 确 定 ">
      <input name="id" type="hidden" value="<%=id%>">
      <input name="cron" type="hidden">
      <input name="data_map" type="hidden">
      <input name="user_name" value="<%=privilege.getUser(request)%>" type="hidden"></td>
  </tr>
</form>
</table>
<%}%>
</body>
<script>
function getDept() {
	return form1.depts.value;
}

function SelectDateTime(objName) {
	var dt = showModalDialog("../util/calendar/time.htm", "" ,"dialogWidth:266px;dialogHeight:125px;status:no;help:no;");
	if (dt!=null)
		findObj(objName).value = dt;
}

function form2_onsubmit() {
	var t = form2.time.value;
	var ary = t.split(":");
	var weekDay = getCheckboxValue("weekDay");
	var dayOfMonth = form2.month_day.value;
	if (weekDay=="" && dayOfMonth=="") {
		alert("请填写每月几号或者星期几！");
		return false;
	}
	if (weekDay=="")
		weekDay = "?";
	if (ary[2].indexOf("0")==0 && ary[2].length>1)
		ary[2] = ary[2].substring(1, ary[2].length);
	if (ary[1].indexOf("0")==0 && ary[1].length>1)
		ary[1] = ary[1].substring(1, ary[1].length);
	if (ary[0].indexOf("0")==0 && ary[0].length>1)
		ary[0] = ary[0].substring(1, ary[0].length);
	if (dayOfMonth=="")
		dayOfMonth = "?";
	var cron = ary[2] + " " + ary[1] + " " + ary[0] + " " + dayOfMonth + " * " + weekDay;
	form2.cron.value = cron;
	form2.data_map.value = "<%=id%>";
}

function trimOptionText(strValue) 
{
	// 注意option中有全角的空格，所以不直接用trim
	var r = strValue.replace(/^　*|\s*|\s*$/g,"");
	return r;
}
</script>
</html>