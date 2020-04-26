<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.chat.*"%>
<%@ include file="../../inc/nocache.jsp"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.chat")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
	RoomMgr rm = new RoomMgr();
	try {
		if (rm.update(request, privilege))
			out.print(StrUtil.Alert_Back("修改成功！"));
		else
			out.print(StrUtil.Alert_Back("修改失败！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
%>
