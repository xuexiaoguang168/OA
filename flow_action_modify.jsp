<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.basic.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="com.redmoon.oa.flow.*" %>
<%@ page import="com.redmoon.oa.flow.strategy.*" %>
<HTML><HEAD><TITLE>流程动作设定</TITLE>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="cfg" scope="page" class="com.redmoon.oa.Config"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String userName = "";
String userRealName = "";
%>
<script src="inc/common.js"></script>
<script language="JavaScript">
function openWin(url,width,height)
{
	var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function ModifyAction() {
	var OfficeColorIndex = dialogArguments.getActionColorIndex();
	var proxyJobCode = dialogArguments.getActionProxyJobCode();
	var proxyJobName = dialogArguments.getActionProxyJobName();
	var proxyUserName = dialogArguments.getActionProxyUserName();
	var proxyUserRealName = dialogArguments.getActionProxyUserRealName();
	var fieldWrite = dialogArguments.getActionFieldWrite();
	var checkState = dialogArguments.getActionCheckState();
	dialogArguments.ModifyAction("", title.value, OfficeColorIndex, "", userName.value, userRealName.value, proxyJobCode, proxyJobName, proxyUserName, proxyUserRealName, fieldWrite, checkState, nodeMode.value, strategy.value);
	alert("请点击保存按钮，然后继续操作！");
	window.close();
}

function onload_win() {
    var STATE_NOTDO = <%=WorkflowActionDb.STATE_NOTDO%>;
    var STATE_IGNORED = <%=WorkflowActionDb.STATE_IGNORED%>;
	var STATE_DOING = <%=WorkflowActionDb.STATE_DOING%>;
    var STATE_RETURN = <%=WorkflowActionDb.STATE_RETURN%>;
    var STATE_FINISHED = <%=WorkflowActionDb.STATE_FINISHED%>;
	
	var chkState = dialogArguments.getActionCheckState();
	if (chkState==STATE_FINISHED || chkState==STATE_DOING) {
		alert("动作已完成或者正在处理中时，不能被编辑！");
		window.close();
		return;
	}

	title.value = dialogArguments.getActionTitle();
	userName.value = dialogArguments.getActionJobCode();
	userRealName.value = dialogArguments.getActionJobName();
	nodeMode.value = dialogArguments.getActionNodeMode();
	
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_ROLE%>")
		spanMode.innerHTML = "角色";
	else
		spanMode.innerHTML = "用户";
		
	dept.value = dialogArguments.getActionDept();
	
	strategy.value = dialogArguments.getActionStrategy();
	
	document.frames["hiddenframe"].location.replace("flow_action_modify_getfieldtitle.jsp?dept=" + dept.value); // 获取可写部门的名称
}

function window_onload() {
	onload_win();
}

function getSelUserNames() {
	if (userName.value=="<%=WorkflowActionDb.PRE_TYPE_USER_SELECT%>") {
		return "";
	}
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_USER%>") {
		if (userName.value=="$self")
			return "";
		else
			return userName.value;
	}
	else
		return "";
}

function getSelUserRealNames() {
	if (userName.value=="<%=WorkflowActionDb.PRE_TYPE_USER_SELECT%>") {
		return "";
	}
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_USER%>") {
		if (userName.value=="$self")
			return "";
		else
			return userRealName.value;
	}
	else
		return "";
}

function getUserRoles() {
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_ROLE%>") {
		return userName.value;
	}
	else
		return "";
}

function getDept() {
	return dept.value;
}

function setDeptName(v) {
	deptName.value = v;
}

function setUsers(users, userRealNames) {
	userName.value = users;
	userRealName.value = userRealNames;
	nodeMode.value = "<%=WorkflowActionDb.NODE_MODE_USER%>";	
	
	spanMode.innerHTML = "用户";	
}

