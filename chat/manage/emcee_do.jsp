<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.chat.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.chat")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

boolean re = false;
try {
	RoomEmceeDb red = new RoomEmceeDb();
	re = red.setEmcees(request);
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert_Back(e.getMessage()));
}
if (re) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "info_operate_success")));
}
%>