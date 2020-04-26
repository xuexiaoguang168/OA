<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><lt:Label res="res.label.forum.admin.user_group_m" key="user_group_manage"/></title>
<link href="../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style4 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
String op = ParamUtil.get(request, "op");
UserGroupDb ug = null;
boolean isEdit = false;
if (op.equals("edit")) {
	isEdit = true;
	String code = ParamUtil.get(request, "code");
	if (code.equals("")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.label.forum.admin_user_group_m", "need_code")));
		return;
	}
	ug = new UserGroupDb();
	ug = ug.getUserGroupDb(code);
}
if (op.equals("editdo")) {
	isEdit = true;
	UserGroupMgr usergroupmgr = new UserGroupMgr();
	try {
		if (usergroupmgr.update(request))
			out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success"))); 
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}	
	String code = ParamUtil.get(request, "code");
	if (code.equals("")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.label.forum.admin_user_group_m", "need_code")));
		return;
	}
	ug = usergroupmgr.getUserGroupDb(code);
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head"><a href="user_group_m.jsp"><lt:Label res="res.label.forum.admin.user_group_m" key="user_group_manage"/></a></td>
    </tr>
  </tbody>
</table>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">
	  <%if (isEdit) {%>
	  	  <lt:Label res="res.label.forum.admin.user_group_m" key="user_group_modify"/>
	  <%}else{%>
		  <lt:Label res="res.label.forum.admin.user_group_m" key="user_group_add"/>
	  <%}%>
	  </TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="53%" border="0" cellpadding="0" cellspacing="1">
          <tr>
            <td align="center"><table width="65%" border="0" cellpadding="0" cellspacing="0">
                <form name="form1" method="post" action="<%=isEdit?"user_group_op.jsp?op=editdo":"user_group_m.jsp?op=add"%>">
                  <tr>
                    <td width="19%" height="31" align="center"><lt:Label res="res.label.forum.admin.user_group_m" key="code"/></td>
                  <td width="81%" align="left"><input name="code" value="<%=isEdit?ug.getCode():""%>" <%=isEdit?"readonly":""%>></td>
                  </tr>
                  <tr>
                    <td height="32" align="center"><lt:Label res="res.label.forum.admin.user_group_m" key="desc"/></td>
                  <td align="left"><input name="desc" value="<%=isEdit?ug.getDesc():""%>"></td>
                  </tr>
                  <tr>
                    <td height="32" align="center"><lt:Label res="res.label.forum.admin.user_group_m" key="display_order"/></td>
                    <td align="left"><input name="displayOrder" value="<%=isEdit?ug.getDisplayOrder():""%>"></td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center">                    </td>
                  </tr>
                  <tr>
                    <td height="43" colspan="2" align="center"><input name="Submit" type="submit" value="<lt:Label key="commit"/>">
&nbsp;&nbsp;&nbsp;
                      <input name="Submit" type="reset" value="<lt:Label key="reset"/>"></td>
                  </tr>
                </form>
            </table></td>
          </tr>
      </table></TD>
    </TR>
    <TR>
      <TD class=tfoot align=right></TD>
    </TR>
  </TBODY>
</TABLE>
<br>
<br>
</body>
</html>