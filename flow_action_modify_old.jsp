<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="com.redmoon.oa.flow.*" %>
<HTML><HEAD><TITLE>流程动作设定</TITLE>
<link href="common.css" rel="stylesheet" type="text/css">
<%
String op = ParamUtil.get(request, "op");
int flowId = ParamUtil.getInt(request, "flowId");
String fieldWrite = ParamUtil.get(request, "hidFieldWrite");
WorkflowDb wfd = new WorkflowDb();
wfd = wfd.getWorkflowDb(flowId);
String title = ParamUtil.get(request, "hidTitle");
%>
<script language="JavaScript">
function openWin(url,width,height)
{
	var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function OpenFormFieldSelWin() {
	openWin("flow_form_field_sel.jsp?flowId=<%=flowId%>&fieldWrite=" + getFieldWriteValue(), 500, 340);
}

function setPerson(deptCode, deptName, user)
{
	jobCode.value = deptCode;
	jobName.value = deptName;
	userName.value = user;
	form1.hidTitle.value = title.value;
	form1.hidJobCode.value = deptCode;
	form1.hidUserName.value = user;
	form1.hidFieldWrite.value = fieldWrite.value;
	form1.submit();
}

function getFieldWriteValue() {
	return fieldWrite.value;
}

function setFieldWriteValue(v) {
	fieldWrite.value = v;
}

function setFieldWriteText(v) {
	fieldWriteText.value = v;
}

function setDeptName(v) {
	deptName.value = v;
}

function getDept() {
	return dept.value;
}

function ModifyAction() {
	window.opener.ModifyAction(userName.value, title.value, OfficeColorIndex.value, userRealName.value, jobCode.value, jobName.value, proxyJobCode.value, proxyJobName.value, proxyUserName.value, proxyUserRealName.value, fieldWrite.value, checkState.value);
	window.close();
}

function onload_win() {
    var STATE_NOTDO = <%=WorkflowActionDb.STATE_NOTDO%>;
    var STATE_IGNORED = <%=WorkflowActionDb.STATE_IGNORED%>;
	var STATE_DOING = <%=WorkflowActionDb.STATE_DOING%>;
    var STATE_RETURN = <%=WorkflowActionDb.STATE_RETURN%>;
    var STATE_FINISHED = <%=WorkflowActionDb.STATE_FINISHED%>;
	
	var chkState = window.opener.getActionCheckState();
	if (chkState==STATE_FINISHED || chkState==STATE_DOING) {
		alert("动作已完成或者正在处理中时，不能被编辑！");
		window.close();
		return;
	}
	userName.value = window.opener.getActionUser();
	form1.hidUserName.value = userName.value;
	title.value = window.opener.getActionTitle();
	OfficeColorIndex.value = window.opener.getActionColorIndex();
	userRealName.value = window.opener.getActionUserRealName();
	jobCode.value = window.opener.getActionJobCode();
	jobName.value = window.opener.getActionJobName();
	proxyJobCode.value = window.opener.getActionProxyJobCode();
	proxyJobName.value = window.opener.getActionProxyJobName();
	proxyUserName.value = window.opener.getActionProxyUserName();
	proxyUserRealName.value = window.opener.getActionProxyUserRealName();
	fieldWrite.value = window.opener.getActionFieldWrite();
	checkState.value = window.opener.getActionCheckState();

	dept.value = window.opener.getActionDept();
	nodeMode.value = window.opener.getActionNodeMode();

	document.frames["hiddenframe"].location.replace("flow_action_modify_getfieldtitle.jsp?flowTypeCode=<%=StrUtil.UrlEncode(wfd.getTypeCode())%>&fieldWrite=" + fieldWrite.value + "&dept=" + dept.value + "&nodeMode=" + nodeMode.value); // 获取可写表单域的名称
}

// 当用模式对话框打开本页时，已放弃
function onload_modwin() {
	userName.value = dialogArguments.getActionUser();
	form1.hidUserName.value = userName.value;
	title.value = dialogArguments.getActionTitle();
	OfficeColorIndex.value = dialogArguments.getActionColorIndex();
}

function window_onload() {
	<%if (!op.equals("load")) {%>
		onload_win();
	<%}else{%>
		fieldWrite.value = "<%=fieldWrite%>";
		dept.value = window.opener.getActionDept();
		nodeMode.value = window.opener.getActionNodeMode();
		document.frames["hiddenframe"].location.replace("flow_action_modify_getfieldtitle.jsp?flowTypeCode=<%=StrUtil.UrlEncode(wfd.getTypeCode())%>&fieldWrite=" + fieldWrite.value + "&dept=" + dept.value + "&nodeMode=" + nodeMode.value); // 获取可写表单域的名称
	<%}%>
}

function selPost() {
	if (nodeMode.value=="1")
		showModalDialog('post_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:480px;status:no;help:no;');
	else
		showModalDialog('post_sel_one.jsp?posts=' + dept.value,window.self,'dialogWidth:500px;dialogHeight:280px;status:no;help:no;');
}
</script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="window_onload()">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="cfg" scope="page" class="com.redmoon.oa.Config"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	// out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	// return;
}

String userName = "";
String userRealName = "";
String jobCode = "";
String jobName = "";
String proxy = ""; // 代理者
String proxyJobName = "";
String proxyUserName = "";
String proxyUserRealName = "";

