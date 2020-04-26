<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.task.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑任务</title>
<link href="common.css" rel="stylesheet" type="text/css">
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
</STYLE>
<script>
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function changeexpression(i)
{
	frmAnnounce.expression.value = i;
	if (i==0)
	{
		expressspan.innerHTML = "";
		return;
	}
	expressspan.innerHTML = "<img align=absmiddle src=forum/images/emot/em"+i+".gif>";
}

function setPerson(deptCode, deptName, user)
{
	frmAnnounce.person.value = user;
	frmAnnounce.jobCode.value = deptCode;
}

function frmAnnounce_onsubmit() {
	frmAnnounce.content.value = IframeID.document.body.innerHTML;
}

function window_onload() {
	setHTML(frmAnnounce.content.value);
	cws_Size(320);
}

var attachCount = 1;
function AddAttach() {
	updiv.insertAdjacentHTML("BeforeEnd", "<table width=100%><tr>附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件&nbsp;&nbsp;<input type='file' name='filename" + attachCount + "' size=40><td></td></tr></table>");
	attachCount += 1;
}

function OfficeOperate() {
	alert(frmAnnounce.redmoonoffice.ReturnMessage.substr(0, 4));
}

// 编辑文件
function editdoc(id, attachId)
{
	rmofficeTable.style.display = "";
	frmAnnounce.redmoonoffice.AddField("taskId", id);
	frmAnnounce.redmoonoffice.AddField("attachId", attachId);
	frmAnnounce.redmoonoffice.Open("<%=Global.getRootPath()%>/task_getfile.jsp?taskId=" + id + "&attachId=" + attachId);
}
</script>
</head>
<body leftmargin="0" topmargin="5" onLoad="window_onload()">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%@ include file="task_inc_menu_top.jsp"%>
<br>
<%
int i=0;
int editid = ParamUtil.getInt(request, "editid");
String privurl = request.getParameter("privurl");
String title="",content="",filename="",extname="",person="";
int expression=0;
int type=0;

TaskDb task = new TaskDb();
task = task.getTaskDb(editid);

String op = ParamUtil.get(request, "op");
if (op.equals("delattach")) {
	int attId = ParamUtil.getInt(request, "attachId");
	boolean re = task.delAttachment(attId);
	if (re)
		out.print(StrUtil.Alert("删除成功！"));
	else
		out.print(StrUtil.Alert("删除失败！"));
	task = task.getTaskDb(editid);
}

int rootid = task.getRootId();
title = task.getTitle();
content = task.getContent();
expression = task.getExpression();
filename = task.getFileName();
extname = task.getExt();
person = task.getPerson();
type = task.getType();

TaskDb rootTask = task.getTaskDb(rootid);
%>
<table width="100%" border="0">
  <tr>
    <td height="24"><strong>&nbsp;&nbsp;<img src=images/task/icon-task.gif align="absmiddle">&nbsp;根任务：
      <%if (rootTask.getExpression()!=0) { %>
      <img align="absmiddle" src="forum/images/emot/em<%=rootTask.getExpression()%>.gif" border=0>
      <%}%>
    <a href="task_show.jsp?rootid=<%=rootid%>&showid=<%=rootid%>"><%=task.getTaskDb(rootid).getTitle()%></a></strong></td>
  </tr>
