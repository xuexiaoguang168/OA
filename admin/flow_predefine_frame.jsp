<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>预定义流程框架</title>
</head>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.flow")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<frameset rows="*" cols="200,*" framespacing="0" frameborder="no" border="0">
  <frame src="flow_predefine_left.jsp" name="flowPredefineLeftFrame" id="flowPredefineLeftFrame" title="flowPredefineLeftFrame" />
  <frame src="flow_predefine_list.jsp" name="flowPredefineMainFrame" id="flowPredefineMainFrame" title="flowPredefineMainFrame" />
</frameset>
<noframes><body>
</body>
</noframes></html>
