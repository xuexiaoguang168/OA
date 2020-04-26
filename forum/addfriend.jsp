<%@ page contentType="text/html;charset=utf-8"
import = "java.io.File"
import = "cn.js.fan.util.ErrMsgException"
import = "cn.js.fan.web.SkinUtil"
%>
<%@ page import="java.util.Calendar" %>
<title><%=cn.js.fan.web.Global.AppName%></title>
<%@ include file="../inc/nocache.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil" />
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice" />
<%
boolean isSuccess = false;
try {
	isSuccess = userservice.AddFriend(request);
}
catch (ErrMsgException e) {
	out.println(StrUtil.Alert_Back(e.getMessage()));
	return;
}
String msg;
if (isSuccess)
	msg = SkinUtil.LoadString(request, "info_op_success"); // "加为好友成功！";
else
	msg = SkinUtil.LoadString(request, "info_op_fail"); // "加为好友失败！";
out.println(StrUtil.Alert_Back(msg));
%>

