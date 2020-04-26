<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<html>
<head>
<title>图书归还处理</title>
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
	String priv="read";
	if (!privilege.isUserPrivValid(request, priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	
	BookMgr bm = new BookMgr();
	boolean re = false;
	String op = ParamUtil.get(request, "op");
	if (op.equals("return")) {
		try {
			re = bm.returnBook(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("还书成功！","book_list.jsp"));
		}
 }
%>
</body>
</html>