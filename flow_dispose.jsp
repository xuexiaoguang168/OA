<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.task.TaskDb"%>
<HTML>
<head>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String myname = privilege.getUser( request );
long myActionId = ParamUtil.getLong(request, "myActionId");
MyActionDb mad = new MyActionDb();
mad = mad.getMyActionDb((long)myActionId);
if (!mad.getUserName().equals(myname) && !mad.getProxyUserName().equals(myname)) {
	// 权限检查
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

WorkflowActionDb wa = new WorkflowActionDb();
int actionId = (int)mad.getActionId();
wa = wa.getWorkflowActionDb(actionId);
if ( wa==null ) {
	out.print(SkinUtil.makeErrMsg(request, "流程中的相应动作不存在！"));
	return;
}

if (wa.getStatus()!=wa.STATE_DOING && wa.getStatus()!=wa.STATE_RETURN) {
	mad.del();
	out.print(StrUtil.Alert_Back("流程中动作节点不处在正处理或被打回状态，可能已经有用户处理过了！"));
	return;
}

int flowId = wa.getFlowId();

WorkflowMgr wfm = new WorkflowMgr();
WorkflowDb wf = wfm.getWorkflowDb(flowId);

String flag = wa.getFlag();

String op = ParamUtil.get(request, "op");
Leaf lf = new Leaf();
lf = lf.getLeaf(wf.getTypeCode());

if (op.equals("discard")) {
	boolean re = false;
	try {
		re = wfm.discard(request, flowId);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "flow_list_doingorreturn.jsp"));
}

if (op.equals("modifyFlow")) {
    String flowstring = ParamUtil.get(request, "flowstring");
	// System.out.print("flow_dispose.jsp flowstring=" + flowstring);
	boolean re = false;
	try {
		re = wf.modifyFlowString(request, flowstring);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("delAttach")) {
	int doc_id = ParamUtil.getInt(request, "doc_id");
	int attach_id = ParamUtil.getInt(request, "attach_id");
	int page_num = ParamUtil.getInt(request, "page_num");
	Document doc = new Document();
	doc = doc.getDocument(doc_id);
	DocContent dc = doc.getDocContent(page_num);
	boolean re = dc.delAttachment(attach_id);
	if (re) {
		out.print(StrUtil.Alert_Redirect("删除成功！", "flow_dispose.jsp?myActionId=" + myActionId));
	}
	else
		out.print(StrUtil.Alert("删除失败！"));
}

String action = ParamUtil.get(request, "action");
%>
<title>处理流程</title>
<script src="inc/flow_dispose.js"></script>
<script src="inc/flow_js.jsp"></script>
<script>
function setradio(myitem,v)
{
     var radioboxs = document.all.item(myitem);
     if (radioboxs!=null)
     {
       for (i=0; i<radioboxs.length; i++)
          {
            if (radioboxs[i].type=="radio")
              {
                 if (radioboxs[i].value==v)
				 	radioboxs[i].checked = true;
              }
          }
     }
}

var isXorRadiate = false;
var isCondSatisfied = true;
var hasCond = false;

var action = "<%=action%>";
function SubmitResult() {
	// 如果本节点是异或节点，且是条件鉴别节点，如果未满足条件，则在此提醒用户先保存结果，然后继续往下进行
	if (isXorRadiate && (hasCond && !isCondSatisfied) ) {
		alert("当前处理不满足往下进行的条件（具体条件请见流程图），请先点击保存，待满足条件后继续！");
		return;
	}
	// 如果是自动存档节点，则先保存表单，然后回到此页面，在onload的时候再FinishActoin
	<%if (flag.length()>=5 && flag.substring(4, 5).equals("2")) {%>
		if (action=="afterAutoSaveArchiveNodeCommit") {
			flowForm.op.value = "finish";
		}
		else
			flowForm.op.value = "AutoSaveArchiveNodeCommit";
	<%}else{%>
		// 如果是条件异或节点，则先保存表单，然后回到此页面，在onload的时候再FinishAction
		if (hasCond && action!="afterXorCondNodeCommit") {
			flowForm.op.value = "XorCondNodeCommit";
		}
		else
			flowForm.op.value='finish';
	<%}%>
	flowForm.flowstring.value = Designer.Workflow;
	// alert("hasCond=" + hasCond + " op=" + flowForm.op.value);
	<%if (flag.length()>=5 && flag.substring(4, 5).equals("2")) {%>			  
	flowForm.formReportContent.value = hidFrame.getFormReportContent();
	<%}%>
	flowForm.submit();
}

function SubmitNotDelive() {
	// 如果本节点是异或聚合，办理完毕，但不转交
	window.location.href = "flow_dispose_do.jsp?myop=setFinishAndNotDelive&myActionId=<%=myActionId%>&actionId=<%=actionId%>";
}

// 编辑文件
function editdoc(doc_id, file_id)
{
	redmoonoffice.AddField("doc_id", doc_id);
	redmoonoffice.AddField("file_id", file_id);
	redmoonoffice.Open("http://<%=Global.server%>:<%=Global.port%>/<%=Global.virtualPath%>/flow_document_get.jsp?doc_id=" + doc_id + "&file_id=" + file_id);
}

// 审批文件，并作痕迹保留
function ReviseByUserColor(user, colorindex, doc_id, file_id)
{
	redmoonoffice.AddField("doc_id", doc_id);
	redmoonoffice.AddField("file_id", file_id);
	<%if (wa.isStart==0) {%>
		redmoonoffice.ReviseByUserColor("http://<%=Global.server%>:<%=Global.port%>/<%=Global.virtualPath%>/flow_document_get.jsp?doc_id=" + doc_id + "&file_id=" + file_id, user, colorindex);
	<%}else{%>
		editdoc(doc_id, file_id);
	<%}%>
}

function uploaddoc(doc_id, file_id) {
	redmoonoffice.Clear();
	redmoonoffice.AddField("doc_id", doc_id);
	redmoonoffice.AddField("file_id", file_id);
	redmoonoffice.UploadDoc();
	// alert(redmoonoffice.ReturnMessage);
}

function OfficeOperate() {
	// alert(redmoonoffice.ReturnMessage);
}

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=50,left=120,width="+width+",height="+height);
}

