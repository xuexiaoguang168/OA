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
.STYLE5 {color: #CC6600}
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

String op = ParamUtil.get(request, "op");
String by = ParamUtil.get(request, "by");
String what = ParamUtil.get(request, "what");

String sql = "select id from flow_my_action where (user_name=" + StrUtil.sqlstr(myname) + " or proxy=" + StrUtil.sqlstr(myname) + ") and is_checked=1 order by receive_date desc";
if (op.equals("search")) {
	if (by.equals("title")) {
		sql = "select m.id from flow f,flow_my_action m where f.id=m.flow_id and f.title like " + StrUtil.sqlstr("%" + what + "%") +  " and (m.user_name=" + StrUtil.sqlstr(myname) + " or m.proxy=" + StrUtil.sqlstr(myname) + ") and m.is_checked=1 order by m.receive_date desc";
	}
	if (by.equals("flowId")) {
		if (!StrUtil.isNumeric(what)) {
			out.print(StrUtil.Alert("编号必须为数字！"));
		}
		else {
			sql = "select m.id from flow f,flow_my_action m where f.id=m.flow_id and f.id=" + what + " and (m.user_name=" + StrUtil.sqlstr(myname) + " or m.proxy=" + StrUtil.sqlstr(myname) + ") and m.is_checked=1 order by m.receive_date desc";
		}
	}
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head"><a href="flow_list_attend.jsp">我参与的工作流</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="flow_list_mine.jsp">我发起的工作流</a>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="STYLE5">历史办理记录</span></td>
    </tr>
  </tbody>
</table>
<table width="80%" border="0" align="center">
  <form name=form1 action="?op=search" method=post>
    <tr>
      <td align="center">按
        &nbsp;
            <select name="by">
              <option value="title">标题</option>
              <option value="flowId">编号</option>
            </select>
        &nbsp;
        <input name="what" >
        &nbsp;
        <input name="submit" type=submit value="搜索"></td>
    </tr>
  </form>
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

MyActionDb mad = new MyActionDb();
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
<table width="92%" border="0" align="center" class="p9">
  <tr>
    <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
  </tr>
</table>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="1" cellPadding="3" width="99%" align="center">
  <tbody>
    <tr>
      <td width="32%" noWrap class="thead" style="PADDING-LEFT: 10px">标题</td>
      <td class="thead" noWrap width="16%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
      <td width="15%" noWrap class="thead"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">到达时间</td>
      <td class="thead" noWrap width="14%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">处理时间</td>
      <td class="thead" noWrap width="9%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">发起人</td>
      <td class="thead" noWrap width="9%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">到达状态</td>
      <td class="thead" noWrap width="5%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
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
      <td>&nbsp;&nbsp;<a title="<%=wfd.getTitle()%>" href="flow_modify.jsp?flowId=<%=wfd.getId()%>&actionId=<%=mad.getActionId()%>"><%=StrUtil.getLeft(wfd.getTitle(), 40)%></a></td>
      <td>
	  <%
	  Leaf ft = dir.getLeaf(wfd.getTypeCode());
	  if (ft!=null)
	  	out.print(ft.getName());
	  %>	  </td>
      <td><%=DateUtil.format(mad.getReceiveDate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=DateUtil.format(mad.getCheckDate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=userRealName%></td>
      <td><%=WorkflowActionDb.getStatusName(mad.getActionStatus())%>	  </td>
      <td align="center"><a href="flow_modify.jsp?flowId=<%=wfd.getId()%>&actionId=<%=mad.getActionId()%>">查看</a></td>
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
	String querystr = "op=" + op + "&by=" + by + "&what=" + StrUtil.UrlEncode(what);
    out.print(paginator.getCurPageBlock("?"+querystr));
%></td>
  </tr>
</table>
</body>
</html>