if (op.equals("load")) {
	String userName1 = ParamUtil.get(request, "hidUserName");
	String jobCode1 = ParamUtil.get(request, "hidJobCode");
	PostMgr pm = new PostMgr();
	PostDb pd = pm.getPostDb(jobCode1);
	jobCode = jobCode1;
	jobName = pd.getName();
	
	UserDb ud = null;
	UserMgr um = new UserMgr();
	ud = um.getUserDb(userName1);
	if (ud!=null && ud.isLoaded()) {
		userName = ud.getName();
		userRealName = ud.getRealName();
		proxy = ud.getProxyNow();
		// System.out.println("proxy:" + proxy);
		if (proxy!=null && !proxy.equals("")) {
			// 检查是否在代理时段内
			pd = pm.getPostDb(proxy);
			proxyJobName = pd.getName();
			proxyUserName = pd.getUserName();
			ud = um.getUserDb(proxyUserName);
			proxyUserRealName = ud.getRealName();
		}
	}
	
}
%>
<table width="100%" height="293"  border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr>
    <td height="23" colspan="4" background="images/top-right.gif" class="right-title">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;流程动作设定</td>
  </tr>
  <tr>
    <td width="6%" align="center">&nbsp;</td>
    <td width="20%" height="22" align="left">真实姓名</td>
    <td width="63%" height="22"><input name="userRealName" type="text" id="userRealName" value="<%=userRealName%>" readonly>
    <input id="userName" name="userName" value="<%=userName%>" type="hidden">
    <a href="#" onClick="selPost()">选择用户</a></td>
    <td width="11%"><form id="form1" name="form1" action="?op=load" method="post" target="_self">
      <input type=hidden name="hidTitle" value="<%=title%>">
      <input type=hidden name="hidJobCode" value="<%=jobCode%>">
	  <input type=hidden name="hidUserName" value="<%=userName%>">
	  <input type=hidden name="hidFieldWrite" value="<%=fieldWrite%>">
	  <input type="hidden" name="flowId" value="<%=flowId%>">
    </form></td>
  </tr>
  
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">动作标题</td>
    <td height="22" colspan="2"><input type="text" name="title" value="<%=title%>"></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">审批颜色</td>
    <td height="22" colspan="2">
      <SELECT name="OfficeColorIndex" style="width:80px">
        <option selected style="BACKGROUND: red" value="6"></option>
        <option style="BACKGROUND: Turquoise" value="3"></option>
        <option style="BACKGROUND: #00ff00" value="4"></option>
        <option style="BACKGROUND: Pink" value="5"></option>
        <option style="BACKGROUND: yellow" value="7"></option>
        <option style="BACKGROUND: black" value="1"></option>
        <option style="BACKGROUND: blue" value="2"></option>
        <option style="BACKGROUND: white" value="8"></option>
        <option style="BACKGROUND: DarkBlue" value="9"></option>
        <option style="BACKGROUND: Teal" value="10"></option>
        <option style="BACKGROUND: green" value="11"></option>
        <option style="BACKGROUND: Violet" value="12"></option>
        <option style="BACKGROUND: DarkRed" value="13"></option>
        <option style="BACKGROUND: #FFCC67" value="14"></option>
        <option style="BACKGROUND: #808080" value="15"></option>
        <option style="BACKGROUND: #C0C0C0" value="16"></option>
    </SELECT>
      <input name="checkState" type="hidden" value="<%=WorkflowActionDb.STATE_NOTDO%>">
	  </td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">职位名称</td>
    <td height="22" colspan="2"><input name="jobName" type="text" id="jobName" value="<%=jobName%>" readonly>
    <input name="jobCode" type="hidden" id="jobCode" value="<%=jobCode%>"></td>
  </tr>
  
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">代理职位名称</td>
    <td height="22" colspan="2"><input name="proxyJobName" type="text" id="proxyJobName" value="<%=proxyJobName%>" readonly>
    <input name="proxyJobCode" type="hidden" id="proxyJobCode" value="<%=proxy%>"></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">代理人用户名</td>
    <td height="22" colspan="2"><input name="proxyUserName" type="text" id="proxyUserName" value="<%=proxyUserName%>" readonly></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">代理人真实姓名</td>
    <td height="22" colspan="2"><input name="proxyUserRealName" readonly type="text" id="proxyUserRealName" value="<%=proxyUserRealName%>"></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">可写表单域</td>
    <td height="22" colspan="2">
	  <input name="fieldWrite" type="hidden" id="fieldWrite" value="<%=fieldWrite%>">
      <input name="fieldWriteText" type="text" id="fieldWriteText" value="" readonly style="width: 200px">
		  </td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td height="22" align="left">可选职位 / 部门</td>
    <td height="22" colspan="2"><input name="dept" type="hidden" id="dept" value="">
        <input name="deptName" type="text" id="deptName" value="" readonly style="width: 200px;background-color:#eeeeee">
        <input name="nodeMode" type="hidden" size="5" readonly></td>
  </tr>
  <tr align="center">
    <td height="28" colspan="4"><input name="okbtn" type="button" class="button1" onClick="ModifyAction()" value=" 确 定 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="cancelbtn" type="button" class="button1" onClick="window.close()" value=" 取 消 ">
<iframe id=hiddenframe name=hiddenframe src="flow_action_modify_getfieldtitle.jsp?flowId=<%=flowId%>&fieldWrite=<%=fieldWrite%>" width="0" height="0"></iframe></td>
  </tr>
</table>
</BODY></HTML>
