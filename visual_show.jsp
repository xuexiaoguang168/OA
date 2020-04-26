<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.visual.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	// out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	// return;
}
String myname = privilege.getUser( request );

String op = ParamUtil.get(request, "op");

String formCode = ParamUtil.get(request, "formCode");
if (formCode.equals("")) {
	out.print(SkinUtil.makeErrMsg(request, "编码不能为空！"));
	return;
}

int id = ParamUtil.getInt(request, "id");
FormMgr fm = new FormMgr();
FormDb fd = fm.getFormDb(formCode);

com.redmoon.oa.visual.FormDAOMgr fdm = new com.redmoon.oa.visual.FormDAOMgr(fd);

if (op.equals("saveformvalue")) {
	boolean re = false;
	try {
		re = fdm.update(application, request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("保存成功！", "visual_edit.jsp?id=" + id + "&formCode=" + StrUtil.UrlEncode(formCode)));
}

if (op.equals("delAttach")) {
	int attachId = ParamUtil.getInt(request, "attachId");
	com.redmoon.oa.visual.Attachment att = new com.redmoon.oa.visual.Attachment(attachId);
	att.del();
}
%>
<title>智能设计-添加内容</title>
<script src="<%=Global.getRootPath()%>/inc/flow_dispose_js.jsp"></script>
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
</script>
<br />
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="left"><table width="100%">
      <form name="flowForm" id="flowForm">
        <tr>
          <td>
		  <%
			com.redmoon.oa.visual.Render rd = new com.redmoon.oa.visual.Render(request, id, fd);
			out.print(rd.report());
		  %>
		  </td>
        </tr>
      </form>
    </table></td>
  </tr>
  <tr>
    <td align="left"></td>
  </tr>
  <tr>
    <td align="left"><%
com.redmoon.oa.visual.FormDAO fdao = fdm.getFormDAO(id);
Iterator ir = fdao.getAttachments().iterator();
				  while (ir.hasNext()) {
				  	com.redmoon.oa.visual.Attachment am = (com.redmoon.oa.visual.Attachment) ir.next(); %>
        <table width="85%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="5%" height="31" align="right"><img src="<%=Global.getRootPath()%>/images/attach.gif" /></td>
            <td>&nbsp; <a target="_blank" href="<%=Global.getRootPath()%>/visual_getfile.jsp?attachId=<%=am.getId()%>"><%=am.getName()%></a>&nbsp;&nbsp;<a href="?op=delAttach&amp;id=<%=id%>&amp;formCode=<%=StrUtil.UrlEncode(formCode)%>&amp;attachId=<%=am.getId()%>"></a><br />
            </td>
          </tr>
        </table>
      <%}
			  %></td>
  </tr>
  <tr>
    <td height="30" align="center"><input name="id" value="<%=id%>" type="hidden" />
      &nbsp;&nbsp;
      <input name="Submit" type="button" class="button1" onclick="showFormReport()" value="查看表单"/></td>
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
</script>
