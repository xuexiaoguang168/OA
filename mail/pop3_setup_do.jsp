<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.oa.emailpop3.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%
	boolean re = false;
	String op = ParamUtil.get(request, "op");
	if (op.equals("edit")) {
		try {
			EmailPop3Mgr epm = new EmailPop3Mgr();
			re = epm.modify(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back("操作成功！"));
		}
	}
	if (op.equals("del")) {
		try {
			EmailPop3Mgr epm = new EmailPop3Mgr();
			re = epm.del(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back("操作成功！"));
		}
	}
%>