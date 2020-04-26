<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>职位-员工</title>
<LINK href="default.css" type=text/css rel=stylesheet>
</head>
<body>
<%
String postCode = ParamUtil.get(request, "postCode");
if (postCode.equals("")) {
	// out.print(StrUtil.Alert("对不起，请选择某个职位！"));
	return;
}
PostDb post = new PostDb();
post = post.getPostDb(postCode);
if (post==null || !post.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "职位" + postCode + "不存在！"));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	try {
		PostUserMgr pum = new PostUserMgr();
		if (pum.add(request))
			out.print(StrUtil.Alert("添加成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("del")) {
	try {
		PostUserMgr pum = new PostUserMgr();
		if (pum.del(request))
			out.print(StrUtil.Alert("删除成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("modify")) {
	try {
		PostUserMgr jm = new PostUserMgr();
		if (jm.modify(request))
			out.print(StrUtil.Alert("修改成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
<select name="deptCode">
<%
	
	DeptDb rootlf = new DeptDb();
	rootlf = rootlf.getDeptDb(DeptDb.ROOTCODE);
	DeptView dv = new DeptView(rootlf);
	dv.ShowDeptAsOptions(out, rootlf, rootlf.getLayer());
%>
</select>	
	</td>
  </tr>
</table>
<table width="444" border="0" align="left" cellpadding="0" cellspacing="1" class="frame_gray" style="height:100%">
  <tr>
    <td align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" align="center" bgcolor="#88B5FF"><%=post.getName()%>职位的员工</td>
      </tr>
    </table>
      <table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" align="center" bgcolor="#C4DAFF">用户</td>
        <td height="24" colspan="3" align="center" bgcolor="#C4DAFF">操作</td>
        </tr>
      <%
	PostUserDb jd = new PostUserDb();
	Vector v = jd.list(postCode);
	Iterator ir = v.iterator();
	while (ir.hasNext()) {
		PostUserDb pu = (PostUserDb)ir.next();
	%>
      <tr>
        <td width="53%" height="22"><%=pu.getName()%></td>
        <td width="16%" height="22"><a target="_parent" href="user_edit.jsp?name=<%=StrUtil.UrlEncode(pu.getName())%>">修改</a></td>
        <td width="15%" height="22">&nbsp;</td>
        <td width="16%" height="22"><a href="?op=del&id=<%=pu.getId()%>&postCode=<%=StrUtil.UrlEncode(postCode)%>">删除</a></td>
      </tr>
      <%}%>
    </table>
      <br>
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <form name="form1" method="post" action="post_employee.jsp">
          <tr>
            <td height="24" colspan="2" align="center" bgcolor="#C4DAFF">添加职位中的用户</td>
          </tr>
          <tr>
            <td width="32%" height="22" align="center"> 职&nbsp;&nbsp;&nbsp;&nbsp;位 </td>
            <td width="68%" align="left"><%=post.getName()%>
              <input type=hidden name="code" value="<%=postCode%>">
              <input name="op" value="add" type=hidden></td>
          </tr>
          <tr>
            <td height="22" align="center">用户名</td>
            <td height="22" align="left"><input name="name" class="singleboarder" value="" size="16">
              <input name="postCode" value="<%=postCode%>" type=hidden></td>
          </tr>
          <tr>
            <td height="15" colspan="2" align="center"> </td>
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
