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
		boolean re = rm.del(request, privilege);
		if (re)
			response.sendRedirect("../chatservice?mode=delroom&room=" + StrUtil.UrlEncode(ParamUtil.get(request, "room")));
		else
			out.print(StrUtil.Alert_Back("删除失败"));
	}
	catch (ErrMsgException e) {
		out.println(StrUtil.Alert_Back(e.getMessage()));
	}
%>