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
	// out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
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
	if (re) {
		out.print(StrUtil.Alert_Redirect("保存成功！", request.getRequestURL() + "?id=" + id + "&formCode=" + StrUtil.UrlEncode(formCode)));
		return;
	}
		// out.print(StrUtil.Alert_Back("保存成功！"));
}

if (op.equals("delAttach")) {
	int attachId = ParamUtil.getInt(request, "attachId");
	com.redmoon.oa.visual.Attachment att = new com.redmoon.oa.visual.Attachment(attachId);
	att.del();
}
%>
<title>智能设计-编辑内容</title>
<script src="<%=Global.getRootPath()%>/inc/flow_dispose_js.jsp"></script>
<script src="<%=Global.getRootPath()%>/inc/flow_js.jsp"></script>
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

function SubmitResult() {
	// 检查是否已选择意见
	if (getradio("resultValue")==null || getradio("resultValue")=="") {
		alert("您必须选择一项意见!");
		return false;
	}
	visualForm.op.value='finish';
	visualForm.submit();
}

// 控件完成上传后，调用Operate()
function Operate() {
	// alert(redmoonoffice.ReturnMessage);
}

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=50,left=120,width="+width+",height="+height);
}

var attachCount = 1;
function AddAttach() {
	updiv.innerHTML += "<table width=100%><tr>文件&nbsp;<input type='file' name='filename" + attachCount + "' style='width:300px'><td></td></tr></table>";
	attachCount += 1;
}
</script>
<br />
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr>
    <td align="left" class="right-title">&nbsp;编辑<%=fd.getName()%>记录	 </td>
  </tr>
  <tr>
    <td><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<form action="?op=saveformvalue&id=<%=id%>&formCode=<%=StrUtil.UrlEncode(formCode)%>" name="visualForm" method="post" enctype="multipart/form-data">
        <tr>
          <td align="left">
		  <table width="100%">
            <tr>
              <td><%
			com.redmoon.oa.visual.Render rd = new com.redmoon.oa.visual.Render(request, id, fd);
			out.print(rd.rend());
		  %></td>
            </tr>
          </table>
		  </td>
        </tr>
        <tr>
          <td align="left">文件&nbsp;<input type="file" name="filename" style="width: 300px">
              &nbsp;&nbsp;
              <input name="button" type="button" onclick="AddAttach()" value="增加附件" />
			  <div id=updiv name=updiv></div>          </td>
        </tr>
        <tr>
          <td align="left"><%
com.redmoon.oa.visual.FormDAO fdao = fdm.getFormDAO(id);
Iterator ir = fdao.getAttachments().iterator();
				  while (ir.hasNext()) {
				  	com.redmoon.oa.visual.Attachment am = (com.redmoon.oa.visual.Attachment) ir.next(); %>
            <table width="82%"  border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="5%" height="31" align="right"><img src="<%=Global.getRootPath()%>/images/attach.gif" /></td>
                <td>&nbsp; <a target=_blank href="<%=Global.getRootPath()%>/visual_getfile.jsp?attachId=<%=am.getId()%>"><%=am.getName()%></a>&nbsp;&nbsp;<a href="?op=delAttach&id=<%=id%>&formCode=<%=StrUtil.UrlEncode(formCode)%>&attachId=<%=am.getId()%>">删除</a><br />                </td>
                </tr>
            </table>
            <%}
			  %></td>
        </tr>
        <tr>
          <td height="30" align="center"><input name="id" value="<%=id%>" type="hidden">
          <input type="submit" name="Submit" value=" 修 改 " />
            &nbsp;&nbsp;</td>
        </tr>
      </form>
    </table>
        <br /></td>
  </tr>
</table>
