<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="privmgr" scope="page" class="com.redmoon.oa.pvg.PrivMgr"/>
<html>
<head>
<title>设置用户组、角色</title>
<link href="default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
String op = ParamUtil.get(request, "op");
boolean isEdit = false;
String name = ParamUtil.get(request, "name");
UserDb user = new UserDb();
if (!name.equals(""))
	user = user.getUserDb(name);
if (op.equals("edit")) {
	isEdit = true;
	name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		StrUtil.Alert_Back("用户名不能为空！");
		return;
	}
}
if (op.equals("setuserofgroup")) {
	isEdit = true;
	name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		out.print(StrUtil.Alert_Back("用户名不能为空！"));
		return;
	}
	UserMgr usermgr = new UserMgr();
	user = usermgr.getUserDb(name);
	// System.out.println("user=" + user.getName());
	try {
		if (user.setGroups(request))
			out.print(StrUtil.Alert("修改用户组成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (op.equals("setuserofrole")) {
	isEdit = true;
	name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		out.print(StrUtil.Alert_Back("用户名不能为空！"));
		return;
	}
	UserMgr usermgr = new UserMgr();
	user = usermgr.getUserDb(name);
	try {
		if (user.setRoles(request))
			out.print(StrUtil.Alert("修改用户角色成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("setprivs")) {
	try {
		String username = ParamUtil.get(request, "name");
		user = user.getUserDb(username);
		if (user.setPrivs(request))
			out.print(StrUtil.Alert("修改用户权限成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (op.equals("modifyLeafPriv")) {
	int id = ParamUtil.getInt(request, "id");
	int see = 0, append=0, del=0, modify=0, examine=0;
	String strsee = ParamUtil.get(request, "see");
	if (StrUtil.isNumeric(strsee)) {
		see = Integer.parseInt(strsee);
	}
	String strappend = ParamUtil.get(request, "append");
	if (StrUtil.isNumeric(strappend)) {
		append = Integer.parseInt(strappend);
	}
	String strmodify = ParamUtil.get(request, "modify");
	if (StrUtil.isNumeric(strmodify)) {
		modify = Integer.parseInt(strmodify);
	}
	String strdel = ParamUtil.get(request, "del");
	if (StrUtil.isNumeric(strdel)) {
		del = Integer.parseInt(strdel);
	}
	String strexamine = ParamUtil.get(request, "examine");
	if (StrUtil.isNumeric(strexamine)) {
		examine = Integer.parseInt(strexamine);
	}
	
	LeafPriv leafPriv = new LeafPriv();
	leafPriv.setId(id);
	leafPriv.setAppend(append);
	leafPriv.setModify(modify);
	leafPriv.setDel(del);
	leafPriv.setSee(see);
	leafPriv.setExamine(examine);
	if (leafPriv.save())
		out.print(StrUtil.Alert("修改成功！"));
	else
		out.print(StrUtil.Alert("修改失败！"));
}

if (op.equals("delLeafPriv")) {
	int id = ParamUtil.getInt(request, "id");
	LeafPriv lp = new LeafPriv();
	lp = lp.getLeafPriv(id);
	if (lp.del())
		out.print(StrUtil.Alert("删除成功！"));
	else
		out.print(StrUtil.Alert("删除失败！"));
}

UserSetupDb usd = new UserSetupDb();
usd = usd.getUserSetupDb(name);

if (op.equals("setMessage")) {
	String depts = ParamUtil.get(request, "depts");
	String userGroups = ParamUtil.get(request, "userGroups");
	String userRoles = ParamUtil.get(request, "userRoles");
	int messageToMaxUser = ParamUtil.getInt(request, "messageToMaxUser");
	int messageUserMaxCount = ParamUtil.getInt(request, "messageUserMaxCount");
	
	boolean re = false;
	usd.setMessageToDept(depts);
	usd.setMessageToUserGroup(userGroups);
	usd.setMessageToUserRole(userRoles);
	usd.setMessageToMaxUser(messageToMaxUser);
	usd.setMessageUserMaxCount(messageUserMaxCount);
	re = usd.save();
	// usd = usd.getUserSetupDb(name);
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
	else
		out.print(StrUtil.Alert("操作失败！"));
}

%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理用户</td>
    </tr>
  </tbody>
</table>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">
	  <%if (user!=null) {%>
	  	  修改用户 <%=user.getRealName()%> 所属的用户组、角色和权限
	  <%}%>	  </TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><br>
        <br>
        <%if (user!=null) {%>
        <table width="44%"  border="0">
          <tr>
            <td align="center"><strong>角 色 设 定</strong></td>
          </tr>
        </table>
        <table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellspacing="0" cellpadding="3" width="50%" align="center">
          <form name="formRole" method="post" action="?op=setuserofrole">
            <tbody>
              <tr>
                <td width="88%" align="left" nowrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">所属角色</td>
              </tr>
              <%
RoleMgr roleMgr = new RoleMgr();		  
RoleDb[] userroles = user.getRoles();
int ulen = 0;
if (userroles!=null)
	ulen = userroles.length;

String roleCode, desc;
String roleCodes = "";
String descs = "";
for (int i=0; i<ulen; i++) {
	RoleDb rd = userroles[i];
	roleCode = rd.getCode();
	desc = rd.getDesc();
	if (roleCodes.equals(""))
		roleCodes += roleCode;
	else
		roleCodes += "," + roleCode;
	if (descs.equals(""))
		descs += desc;
	else
		descs += "," + desc;
}		
%>
              <tr class="row" style="BACKGROUND-COLOR: #ffffff">
                <td align="left"><textarea name=roleDescs cols="60" rows="3"><%=descs%></textarea>
                    <input name="roleCodes" value="<%=roleCodes%>" type=hidden>                </td>
              </tr>
              <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
                <td style="PADDING-LEFT: 10px"><input type=hidden name="name" value="<%=user.getName()%>">
                  <input name="button2" type="button" class="singleboarder" onClick="showModalDialog('../role_multi_sel.jsp?roleCodes=<%=roleCodes%>',window.self,'dialogWidth:526px;dialogHeight:435px;status:no;help:no;')" value="选择角色">
&nbsp;&nbsp;&nbsp;&nbsp;
                <input name="Submit3" type="submit" class="singleboarder" value=" 提 交 "></td>
              </tr>
            </tbody>
          </form>
        </table>
        <%}%>
        <br>
        <%if (user!=null) {%>
        <table width="44%"  border="0">
          <tr>
            <td align="center"><strong>用 户 组 设 定</strong></td>
          </tr>
        </table>
        <table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="50%" align="center">
          <form name="form1" method="post" action="?op=setuserofgroup">
            <tbody>
              <tr>
                <td class="thead" style="PADDING-LEFT: 10px" noWrap width="9%">&nbsp;</td>
                <td width="91%" align="left" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">用户组描述</td>
              </tr>
<%
UserGroupMgr usergroupmgr = new UserGroupMgr();		  
UserGroupDb[] ugs = usergroupmgr.getAllUserGroup();
int len = 0;
if (ugs!=null)
	len = ugs.length;
UserGroupDb[] userofgroups = user.getGroups();
int ulen = 0;
if (userofgroups!=null)
	ulen = userofgroups.length;

String group_code, desc;

for (int i=0; i<len; i++) {
	UserGroupDb ug = ugs[i];
	group_code = ug.getCode();
	desc = ug.getDesc();
	%>
              <tr class="row" style="BACKGROUND-COLOR: #ffffff">
                <td style="PADDING-LEFT: 10px"><%
	  boolean isChecked = false;
	  for (int k=0; k<ulen; k++) {
	  	if (userofgroups[k].getCode().equals(group_code)) {
			isChecked = true;
			break;
		}
	  }
	  if (group_code.equals(UserGroupDb.EVERYONE)) {
	  	  out.print("<input type=checkbox disabled name=group_code value='" + UserGroupDb.EVERYONE + "' checked>");
	  }
	  else {
		  if (isChecked)
			out.print("<input type=checkbox name=group_code value='" + group_code + "' checked>");
		  else
			out.print("<input type=checkbox name=group_code value='" + group_code + "'>");
	  }%>                </td>
                <td align="left"><%=desc%></td>
              </tr>
              <%}%>
              <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
                <td colspan="2" style="PADDING-LEFT: 10px"><input type=hidden name="name" value="<%=user.getName()%>">
                    <input name="Submit2" type="submit" class="singleboarder" value=" 提 交 ">
                  &nbsp;&nbsp;&nbsp;
                  <input name="Submit2" type="reset" class="singleboarder" value=" 重 置 "></td>
              </tr>
            </tbody>
          </form>
        </table>
        <%}%>
        <%
if (user!=null) {		
%>
        <br>
        <table width="44%"  border="0">
          <tr>
            <td align="center"><strong>权 限 设 定</strong></td>
          </tr>
        </table>
                  <table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="50%" align="center">
                    <form name="form1" method="post" action="?op=setprivs">
                      <tbody>
                        <tr>
                          <td class="thead" style="PADDING-LEFT: 10px" noWrap width="12%">
                          <input type=hidden name="name" value="<%=user.getName()%>">                          </td>
                  <td width="88%" align="left" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
                </tr>
  <%
String[] userprivs = user.getPrivs();
PrivDb[] privs = privmgr.getAllPriv();
String priv, desc;
			  
int len = 0;
if (privs!=null)
	len = privs.length;
int privlen = 0;
if (userprivs!=null)
	privlen = userprivs.length;
	
for (int i=0; i<len; i++) {
	PrivDb pv = privs[i];
	priv = pv.getPriv();
	desc = pv.getDesc();
	%>
                        <tr class="row" style="BACKGROUND-COLOR: #ffffff">
                          <td style="PADDING-LEFT: 10px">
                            &nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;
                            <%
	  boolean isChecked = false;
	  for (int k=0; k<privlen; k++) {
	  	if (userprivs[k].equals(priv)) {
			isChecked = true;
			break;
		}
	  }
	  if (isChecked)
	  	out.print("<input type=checkbox name=priv value='" + priv + "' checked>");
	  else
	  	out.print("<input type=checkbox name=priv value='" + priv + "'>");
	  %>                          </td>
                  <td align="left"><%=desc%></td>
                </tr>
                        <%}%>
                        <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
                          <td colspan="2" style="PADDING-LEFT: 10px"><input type=hidden name=username value="<%=user.getName()%>">
                            <input name="Submit" type="submit" class="singleboarder" value=" 提 交 ">
  &nbsp;&nbsp;&nbsp;
                            <input name="Submit" type="reset" class="singleboarder" value="重 置 "></td>
                </tr>
                      </tbody>
                    </form>
        </table>
  <%}%>		
  <%if (user!=null) {%>
  <br>
  <table width="44%"  border="0">
    <tr>
      <td align="center"><strong>文件柜的权限</strong></td>
    </tr>
  </table>
  <table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
    <tbody>
      <tr>
        <td class="thead" style="PADDING-LEFT: 10px" noWrap width="18%">目录</td>
        <td class="thead" noWrap width="13%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
        <td class="thead" noWrap width="43%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">权限</td>
        <td width="26%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
      </tr>
<%
LeafPriv leafPriv = new LeafPriv();	
Vector result = leafPriv.listUserPriv(user.getName());
Iterator ir = result.iterator();
int i = 0;
Leaf lf = new Leaf();
while (ir.hasNext()) {
 	LeafPriv lp = (LeafPriv)ir.next();
	lf = lf.getLeaf(lp.getDirCode());
	i++;
	%>
    <form id="form<%=i%>" name="form<%=i%>" action="?op=modifyLeafPriv" method=post>
      <tr class="row" style="BACKGROUND-COLOR: #ffffff">
        <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<%=lf.getName()%>
            <input type=hidden name="op" value="edit">
            <input type=hidden name="id" value="<%=lp.getId()%>">
            <input type=hidden name="dirCode" value="<%=lp.getDirCode()%>">
            <input type=hidden name="name" value="<%=user.getName()%>">        </td>
        <td><%=lp.getType()==0?"用户组":"用户"%></td>
        <td><input name=see type=checkbox <%=lp.getSee()==1?"checked":""%> value="1">
          浏览&nbsp;
          <input name=append type=checkbox <%=lp.getAppend()==1?"checked":""%> value="1">
          添加 &nbsp;
          <input name=del type=checkbox <%=lp.getDel()==1?"checked":""%> value="1">
          删除&nbsp;
          <input name=modify type=checkbox <%=lp.getModify()==1?"checked":""%> value="1">
          修改
          <input name=examine type=checkbox <%=lp.getExamine()==1?"checked":""%> value="1">
          审核 </td>
        <td><input name="submit" type=submit value="修改">
          &nbsp;
          <input name="button" type=button onClick="window.location.href='user_op.jsp?op=delLeafPriv&op=edit&name=<%=StrUtil.UrlEncode(user.getName())%>&dirCode=<%=StrUtil.UrlEncode(lp.getDirCode())%>&id=<%=lp.getId()%>'" value=删除>        </td>
      </tr>
    </form>
    <%}%>
  </table>
  <%}%>
  <br>
  <table width="472" border="0" align="center" cellpadding="2" cellspacing="0" class="frame_gray">
  <form name="formDept" action="?op=setMessage" method="post">
    <tr>
      <td colspan="2" align="center" class="thead">
        用户能发送短消息至部门、用户组、用户角色的设置，空表示没有限制</td>
      </tr>
    <tr>
      <td width="21">&nbsp;</td>
      <td width="441" align="left">
	  <%
	  String messageToDept = "";
	  String messageToUserGroup = "";
	  String messageToUserRole = "";
	  if (usd!=null && usd.isLoaded()) {
	  	messageToDept = usd.getMessageToDept();
		messageToUserGroup = usd.getMessageToUserGroup();
		messageToUserRole = usd.getMessageToUserRole();
	  }
	  String deptNames = "";
	  String userGroupNames = "";
	  String userRoleNames = "";
	  if (!messageToDept.equals("")) {
	  	String[] ary = messageToDept.split(",");
		DeptDb dd = new DeptDb();
		int len = ary.length;
		for (int i=0; i<len; i++) {
			dd = dd.getDeptDb(ary[i]);
			if (deptNames.equals(""))
				deptNames = dd.getName();
			else
				deptNames += "," + dd.getName();
		}
	  }
	  if (!messageToUserGroup.equals("")) {
	  	String[] ary = messageToUserGroup.split(",");
		UserGroupDb dd = new UserGroupDb();
		int len = ary.length;
		for (int i=0; i<len; i++) {
			dd = dd.getUserGroupDb(ary[i]);
			if (userGroupNames.equals(""))
				userGroupNames = dd.getDesc();
			else
				userGroupNames += "," + dd.getDesc();
		}
	  }	  
	  if (!messageToUserRole.equals("")) {
	  	String[] ary = messageToUserRole.split(",");
		RoleDb dd = new RoleDb();
		int len = ary.length;
		for (int i=0; i<len; i++) {
			dd = dd.getRoleDb(ary[i]);
			if (userRoleNames.equals(""))
				userRoleNames = dd.getDesc();
			else
				userRoleNames += "," + dd.getDesc();
		}
	  }	  
	  %>
	  <input type="hidden" name="depts" value="<%=messageToDept%>">
	  <textarea name="deptNames" cols="50" rows="3" readonly><%=deptNames%></textarea>
        <a href="#" onClick="openWinDepts()">选择部门</a>          <br>
	  <input type="hidden" name="userGroups" value="<%=messageToUserGroup%>">
        <textarea name="userGroupNames" cols="50" rows="3" readonly><%=userGroupNames%></textarea>
        <a href="#" onClick="openWinUserGroups()">选择用户组</a><br>
	  <input type="hidden" name="userRoles" value="<%=messageToUserRole%>">
        <textarea name="userRoleNames" cols="50" rows="3" readonly><%=userRoleNames%></textarea>
        <a href="#" onClick="openWinUserRoles()">选择角色</a><br>
        短消息群发的最大用户数
        <input name="messageToMaxUser" value="<%=usd.getMessageToMaxUser()%>" size="3">
        <br>
        短消息信箱容量
        <input name="messageUserMaxCount" value="<%=usd.getMessageUserMaxCount()%>" size="3">
        条（超出部分的最早收到的消息将会被系统定期删除）<br></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="submit" name="Submit4" value=" 提 交 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="reset" name="Submit42" value=" 重 置 ">
        <span class="thead" style="PADDING-LEFT: 10px">
        <input type=hidden name="name" value="<%=user.getName()%>">
        </span></td>
      </tr>
  </form>
  </table></TD>
    </TR>
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
<br>
<br>

</body>
<script language="javascript">
<!--
function form1_onsubmit()
{

}

function getDepts() {
	return formDept.depts.value;
}

function getUserGroups() {
	return formDept.userGroups.value;
}

function getUserRoles() {
	return formDept.userRoles.value;
}

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function openWinDepts() {
	var ret = showModalDialog('../dept_multi_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:480px;status:no;help:no;')
	if (ret==null)
		return;
	formDept.deptNames.value = "";
	formDept.depts.value = "";
	for (var i=0; i<ret.length; i++) {
		if (formDept.deptNames.value=="") {
			formDept.depts.value += ret[i][0];
			formDept.deptNames.value += ret[i][1];
		}
		else {
			formDept.depts.value += "," + ret[i][0];
			formDept.deptNames.value += "," + ret[i][1];
		}
	}
	if (formDept.depts.value.indexOf("<%=DeptDb.ROOTCODE%>")!=-1) {
		formDept.depts.value = "<%=DeptDb.ROOTCODE%>";
		formDept.deptNames.value = "全部";
	}
}

function openWinUserGroups() {
	var ret = showModalDialog('../usergroup_multi_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:480px;status:no;help:no;')
	if (ret==null)
		return;
	formDept.userGroupNames.value = "";
	formDept.userGroups.value = "";
	for (var i=0; i<ret.length; i++) {
		if (formDept.userGroupNames.value=="") {
			formDept.userGroups.value += ret[i][0];
			formDept.userGroupNames.value += ret[i][1];
		}
		else {
			formDept.userGroups.value += "," + ret[i][0];
			formDept.userGroupNames.value += "," + ret[i][1];
		}
	}
}

function openWinUserRoles() {
	var ret = showModalDialog('../userrole_multi_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:480px;status:no;help:no;')
	if (ret==null)
		return;
	formDept.userRoleNames.value = "";
	formDept.userRoles.value = "";
	for (var i=0; i<ret.length; i++) {
		if (formDept.userRoleNames.value=="") {
			formDept.userRoles.value += ret[i][0];
			formDept.userRoleNames.value += ret[i][1];
		}
		else {
			formDept.userRoles.value += "," + ret[i][0];
			formDept.userRoleNames.value += "," + ret[i][1];
		}
	}
}

function setRoles(roles, descs) {
	formRole.roleCodes.value = roles;
	formRole.roleDescs.value = descs
}
//-->
</script>
</html>