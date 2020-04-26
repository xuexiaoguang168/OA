<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.flow.WorkflowPredefineDb"%>
<%@ page import="com.redmoon.oa.flow.WorkflowDb"%>
<%@ page import="com.redmoon.oa.flow.Render"%>
<%@ page import="com.redmoon.oa.flow.WorkflowMgr"%>
<%@ page import="com.redmoon.oa.flow.WorkflowActionDb"%>
<%@ page import="com.redmoon.oa.fileark.DirView"%>
<script src="inc/flow_dispose_js.jsp"></script>
<script>
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

function ShowChild(imgobj, name)
{
	var tableobj = findObj("childof"+name);
	if (tableobj.style.display=="none")
	{
		tableobj.style.display = "";
		if (imgobj.src.indexOf("i_puls-root-1.gif")!=-1)
			imgobj.src = "images/i_puls-root.gif";
		if (imgobj.src.indexOf("i_plus-1-1.gif")!=-1)
			imgobj.src = "images/i_plus2-2.gif";
		if (imgobj.src.indexOf("i_plus-1.gif")!=-1)
			imgobj.src = "images/i_plus2-1.gif";
	}
	else
	{
		tableobj.style.display = "none";
		if (imgobj.src.indexOf("i_puls-root.gif")!=-1)
			imgobj.src = "images/i_puls-root-1.gif";
		if (imgobj.src.indexOf("i_plus2-2.gif")!=-1)
			imgobj.src = "images/i_plus-1-1.gif";
		if (imgobj.src.indexOf("i_plus2-1.gif")!=-1)
			imgobj.src = "images/i_plus-1.gif";
	}
}

function selectDir(dirCode, dirName) {
	flowForm.dirCode.value = dirCode;
	spanDirName.innerHTML = dirName;
}

function flowForm_onsubmit() {
	if (flowForm.dirCode.value=="") {
		alert("请选择所属目录！");
		return false;
	}
	if (flowForm.title.value=="") {
		alert("标题不能为空！");
		return false;
	}
	flowForm.content.value = formDiv.innerHTML;
}
</script>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
int flowId = ParamUtil.getInt(request, "flowId");
int actionId = ParamUtil.getInt(request, "actionId");
WorkflowMgr wfm = new WorkflowMgr();
WorkflowDb wf = wfm.getWorkflowDb(flowId);
WorkflowActionDb wa = new WorkflowActionDb();
wa = wa.getWorkflowActionDb(actionId);

WorkflowPredefineDb wpd = new WorkflowPredefineDb();
wpd = wpd.getDefaultPredefineFlow(wf.getTypeCode());
String dirCode = wpd.getDirCode();
String dirName = "";
if (!dirCode.equals("")) {
	cn.js.fan.module.cms.Leaf lf = new cn.js.fan.module.cms.Leaf();
	lf = lf.getLeaf(dirCode);
	if (lf!=null)
		dirName = lf.getName();
}
%>
<title>存档</title><table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr>
    <td height="23" valign="bottom" class="right-title">&nbsp;&nbsp;<span>存档 - 请选择存档目录和文件 </span></td>
  </tr>
  <tr>
    <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="33%" align="center" valign="top"><%
Directory dir = new Directory();
Leaf rootLeaf = dir.getLeaf(Leaf.ROOTCODE);
// DirectoryView dv = new DirectoryView(rootLeaf);
DirView dv = new DirView(request, rootLeaf);
dv.ListFunc(out, "_self", "selectDir", "", "" );
%></td>
          <td width="67%" valign="top">
		  <table width="98%" border="0" cellpadding="5" cellspacing="0" class="tableframe">
		  <form id=flowForm name=flowForm action="flow_doc_archive_save_do.jsp" method=post onsubmit="return flowForm_onsubmit()" target="_self">
            <tr>
              <td>目录：<input name=dirCode value="<%=dirCode%>" type=hidden><span id=spanDirName name=spanDirName><%=dirName%></span></td>
            </tr>
            <tr>
              <td>标题：<input name="title" value="<%=wf.getTitle()%>" size="50" reserve="true">
			  <input name="content" type="hidden" value="" />
			  <input name="flowId" type="hidden" value="<%=flowId%>" />
			  <input name="actionId" type="hidden" value="<%=actionId%>" />
			  </td>
            </tr>
            <tr>
              <td>表单：</td>
            </tr>
            <tr>
              <td>
					<%
				  int doc_id = wf.getDocId();
				  com.redmoon.oa.flow.DocumentMgr dm = new com.redmoon.oa.flow.DocumentMgr();
				  com.redmoon.oa.flow.Document doc = dm.getDocument(doc_id);
				  Render rd = new Render(request, wf, doc);
				  out.print(rd.report());
					%>				
			  </td>
            </tr>
            <tr>
              <td>附件：</td>
            </tr>
            <tr>
              <td><%
		  java.util.Vector attachments = doc.getAttachments(1);
		  java.util.Iterator ir = attachments.iterator();
  
		  while (ir.hasNext()) {
		  	com.redmoon.oa.flow.Attachment am = (com.redmoon.oa.flow.Attachment) ir.next(); %>
                <table width="100%"  border="0" cellpadding="0" cellspacing="0" bordercolor="#D6D3CE">
                  <tr>
                    <td width="5%" height="24" align="right"><img src="images/attach.gif" /></td>
                    <td width="73%">&nbsp; <a target="_blank" href="<%=am.getVisualPath() + "/" + am.getDiskName()%>"><%=am.getName()%></a><br />                    </td>
                    <td width="22%"><input type="checkbox" name="attachIds" value="<%=am.getId()%>" checked="checked" />
                      是否存档</td>
                  </tr>
                </table>
                <%}%></td>
            </tr>
            <tr>
              <td align="center"><input type="submit" value=" 保 存 " />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="reset" name="Submit2" value=" 重 置 " /></td>
            </tr>
			</form>
			</table>
          </td>
        </tr>
        <tr>
          <td colspan="2" align="center">&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>
