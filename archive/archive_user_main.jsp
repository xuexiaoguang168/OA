<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<LINK href="../admin/default.css" type=text/css rel=stylesheet>
<script>
function preview(userName,deptCode)
{
	window.parent.location.href='archive_user_modify.jsp?userName='+userName+'&deptCode='+deptCode;
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
	
	if (deptCode.equals("")) {
		return;
	}
	
	DeptDb dd = new DeptDb();
	dd = dd.getDeptDb(deptCode);
	if (dd==null || !dd.isLoaded()) {
		out.print(StrUtil.Alert("部门" + deptCode + "不存在！"));
		return;
	}
	
	String op = ParamUtil.get(request, "op");
	if (op.equals("move")) {
	    UserInfoMgr uim = new UserInfoMgr();
		try {
			uim.move(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert(e.getMessage()));
		}
	}
%>
<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" class="frame_gray" style="height:100%">
 <form name="form1" method="post" action="archive_user_add.jsp?deptCode=<%=deptCode%>">
  <tr>
    <td width="496" align="right" valign="top">
	 <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" align="center" bgcolor="#88B5FF"><%=dd.getName()%>用户档案维护</td>
      </tr>
     </table>
     <table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="28%" height="24" align="center" bgcolor="#C4DAFF">职员</td>
        <td height="24" colspan="4" align="center" bgcolor="#C4DAFF">操作</td>
      </tr>
<%
    UserInfoDb uid = new UserInfoDb();
	Vector vt = uid.list(deptCode);
	Iterator ir = vt.iterator();
	while (ir.hasNext()) {
	    uid = (UserInfoDb)ir.next();
%>
      <tr>
        <td height="22" align="center"><%=uid.getUserRealName()%></td>
        <td width="22%" height="22" align="center"><a href="#" onClick="preview('<%=StrUtil.UrlEncode(uid.getUserName())%>','<%=StrUtil.UrlEncode(deptCode)%>')">维护档案信息</a></td>
        <td width="22%" align="center"><a href="archive_user_do.jsp?userName=<%=StrUtil.UrlEncode(uid.getUserName())%>&deptCode=<%=StrUtil.UrlEncode(deptCode)%>&op=del">删除档案信息</a></td>
        <td width="14%" align="center"><a href="?op=move&direction=up&userName=<%=StrUtil.UrlEncode(uid.getUserName())%>&deptCode=<%=StrUtil.UrlEncode(deptCode)%>">上移</a></td>
        <td width="14%" align="center"><a href="?op=move&direction=down&userName=<%=StrUtil.UrlEncode(uid.getUserName())%>&deptCode=<%=StrUtil.UrlEncode(deptCode)%>">下移</a></td>
      </tr>
<%
    }
%>
    </table>
    <input name="btn" type="submit" class="button" id="btn" value="增加新用户基本信息">
   </td><br>
  </tr>
 </form> 
</table>
</body>
</html>
