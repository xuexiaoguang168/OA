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
	if (!privilege.isUserPrivValid(request, "archive.query")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}

	ArchiveQueryMgr aqm = new ArchiveQueryMgr();
	boolean re = false;
	String op = ParamUtil.get(request, "op");

	if (op.equals("add")) {
		try {
			re = aqm.create(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_add_query"),"archive_query_save_list.jsp"));
		}
	}
	
	if (op.equals("modify")) {
		try {
			re = aqm.modify(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_modify_query")));
		}
	}
	
    if (op.equals("modifyDeptCode")) {
		try {
			re = aqm.modifyDeptCode(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_modify_query")));
		}
	}
		
    if (op.equals("modifyTableCode")) {
		try {
			re = aqm.modifyTableCode(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_modify_query")));
		}
	}
	
	if (op.equals("modifyShowFieldCode")) {
		try {
			re = aqm.modifyShowFieldCode(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_modify_query")));
		}
	}
	
    if (op.equals("modifyConditionFieldCode")) {
		try {
			re = aqm.modifyConditionFieldCode(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_modify_query"), "archive_query_save_list.jsp"));
		}
	}
	
	if (op.equals("modifyOrderFieldCode")) {
		try {
			re = aqm.modifyOrderFieldCode(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_modify_query")));
		}
	}
	
	if (op.equals("del")) {
		try {
			re = aqm.del(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_del_query")));
		}
	}	
	
	if (op.equals("modifyUsers")){
	    ArchivePrivilegeMgr apm = new ArchivePrivilegeMgr();
		try {
			re = apm.create(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive", "success_add_user")));
		}
	}
	
%>
</body>
</html>
