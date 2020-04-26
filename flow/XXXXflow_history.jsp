<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>流程处理记录</title>
<link href="../admin/default.css" rel="stylesheet" type="text/css">
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
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String myname = privilege.getUser(request);

long flowId = ParamUtil.getLong(request, "flowId");

String sql = "select id from flow_my_action where flow_id=" + flowId + " order by receive_date asc";
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">流程处理记录&nbsp;</td>
    </tr>
  </tbody>
</table>
<%
MyActionDb mad = new MyActionDb();
Vector v = mad.list(sql);
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="99%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="8%">编号</td>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap>标题</td>
      <td class="thead" noWrap width="11%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
      <td class="thead" noWrap width="14%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">到达时间</td>
      <td class="thead" noWrap width="15%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">处理时间</td>
      <td class="thead" noWrap width="9%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">发起人</td>
      <td class="thead" noWrap width="9%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">状态</td>
      <td class="thead" noWrap width="8%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
    <%
java.util.Iterator ir = v.iterator();	
com.redmoon.oa.person.UserMgr um = new com.redmoon.oa.person.UserMgr();
Directory dir = new Directory();	
while (ir.hasNext()) {
 	mad = (MyActionDb)ir.next();
	WorkflowDb wfd = new WorkflowDb();
	wfd = wfd.getWorkflowDb((int)mad.getFlowId());
	String userName = wfd.getUserName();
	String userRealName = "";
	if (userName!=null) {
		UserDb user = um.getUserDb(wfd.getUserName());
		userRealName = user.getRealName();
	}
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">
      <img src="../admin/images/arrow.gif" align="absmiddle">&nbsp;<%=wfd.getId()%></td>
      <td style="PADDING-LEFT: 10px">&nbsp;&nbsp;<%=StrUtil.getLeft(wfd.getTitle(), 28)%></td>
      <td>
	  <%
	  Leaf ft = dir.getLeaf(wfd.getTypeCode());
	  if (ft!=null)
	  	out.print(ft.getName());
	  %>	  </td>
      <td><%=DateUtil.format(mad.getReceiveDate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=DateUtil.format(mad.getCheckDate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=userRealName%></td>
      <td><%=mad.isChecked()?"已处理":"未处理"%>	  </td>
      <td><a href="../flow_modify.jsp?flowId=<%=wfd.getId()%>&actionId=<%=mad.getActionId()%>">查看</a></td>
    </tr>
    <%}%>
  </tbody>
</table>
<table width="96%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
</table>
</body>
</html>