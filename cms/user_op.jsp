<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<jsp:useBean id="privmgr" scope="page" class="com.redmoon.oa.pvg.PrivMgr"/>
<html>
<head>
<title>管理登录</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
String op = ParamUtil.get(request, "op");
User user = null;
boolean isEdit = false;
if (op.equals("edit")) {
	isEdit = true;
	String name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		StrUtil.Alert_Back("用户名不能为空！");
		return;
	}
	user = new User(name);
}
if (op.equals("editdo")) {
	isEdit = true;
	UserMgr usermgr = new UserMgr();
	try {
		if (usermgr.update(request))
			out.print(StrUtil.Alert("修改成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}	
	String name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		StrUtil.Alert_Back("用户名不能为空！");
		return;
	}
	user = usermgr.getUser(name);
}
if (op.equals("setuserofgroup")) {
	isEdit = true;
	String name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		StrUtil.Alert_Back("用户名不能为空！");
		return;
	}
	UserMgr usermgr = new UserMgr();
	user = usermgr.getUser(name);
	try {
		if (user.setGroups(request))
			out.print(StrUtil.Alert("修改用户组权限成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}
if (op.equals("setprivs")) {
	try {
		String username = ParamUtil.get(request, "name");
		user = new User();
		user = user.getUser(username);
		if (user.setPrivs(request))
			out.print(StrUtil.Alert("修改用户权限成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
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
	  	  修改用户
	  	  <%}else{%>
		  添加用户
		  <%}%>
	  </TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="64%" border="0" cellpadding="0" cellspacing="1">
          <tr>
            <td align="center"><table width="71%" border="0" cellpadding="0" cellspacing="0">
                <form name="form1" method="post" action="<%=user!=null?"user_op.jsp?op=editdo":"user_m.jsp?op=add"%>">
                  <tr>
                    <td width="113" height="31" align="center">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</td>
                  <td align="left"><input name="name" value="<%=user!=null?user.getName():""%>" <%=isEdit?"readonly":""%>></td>
                  </tr>
                  <tr>
                    <td height="32" align="center">真实姓名</td>
                    <td align="left"><input name="realname" value="<%=user!=null?user.getRealName():""%>" ></td>
                  </tr>
                  <tr>
                    <td height="32" align="center">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述</td>
                  <td align="left"><input name="desc" value="<%=user!=null?user.getDesc():""%>"></td>
                  </tr>
                  <tr>
                    <td height="32" align="center">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</td>
                    <td align="left"><input name="pwd" type="password" id="pwd"></td>
                  </tr>
                  <tr>
                    <td height="32" align="center">确认密码</td>
                    <td align="left"><input name="pwd_confirm" type="password" id="pwd_confirm"></td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center">
                    </td>
                  </tr>
                  <tr>
                    <td height="43" colspan="2" align="center"><input name="Submit" type="submit" class="singleboarder" value="提交">
&nbsp;&nbsp;&nbsp;
                      <input name="Submit" type="reset" class="singleboarder" value="重置"></td>
                  </tr>
                  <tr>
                    <td height="43" colspan="2" align="center">
					<%if (isEdit) {%>
					请注意：如果要更改密码，则请填写，否则勿需填写
					<%}%>
					</td>
                  </tr>
                </form>
            </table></td>
          </tr>
      </table><br>
	  <%if (user!=null) {%>
        <table class="" width="72%" border="0" cellpadding="0" cellspacing="1">
          <tr>
            <td align="center"><table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="90%" align="center">
              <form name="form1" method="post" action="?op=setuserofgroup">
                <tbody>
                  <tr>
                    <td class="thead" style="PADDING-LEFT: 10px" noWrap width="15%">&nbsp;</td>
                    <td class="thead" style="PADDING-LEFT: 10px" noWrap width="32%">用户组编码</td>
                    <td class="thead" noWrap width="53%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">用户组描述</td>
                  </tr>
                  <%
UserGroupMgr usergroupmgr = new UserGroupMgr();		  
UserGroup[] ugs = usergroupmgr.getAllUserGroup();
int len = 0;
if (ugs!=null)
	len = ugs.length;
UserGroup[] userofgroups = user.getGroup();
int ulen = 0;
if (userofgroups!=null)
	ulen = userofgroups.length;

String group_code, desc;

for (int i=0; i<len; i++) {
	UserGroup ug = ugs[i];
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
	  if (isChecked)
	  	out.print("<input type=checkbox name=group_code value='" + group_code + "' checked>");
	  else
	  	out.print("<input type=checkbox name=group_code value='" + group_code + "'");
	  %>
                    </td>
                    <td style="PADDING-LEFT: 10px">&nbsp;<img src="images/arrow.gif" align="absmiddle">&nbsp;<%=group_code%></td>
                    <td><%=desc%></td>
                  </tr>
                  <%}%>
                  <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
                    <td colspan="3" style="PADDING-LEFT: 10px"><input type=hidden name="name" value="<%=user.getName()%>">
                        <input name="Submit" type="submit" class="singleboarder" value="提交">
&nbsp;&nbsp;&nbsp;
          <input name="Submit" type="reset" class="singleboarder" value="重置"></td>
                  </tr>
                </tbody>
              </form>
            </table></td>
          </tr>
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
                <table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="64%" align="center">
          <form name="form1" method="post" action="?op=setprivs">
            <tbody>
              <tr>
                <td class="thead" style="PADDING-LEFT: 10px" noWrap width="15%">
				<input type=hidden name="name" value="<%=user.getName()%>">
				</td>
                <td class="thead" style="PADDING-LEFT: 10px" noWrap width="29%">编码</td>
                <td class="thead" noWrap width="56%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">描述</td>
              </tr>
<%
String[] userprivs = user.getPrivs();
Priv[] privs = privmgr.getAllPriv();
String priv, desc;
			  
int len = 0;
if (privs!=null)
	len = privs.length;
int privlen = 0;
if (userprivs!=null)
	privlen = userprivs.length;
	
for (int i=0; i<len; i++) {
	Priv pv = privs[i];
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
	  	out.print("<input type=checkbox name=priv value='" + priv + "'");
	  %>
                </td>
                <td style="PADDING-LEFT: 10px"><%=priv%></td>
                <td><%=desc%></td>
              </tr>
              <%}%>
              <tr align="center" class="row" style="BACKGROUND-COLOR: #ffffff">
                <td colspan="3" style="PADDING-LEFT: 10px"><input type=hidden name=username value="<%=user.getName()%>">
                    <input name="Submit" type="submit" class="singleboarder" value="提交">
&nbsp;&nbsp;&nbsp;
          <input name="Submit" type="reset" class="singleboarder" value="重置"></td>
              </tr>
            </tbody>
          </form>
        </table>
<%}%>		
</TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
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
//-->
</script>
</html>