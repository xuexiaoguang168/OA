<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<html>
<head>
<title></title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	String priv="book.all";
	if (!privilege.isUserPrivValid(request, priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	
	BookMgr bm = new BookMgr();
	boolean re = false;

	String op = ParamUtil.get(request, "op");
	if (op.equals("add")) {
		try {
			re = bm.create(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("添加成功！", "book_add.jsp"));
			//out.print("OK!");
		}
	}
	if (op.equals("modify")) {
		try {
			re = bm.modify(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back("修改成功！"));
		}
	}
		if (op.equals("borrow")) {
		try {
			re = bm.borrow(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Back("借书成功！"));
		}
	}

	if (op.equals("del")) {
		try {
			re = bm.del(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("删除成功！", "book_list.jsp"));
		}
	}	
%>
</body>
</html>