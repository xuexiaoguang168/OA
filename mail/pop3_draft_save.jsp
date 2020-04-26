<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.mail.*"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>取邮件</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<%@ include file="../inc/nocache.jsp" %>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
boolean re = false;
MailMsgMgr mmm = new MailMsgMgr();
try {
	re = mmm.add(application, request);
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert_Back(e.getMessage()));
	return;
}
if (re) {
	out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "mail_list.jsp?type=" + MailMsgDb.TYPE_DRAFT + "&sender=" + mmm.getMailMsgDb().getSender()));
}
%>
</body>
</html>
