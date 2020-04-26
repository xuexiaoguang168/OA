<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.pvg.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="com.redmoon.oa.basic.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>部门员工</title>
<LINK href="default.css" type=text/css rel=stylesheet>
<script>
function setPerson(user, userRealName)
{
	form1.userName.value = user;
	form1.userRealName.value = userRealName;
}

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,top=50,left=120,width="+width+",height="+height);
}
</script>
</head>
<body>
<%
String deptCode = ParamUtil.get(request, "deptCode");
if (deptCode.equals(DeptDb.ROOTCODE)) {
	out.print(SkinUtil.makeErrMsg(request, "请选择某个部门！"));
	return;
}

DeptDb dd = new DeptDb();
dd = dd.getDeptDb(deptCode);
if (dd==null) {
	out.print(SkinUtil.makeErrMsg(request, "部门 " + deptCode + " 不存在！"));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	try {
		DeptUserMgr pum = new DeptUserMgr();
		if (pum.add(request))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("move")) {
	try {
		DeptUserMgr jm = new DeptUserMgr();
		jm.move(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("del")) {
	try {
		DeptUserMgr pum = new DeptUserMgr();
		if (pum.del(request))
			out.print(StrUtil.Alert("删除成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("modify")) {
	try {
		DeptUserMgr jm = new DeptUserMgr();
		if (jm.modify(request))
			out.print(StrUtil.Alert("修改成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
%>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" class="frame_gray" style="height:100%">
  <tr>
    <td width="100%" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" align="center" bgcolor="#88B5FF">
		  <%=dd.getName()%>&nbsp;的员工</td>
      </tr>
    </table>
      <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center" bgcolor="#C4DAFF">职级</td>
        <td height="24" align="center" bgcolor="#C4DAFF">用户</td>
        <td align="center" bgcolor="#C4DAFF">角色</td>
        <td width="21%" height="24" align="center" bgcolor="#C4DAFF">操作</td>
        </tr>
    <%
	RankDb rd = new RankDb();
	
	DeptUserDb jd = new DeptUserDb();
	Vector v = jd.list(deptCode);
	Iterator ir = v.iterator();
	while (ir.hasNext()) {
		DeptUserDb pu = (DeptUserDb)ir.next();
		UserDb ud = new UserDb();
		if (!pu.getUserName().equals(""))
			ud = ud.getUserDb(pu.getUserName());
	%>
      <tr>
        <td width="11%">
		<%
		String userRealName = "";
		if (ud.isLoaded()) {
			out.print(StrUtil.getNullString(rd.getRankDb(ud.getRankCode()).getName()));
			userRealName = ud.getRealName();
		}
		%></td>
        <td width="23%" height="22"><a href="user_edit.jsp?name=<%=StrUtil.UrlEncode(pu.getUserName())%>"><%=userRealName%></a></td>
        <td width="45%">
		<%
		RoleDb[] roleary = ud.getRoles();
		if (roleary!=null) {
			int len = roleary.length;
			for (int i=0; i<len; i++) {
				if (i==0)
					out.print(roleary[i].getDesc());
				else
					out.print("，" + roleary[i].getDesc());
			}
		}
		%>
		</td>
        <td height="22"><a href="dept_user_edit.jsp?deptCode=<%=StrUtil.UrlEncode(pu.getDeptCode())%>&id=<%=pu.getId()%>">修改</a>&nbsp;&nbsp;<a href="?op=move&direction=up&deptCode=<%=StrUtil.UrlEncode(pu.getDeptCode())%>&deptCode=<%=StrUtil.UrlEncode(pu.getDeptCode())%>&id=<%=pu.getId()%>">上移</a>&nbsp;&nbsp;<a href="?op=move&direction=down&deptCode=<%=StrUtil.UrlEncode(pu.getDeptCode())%>&deptCode=<%=StrUtil.UrlEncode(pu.getDeptCode())%>&id=<%=pu.getId()%>">下移</a>&nbsp;&nbsp;<a href="?op=del&id=<%=pu.getId()%>&deptCode=<%=StrUtil.UrlEncode(deptCode)%>">删除</a></td>
        </tr>
    <%}%>
    </table>
      <br>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <form name="form1" method="post" action="?">
          <tr>
            <td height="24" colspan="2" align="center" bgcolor="#C4DAFF">添加部门中的用户</td>
          </tr>
          <tr>
            <td width="32%" height="22" align="center"> 部&nbsp;&nbsp;&nbsp;&nbsp;门 </td>
            <td width="68%" align="left"><%=dd.getName()%>
              <input type=hidden name="deptCode" value="<%=deptCode%>">
              <input name="op" value="add" type=hidden></td>
          </tr>
          <tr>
            <td height="22" align="center">用户名</td>
            <td height="22" align="left"><input name="userName" class="singleboarder" value="" size="16" type="hidden">
              <input name="rank" class="singleboarder" value="" size="16" type="hidden">
              <input name="userRealName" class="singleboarder" id="userRealName" value="" size="18" readonly>
			<a href="#" onClick="openWin('user_sel.jsp', 480, 320)">选择</a>&nbsp;<a href="#" onClick="form1.name.value=''; form1.userRealName.value=''">清除</a></td>
          </tr>
          
          <tr>
            <td height="22" colspan="2" align="center"><input name="Submit" type="submit" class="singleboarder" value="添加">
&nbsp;&nbsp;&nbsp;
        <input name="Submit" type="reset" class="singleboarder" value="重置">            </td>
          </tr>
        </form>
    </table></td>
  </tr>
</table>
</body>
</html>
