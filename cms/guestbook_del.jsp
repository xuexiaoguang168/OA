<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "cn.js.fan.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>删除留言</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=3 marginheight="3" marginwidth="0">
<jsp:useBean id="privilege" scope="page" class="com.fan.redmoon.Privilege"/>
<%
if (!privilege.isAdmin(request))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String id = request.getParameter("id");
if (id==null || !StrUtil.isNumeric(id))
{
	out.println(StrUtil.Alert_Redirect("未选择留言标识！","guestbookm.jsp"));
	return;
}
%>
<jsp:useBean id="msgmgr" scope="page" class="cn.js.fan.module.guestbook.MessageMgr"/>
<%
boolean re = false;
try {
	re = msgmgr.del(Integer.parseInt(id));
}
catch (ErrMsgException e) {
	out.print(StrUtil.makeErrMsg(e.getMessage()));
}
if (re)
{
	out.println(StrUtil.Alert_Redirect("删除留言成功！","guestbook.jsp"));
}
%>
</BODY></HTML>
