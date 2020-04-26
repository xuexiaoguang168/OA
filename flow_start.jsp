<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
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
boolean re = false;
try {
	re = wfm.start(request, flow_id); // 在start中对flowString作了更改
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert_Back(e.getMessage()));
	return;
}
if (!re)
	out.print(StrUtil.Alert_Back("开始流程未成功！"));
else {
	WorkflowDb wf = wfm.getWorkflowDb(flow_id);
%>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr>
    <td height="23" valign="bottom" class="right-title">&nbsp;&nbsp;<span>流程开始</span></td>
  </tr>
  <tr>
    <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
		    <OBJECT ID="Designer" CLASSID="CLSID:ADF8C3A0-8709-4EC6-A783-DD7BDFC299D7" codebase="<%=request.getContextPath()%>/activex/Designer.CAB" width=740 height=338>
              <param name="Workflow" value="<%=wf.getFlowString()%>">
              <param name="Mode" value="user"><!--debug user initiate complete-->
              <param name="CurrentUser" value="<%=privilege.getUser(request)%>">
            </OBJECT>
          </td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="29" align="center"><span class="p14"><strong>流程开始了！</strong></span></td>
  </tr>
</table>
<%}%>