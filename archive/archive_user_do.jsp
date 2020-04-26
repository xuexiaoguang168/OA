<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人事档案管理</title>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	if (!privilege.isUserPrivValid(request, "archive.userinfo")) {
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	
	UserInfoMgr uim = new UserInfoMgr();
	boolean re = false;

	String op = ParamUtil.get(request, "op");
	if (op.equals("add")) {
	    String deptCode = ParamUtil.get(request, "deptCode");
		try {
			re = uim.create(application, request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
		    out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_add_userinfo"),"archive_user_main.jsp?deptCode=" + StrUtil.UrlEncode(deptCode)));
		}
	}
	
	if (op.equals("modify")) {
	    String userName = ParamUtil.get(request, "userName");
		try {
			re = uim.modify(application, request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_modify_userinfo"),"archive_user_modify.jsp?userName=" + userName));
		}
	}
	
	if (op.equals("del")) {
	    String deptCode = ParamUtil.get(request, "deptCode");
		try {	
			re = uim.del(application,request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_del_userinfo"),"archive_user_main.jsp?deptCode=" + StrUtil.UrlEncode(deptCode)));
		}
	}	
%>
</body>
</html>