function initTask(flowId, actionId) {
	openWin("task_flow_init.jsp?op=newflowtask&flowId=" + flowId + "&actionId=" + actionId, 700, 580);
}

function saveArchive(flowId, actionId) {
	openWin("flow_doc_archive_save.jsp?op=saveFromFlow&flowId=" + flowId + "&actionId=" + actionId);
}

function OpenModifyWin(internalName) {
	SelAction(internalName);
	if (Designer.Message=='no_node') {
		alert('节点已不存在！');
		return;
	}

	var isActionSelected = Designer.isActionSelected
	if (isActionSelected) {
		showModalDialog('flow_action_modify.jsp',window.self,'dialogWidth:480px;dialogHeight:300px;status:no;help:no;')
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
}

function ModifyAction(user, title, clrindex, userRealName, jobCode, jobName, proxyJobCode, proxyJobName, proxyUserName, proxyUserRealName, fieldWrite, checkState, nodeMode, strategy) {
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
	Designer.ActionDeptMode = Number(nodeMode);
	Designer.ActionStrategy = strategy;
	
	Designer.ModifyAction();
	
	flowForm.isFlowModified.value = "1";

	/*
	if (confirm("您确定要保存修改过的流程吗？")) {
		form100.flowstring.value = Designer.Workflow;
		form100.submit();
	}
	*/
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

function getActionNodeMode() {
	return Designer.ActionDeptMode;
}

function getActionStrategy() {
	return Designer.ActionStrategy;
}

function SelAction(internalName) {
	Designer.SelectAction(internalName);
}

function selPerson(internalName, userName, userRealName, nodeMode, isChecked) {
	Designer.SelectAction(internalName);
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
	
	var title = getActionTitle();
	var OfficeColorIndex = getActionColorIndex();
	var jobCode = getActionJobCode();
	var jobName = getActionJobName();
	var proxyJobCode = getActionProxyJobCode();
	var proxyJobName = getActionProxyJobName();
	var proxyUserName = getActionProxyUserName();
	var proxyUserRealName = getActionProxyUserRealName();
	var fieldWrite = getActionFieldWrite();
	var checkState = getActionCheckState();
	var dept = getActionDept();
	var strategy = getActionStrategy();
	
	var actionUserName = getActionUser();
	var actionUserRealName = getActionUserRealName();
	if (isChecked) {
		// 检查是否有重复，没有则加上userName及userRealName
		var userary = actionUserName.split(",");
		var len = userary.length;
		var isFound = false; 
		for (var i=0; i<len; i++) {
			if (userary[i]==userName) {
				isFound = true;
				break;
			}
		}
		if (!isFound) {
			if (actionUserName==null || actionUserName=="") {
				;
			}
			else {
				userName = actionUserName + "," + userName;
				userRealName = actionUserRealName + "," + userRealName;
			}
		}
	}
	else {
		// 去除userName及userRealName
		var userary = actionUserName.split(",");
		var realnameary = actionUserRealName.split(",");
		var newary = new Array();
		var newrealnameary = new Array();
		var len = userary.length;	
		var k = 0;
		for (var i=0; i<len; i++) {
			if (userary[i]!=userName) {
				newary[k] = userary[i];
				newrealnameary[k] = realnameary[i];
				k++;			
			}
		}

		userName = "";
		userRealName = "";
		for (i=0; i<k; i++) {
			if (userName=="") {
				userName = newary[i];
				userRealName = newrealnameary[i];
			}
			else {
				userName += "," + newary[i];
				userRealName += "," + newrealnameary[i];
			}
		}
	}
	ModifyAction(userName, title, OfficeColorIndex, userRealName, jobCode, jobName, proxyJobCode, proxyJobName, proxyUserName, proxyUserRealName, fieldWrite, checkState, nodeMode, strategy);
}

function XorSelect(curInternalName, nextInternalName) {
	// if (confirm("您确定要选择该节点吗？")) {
		Designer.Message = "";
		Designer.SelectXorRadiateActionPath(curInternalName, nextInternalName);
		// alert("被忽略的动作节点有：" + Designer.Message);
		flowForm.isFlowModified.value = "1";
		flowForm.XorNextActionInternalName.value = nextInternalName;
		// flowForm_onsubmit(); // 保存节点
		// flowForm.submit();
	// }
}

var curInternalName, toInternalname
var isCondSatisfied = false;
var toActionName = "";
function setSatisfiedAction()
{
	// alert("节点 " + toActionName + " 满足预设的条件！");
	XorSelect(curInternalName, toInternalname);
	<%
	if (action.equals("afterXorCondNodeCommit")) {
	%>
		alert("节点 " + toActionName + " 满足预设的条件，点击确定继续！");
		SubmitResult();
	<%
	}
	%>
}

function checkDesignerInstalled() {
	var bCtlLoaded = false;
	try	{
		if (typeof(Designer.ModifyAction)=="undefined")
			bCtlLoaded = false;
		if (typeof(Designer.ModifyAction)=="unknown") {
			bCtlLoaded = true;
		}
	}
	catch (ex) {
	}
	if (!bCtlLoaded) {
		if (confirm("您还没有安装流程控件！请点击确定按钮下载安装！")) {
			window.open("activex/oa_client.EXE");
		}
	}	
}

function checkOfficeEditInstalled() {
	var bCtlLoaded = false;
	try	{
		if (typeof(redmoonoffice.AddField)=="undefined")
			bCtlLoaded = false;
		if (typeof(redmoonoffice.AddField)=="unknown") {
			bCtlLoaded = true;
		}
	}
	catch (ex) {
	}
	if (!bCtlLoaded) {
		if (confirm("您还没有安装Office在线编辑控件！请点击确定按钮下载安装！")) {
			window.open("activex/oa_client.EXE");
		}
	}	
}

function window_onload() {
	checkDesignerInstalled();
	checkOfficeEditInstalled();
}
</script>
</head>
<body onLoad="window_onload()">
			  <%
			  	com.redmoon.oa.Config cfg = new com.redmoon.oa.Config();
				String canUserSeeDesignerWhenDispose = cfg.get("canUserSeeDesignerWhenDispose");
				String canUserModifyFlow = cfg.get("canUserModifyFlow");
				String mode = "user";
				if (canUserModifyFlow.equals("true"))
					mode = "user";
				else
					mode = "view";
			  %>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr>
    <td width="90%" align="left" class="right-title">&nbsp;&nbsp;&nbsp;处理流程&nbsp;-&nbsp;<%=wf.getTitle()%> ( <%=lf.getName()%> ) 
    <%
			int doc_id = wf.getDocId();
			DocumentMgr dm = new DocumentMgr();
			Document doc = dm.getDocument(doc_id);
	%></td>
    <td width="10%" align="left" class="right-title">
	<%if (canUserSeeDesignerWhenDispose.equals("true")) {%>
	<input name="btnShowDesigner" type="button" class="singleboarder" onClick="ShowDesigner()" value="显示流程" />
	<%}%>
	</td>
  </tr>
  <tr>
    <td colspan="2">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="100%" valign="top" class="main">
		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%" colspan="3" align="center">
			  <object id="Designer" classid="CLSID:ADF8C3A0-8709-4EC6-A783-DD7BDFC299D7" codebase="<%=request.getContextPath()%>/activex/Designer.CAB" style="width:0px; height:0px">
                  <param name="Workflow" value="<%=wf.getFlowString()%>" />
                  <param name="Mode" value="<%=mode%>" />
                  <!--debug user initiate complete-->
                  <param name="CurrentUser" value="<%=privilege.getUser(request)%>" />
              </object>
			  </td>
            </tr>
        </table></td>
      </tr>
    </table>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
      <form id="flowForm" name="flowForm" action="flow_dispose_do.jsp" onSubmit="return flowForm_onsubmit()" method="post" enctype="multipart/form-data">
        <tr>
          <td width="35%" align="center"><%
					Render rd = new Render(request, wf, doc);
					out.print(rd.rend(wa));
					%>
					<textarea name="flowstring" style="display:none"></textarea>
					<input name="returnBack" value="<%=wf.isReturnBack()?"true":"false"%>" type=hidden>
                    <table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="91%">文件&nbsp;<input type="file" name="filename" style="width: 300px" />
        &nbsp;&nbsp;
        <input name="button" type="button" onClick="AddAttach()" value="增加附件" /><div id="updiv" name="updiv"></div></td>
            <td width="9%"><input type="hidden" name="flowId" value="<%=flowId%>" />
              <input type="hidden" name="actionId" value="<%=actionId%>" />
              <input type="hidden" name="myActionId" value="<%=myActionId%>" />
              <input type="hidden" name="isFlowModified" value="0"/>
			  <input type="hidden" name="XorNextActionInternalName" value=""/>
			  <textarea name="formReportContent" style="display:none"></textarea>
			  </td>
          </tr>
        </table>			</td>
        </tr>
        <tr>
          <td align="center"><br />
            <table width="60%" border="0" cellpadding="3" cellspacing="0" bgcolor="#E3E9EA">
            <tr>
              <td class="right-title">&nbsp;处理流程</td>
            </tr>
            <tr>
              <td>
			  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
                  <tr>
                    <td width="33%" valign="top"><strong>将转交给下列办理人员</strong>：<br>
<%
WorkflowRuler wr = new WorkflowRuler();
Vector vto = wa.getLinkToActions();

	boolean flagXorRadiate = wa.isXorRadiate();
	if (flagXorRadiate) {
		out.print("(请选择某个动作节点后继续)");
	}
	
%>					
					</td>
                    <td width="67%" valign="top">
<%
Iterator toir = vto.iterator();

// 如果在后继节点的连接线上存在条件，则判别是否有符合条件的分支，如果有满足条件的，则自动运行，注意条件分支中应只有一个分支满足条件
// 鉴别模型 Discriminator Choice
WorkflowLinkDb linkMatched = null;
StringBuffer condBuf = new StringBuffer();
if (flagXorRadiate) {
	linkMatched = wa.matchNextBranch(condBuf);
}

String conds = condBuf.toString();

boolean isCondSatisfied = linkMatched!=null?true:false;
boolean hasCond = conds.equals("")?false:true; // 是否含有条件

if (hasCond) {
%>
<script>
	hasCond = true;
</script>
<%
}
%>
<script>
<%
if (flagXorRadiate)
	out.println("isXorRadiate=true;");
else
	out.println("isXorRadiate=false;");
if (isCondSatisfied)
	out.println("isCondSatisfied=true;");
else
	out.println("isCondSatisfied=false;");
%>
</script>
<%
// 如果没有满足条件的，则不显示待选分支
if (hasCond && !isCondSatisfied) {
	out.print("条件“" + StrUtil.toHtml(conds) + "”不匹配，请注意填写是否正确，重新填写后请点击保存按钮！");
}
else {
	int q = 0;
	while (toir.hasNext()) {
		q ++;
		WorkflowActionDb towa = (WorkflowActionDb)toir.next();
		String color = "";
		// 如果本节点是异或发散节点
		if (flagXorRadiate) {
			// 如果有节点被忽略，则说明有后继节点被选中
			if (towa.getStatus()==towa.STATE_IGNORED) {
				color = "#99CCCC";
	%>
				<script>flowForm.XorNextActionInternalName.value = "NODE_SELECTED";</script>
	<%		
			}
			// 如果存在条件，且匹配结果不为空
			if (hasCond) {
				if (isCondSatisfied) {
					// 找到满足条件的节点，则在onload时的定时器中选择本节点
					if (towa.getInternalName().equals(linkMatched.getTo())) {
	%>
						<script>
						isCondSatisfied = true;
						curInternalName = "<%=wa.getInternalName()%>";
						toInternalname = "<%=towa.getInternalName()%>";
						toActionName = "<%=towa.getJobName()%>";
						// XorSelect('<%=wa.getInternalName()%>', '<%=towa.getInternalName()%>'); // 在这里选择无效，因为控件还不能显示，不支持选中节点
						</script>
	<%					
					}
					else // 条件不满足，则继续寻找，不写出待选节点
						continue;
				}
			}
			else {
	%>
				<span style="background-color:#8888ff"><input name="XorActionSelected" type="radio" value="<%=towa.getInternalName()%>" onClick="XorSelect('<%=wa.getInternalName()%>', '<%=towa.getInternalName()%>')"></span>
	<%		}
		}
		out.print("<font color='" + color + "'>" + towa.getJobName() + "</font>：");
		if (towa.getJobCode().equals(WorkflowActionDb.PRE_TYPE_USER_SELECT)) {%>
			<input type="button" value="选择用户" onClick="OpenModifyWin('<%=towa.getInternalName()%>')">
		<%}
		else {
			Iterator userir = null;
			try {
				Vector vuser = towa.matchActionUser(towa, wa);
				userir = vuser.iterator();
			}
			catch (ErrMsgException e) {
				out.print("<BR><font color=red>" + e.getMessage() + "</font>");
				return;
			}
			String[] userSelected = StrUtil.split(towa.getUserName(), ",");
			if (userSelected == null)
				userSelected = new String[0];
			int userSelectedLen = userSelected.length;
			int nodeMode = WorkflowActionDb.NODE_MODE_ROLE_SELECTED;
			if (towa.getNodeMode()==towa.NODE_MODE_USER_SELECTED || towa.getNodeMode()==towa.NODE_MODE_USER)
				nodeMode = towa.NODE_MODE_USER_SELECTED;
			while (userir.hasNext()) {
				UserDb ud = (UserDb)userir.next();
				String checked = "";
				for (int p=0; p<userSelectedLen; p++) {
					if (userSelected[p].equals(ud.getName())) {
						checked = "checked";
						break;
					}
				}
				String onclick = "onClick=\"selPerson('" + towa.getInternalName() + "', '" + ud.getName() + "', '" + ud.getRealName() + "', '" + nodeMode + "', this.checked)\"";
		%>
				<input name="tmp_sel_person<%=q%>" type="checkbox" <%=checked%> value="<%=ud.getName()%>+<%=ud.getId()%>" <%=onclick%>>
		<%					
				out.print(ud.getRealName());
				// if (checked.equals("checked"))
				//	out.print("(<font color=red>已选</font>)");
			}
		}
	%>
	<!--// 不支持删除节点，这样需要对流程图重新解析，会带来用户同时处理并行节点时的图的同步问题
		<%if (wr.canUserDeleteAction(request, towa)) {%>
		   <a href="javascript:DeleteAction('<%=towa.getInternalName()%>')">[删除]</a>
		<%}%>
	-->
	<hr style="height:1px"/>
	<%}
}
	// 如果匹配成功了，则flowString会被改写，因此这儿要重新获取一下以刷新Designer中的视图
	wf = wfm.getWorkflowDb(flowId);
%>
	<textarea id="textareaFlowString" style="display:none"><%=wf.getFlowString()%></textarea>
	<script>
	Designer.Workflow = flowForm.textareaFlowString.value;
	</script>
<%
Vector returnv = wa.getLinkReturnActions();
if (returnv.size()>0) {
%>
    打回至：
<%}
Iterator returnir = returnv.iterator();
while (returnir.hasNext()) {
	WorkflowActionDb returnwa = (WorkflowActionDb)returnir.next();
	if (returnwa.getStatus()!=WorkflowActionDb.STATE_IGNORED) {
%>
       <input type="checkbox" name="returnId" value="<%=returnwa.getId()%>" checked="checked" />
       <%=returnwa.getUserRealName()%>
<%	}
}
%>
                      <br /></td>
                  </tr>
                </table>
                  </td>
            </tr>
          </table>
            <br /></td>
        </tr>
        <tr>
          <td height="30" align="center">
<%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
<input name="isToMobile" value="true" type="checkbox" checked="checked" />
短讯
<%}%>
<input name="isUseMsg" value="true" type="checkbox" checked />
		  消息提醒
		  <input type="hidden" name="op" value="saveformvalue" />
          <input type="submit" name="Submit" value=" 保 存 " />
			<%
			if (wr.canUserStartFlow(request, wf)) {%>
				&nbsp;&nbsp;
				<input name="button" type=button onClick="SubmitResult()" value="开始流程" />
			<%}else{%>			
            	<input type="button" name="Submit2" value="办理完毕" onClick="SubmitResult()" title="转交至下一个动作节点办理"/>
            <%}%>
			&nbsp;
			<%
			// 如果该节点是异或节点，则如果其后续相邻节点中有已完成的节点，说明该节点曾被激活过，那么用户可以选择不往下继续
			if (wa.isXorAggregate()) {
				int accessedCount = wa.linkedFromActionsAccessedCount();
				if (accessedCount>=2) {
			%>
				<input type="button" onClick="SubmitNotDelive()" value="办理完毕（不转交）" title="置为办理完毕状态，但不转交下一个动作节点办理"/>
			<%	}
			}%>
            <%if (wa.isStart!=1) {%>
				<%if (returnv.size()>0) {%>
					<input name="button22" type="button" onClick="flowForm.op.value='return';flowForm.flowstring.value=Designer.Workflow;flowForm.submit()" value=" 打  回 " />
				<%}%>
            <%}%>
            &nbsp;&nbsp;
			<%
				  boolean hasTask = false;
				  if (wa.getTaskId()!=wa.NOTASK) {
				  		TaskDb td = new TaskDb();
						td = td.getTaskDb(wa.getTaskId());
						if (td!=null && td.isLoaded()) {
							hasTask = true;
				  %>
				  			<input type=button onClick="openWin('task_show.jsp?rootid=<%=td.getId()%>&showid=<%=td.getId()%>', 700, 580)" title="<%=td.getTitle()%>" value="查看任务">
				  <%
				  		}
				  }
				  %>
				  <!--
				  <%
				  if (!hasTask) {
				  %>
					<input type="button" value="发起任务" onClick="initTask(<%=wf.getId()%>, <%=wa.getId()%>)"/>
				  <%}%>-->
			&nbsp;
			<%if (flag.length()>=3 && flag.substring(2, 3).equals("1")) {%>
			<input name="Submit22" type="button" onClick="window.location.href='?op=discard&myActionId=<%=myActionId%>'" value="放弃流程"/>
			<%}%>
			&nbsp;
			<%if (flag.length()>=4 && flag.substring(3, 4).equals("1")) {%>
			<input name="button" type=button onClick="window.location.href='flow_del.jsp?flow_id=<%=flowId%>'" value=" 删 除 " />
			<%}%>
			&nbsp;
			<%if (flag.length()>=5 && flag.substring(4, 5).equals("1")) {%>
				<input type="button" value=" 存 档 " onClick="saveArchive(<%=wf.getId()%>, <%=wa.getId()%>)">
			<%}%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!--<input name="button2" type="button" onclick="openWin('flow_modify3.jsp?flowId=<%=flowId%>', 640, 480)" value=" 修改流程 " />--></td>
        </tr>
      </form>
    </table>
        <br />
        <table width="60%"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#D6D7DE">
          <tr>
            <td align="left" background="images/top-right.gif" class="right-title">&nbsp;处理附件</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#E3E9EA"><object id="redmoonoffice" classid="CLSID:D01B1EDF-E803-46FB-B4DC-90F585BC7EEE" 
codebase="<%=request.getContextPath()%>/activex/rmoffice.cab#version=2,0,0,1" width="316" height="43" viewastext="viewastext">
                <param name="Encode" value="utf-8" />
                <param name="BackColor" value="0000ff00" />
                <param name="Server" value="<%=Global.server%>" />
                <param name="Port" value="<%=Global.port%>" />
                <!--设置是否自动上传-->
                <param name="isAutoUpload" value="1" />
                <!--设置文件大小不超过1M-->
                <param name="MaxSize" value="<%=Global.FileSize%>" />
                <!--设置自动上传前出现提示对话框-->
                <param name="isConfirmUpload" value="1" />
                <!--设置IE状态栏是否显示信息-->
                <param name="isShowStatus" value="0" />
                <param name="PostScript" value="<%=Global.virtualPath%>/flow_document_check.jsp" />
              </object>
            <!--<input name="remsg" type="button" onclick='alert(redmoonoffice.ReturnMessage)' value="查看上传后的返回信息" />-->            </td>
          </tr>
      </table>
      <span class="stable"> </span>
        <%
			  if (doc!=null) {
				  java.util.Vector attachments = doc.getAttachments(1);
				  java.util.Iterator ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	Attachment am = (Attachment) ir.next(); %>
        <table width="60%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#D6D3CE" bgcolor="#E3E9EA">
          <tr>
            <td width="5%" height="31" align="right"><img src="images/attach.gif" /></td>
            <td width="72%">&nbsp; <%=am.getName()%><br />            </td>
            <td width="23%">
			<%
			String ext = StrUtil.getFileExt(am.getDiskName());
			if (ext.equals("doc") || ext.equals("xls")) {%>
				<%if (wa.isStart==1) {%>
                <input name="button" type="button" class="singleboarder" onClick="javascript:ReviseByUserColor('<%=myname%>', <%=wa.getOfficeColorIndex()%>, <%=doc_id%>, <%=am.getId()%>)" value="编 辑" />
                <%}else{%>
                <input name="button" type="button" class="singleboarder" onClick="javascript:ReviseByUserColor('<%=myname%>', <%=wa.getOfficeColorIndex()%>, <%=doc_id%>, <%=am.getId()%>)" value="审 批" />
                <%}%>
			<%}else{%>
				<a href="flow_getfile.jsp?attachId=<%=am.getId()%>&flowId=<%=flowId%>" target="_blank">查看</a>
			<%}%>
              &nbsp;&nbsp;
              <!--<input type=button class="singleboarder" onClick="javascript:uploaddoc(<%=doc_id%>, <%=am.getId()%>)" value="  上 传  ">-->
              <%if (flag.length()>=6 && flag.substring(5, 6).equals("1")) {%>
			  &nbsp;
              <a href="?op=delAttach&myActionId=<%=myActionId%>&flowId=<%=flowId%>&doc_id=<%=am.getDocId()%>&attach_id=<%=am.getId()%>&page_num=1">删除</a>
			  <%}%>		    </td>
          </tr>
      </table>
        <%}
			  }
			  %>
			<%if (flag.length()>=5 && flag.substring(4, 5).equals("2")) {%>			  
			  <iframe id="hidFrame" src="flow_doc_archive_content.jsp?flowId=<%=flowId%>&actionId=<%=actionId%>" width=0 height=0></iframe>
			<%}%>
      <br /></td>
  </tr>
