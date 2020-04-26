<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="com.redmoon.oa.pvg.Privilege"%>
<%@ page import="java.util.Calendar" %>
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<%
Privilege privilege = new Privilege();

boolean re = false;
try {
	re = docmanager.UpdateSummary(application, request, privilege);
}
catch (ErrMsgException e) {
	out.print(e.getMessage());
}
if (re) {
	out.print("操作成功！");
}
else
	out.print("操作失败！");
%>