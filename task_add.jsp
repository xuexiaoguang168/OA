<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.task.*"%>
<%@ page import="cn.js.fan.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发起任务</title>
<link href="common.css" rel="stylesheet" type="text/css">
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
		expressspan.innerHTML = "无";
		return;
	}
	expressspan.innerHTML = "<img align=absmiddle src=sq/forum/images/emot/em"+i+".gif>";
}

function setPerson(deptCode, deptName, user, realName)
{
	frmAnnounce.person.value = user;
	frmAnnounce.jobCode.value = deptCode;
	frmAnnounce.userRealName.value = realName;
}

function frmAnnounce_onsubmit() {
	frmAnnounce.content.value = IframeID.document.body.innerHTML;
}

function window_onload() {
	cws_Size(320);
}

var attachCount = 1;
function AddAttach() {
	updiv.innerHTML += "<table width=100%><tr>附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件&nbsp;&nbsp;<input type='file' name='filename" + attachCount + "' size=40><td></td></tr></table>";
	attachCount += 1;
}
</script>
</head>
<body leftmargin="0" topmargin="5" onLoad="window_onload()">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%@ include file="task_inc_menu_top.jsp"%>
<br>
<%
String priv = "read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = fchar.getNullStr(request.getParameter("op"));
if (op.equals(""))
{
	out.print(fchar.Alert("您未选择操作方式！"));
	return;
}
String typedesc = "";//类型描述
int type=0;
if (op.equals("new"))
{
	type = 0;
	typedesc = "发起新任务";
	priv="task";
	if (!privilege.isUserPrivValid(request,priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
if (op.equals("newsubtask"))
{
	type = 1;
	typedesc = "发起子任务";
	priv="task";
	if (!privilege.isUserPrivValid(request,priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}

if (op.equals("addresult"))
{
	type = 2;
	typedesc = "汇报办理结果";
}
if (op.equals("hurry"))
{
	type = 3;
	typedesc = "催办";
}
String parentid = fchar.getNullStr(request.getParameter("parentid"));

// 如果父节点，或者根节点为已完成状态，则不可添加
TaskDb ptd = new TaskDb();
ptd = ptd.getTaskDb(Integer.parseInt(parentid));
if (ptd.getStatus()==ptd.STATUS_FINISHED) {
	out.print(StrUtil.Alert_Back("任务已处于完成状态"));
	return;
}
if (ptd.getStatus()==ptd.STATUS_DISCARD) {
	out.print(StrUtil.Alert_Back("任务已处于作废状态"));
	return;
}

TaskDb rootTask = ptd.getTaskDb(ptd.getRootId());
if (rootTask.getStatus()==rootTask.STATUS_FINISHED) {
	out.print(StrUtil.Alert_Back("根任务已处于完成状态"));
	return;
}
if (rootTask.getStatus()==rootTask.STATUS_DISCARD) {
	out.print(StrUtil.Alert_Back("根任务已处于作废状态"));
	return;
}

String privurl = ParamUtil.get(request, "privurl");
String person = ParamUtil.get(request, "person");

TaskDb td = null;
if (!op.equals("new")) {
	int pid = Integer.parseInt(parentid);
	td = new TaskDb();
	td = td.getTaskDb(pid);
	String icon = "";
  	if (td.getType()==0)
		icon = "images/task/icon-task.gif";
  	else if (td.getType()==1)
		icon = "images/task/icon-subtask.gif";
  	else if (td.getType()==2)
		icon = "images/task/icon-result.gif";
  	else if (td.getType()==3)
		icon = "images/task/icon-hurry.gif";
  	else
		icon = "images/task/icon-task.gif";
%>
<table align="center" width="98%"><tr><td width="80"><img src="<%=icon%>" border=0>&nbsp;<strong>父任务</strong>：</td>
  <td>
<%if (td.getExpression()!=0) { %>
	<img align="absmiddle" src="forum/images/emot/em<%=td.getExpression()%>.gif" border=0> 
<%}%>  
<a href="task_show.jsp?rootid=<%=td.getRootId()%>&showid=<%=parentid%>"><%=td.getTitle()%></a></td>
</tr></table>
<%}%>
<table width="98%" border="0" align="center" cellpadding="4" cellspacing="0" class="main">
  <form id="frmAnnounce" name=frmAnnounce method="post" action="task_add_do.jsp?op=<%=op%>" enctype="MULTIPART/FORM-DATA" onSubmit="return frmAnnounce_onsubmit()">
    <TBODY>
      <tr> 
        <td class="right-title"> <font color="#FFFFFF">&nbsp; <span id=expressspan></span>&nbsp;<%=typedesc%>  
          <input type=hidden name=type value="<%=type%>">
          <input type=hidden name=op value="<%=op%>">
          
          <input type=hidden name=expression value="0">
          <input type=hidden name=parentid value="<%=parentid%>">
          <input type=hidden name=privurl value="<%=privurl%>">
          </font></td>
      </tr>
    </TBODY>
    <TBODY>
      <tr>
        <td>承&nbsp;&nbsp;办&nbsp;&nbsp;者
          <%if (op.equals("hurry") || op.equals("addresult")) {//如果是催办或汇报办理结果，则不需再选择承办人%>
	<input type="text" name="person" readonly size=40 value="<%=person%>">
<%}else{
	String userRealName = "";
	if (!person.equals("")) {
		com.redmoon.oa.person.UserDb ud = new com.redmoon.oa.person.UserDb();
		ud = ud.getUserDb(person);
		if (ud!=null && ud.isLoaded()) {
			userRealName = ud.getRealName();
		}
	}
%>
	<input type="hidden" name="person" size=40 value="<%=person%>">
	<input type="text" name="userRealName" readonly size="40" value="<%=userRealName%>">
	<a href=# onClick="javascript:showModalDialog('user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择承办人</a> 
<%}%>		  <span class="tablebody1">
<input name="jobCode" type="hidden">
<input type="checkbox" name="isUseMsg" value="true" checked>
消息提醒&nbsp;
<%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
<input name="isToMobile" value="true" type="checkbox" checked />
短讯提醒
<%}%>
</span></td>
      </tr>
      <tr> 
        <td width="100%"> 标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题&nbsp;&nbsp; 
        <input name="title" type="text" id="topic" size="55" maxlength="80" value="<%=(td==null && !op.equals("hurry"))?"":"请完成：" + td.getTitle()%>">        </td>
      </tr>
      <tr>
        <td>表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;情
          <iframe src="task_iframe_emote.jsp" height="25" width="610" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
             
        <a href="#" onClick="changeexpression(0)">取消表情&nbsp;</a></td>
      </tr>
      <tr> 
        <td><table width="100%" border=0 cellspacing=0 cellpadding=0>
            <tr> 
              <td class=tablebody1 valign=top height=30> 附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件 
                <input type="file" name="filename" size=40>
                <input name="content" type="hidden">
				<textarea name="content_hid" style="display:none"> </textarea>			  <input name="button" type=button onClick="AddAttach()" value="增加附件"></td>
            </tr>
          </table><div id=updiv name=updiv></div></td>
      </tr>
      <tr> 
        <td><%@ include file="editor_full/editor.jsp"%></td>
      </tr>
      <tr> 
        <td align="center">
            <input name="submit" type=submit value=" 确 定 ">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input name="reset" type=reset value=" 重 写 ">          </td>
      </tr>
    </TBODY>
  </form>
</table>
<script>
IframeID.document.body.innerHTML = frmAnnounce.content_hid.value;
</script>
</body>
</html>
