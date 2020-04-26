<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
int flowId = ParamUtil.getInt(request, "flowId");
String op = ParamUtil.get(request, "op");
String priv="flow.init";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(fchar.makeErrMsg("对不起，您不具有发起流程的权限！"));
	return;
}
WorkflowMgr wm = new WorkflowMgr();
WorkflowDb wf = wm.getWorkflowDb(flowId);

PostDb pd = new PostDb();
pd = pd.getPostDbByUserName(privilege.getUser(request));
if (pd==null)
	pd = new PostDb();
	
UserDb ud = new UserDb();
ud = ud.getUserDb(privilege.getUser(request));	

String flowString = "";

String returnBackChecked = "checked";

WorkflowPredefineDb wpd = new WorkflowPredefineDb();
if (op.equals("")) {
	wpd = wpd.getDefaultPredefineFlow(wf.getTypeCode());
	if (wpd!=null && wpd.isLoaded()) {
		int preId = wpd.getId();
		wpd = wpd.getWorkflowPredefineDb(preId);
		flowString = wpd.getFlowString();
		// 替换其中的“本人”、“本部门领导”节点
		flowString = wf.regeneratePredefinedFlowString(privilege.getUser(request), flowString);
		// System.out.println("flow_initiatte3.jsp preId=" + preId);
		if (!wpd.isReturnBack())
			returnBackChecked = "";
		op = "setDefault";
	}
	else
		wpd = new WorkflowPredefineDb();
}

if (op.equals("loadPredefinedFlow")) {
	int preId = ParamUtil.getInt(request, "preId");
	wpd = wpd.getWorkflowPredefineDb(preId);
	flowString = wpd.getFlowString();
	// 替换其中的“本人”、“本部门领导”节点
	flowString = wf.regeneratePredefinedFlowString(privilege.getUser(request), flowString);
	// System.out.println("flow_initiatte3.jsp preId=" + preId);
	if (!wpd.isReturnBack())
		returnBackChecked = "";
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发起流程</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
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
	var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function ModifyAction(user, title, clrindex, userRealName, jobCode, jobName, proxyJobCode, proxyJobName, proxyUserName, proxyUserRealName, fieldWrite, checkState) {
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
	Designer.ActionDept = Designer.ActionDept;
	Designer.ActionFlag = Designer.ActionFlag; // 如果不获取一次属性，在Designer.ModifyAction()中就不能初始化m_actionFlag的值，ActionDept也是如此
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

function OpenModifyWin() {
	var isActionSelected = Designer.isActionSelected
	if (isActionSelected) {
		// showModalDialog('flow_action_modify.jsp',window.self,'dialogWidth:480px;dialogHeight:400px;status:no;help:no;')
		openWin("flow_action_modify.jsp?flowId=<%=flowId%>&hidFieldWrite=" + getActionFieldWrite(), 480, 292);
	}
	else
		alert("请选择一个动作！");
}

function Operate() {
	OpenModifyWin();
}

function form1_onsubmit() {
	form1.flowString.value =  Designer.Workflow;
}

function loadPredefinedFlow() {
	openWin("flow_sel_predefined_frame.jsp", 640, 480);
}

function sel(id) {
	window.location.href = "flow_initiate3.jsp?op=loadPredefinedFlow&preId=" + id + "&flowId=<%=flowId%>";
}

function getFlowId() {
	return <%=flowId%>;
}

var op = "<%=op%>";
function window_onload() {
	if (op=="") {
		Designer.New()
	}
}
//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0" onLoad="window_onload()">
<table height="89" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <tr> 
    <td height="23" class="right-title">&nbsp;&nbsp;流程向导 （第二步 “<%=wf.getTitle()%>”可视化定义）</td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center">
		<div id=divDesigner>
	<%
	String mode = "initiate";
	com.redmoon.oa.Config cfg = new com.redmoon.oa.Config();
    String canUserModifyFlow = cfg.get("canUserModifyFlow");
    if (!canUserModifyFlow.equals("true")) {
		mode = "view";
	}
	%>
	<OBJECT ID="Designer" CLASSID="CLSID:ADF8C3A0-8709-4EC6-A783-DD7BDFC299D7" codebase="<%=request.getContextPath()%>/activex/Designer.CAB" width=740 height=338>
    <param name="Workflow" value="<%=flowString%>">
	<param name="Mode" value="<%=mode%>"><!--debug user initiate complete view-->
	<param name="CurrentUser" value="<%=privilege.getUser(request)%>">
	<param name="CurrentUserRealName" value="<%=ud.getRealName()%>">
	<param name="CurrentJobCode" value="<%=pd.getCode()%>">
	<param name="CurrentJobName" value="<%=pd.getName()%>">
	</OBJECT></div></td>
      </tr>
	  <form action="flow_initiate3_do.jsp" method="post" id="form1" name="form1" onSubmit="form1_onsubmit()">
      <tr>
        <td height="35" align="center">
		  <%
		WorkflowPredefineDb ftd = new WorkflowPredefineDb();
		String sql = "select id from flow_predefined where typeCode=" + StrUtil.sqlstr(wf.getTypeCode());
		java.util.Iterator ir = ftd.list(sql).iterator();
		Directory dir = new Directory();
		while (ir.hasNext()) {
			ftd = (WorkflowPredefineDb) ir.next();
			Leaf lf = dir.getLeaf(ftd.getTypeCode());
		%>
          <table width="100%"  border="0" cellpadding="5" cellspacing="0" class="p14">
            <tr>
              <td width="69%" height="31" bgcolor="#EAEAEA" ><%=ftd.getTitle()%>			  </td>
              <td width="12%" bgcolor="#EAEAEA" >
			  <%=ftd.isDefaultFlow()?"默认流程":""%>
			  </td>
              <td width="19%" align="center" bgcolor="#EAEAEA" ><input name="button2" type="button" class="button1" onClick="openWin('flow_sel_predefined_preview.jsp?id=<%=ftd.getId()%>', 640, 365)" value="预览">
                &nbsp;&nbsp;
                <input name="button" type="button" class="button1" onClick="sel('<%=ftd.getId()%>')" value="选择"></td>
            </tr>
          </table>
          <%}%></td>
      </tr>
      <tr>
        <td height="35" align="center"><input type="hidden" name="returnBack" value="true" <%=returnBackChecked%>>
<!--允许打回&nbsp;&nbsp;
<input name="button3" type="button" class="singleboarder" onClick="loadPredefinedFlow()" value="载入其它预定义流程">
&nbsp;&nbsp;-->
<input type=hidden name="flowString" value="">
<input type=hidden name="flowId" value="<%=flowId%>">
<input name="submit" type="submit" class="singleboarder" value=" 办理流程 " title="办理流程"></td>
      </tr>
	  </form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
