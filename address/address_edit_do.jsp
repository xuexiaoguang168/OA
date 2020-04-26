<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<html>
<head>
<title>增加日程</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script language="javascript">
<!--
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
	AddressMgr am = new AddressMgr();
	boolean re = false;

	int id = ParamUtil.getInt(request, "id");
	int type = ParamUtil.getInt(request, "type");
	
		try {
			re = am.modify(request);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
		if (re) {
			out.print(StrUtil.Alert_Redirect("修改成功！", "address_modify.jsp?id=" + id + "&type=" + type));
		}


%>
</body>
</html>