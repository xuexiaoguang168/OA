<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.task.TaskDb"%>
<%@ page import="com.redmoon.oa.person.*"%>
<link href="common.css" rel="stylesheet" type="text/css">
<link href="admin/default.css" rel="stylesheet" type="text/css">
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

WorkflowRuler wr = new WorkflowRuler();
if (!privilege.isUserPrivValid(request, "admin.flow")) {
	LeafPriv lp = new LeafPriv(wf.getTypeCode());
	// 判断是否拥有管理权
	if (!lp.canUserSee(privilege.getUser(request))) {
		// 判断是否参与了流程
		if (!wf.isUserAttended(privilege.getUser(request))) {
			out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
	}
}

boolean isStarted = wf.isStarted();
String op = ParamUtil.get(request, "op");
if (op.equals("discard")) {
	boolean re = false;
	try {
		re = wfm.discard(request, flow_id);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
}

com.redmoon.oa.person.UserMgr um = new com.redmoon.oa.person.UserMgr();
%>
<title>处理流程</title>
<script src="inc/flow_dispose_js.jsp"></script>
<script>
function Operate() {
	alert("当前未处在修改状态！");
}

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}
</script>
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
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr>
    <td width="83%" height="23" background="images/top-right.gif" class="right-title">&nbsp;&nbsp;<span>修改 / 查看流程&nbsp;&nbsp;<%=wf.getTitle()%></span></td>
    <td width="17%" background="images/top-right.gif" class="right-title">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" valign="top" class="main"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="2" align="center"><object id="Designer" classid="CLSID:ADF8C3A0-8709-4EC6-A783-DD7BDFC299D7" codebase="<%=request.getContextPath()%>/activex/Designer.CAB" style="width:0px; height:0px">
            <param name="Workflow" value="<%=wf.getFlowString()%>" />
            <param name="Mode" value="view" />
            <!--debug user initiate complete-->
            <param name="CurrentUser" value="<%=privilege.getUser(request)%>" />
          </object></td>
        </tr>
          <tr>
            <td height="12" colspan="2" align="center"></td>
          </tr>
          
          <tr>
            <td width="2%" height="35" align="left">&nbsp;</td>
            <td width="98%" align="left"><strong class="p14">
              <%
			int doc_id = wf.getDocId();
			DocumentMgr dm = new DocumentMgr();
			Document doc = dm.getDocument(doc_id);
			%>
              <%=doc.getTitle()%></strong>&nbsp;&nbsp;发起人：<%=um.getUserDb(wf.getUserName()).getRealName()%>&nbsp;&nbsp;状态：<%=wf.getStatusDesc()%></td>
          </tr>
          <tr>
            <td colspan="2"><table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="left">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <form id="flowForm" name="flowForm" action="">
                  <tr>
                    <td>
					<%
					Render rd = new Render(request, wf, doc);
					out.print(rd.report());
					%>					</td>
                  </tr>
				  </form>
                </table>
				<br>
                  <%
			  if (doc!=null) {
				  java.util.Vector attachments = doc.getAttachments(1);
				  java.util.Iterator ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	Attachment am = (Attachment) ir.next(); %>
                  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="16%" align="right"><img src=images/attach.gif></td>
                      <td width="84%">&nbsp; <a target=_blank href="flow_getfile.jsp?attachId=<%=am.getId()%>&amp;flowId=<%=flow_id%>"><%=am.getName()%></a> </td>
                    </tr>
                  </table>
                <%}
			  }
			  %>
<%
String sql = "select id from flow_my_action where flow_id=" + flow_id + " order by receive_date asc";
MyActionDb mad = new MyActionDb();
Vector v = mad.list(sql);
%>
                <br />
                <table width="99%" align="center" cellpadding="3" cellspacing="1" bgcolor="#ACA38A">
                  <tbody>
                    <tr>
                      <td width="16%" align="center" nowrap="nowrap" class="thead" style="PADDING-LEFT: 10px"><strong>处理人</strong></td>
                      <td width="34%" align="center" nowrap="nowrap" class="thead" style="PADDING-LEFT: 10px">任务</td>
                      <td width="9%" align="center" nowrap="nowrap" class="thead">到达状态</td>
                      <td width="16%" align="center" nowrap="nowrap" class="thead"><strong>开始时间</strong></td>
                      <td width="17%" align="center" nowrap="nowrap" class="thead"><strong>处理时间</strong></td>
                      <td width="8%" align="center" nowrap="nowrap" class="thead"><strong>当前状态</strong></td>
                      </tr>
                    <%
