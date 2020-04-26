<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<html>
<head>
<title>管理登录</title>
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
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.role")) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String op = ParamUtil.get(request, "op");
RoleDb rd = new RoleDb();
boolean isEdit = false;
if (op.equals("edit")) {
	isEdit = true;
	String code = ParamUtil.get(request, "code");
	if (code.equals("")) {
		StrUtil.Alert_Back("编码不能为空！");
		return;
	}
	rd = rd.getRoleDb(code);
}
if (op.equals("editdo")) {
	isEdit = true;
	RoleMgr roleMgr = new RoleMgr();
	try {
		if (roleMgr.update(request))
			out.print(StrUtil.Alert("修改成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}	
	String code = ParamUtil.get(request, "code");
	if (code.equals("")) {
		StrUtil.Alert_Back("编码不能为空！");
		return;
	}
	rd = roleMgr.getRoleDb(code);
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理角色&nbsp;&nbsp;（<a href="user_role_m.jsp">列表</a>）</td>
    </tr>
  </tbody>
</table>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">
	  <%if (isEdit) {%>
	  	  修改角色
	      <%}else{%>
		  添加角色
	      <%}%>
	  </TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="53%" border="0" cellpadding="0" cellspacing="1">
          <tr>
            <td align="center"><table width="65%" border="0" cellpadding="0" cellspacing="0">
                <form name="form1" method="post" action="<%=isEdit?"user_role_op.jsp?op=editdo":"user_role_m.jsp?op=add"%>">
                  <tr>
                    <td width="100" height="31" align="center">编码</td>
                  <td align="left"><input name="code" value="<%=isEdit?rd.getCode():RandomSecquenceCreator.getId(20)%>" <%=isEdit?"readonly":""%>></td>
                  </tr>
                  <tr>
                    <td height="32" align="center">描述</td>
                  <td align="left"><input name="desc" value="<%=isEdit?rd.getDesc():""%>"></td>
                  </tr>
                  <tr>
                    <td height="32" align="center">顺序</td>
                    <td align="left"><input name="orders" value="<%=isEdit?""+rd.getOrders():""%>"></td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center">                    </td>
                  </tr>
                  <tr>
                    <td height="43" colspan="2" align="center"><input name="Submit" type="submit" class="singleboarder" value="提交">
&nbsp;&nbsp;&nbsp;
                      <input name="Submit" type="reset" class="singleboarder" value="重置"></td>
                  </tr>
                </form>
            </table></td>
          </tr>
      </table></TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
<br>
<br>

</body>
<script language="javascript">
<!--
function form1_onsubmit()
{

}
//-->
</script>
</html>