</table>
<table width=98% border="0" align="center" cellpadding="0" cellspacing="0">
<form name=form100 action="?op=modifyFlow" method=post>
<tr><td>
<input name="flowstring" type="hidden">
<input name="flowId" type="hidden" value="<%=flowId%>">
<input name="myActionId" type="hidden" value="<%=myActionId%>">
</td></tr>
</form>
</table>
<br />
</body>
<script>
function flowForm_onsubmit() {
	flowForm.flowstring.value = Designer.Workflow;
}

function DeleteAction(internalName) {
	if (!confirm("您确定要删除吗？")) {
		return;
	}
	SelAction(internalName);
	if (Designer.Message=='no_node') {
		alert('节点已不存在！');
		return;
	}
	Designer.DeleteAllSelected();
	SelAction(internalName);
	if (Designer.Message=='no_node') {
		alert("已从流程图中删除，请保存或者转交！");
	}
	flowForm.isFlowModified.value = "1";
}

var attachCount = 1;
function AddAttach() {
	updiv.innerHTML += "<table width=100%><tr>文件&nbsp;<input type='file' name='filename" + attachCount + "' style='width:300px'><td></td></tr></table>";
	attachCount += 1;
}

function ShowDesigner() {
	if (Designer.style.width=="0px") {
		Designer.style.width = 740;
		Designer.style.height = 338;
		btnShowDesigner.value = "隐藏流程";
	}
	else {
		Designer.style.width = 0;
		Designer.style.height = 0;
		btnShowDesigner.value = "显示流程";
	}
}

// 利用定时器来选择路径，因为窗口load时，控件由于不能选择节点，因而无法进行路径的处理，但是放在body的onload事件中也有问题，因为当有图片找不着时，页面显示出来了，因为图片不能显示，致onload事件很久才能激发
if (isCondSatisfied) {
	// 满足条件，则选定路径
	// setSatisfiedAction(); // 直接调用无效，需置于setTimeout中
	window.setTimeout("setSatisfiedAction()", 200);
}
// 如果是自动存档节点，则在保存返回本页后，自动转交下一步
if (action=="afterAutoSaveArchiveNodeCommit") {
	window.setTimeout("SubmitResult()", 200);
}
</script>
</html>