function setRoles(roleCodes, roleDescs) {
	userName.value = roleCodes;
	userRealName.value = roleDescs;
	nodeMode.value = "<%=WorkflowActionDb.NODE_MODE_ROLE%>";
	spanMode.innerHTML = "角色";
}

function openWinUserRoles() {
	var roleCodes = "";
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_ROLE%>")
		roleCodes = userName.value
	showModalDialog('role_multi_sel.jsp?roleCodes=' + roleCodes,window.self,'dialogWidth:526px;dialogHeight:435px;status:no;help:no;');
	return;
	
	var ret = showModalDialog('userrole_multi_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:480px;status:no;help:no;')
	if (ret==null)
		return;
	
	userName.value = "";
	userRealName.value = "";
	// deptName.value = "";
	// dept.value = "";
	for (var i=0; i<ret.length; i++) {
		if (userRealName.value=="") {
			userName.value += ret[i][0];
			userRealName.value += ret[i][1];
		}
		else {
			userName.value += "," + ret[i][0];
			userRealName.value += "," + ret[i][1];
		}
	}
	nodeMode.value = "<%=WorkflowActionDb.NODE_MODE_ROLE%>";
	spanMode.innerHTML = "角色";
}
</script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="window_onload()">
<table width="100%"  border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="23" colspan="2" class="right-title">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;流程动作设定</td>
  </tr>
  <tr>
    <td height="22" colspan="2" align="center" bgcolor="#FFFFFF"><a href="#" onClick="openWinUserRoles()">选择角色</a>&nbsp;&nbsp;<a href="#" onClick="javascript:showModalDialog('user_multi_sel.jsp',window.self,'dialogWidth:600px;dialogHeight:480px;status:no;help:no;')">选择用户</a>&nbsp;<!--<a href="#" onClick="userName.value='$deptLeader';userRealName.value='部门领导';jobCode.value='';jobName.value='';proxyJobCode.value='';proxyJobName.value=''">部门领导</a>--></td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">动作标题</td>
    <td height="22" bgcolor="#FFFFFF"><input type="text" name="title" style="width: 260px"></td>
  </tr>
  <tr>
    <td width="90" height="22" align="left" bgcolor="#FFFFFF">角色&nbsp;/  用户</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="userName" rows="3" readonly id="userName" style="display:none;width: 260px;background-color:#eeeeee"><%=userName%></textarea>
      <input name="nodeMode" type="hidden" size="5" readonly value="">
    <font color="red">当前为：<span id="spanMode" name="spanMode"></span></font></td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">名称&nbsp;/&nbsp;姓名</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="userRealName" rows="3" id="userRealName" style="width: 260px"><%=userRealName%></textarea>	</td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">部门</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="deptName" rows="3" readonly id="deptName" style="width: 260px;background-color:#eeeeee"></textarea>
      <input name="dept" type="hidden" id="dept" value=""></td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">策略</td>
    <td height="22" bgcolor="#FFFFFF">
	<select name="strategy">
	<option value="">用户指定</option>
<%
StrategyMgr sm = new StrategyMgr();
Vector smv = sm.getAllStrategy();
String smopts = "";
if (smv!=null) {
	Iterator smir = smv.iterator();
	while (smir.hasNext()) {
		StrategyUnit su = (StrategyUnit)smir.next();
		smopts += "<option value='" + su.getCode() + "'>" + su.getName() + "</option>";
	}
}
out.print(smopts);
%>
	</select>
	( 当满足条件的用户有多个时 )	</td>
  </tr>
  
  <tr align="center">
    <td height="28" colspan="2" bgcolor="#FFFFFF"><input name="okbtn" type="button" class="button1" onClick="ModifyAction()" value=" 确 定 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="cancelbtn" type="button" class="button1" onClick="window.close()" value=" 取 消 ">
<iframe id=hiddenframe name=hiddenframe src="flow_action_modify_getfieldtitle.jsp" width=0 height=0></iframe></td>
  </tr>
</table>
</BODY></HTML>
