<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String myop = ParamUtil.get(request, "myop");
if (myop.equals("setFinishAndNotDelive")) {
	long myActionId = ParamUtil.getLong(request, "myActionId");
	long actionId = ParamUtil.getLong(request, "actionId");
	WorkflowActionDb wa = new WorkflowActionDb();
	wa = wa.getWorkflowActionDb((int)actionId);
	wa.setStatus(wa.STATE_FINISHED);
	wa.save();
	MyActionDb mad = new MyActionDb();
	mad = mad.getMyActionDb(myActionId);
    mad.setCheckDate(new java.util.Date());
    mad.setChecked(true);
    mad.save();	
    WorkflowDb wfd = new WorkflowDb();
    wfd = wfd.getWorkflowDb(wa.getFlowId());
    // 检查流程中的节点是否都已完成
    if (wfd.checkStatusFinished()) {
    	wfd.changeStatus(wfd.STATUS_FINISHED, wa);
    }
	out.print(StrUtil.Alert_Redirect("操作成功！", "flow_list_doingorreturn.jsp"));
	return;
}

WorkflowMgr wfm = new WorkflowMgr();
wfm.doUpload(application, request);

String op = wfm.getFieldValue("op");
String strFlowId = wfm.getFieldValue("flowId");
int flowId = Integer.parseInt(strFlowId);
String strActionId = wfm.getFieldValue("actionId");
int actionId = Integer.parseInt(strActionId);
String strMyActionId = wfm.getFieldValue("myActionId");
long myActionId = Long.parseLong(strMyActionId);

WorkflowDb wf = wfm.getWorkflowDb(flowId);

String myname = privilege.getUser( request );
WorkflowActionDb wa = new WorkflowActionDb();
wa = wa.getWorkflowActionDb(actionId);
if (!wa.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "没有正在办理的节点！"));
	return;
}

if (op.equals("return"))
{
	try {
		boolean re = wfm.ReturnAction(request, wf, wa, myActionId);
		if (re)
			out.print(StrUtil.Alert_Redirect("打回成功！", "flow_list_doingorreturn.jsp"));
		else {
			out.print(StrUtil.Alert_Redirect("操作失败！", "flow_dispose.jsp?myActionId=" + myActionId));
		}
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Redirect(e.getMessage(), "flow_dispose.jsp?myActionId=" + myActionId));
	}
}

if (op.equals("finish"))
{
	try {
		boolean re = wfm.FinishAction(request, wf, wa, myActionId);
		if (re) {
			// 如果后继节点中有一个节点是由本人继续处理，且已处于激活状态，则继续处理这个节点
			MyActionDb mad = wa.getNextActionDoingWillBeCheckedByUserSelf();
			if (mad!=null) {
				out.print(StrUtil.Alert_Redirect("操作成功！请点击确定，继续处理下一节点！", "flow_dispose.jsp?myActionId=" + mad.getId()));
			}
			else {
				out.print(StrUtil.Alert_Redirect("操作成功！", "flow_list_doingorreturn.jsp"));
			}
			return;
		}
		else {
			out.print(StrUtil.Alert_Redirect("操作失败！", "flow_dispose.jsp?myActionId=" + myActionId));
		}
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Redirect(e.getMessage(), "flow_dispose.jsp?myActionId=" + myActionId));
	}
}

// 自动存档前先保存数据，然后获取flow_displose.jsp中iframe中的report表单数据在 办理完毕 时存档
if (op.equals("saveformvalue") || op.equals("XorCondNodeCommit") || op.equals("AutoSaveArchiveNodeCommit")) {
	boolean re = false;
	try {
		re = wfm.saveFormValue(request, wf, wa);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
	// afterXorCondNodeCommit通知flow_dispose.jsp页面，已保存完毕，匹配条件后，自动重定向
	if (re) {
		if (op.equals("saveformvalue"))
			out.print(StrUtil.Alert_Redirect("保存成功！", "flow_dispose.jsp?myActionId=" + myActionId));
		else if (op.equals("XorCondNodeCommit")) {
			response.sendRedirect("flow_dispose.jsp?action=afterXorCondNodeCommit&myActionId=" + myActionId);
			return;
		}
		else if (op.equals("AutoSaveArchiveNodeCommit")) {
			System.out.print("flow_displose_do.jsp back");
			response.sendRedirect("flow_dispose.jsp?action=afterAutoSaveArchiveNodeCommit&myActionId=" + myActionId);
			return;
		}
	}
}
%>
