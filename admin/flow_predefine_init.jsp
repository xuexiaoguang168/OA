<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String flowTypeCode = ParamUtil.get(request, "flowTypeCode");
String op = ParamUtil.get(request, "op");

WorkflowPredefineMgr wpm = new WorkflowPredefineMgr();
WorkflowPredefineDb wpd = null;
if (op.equals("edit")) {
	int id = ParamUtil.getInt(request, "id");
	wpd = wpm.getWorkflowPredefineDb(request, id);
	flowTypeCode = wpd.getTypeCode();
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预定义流程</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language=javascript>
<!--
function openWin(url,width,height)
{
	window.open(url, "pre_action_modify", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function ModifyAction(user, title, clrindex, userRealName, jobCode, jobName, proxyJobCode, proxyJobName, proxyUserName, proxyUserRealName, fieldWrite, checkState, dept, flag, nodeMode, strategy) {
	Designer.ActionUser = user;
	Designer.ActionTitle = title;
	Designer.ActionColorIndex = clrindex;
	Designer.ActionUserRealName = userRealName;
	Designer.ActionJobCode = jobCode;
	Designer.ActionJobName = jobName;
	Designer.ActionProxyJobCode = proxyJobCode;
	Designer.ActionProxyJobName = proxyJobName;
	Designer.ActionProxyUserName = proxyUserName;
	Designer.ActionProxyUserRealName = proxyUserRealName;
	Designer.ActionFieldWrite = fieldWrite;
	Designer.ActionCheckState = checkState;
	Designer.ActionDept = dept;
	Designer.ActionFlag = flag;
	Designer.ActionDeptMode = Number(nodeMode);
	Designer.ActionStrategy = strategy;
	Designer.ModifyAction();
}

function getActionUser() {
	return Designer.ActionUser;
}

function getActionTitle() {
	return Designer.ActionTitle;
}

function getActionColorIndex() {
	return Designer.ActionColorIndex;
}

function getActionUserRealName() {
	return Designer.ActionUserRealName;
}

function getActionCheckState() {
	return Designer.ActionCheckState;
}

function getActionJobCode() {
	return Designer.ActionJobCode;
}

function getActionJobName() {
	return Designer.ActionJobName;
}

function getActionProxyJobCode() {
	return Designer.ActionProxyJobCode;
}

function getActionProxyJobName() {
	return Designer.ActionProxyJobName;
}

function getActionProxyUserName() {
	return Designer.ActionProxyUserName;
}

function getActionProxyUserRealName() {
	return Designer.ActionProxyUserRealName;
}

function getActionFieldWrite() {
	return Designer.ActionFieldWrite;
}

function getActionDept() {
	return Designer.ActionDept;
}

function getActionFlag() {
	return Designer.ActionFlag;
}

function getActionNodeMode() {
	return Designer.ActionDeptMode;
}

function getActionType() {
	return Designer.ActionType;
}

function getActionStrategy() {
	return Designer.ActionStrategy;
}

function OpenModifyWin() {
	var isActionSelected = Designer.isActionSelected
	if (isActionSelected) {
		// showModalDialog('flow_predefine_action_modify.jsp',window.self,'dialogWidth:480px;dialogHeight:400px;status:no;help:no;')
		// alert(getActionFieldWrite());
		openWin("flow_predefine_action_modify.jsp?flowTypeCode=<%=flowTypeCode%>" + "&hidFieldWrite=" + getActionFieldWrite(), 620, 475);
	}
	else
		alert("请选择一个动作！");
}

function Operate() {
	OpenModifyWin();
}

function SetSelectedLinkProperty(propItem, propValue) {
	Designer.SetSelectedLinkProperty(propItem, propValue);
}

function GetSelectedLinkProperty(propItem) {
	return Designer.GetSelectedLinkProperty(propItem);
}

function OpenLinkPropertyWin() {
	var t = GetSelectedLinkProperty("title");
	var conditionType = GetSelectedLinkProperty("conditionType");
	t = encodeURI(t);
	openWin("flow_predefine_link_modify.jsp?flowTypeCode=<%=flowTypeCode%>&conditionType=" + conditionType + "&title=" + t, 620, 248);
}

function form1_onsubmit() {
	if (form1.title.value=="") {
		alert("请填写名称！");
		return false;
	}
	form1.flowString.value =  Designer.Workflow;
}
//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%
String priv="flow.init";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(fchar.makeErrMsg("对不起，您不具有发起流程的权限！"));
	return;
}

UserDb ud = new UserDb();
ud = ud.getUserDb(privilege.getUser(request));	
%>
<table height="89" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" class="right-title">&nbsp;&nbsp;预定义流程</td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center">
<%
String mode = "define"; // "initiate";
String flowString = "";
String title = "";
int id = 0;
String returnBackChecked = "checked";
String dirCode = "";
int examine = 0;
if (op.equals("edit")) {
	// mode = "user";
	flowString = wpd.getFlowString();
	title = wpd.getTitle();
	id = wpd.getId();
	dirCode = wpd.getDirCode();
	if (!wpd.isReturnBack())
		returnBackChecked = "";
	examine = wpd.getExamine();
}
%>	
	<OBJECT ID="Designer" CLASSID="CLSID:ADF8C3A0-8709-4EC6-A783-DD7BDFC299D7" codebase="<%=request.getContextPath()%>/activex/Designer.CAB" width=740 height=338>
    <param name="Workflow" value="<%=flowString%>">
	<param name="Mode" value="<%=mode%>"><!--debug user initiate complete-->
	<param name="CurrentUser" value="<%=privilege.getUser(request)%>">
	<param name="CurrentUserRealName" value="<%=ud.getRealName()%>">
	<param name="CurrentJobCode" value="">
	<param name="CurrentJobName" value="">
	</OBJECT></td>
      </tr>
	  <form action="flow_predefine_init_do.jsp?op=<%=op%>" method="post" id="form1" name="form1" onSubmit="form1_onsubmit()">
      <tr>
        <td height="35" align="center">
		流程名称：
		  <input name="id" type="hidden" value="<%=id%>">
		<input name="title" value="<%=title%>">
		<input type=hidden name="flowString" value="">
		<input type=hidden name="typeCode" value="<%=flowTypeCode%>">
		<input type="hidden" name="returnBack" value="true" <%=returnBackChecked%>>
		<!--允许打回-->
		 &nbsp;自动存档目录：
         <select name="dirCode" onChange="if(this.options[this.selectedIndex].value=='not'){alert(this.options[this.selectedIndex].text+' 不能被选择！'); return false;}">
           <option value="" selected>无</option>
           <%
		  			cn.js.fan.module.cms.Directory dir = new cn.js.fan.module.cms.Directory();
					cn.js.fan.module.cms.Leaf lf = dir.getLeaf("root");
					cn.js.fan.module.cms.DirectoryView dv = new cn.js.fan.module.cms.DirectoryView(lf);
					dv.ShowDirectoryAsOptions(out, lf, lf.getLayer());
		  %>
         </select>
&nbsp;审核状态：
<select name="examine">
  <option value="<%=cn.js.fan.module.cms.Document.EXAMINE_NOT%>">未审核</option>
  <option value="<%=cn.js.fan.module.cms.Document.EXAMINE_PASS%>">已通过</option>
</select>
<script>
		form1.dirCode.value = "<%=dirCode%>";
		form1.examine.value = "<%=examine%>";
		</script>
&nbsp;
<input name="submit" type="submit" value=" 确 定 "></td>
      </tr>
      <tr>
        <td height="35" align="center">&nbsp;</td>
      </tr>
	  </form>
    </table></td>
  </tr>
  <tr> 
    <td height="9">&nbsp;</td>
  </tr>
</table>
<br>
<br>
</body>
</html>
