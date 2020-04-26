<%@ page contentType="text/html; charset=utf-8" %>
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

	String flowString = ParamUtil.get(request, "flowString");
	int flowId = ParamUtil.getInt(request, "flowId");

	WorkflowMgr wfm = new WorkflowMgr();
	WorkflowDb wf = wfm.getWorkflowDb(flowId);
	boolean returnBack = ParamUtil.getBoolean(request, "returnBack", false); 
	try {	
		wf.createFromString(flowString);
		wf.setReturnBack(returnBack);
		wf.save();
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
	
	response.sendRedirect("flow_dispose.jsp?flowId=" + flowId);
	if (true)
		return;
%>
<table width="98%" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr>
    <td width="100%" height="23" valign="bottom" background="images/top-right.gif" class="right-title">&nbsp;&nbsp;<span>流程向导 （预览流程）</span></td>
  </tr>
  <tr>
    <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
		    <OBJECT ID="Designer" CLASSID="CLSID:ADF8C3A0-8709-4EC6-A783-DD7BDFC299D7" codebase="<%=request.getContextPath()%>/activex/Designer.CAB" width=740 height=338>
              <param name="Workflow" value="<%=flowString%>">
              <param name="Mode" value="user"><!--debug user initiate complete-->
              <param name="CurrentUser" value="<%=privilege.getUser(request)%>">
          </OBJECT></td>
        </tr>
          <tr>
            <td height="35" align="center">
			<input type="button" class="button1" onclick="window.location.href='flow_modify.jsp?flowId=<%=flowId%>'" value="修改流程"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=button class="button1" onClick="window.location.href='flow_dispose.jsp?flowId=<%=flowId%>'" value=" 办 理 ">
			<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;
			<input name="button" type="button" class="button1" onclick="window.location.href='flow_monitor.jsp?flowId=<%=flowId%>'" value="指定流程监控人员" />
			-->
			</td>
          </tr>
          
          <tr>
            <td height="35" align="center"><!--			<strong class="p14">流 程 内 容<br />
            </strong>
              <%
			int doc_id = wf.getDocId();
			DocumentMgr dm = new DocumentMgr();
			Document doc = dm.getDocument(doc_id);
			%>
			<%=doc.getContent(1)%><br>
              <br>
              <%
			  if (doc!=null) {
				  java.util.Vector attachments = doc.getAttachments(1);
				  java.util.Iterator ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	Attachment am = (Attachment) ir.next(); %>
              <table width="569"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="91" align="right"><img src=images/attach.gif></td>
                  <td width="478">&nbsp; <a target=_blank href="<%=am.getVisualPath() + "/" + am.getDiskName()%>"><%=am.getName()%></a> </td>
                </tr>
              </table>
            <%}
			  }
			  %>
            <br>
            <%if (doc.getType()==1) {
					String[] voptions = doc.getVoteOption().split("\\|");
					int len = voptions.length; %>
            <table width="100%" >
              <form action="?op=vote" name=formvote method="post">
                <input type=hidden name=op value="vote">
                <input type=hidden name=id value="<%=doc.getID()%>">
                <%for (int k=0; k<len; k++) { %>
                <tr>
                  <td width="5%"><%=k+1%>、 </td>
                  <td width="73%"><input class="n" type=radio name=votesel value="<%=k%>">
                      <%=voptions[k]%> </td>
                  <td>&nbsp;</td>
                </tr>
                <% } %>
                <tr>
                  <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;          </td>
                  <td width="22%">&nbsp;</td>
                </tr>
              </form>
            </table>
            <%}%>
            <br>--></td>
          </tr>
    </table></td>
  </tr>
</table>
