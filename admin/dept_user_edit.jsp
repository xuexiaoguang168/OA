<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
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
<title>职位-员工</title>
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

int id = ParamUtil.getInt(request, "id");
DeptUserDb du = new DeptUserDb();
du = du.getDeptUserDb(id);

UserDb ud = new UserDb();
ud = ud.getUserDb(du.getUserName());

String op = ParamUtil.get(request, "op");
if (op.equals("modify")) {
		String userName = ParamUtil.get(request, "userName");
		String rank = ParamUtil.get(request, "rank");
		du.setUserName(userName);
		du.setRank(rank);
		if (du.save())
			out.print(StrUtil.Alert("操作成功！"));
		else
			out.print(StrUtil.Alert_Back("操作失败！"));
		du = du.getDeptUserDb(id);
		ud = ud.getUserDb(du.getUserName());
}
%>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" class="frame_gray" style="height:100%">
  <tr>
    <td align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" align="center" bgcolor="#88B5FF">
		  <a href="dept_user.jsp?deptCode=<%=StrUtil.UrlEncode(deptCode)%>"><%=dd.getName()%></a>&nbsp;的员工</td>
      </tr>
    </table>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <form name="form1" method="post" action="?op=modify">
          <tr>
            <td height="24" colspan="2" align="center" bgcolor="#C4DAFF">修改部门中的用户</td>
          </tr>
          <tr>
            <td width="22%" height="22" align="center"> 部&nbsp;&nbsp;&nbsp;&nbsp;门 </td>
            <td width="78%" align="left"><%=dd.getName()%>
              <input type=hidden name="deptCode" value="<%=deptCode%>">
              <input name="op" value="add" type=hidden>
            <input name="id" value="<%=id%>" type=hidden></td>
          </tr>
          <tr>
            <td height="22" align="center">用户名</td>
            <td height="22" align="left">
			<%
			String userRealName = "";
			if (ud.isLoaded())
				userRealName = ud.getRealName();
			%>
			<input name="userName" value="<%=ud.getName()%>" size="16" type="hidden">
			<input name="userRealName" class="singleboarder" id="userRealName" size="18" readonly value="<%=userRealName%>">
			<a href="#" onClick="openWin('user_sel.jsp', 480, 320)">选择</a>&nbsp;<a href="#" onClick="form1.userName.value=''; form1.userRealName.value=''">清除</a>
			<input name="rank" class="singleboarder" value="" size="16" type="hidden"></td>
          </tr>
          
          <tr>
            <td height="22" colspan="2" align="center"><input name="Submit" type="submit" class="singleboarder" value="确定">
&nbsp;&nbsp;&nbsp;
        <input name="Submit" type="reset" class="singleboarder" value="重置">            </td>
          </tr>
        </form>
    </table></td>
  </tr>
</table>
</body>
</html>