java.util.Iterator ir = v.iterator();	
Directory dir = new Directory();	
while (ir.hasNext()) {
 	mad = (MyActionDb)ir.next();
	WorkflowDb wfd = new WorkflowDb();
	wfd = wfd.getWorkflowDb((int)mad.getFlowId());
	String userName = wfd.getUserName();
	String userRealName = "";
	if (userName!=null) {
		UserDb user = um.getUserDb(mad.getUserName());
		userRealName = user.getRealName();
	}
	WorkflowActionDb wad = new WorkflowActionDb();	
	wad = wad.getWorkflowActionDb((int)mad.getActionId());
	%>
                    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
                      <td style="PADDING-LEFT: 10px">&nbsp;&nbsp;<%=userRealName%></td>
                      <td style="PADDING-LEFT: 10px"><%=wad.getTitle()%></td>
                      <td><%=WorkflowActionDb.getStatusName(mad.getActionStatus())%> </td>
                      <td><%=DateUtil.format(mad.getReceiveDate(), "yy-MM-dd HH:mm:ss")%> </td>
                      <td><%=DateUtil.format(mad.getCheckDate(), "yy-MM-dd HH:mm:ss")%> </td>
                      <td><%=mad.isChecked()?"已处理":"未处理"%></td>
                      </tr>
                    <%}%>
                  </tbody>
                </table>
                <br>
<%
String strActionId = ParamUtil.get(request, "actionId");				
if (!strActionId.equals("")) {
	long actionId = Long.parseLong(strActionId);
	WorkflowActionDb wa = new WorkflowActionDb();
	wa = wa.getWorkflowActionDb((int)actionId);
	if ( wa==null ) {
		out.print(SkinUtil.makeErrMsg(request, "流程中的相应动作不存在！"));
		return;
	}
	Vector vto = wa.getLinkToActions();
	Iterator toir = vto.iterator();
	out.print("办理完毕时间：" + DateUtil.format(wa.getCheckDate(), "yyyy-MM-dd HH:mm:ss") + "<BR>");
	if (vto.size()>0)
		out.print("正在办理中的下一节点的人员：<BR>");
	while (toir.hasNext()) {
		WorkflowActionDb towa = (WorkflowActionDb)toir.next();
		if (towa.getStatus()==towa.STATE_DOING) {
			String[] users = StrUtil.split(towa.getUserName(), ",");
			String[] userRealNames = StrUtil.split(towa.getUserRealName(), ",");
			int len = users.length;
			for (int i=0; i<len; i++) {
%>		
				<%=userRealNames[i]%>&nbsp;&nbsp;<a href="#" onClick="openWin('message_oa/myreply.jsp?receiver=<%=StrUtil.UrlEncode(users[i])%>&title=<%=StrUtil.UrlEncode("请尽快办理：" + wf.getTitle())%>', 320, 262)">催办</a>
<%			}
		}
	}
}
%>				
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="28" align="center">
					<%
					if (wr.canMonitor(request, wf)) {
						if (wr.canUserModifyFlow(request, wf)) {%>
							<input name="button" type="button" class="button1" onclick="window.location.href='flow_modify1.jsp?flowId=<%=flow_id%>'" value=" 修 改 " />
							<!--&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="button" type="button" class="button1" onclick="window.location.href='flow_modify3.jsp?flowId=<%=flow_id%>'" value=" 修改流程 " />
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="Submit22" type="button" class="button1" onclick="window.location.href='?op=discard&flowId=<%=flow_id%>'" value="放弃流程"/>
							-->
						<%}%>
						<%if (wr.canUserDelFlow(request, wf)) {%>
							<!--&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="button" type=button class="button1" onclick="window.location.href='flow_del.jsp?flow_id=<%=flow_id%>'" value=" 删 除 " />
							-->
						<%}%>
						<!--&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="Submit2" type="button" class="button1" onclick="window.location.href='flow_monitor.jsp?flowId=<%=flow_id%>'" value="监控人员"/>
						-->
                    <%}%>
					<%if (wr.canUserStartFlow(request, wf)) {%>
						<!--&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="button" type=button class="button1" onclick="window.location.href='flow_dispose.jsp?flowId=<%=flow_id%>'" value=" 办 理 " />-->
					<%}%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="Submit" type="button" class="button1" onclick="showFormReport()" value="打印表单"/>
&nbsp;&nbsp;&nbsp;
<%if (canUserSeeDesignerWhenDispose.equals("true")) {%>
<input name="btnShowDesigner" type="button" class="button1" onclick="ShowDesigner()" value="显示流程" />
<%}%></td>
                  </tr>
                </table>
                <br></td>
              </tr>
            </table>            </td>
          </tr>
    </table></td>
  </tr>
</table>
<script>
function showFormReport() {
	var preWin=window.open('preview','','left=0,top=0,width=550,height=400,resizable=1,scrollbars=1, status=1, toolbar=1, menubar=1');
	preWin.document.open();
	preWin.document.write("<style>TD{ TABLE-LAYOUT: fixed; FONT-SIZE: 12px; WORD-BREAK: break-all; FONT-FAMILY:}</style>" + formDiv.innerHTML);
	preWin.document.close();
	preWin.document.title="表单";
	preWin.document.charset="UTF-8";
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
</script>
