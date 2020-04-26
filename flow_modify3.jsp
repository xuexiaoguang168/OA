<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int flow_id = ParamUtil.getInt(request, "flowId");
WorkflowMgr wfm = new WorkflowMgr();
WorkflowDb wf = wfm.getWorkflowDb(flow_id);
boolean isStarted = wf.isStarted();

PostDb pd = new PostDb();
pd = pd.getPostDbByUserName(privilege.getUser(request));
if (pd==null)
	pd = new PostDb();

UserDb ud = new UserDb();
ud = ud.getUserDb(privilege.getUser(request));

String returnBackChecked = "checked";

String op = ParamUtil.get(request, "op");
String flowString = wf.getFlowString();
if (!wf.isReturnBack())
	returnBackChecked = "";
	
if (op.equals("loadPredefinedFlow")) {
	int preId = ParamUtil.getInt(request, "preId");
	WorkflowPredefineDb wpd = new WorkflowPredefineDb();
	wpd = wpd.getWorkflowPredefineDb(preId);
	
	flowString = wpd.getFlowString();
	// 替换其中的“本人”、“本部门领导”节点
	flowString = wf.regeneratePredefinedFlowString(privilege.getUser(request), flowString);
	// System.out.println("flow_initiatte3.jsp preId=" + preId);
	if (!wpd.isReturnBack())
		returnBackChecked = "";
}
%>
<title>修改流程</title>
<script>
function openWin(url,width,height)
{
	var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function form1_onsubmit() {
	form1.flowstring.value = Designer.Workflow;
}

function OpenModifyWin() {
	var isActionSelected = Designer.isActionSelected
	if (isActionSelected) {
		// showModalDialog('flow_action_modify.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')
		openWin("flow_action_modify.jsp?flowId=<%=flow_id%>", 480, 320);
	}
	else
		alert("请选择一个动作！");
}

function Operate() {
    var STATE_NOTDO = <%=WorkflowActionDb.STATE_NOTDO%>;
    var STATE_IGNORED = <%=WorkflowActionDb.STATE_IGNORED%>;
	var STATE_DOING = <%=WorkflowActionDb.STATE_DOING%>;
    var STATE_RETURN = <%=WorkflowActionDb.STATE_RETURN%>;
    var STATE_FINISHED = <%=WorkflowActionDb.STATE_FINISHED%>;
	
	var checkState = getActionCheckState();
	if (checkState==STATE_FINISHED || checkState==STATE_DOING) {
		alert("动作已完成或者正在处理中时，不能被编辑！");
		return;
	}
	OpenModifyWin();
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

function loadPredefinedFlow() {
	openWin("flow_sel_predefined_frame.jsp?flowId=<%=flow_id%>", 640, 480);
}

function getFlowId() {
	return <%=flow_id%>;
}

function sel(id) {
	window.location.href = "flow_modify3.jsp?op=loadPredefinedFlow&preId=" + id + "&flowId=<%=flow_id%>";
}
</script>
<table border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr>
    <td height="23" class="right-title">&nbsp;&nbsp;修改流程</td>
  </tr>
  <tr>
    <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
		    <OBJECT ID="Designer" CLASSID="CLSID:ADF8C3A0-8709-4EC6-A783-DD7BDFC299D7" codebase="<%=request.getContextPath()%>/activex/Designer.CAB" width=740 height=338>
              <param name="Workflow" value="<%=flowString%>">
              <param name="Mode" value="user"><!--debug user initiate complete-->
              <param name="CurrentUser" value="<%=privilege.getUser(request)%>">
			  <param name="CurrentUserRealName" value="<%=ud.getRealName()%>">
			  <param name="CurrentJobCode" value="<%=pd.getCode()%>">
			  <param name="CurrentJobName" value="<%=pd.getName()%>">			  
            </OBJECT>          </td>
        </tr>
          <tr>
            <td height="35" align="center">
			<%
	if (!isStarted) {		
		WorkflowPredefineDb ftd = new WorkflowPredefineDb();
		String sql = "select id from flow_predefined where typeCode=" + StrUtil.sqlstr(wf.getTypeCode());
		java.util.Iterator ir = ftd.list(sql).iterator();
		com.redmoon.oa.flow.Directory dir = new com.redmoon.oa.flow.Directory();
		while (ir.hasNext()) {
			ftd = (WorkflowPredefineDb) ir.next();
			com.redmoon.oa.flow.Leaf lf = dir.getLeaf(ftd.getTypeCode());
		%>
              <table width="100%"  border="0" cellpadding="5" cellspacing="0" class="p14">
                <tr>
                  <td width="67%" height="31" bgcolor="#EAEAEA" ><%=ftd.getTitle()%></td>
                  <td width="14%" bgcolor="#EAEAEA" ><%=ftd.isDefaultFlow()?"默认流程":""%></td>
                  <td width="19%" align="center" bgcolor="#EAEAEA" ><input name="button2" type="button" class="button1" onclick="openWin('flow_sel_predefined_preview.jsp?id=<%=ftd.getId()%>', 640, 365)" value="预览" />
                    &nbsp;&nbsp;
                    <input name="button2" type="button" class="button1" onclick="sel('<%=ftd.getId()%>')" value="选择" /></td>
                </tr>
              </table>
     <% }
	 }%></td>
          </tr>
          <tr>
		  <form name=form1 action="flow_modify3_do.jsp" method=post onsubmit="form1_onsubmit()">
            <td height="35" align="center">
			  <input type="hidden" name="returnBack" value="true" <%=returnBackChecked%> />
<!--允许打回-->
<%if (!isStarted) {%>
			  <input name="button" type="button" class="singleboarder" onclick="loadPredefinedFlow()" value="载入预定义流程" />
			<%}%>
			  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  <input type=hidden name=flowstring>
			<input type=hidden name=flowId value="<%=flow_id%>">
		<%
		com.redmoon.oa.Config cfg = new com.redmoon.oa.Config();
		String canUserModifyFlowForm = cfg.get("canUserModifyFlowForm");
		if (canUserModifyFlowForm.equals("true")) {
		%>
			<input type=button class="singleboarder" onClick="window.location.href='flow_initiate2.jsp?op=edit&id=<%=wf.getDocId()%>&work=modify&flowId=<%=flow_id%>'" value="  上一步(修改表单)  ">
		<%}else{%>
			<!--<input type=button class="singleboarder" onClick="window.location.href='flow_initiate2_notmodifyform.jsp?op=edit&id=<%=wf.getDocId()%>&work=modify&flowId=<%=flow_id%>'" value="  上一步(添加附件)  ">-->
		<%}%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=submit class="singleboarder" value="  完  成  "></td>
		  </form>
          </tr>
          
    </table></td>
  </tr>
</table>