</table>
<table width="98%" border="1" align="center" cellpadding="4" cellspacing="0" class="main">
  <form  name=frmAnnounce method="post" action="task_edit_do.jsp" enctype="MULTIPART/FORM-DATA" onSubmit="return frmAnnounce_onsubmit()">
    <TBODY>
      <tr> 
        <td width="100%" class="right-title"><span id=expressspan> 
          <%if (expression!=0) {%><img align="absmiddle" src="forum/images/emot/em<%=expression%>.gif" border=0><%}%>
          </span>&nbsp;编辑：<font color="#FFFFFF"><input type=hidden name=expression value="<%=expression%>">
          <input type=hidden name=type value="<%=type%>">
        </font><a class="title_white" href="task_show.jsp?rootid=<%=rootid%>&showid=<%=editid%>""><%=title%></a></td>
      </tr>
    </TBODY>
    <TBODY>
	<%if (task.getParentId()!=task.NOPARENT) {%>
      <tr>
        <td>承&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办 
          <input type="text" name="person" readonly size=40 value="<%=person%>">
          <a href=# onClick="javascript:showModalDialog('user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择承办人</a>
		  <input type="checkbox" name="isUseMsg" value="true" checked>消息提醒
		&nbsp;
		<%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
        <input name="isToMobile" value="true" type="checkbox" checked />
短讯提醒
<%}%></td>
      </tr>
	<%}%>
      <tr> 
        <td> 标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题 
          <input name="title" type="text" id="title" size="55" value="<%=title%>" title="不得超过 25 个汉字或50个英文字符" maxlength="80"> 
          <font color="#FFFFFF"> 
          <input type=hidden name=privurl value="<%=privurl%>">
          <input type=hidden name="editid" value="<%=editid%>">
          </font> <span class="tablebody1">
          <input name="jobCode" type="hidden" value="<%=task.getJobCode()%>">
          </span>
		  <%if (task.getParentId()==task.NOPARENT) {%>
          <input type="hidden" name="person" value="<%=person%>">
		  <%}%></td>
      </tr>
      <tr>
        <td>表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;情
          <iframe src="task_iframe_emote.jsp?expression=<%=expression%>" height="25" width="610" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
             
          <a href="#" onClick="changeexpression(0)">取消表情&nbsp;</a></td>
      </tr>
      <tr> 
        <td><table width="100%" border=0 cellspacing=0 cellpadding=0>
            <tr> 
              <td class=tablebody1 valign=top height=30> 附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件 
                <input type="file" name="filename" size=40>
                <input name="button" type=button onClick="AddAttach()" value="增加附件"></td>
            </tr>
          </table><div id=updiv name=updiv></div></td>
      </tr>
      <tr>
        <td>附件：
          <%
					  java.util.Iterator attir = task.getAttachments().iterator();
					  while (attir.hasNext()) {
					  	Attachment att = (Attachment)attir.next();
						String ext = StrUtil.getFileExt(att.getDiskName());
					  %>
            <table width=100%><tr><td style="height: 150%">
			<img src="images/attach.gif" align="absmiddle"><a target="_blank" href="task_getfile.jsp?taskId=<%=task.getId()%>&attachId=<%=att.getId()%>"><%=att.getName()%></a>&nbsp;&nbsp;[<a href="?op=delattach&editid=<%=editid%>&attachId=<%=att.getId()%>&privurl=<%=StrUtil.UrlEncode(privurl)%>">删除</a>]&nbsp;
              <%if (ext.equals("doc") || ext.equals("xls")) {%>
              <a href="javascript:editdoc('<%=task.getId()%>', '<%=att.getId()%>')" title="编辑Office文件">
			  <img src="netdisk/images/btn_edit_office.gif" border="0" align="absmiddle">
			  </a>
              <%}%>
            </td></tr></table>
            <%}%>
		  <table id="rmofficeTable" name="rmofficeTable" style="display:none" width="29%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr>
              <td height="22" align="center" bgcolor="#E3E3E3"><strong>&nbsp;编辑Office文件</strong></td>
            </tr>
            <tr>
              <td align="center" bgcolor="#FFFFFF"><object id="redmoonoffice" classid="CLSID:D01B1EDF-E803-46FB-B4DC-90F585BC7EEE" 
codebase="<%=request.getContextPath()%>/activex/rmoffice.cab#version=2,0,0,1" width="316" height="43" viewastext="viewastext">
                  <param name="Encode" value="utf-8" />
                  <param name="BackColor" value="0000ff00" />
                  <param name="Server" value="<%=Global.server%>" />
                  <param name="Port" value="<%=Global.port%>" />
                  <!--设置是否自动上传-->
                  <param name="isAutoUpload" value="1" />
                  <!--设置文件大小不超过1M-->
                  <param name="MaxSize" value="1024000" />
                  <!--设置自动上传前出现提示对话框-->
                  <param name="isConfirmUpload" value="1" />
                  <!--设置IE状态栏是否显示信息-->
                  <param name="isShowStatus" value="0" />
                  <param name="PostScript" value="<%=Global.virtualPath%>/task_office_upload.jsp" />
                </object>
                  <!--<input name="remsg" type="button" onclick='alert(frmAnnounce.redmoonoffice.ReturnMessage)' value="查看上传后的返回信息" />--></td>
            </tr>
          </table>			
		</td>
      </tr>
      <tr> 
        <td><%@ include file="editor_full/editor.jsp"%></td>
      </tr>
      <tr> 
        <td><div align="center"> 
            <textarea cols="75" name="content" rows="12" wrap="VIRTUAL" title="可以使用Ctrl+Enter直接提交贴子" onkeydown=ctlent() style="display: none"><%=content%></textarea>
            <br>
            <input name="submit" type=submit value=" 发 出 ">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input name="reset" type=reset value=" 重 写 ">
          </div></td>
      </tr>
    </TBODY>
  </form>
</table>
</body>
</html>
