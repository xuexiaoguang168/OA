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
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<%
	String userName = ParamUtil.get(request, "userName");
	if (!privilege.isUserPrivValid(request, "archive.study")||!archivePrivilege.canAdminUser(request,userName)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}

	UserStudyMgr usm = new UserStudyMgr();
	boolean re = false;

	String op = ParamUtil.get(request, "op");
	if (op.equals("add")) {
		try {
			re = usm.create(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
		    out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_add_userstudy"),"archive_study_list.jsp?userName=" + userName));
		}
	}
	if (op.equals("modify")) {
		try {
			re = usm.modify(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_modify_userstudy")));
		}
	}
	if (op.equals("del")) {
		try {
			re = usm.del(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_del_userstudy")));
		}
	}	
%>
</body>
</html>
