<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.basic.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="com.redmoon.oa.flow.*" %>
<%@ page import="com.redmoon.oa.flow.strategy.*" %>
<HTML><HEAD><TITLE>流程动作设定</TITLE>
<link href="../common.css" rel="stylesheet" type="text/css">
<%
String op = ParamUtil.get(request, "op");
String fieldWrite = ParamUtil.get(request, "hidFieldWrite");
String flowTypeCode = ParamUtil.get(request, "flowTypeCode");
String dept = ParamUtil.get(request, "hidDept");
String nodeMode = ParamUtil.get(request, "hidNodeMode");
if (nodeMode.equals(""))
	nodeMode = "" + WorkflowActionDb.NODE_MODE_ROLE; 
if (op.equals("load"))
	nodeMode = "" + WorkflowActionDb.NODE_MODE_ROLE;
%>
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
<script src="../inc/common.js"></script>
<script language="JavaScript">
function openWin(url,width,height)
{
	var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function OpenFormFieldSelWin() {
	openWin("flow_predefine_form_field_sel.jsp?flowTypeCode=<%=flowTypeCode%>&fieldWrite=" + getFieldWriteValue(), 500, 340);
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

var flag = "";

function ModifyAction() {
	if (flagModify.checked)
		flag = "1";
	else
		flag = "0";
	if (flagDel.checked)
		flag += "1";
	else
		flag += "0";
	if (flagDiscardFlow.checked)
		flag += "1";
	else
		flag += "0";
	if (flagDelFlow.checked)
		flag += "1";
	else
		flag += "0";
	flag += flagSaveArchive.value;
	if (flagDelAttach.checked)
		flag += "1";
	else
		flag += "0";
	if (flagXorRadiate.checked)
		flag += "1";
	else
		flag += "0";
	if (flagXorAggregate.checked)
		flag += "1";
	else
		flag += "0";
	var rankName = rank.options[rank.selectedIndex].text;
	var rel = "0";
	if (relateRoleToOrganization.checked)
		rel = "1";
	window.opener.ModifyAction("", title.value, OfficeColorIndex.value, "", userName.value, userRealName.value, getRadioValue("direction"), rank.value, rankName, rel, fieldWrite.value, checkState.value, dept.value, flag, nodeMode.value, strategy.value);
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

	userName.value = window.opener.getActionJobCode();
	title.value = window.opener.getActionTitle();
	OfficeColorIndex.value = window.opener.getActionColorIndex();
	userRealName.value = window.opener.getActionJobName();
	setRadioValue("direction", window.opener.getActionProxyJobCode());
	rank.value = window.opener.getActionProxyJobName();
	var rel = window.opener.getActionProxyUserRealName();
	if (rel=="1")
		relateRoleToOrganization.checked = true;
	else
		relateRoleToOrganization.checked = false;
	fieldWrite.value = window.opener.getActionFieldWrite();
	checkState.value = window.opener.getActionCheckState();
	
	nodeMode.value = window.opener.getActionNodeMode();
	
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_ROLE%>")
		spanMode.innerHTML = "角色";
	else
		spanMode.innerHTML = "用户";
		
	<%if (dept.equals("")) {%>
		dept.value = window.opener.getActionDept();
	<%}%>
	flag = window.opener.getActionFlag();
	if (flag.length>=1) {
		if (flag.substr(0, 1)!="1")
			flagModify.checked = false;
	}
	if (flag.length>=2) {
		if (flag.substr(1, 1)!="1")
			flagDel.checked = false;
	}
	
	// flag.length长度为2时，是给新创建的节点设置属性
	
	if (flag.length>=3) {
		if (flag.substr(2, 1)!="1")
			flagDiscardFlow.checked = false;
	}
	else
		flagDiscardFlow.checked = false;
	
	if (flag.length>=4) {
		if (flag.substr(3, 1)!="1")
			flagDelFlow.checked = false;
	}
	else
		flagDelFlow.checked = false;
		
	if (flag.length>=5) {
		flagSaveArchive.value = flag.substr(4, 1);
	}
	else
		flagSaveArchive.value = "0";
		
	if (flag.length>=6) {
		if (flag.substr(5, 1)!="1")
			flagDelAttach.checked = false;
	}
	else
		flagDelAttach.checked = false;
		
	if (flag.length>=7) {
		if (flag.substr(6, 1)!="1")
			flagXorRadiate.checked = false;
	}
	else
		flagXorRadiate.checked = false;
	
	if (flag.length>=8) {
		if (flag.substr(7, 1)!="1")
			flagXorAggregate.checked = false;
	}
	else
		flagXorAggregate.checked = false;
		
	strategy.value = window.opener.getActionStrategy();
		
	if (window.opener.getActionType()=="workflow_start") {
		span_direction.style.display = "none";
		span_starter.style.display = "none";
	}
	else if (window.opener.getActionType()=="workflow_action") {
		span_self.style.display = "none";
	}
	// 屏蔽删除标志，不再启用
	span_flag_del.style.display = "none";
	
	document.frames["hiddenframe"].location.replace("flow_predefine_action_modify_getfieldtitle.jsp?flowTypeCode=<%=flowTypeCode%>&fieldWrite=" + fieldWrite.value + "&dept=" + dept.value + "&nodeMode=" + nodeMode.value); // 获取可写表单域的名称
}

function window_onload() {
	onload_win();
}

function openWinDepts() {
	var ret = showModalDialog('../dept_multi_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')
	if (ret==null)
		return;
	dept.value = "";
	deptName.value = "";
	for (var i=0; i<ret.length; i++) {
		if (dept.value=="") {
			dept.value += ret[i][0];
			deptName.value += ret[i][1];
		}
		else {
			dept.value += "," + ret[i][0];
			deptName.value += "," + ret[i][1];
		}
	}
}

function getSelUserNames() {
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_USER%>") {
		if (userName.value=="$self" || userName.value=="$starter" || userName.value=="$userSelect")
			return "";
		else
			return userName.value;
	}
	else
		return "";
}

function getSelUserRealNames() {
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_USER%>") {
		if (userName.value=="$self" || userName.value=="$starter" || userName.value=="$userSelect")
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

function getDepts() {
	return dept.value;
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
	if (relateRoleToOrganization.checked) {
		if (roleCodes.indexOf(",")!=-1) {
			relateRoleToOrganization.checked = false;
			alert("多个角色被选择，角色关联已经被取消！");
		}
	}	
}

function openWinUserRoles() {
	var roleCodes = "";
	if (nodeMode.value=="<%=WorkflowActionDb.NODE_MODE_ROLE%>")
		roleCodes = userName.value
	showModalDialog('../role_multi_sel.jsp?roleCodes=' + roleCodes,window.self,'dialogWidth:526px;dialogHeight:435px;status:no;help:no;');
	return;
	
	var ret = showModalDialog('../userrole_multi_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:480px;status:no;help:no;')
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
	if (relateRoleToOrganization.checked) {
		if (ret.length>1) {
			relateRoleToOrganization.checked = false;
			alert("多个角色被选择，角色关联已经被取消！");
		}
	}
}

function checkRelation() {
	if (relateRoleToOrganization.checked) {
		// if (userName.value.indexOf(",")!=-1) {
		//	alert("当只有一个角色时，才能被关联！");
		//	relateRoleToOrganization.checked = false;
		// }
	}
}
</script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="window_onload()">
<table width="100%"  border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="23" colspan="2" class="right-title">&nbsp;&nbsp;流程动作设定</td>
  </tr>
  <tr>
    <td height="22" colspan="2" align="center" bgcolor="#FFFFFF">
	<span id="span_direction">
	  上一节点至本节点是：<input name="direction" type="radio" value="2" checked="checked">上行&nbsp;<input name="direction" type="radio" value="0">下行&nbsp;<input name="direction" type="radio" value="1">
      平行(含本部门)
      <input name="direction" type="radio" value="<%=WorkflowActionDb.DIRECTION_PARALLEL_MYDEPT_UP%>">
平行(含本部门，找不到则往上寻找)
      &nbsp;
      <input name="direction" type="radio" value="3" checked="checked">本部门<br>
      &nbsp;	  </span>
	  <span id="span_self">
	  	<a title="自动转换为发起人" href="#" onClick="userName.value='$self';userRealName.value='本人';nodeMode.value='1';spanMode.innerHTML='用户'">本人</a>&nbsp;&nbsp;	  </span>
	  <a href="#" onClick="openWinUserRoles()">选择角色</a>&nbsp;&nbsp;<a href="#" onClick="javascript:showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:600px;dialogHeight:480px;status:no;help:no;')">选择用户</a>&nbsp;&nbsp;<!--<a href="#" onClick="userName.value='$deptLeader';userRealName.value='部门领导';jobCode.value='';jobName.value='';proxyJobCode.value='';proxyJobName.value=''">部门领导</a>-->
	<!--&nbsp;&nbsp;<a href="#" onClick="userName.value='<%=WorkflowActionDb.PRE_TYPE_USER_SELECT%>';userRealName.value='用户自选';jobCode.value='';jobName.value='';proxyJobCode.value='';proxyJobName.value=''">用户自选</a>-->
	<span id="span_starter"><a title="自动转换为发起人" href="#" onClick="userName.value='$starter';userRealName.value='自动转换为发起人';nodeMode.value='1';spanMode.innerHTML='发起人'">发起人</a>&nbsp;<a title="由前一用户自行指定" href="#" onClick="userName.value='<%=WorkflowActionDb.PRE_TYPE_USER_SELECT%>';userRealName.value='自选用户';nodeMode.value='1';spanMode.innerHTML='发起人'">自选用户</a></span></td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">动作标题</td>
    <td height="22" bgcolor="#FFFFFF"><input type="text" name="title" style="width: 260px"></td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">职级</td>
    <td height="22" bgcolor="#FFFFFF">
	<select name="rank">
	<option value="">不限定</option>
<%
	RankDb rd = new RankDb();
	java.util.Iterator ir = rd.list().iterator();
	String opts = "";
	while (ir.hasNext()) {
		rd = (RankDb)ir.next();
		opts += "<option value='" + rd.getCode() + "'>" + rd.getName() + "</option>";
	}
	out.print(opts);
%>
	</select>
	Office&nbsp;审批颜色
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
        <input name="checkState" value="<%=WorkflowActionDb.STATE_NOTDO%>" type="hidden"> 
        (需安装签名批注插件)    </td>
  </tr>
  <tr>
    <td width="90" height="22" align="left" bgcolor="#FFFFFF">角色&nbsp;/  用户</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="userName" rows="3" readonly id="userName" style="width: 260px;background-color:#eeeeee"><%=userName%></textarea>
      <input name="nodeMode" type="hidden" size="5" readonly value="<%=nodeMode%>">
      <br>
      <input type=checkbox name="relateRoleToOrganization" value="1" checked title="设为关联后，如果角色中存在有多个用户，系统将自动根据组织机构图就近匹配，采用这种方式时，流程中的处理人员不能处于多个部门中，只有当设为关联时，行文方向才有效" onClick="checkRelation()">
      角色与组织机构(行文方向)、职级、部门相关联
    <font color="red">当前为：<span id="spanMode" name="spanMode"></span></font></td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">名称&nbsp;/&nbsp;姓名</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="userRealName" rows="3" id="userRealName" style="width: 260px"><%=userRealName%></textarea>	</td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">部门</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="deptName" rows="3" readonly id="deptName" style="width: 260px;background-color:#eeeeee"></textarea>
      <a href="javascript:openWinDepts()">选择部门</a>
      <input name="dept" type="hidden" id="dept" value="<%=dept%>"></td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">可写表单域</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="fieldWriteText" rows="3" readonly="" id="fieldWriteText" style="width: 260px;background-color:#eeeeee"></textarea>&nbsp;<a href="javascript:OpenFormFieldSelWin()">选择表单域 </a>
    <input name="fieldWrite" type="hidden" id="fieldWrite" value="<%=fieldWrite%>"></td>
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
	( 当满足条件的用户有多个时 )
	</td>
  </tr>
  <tr>
    <td height="22" align="left" bgcolor="#FFFFFF">标志位</td>
    <td height="22" bgcolor="#FFFFFF"><input type=checkbox name="flagModify" value="1" checked style="display:none">
    <!--可选人员-->
      <span id="span_flag_del">
	  <input type=checkbox name="flagDel" value="1" checked title="节点可被上一节点办理人员删除">&nbsp;可被删除	  </span>
	  <input type="checkbox" name="flagDiscardFlow" value="1" checked>&nbsp;放弃流程
	  <input type="checkbox" name="flagDelFlow" value="1" checked>&nbsp;删除流程
	&nbsp;
	<select name="flagSaveArchive">
	<option value="0" selected>不存档</option>
	<option value="1">手工存档</option>
	<option value="2">自动存档</option>
	</select>
	<br>
	<input type="checkbox" name="flagDelAttach" value="1" checked>&nbsp;删除附件	
	<input type="checkbox" name="flagXorRadiate" value="1" checked title="发散节点有多条路径从其通过，如果置为异或，则只选取其中的一条继续，否则，所有路径都会继续">&nbsp;异或发散
	<input type="checkbox" name="flagXorAggregate" value="1" checked title="聚合节点有多条路径汇合，如果置为异步，则只要有其中的一条到达，节点就会被激活，否则，只有当所有路径都到达后才会继续">	异或聚合</td>
  </tr>
  <tr align="center">
    <td height="28" colspan="2" bgcolor="#FFFFFF"><input name="okbtn" type="button" class="button1" onClick="ModifyAction()" value=" 确 定 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="cancelbtn" type="button" class="button1" onClick="window.close()" value=" 取 消 ">
<iframe id=hiddenframe name=hiddenframe src="flow_predefine_action_modify_getfieldtitle.jsp" width=0 height=0></iframe></td>
  </tr>
</table>
</BODY></HTML>
