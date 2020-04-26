<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>待办流程列表</title>
<link href="admin/default.css" rel="stylesheet" type="text/css">
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

String op = StrUtil.getNullString(request.getParameter("op"));
if (op.equals("del")) {
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">待办工作流&nbsp;</td>
    </tr>
  </tbody>
</table>
<%
String strcurpage = StrUtil.getNullString(request.getParameter("CPages"));
if (strcurpage.equals(""))
	strcurpage = "1";
if (!StrUtil.isNumeric(strcurpage)) {
	out.print(StrUtil.makeErrMsg("标识非法！"));
	return;
}
int pagesize = 20;
int curpage = Integer.parseInt(strcurpage);

String myname = privilege.getUser(request);
MyActionDb mad = new MyActionDb();
String sql = "select id from flow_my_action where (user_name=" + StrUtil.sqlstr(myname) + " or proxy=" + StrUtil.sqlstr(myname) + ") and is_checked=0 order by receive_date desc";
ListResult lr = mad.listResult(sql, curpage, pagesize);
int total = lr.getTotal();
Paginator paginator = new Paginator(request, total, pagesize);
// 设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}

int start = (curpage-1)*pagesize;
int end = curpage*pagesize;
%>
<br>
<table width="92%" border="0" align="center" class="p9">
  <tr>
    <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
  </tr>
</table>
<table width="99%" border="0" align="center" cellPadding="3" cellSpacing="1" bordercolor="#EFEBDE" bgcolor="#EFEBDE" style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="34%">标题</td>
      <td class="thead" noWrap width="14%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
      <td class="thead" noWrap width="15%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">开始时间</td>
      <td class="thead" noWrap width="10%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">发起人</td>
      <td class="thead" noWrap width="10%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">状态</td>
      <td class="thead" noWrap width="6%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
    <%
java.util.Iterator ir = lr.getResult().iterator();	
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
    <tr onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" class="tbg1">
      <td>&nbsp;&nbsp;<a href="flow_dispose.jsp?myActionId=<%=mad.getId()%>" title="<%=wfd.getTitle()%>"><%=StrUtil.getLeft(wfd.getTitle(), 40)%></a></td>
      <td>
	  <%
	  Leaf ft = dir.getLeaf(wfd.getTypeCode());
	  if (ft!=null)
	  	out.print(ft.getName());
	  %>	  </td>
      <td><%=DateUtil.format(wfd.getBeginDate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=userRealName%></td>
      <td><%=WorkflowActionDb.getStatusName(mad.getActionStatus())%>	  </td>
      <td align="center"><a href="flow_dispose.jsp?myActionId=<%=mad.getId()%>">处理</a></td>
    </tr>
    <%}%>
  </tbody>
</table>
<table width="96%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%
	String querystr = "op="+op;
    out.print(paginator.getCurPageBlock("?"+querystr));
%></td>
  </tr>
</table>
</body>
</html>