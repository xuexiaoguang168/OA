<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>工作流管理</title>
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
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="admin.flow";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td height="28" class="head">工作流管理</td>
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
int pagesize = 10;
int curpage = Integer.parseInt(strcurpage);

String typeCode = ParamUtil.get(request, "typeCode");
String op = ParamUtil.get(request, "op");
String by = ParamUtil.get(request, "by");
String what = ParamUtil.get(request, "what");

String action = ParamUtil.get(request, "action");
if (action.equals("del")) {
	try {
		int flow_id = ParamUtil.getInt(request, "flow_id");
		System.out.println("flow_del.jsp " + flow_id);
		WorkflowMgr wm = new WorkflowMgr();
		WorkflowDb wf = wm.getWorkflowDb(flow_id);
		LeafPriv lp = new LeafPriv(typeCode);
		// 判断用户是否拥有管理权
		if (!lp.canUserSee(privilege.getUser(request))) {
			out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}		
		wf.del();
		out.print(StrUtil.Alert_Redirect("删除完毕！", "flow_list.jsp?op=" + op + "&by=" + by + "&typeCode=" + StrUtil.UrlEncode(typeCode) + "&what=" + StrUtil.UrlEncode(what)));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

WorkflowDb wf = new WorkflowDb();

String sql = "select id from flow order by begin_date desc";
if (op.equals("search")) {
	if (by.equals("user")) {
		// sql = "select id from flow where username like " + StrUtil.sqlstr("%" + what + "%") +  " order by begin_date desc";
		// 有管理权，则可在全部流程中搜索
		if (privilege.isUserPrivValid(request, "admin"))
			sql = "select f.id from flow f, users u where f.username=u.name and u.realName like " + StrUtil.sqlstr("%" + what + "%") +  " order by begin_date desc";
		else
			sql = "select f.id from flow f, users u where f.username=u.name and f.type_code=" + StrUtil.sqlstr(typeCode) + " and u.realName like " + StrUtil.sqlstr("%" + what + "%") +  " order by begin_date desc";
	}
	else if (by.equals("title")) {
		// 有管理权，则可在全部流程中搜索
		if (privilege.isUserPrivValid(request, "admin"))	
			sql = "select id from flow where title like " + StrUtil.sqlstr("%" + what + "%") +  " order by begin_date desc";
		else
			sql = "select id from flow where title like " + StrUtil.sqlstr("%" + what + "%") +  " and type_code=" + StrUtil.sqlstr(typeCode) + " order by begin_date desc";		
	}
}
else {
	if (!typeCode.equals("")) {
		LeafPriv lp = new LeafPriv(typeCode);
		if (!lp.canUserSee(privilege.getUser(request))) {
			out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
		sql = "select id from flow where type_code=" + StrUtil.sqlstr(typeCode) + " order by begin_date desc";
	}
}

ListResult lr = wf.listResult(sql, curpage, pagesize);
int total = lr.getTotal();
Paginator paginator = new Paginator(request, total, pagesize);
// 设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}

Vector v = lr.getResult();
Iterator ir = null;
if (v!=null)
	ir = v.iterator();
%>
<table width="80%" border="0" align="center">
<form name=form1 action="?op=search" method=post>
  <tr>
    <td align="center">按
	&nbsp;
	<select name="by">
	<option value="title">标题</option>
	<option value="user">发起人</option>
	</select>
<%
if (op.equals("search")) {
%>
	<script>
	form1.by.value = "<%=by%>";
	</script>
<%}%>	
	&nbsp;
	<input name="what" >
	&nbsp;
	<input value="搜索" type=submit>
	<input name="typeCode" type="hidden" value="<%=typeCode%>">
	</td>
  </tr>
</form>  
</table>
<br>
<table width="92%" border="0" align="center" class="p9">
  <tr>
    <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
  </tr>
</table>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="6%">编号</td>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="29%">标题</td>
      <td class="thead" noWrap width="15%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
      <td class="thead" noWrap width="17%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">开始时间</td>
      <td class="thead" noWrap width="12%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">发起人</td>
      <td class="thead" noWrap width="8%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">状态</td>
      <td class="thead" noWrap width="13%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">管理</td>
    </tr>
    <%
Leaf ft = new Leaf();	
UserMgr um = new UserMgr();
while (ir.hasNext()) {
 	WorkflowDb wfd = (WorkflowDb)ir.next(); 
	UserDb user = null;
	if (wfd.getUserName()!=null)
		user = um.getUserDb(wfd.getUserName());
	String userRealName = "";
	if (user!=null)
		userRealName = user.getRealName();	
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">
      <img src="images/arrow.gif" align="absmiddle"><%=wfd.getId()%></td>
      <td style="PADDING-LEFT: 10px">&nbsp;&nbsp;<%=wfd.getTitle()%></td>
      <td>
	  <%
	  Leaf lf = ft.getLeaf(wfd.getTypeCode());
	  if (lf!=null)
	  	out.print(lf.getName());
	  %>	  </td>
      <td><%=DateUtil.format(wfd.getBeginDate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=userRealName%></td>
      <td><%=wfd.getStatusDesc()%>	  </td>
      <td><a href="../flow_modify.jsp?flowId=<%=wfd.getId()%>">查看/修改</a>&nbsp;&nbsp;
		<a href="javascript: if (confirm('您确定要删除吗?')) window.location.href='?action=del&flow_id=<%=wfd.getId() + "&op=" + op + "&by=" + by + "&typeCode=" + StrUtil.UrlEncode(typeCode) + "&what=" + StrUtil.UrlEncode(what)%>'">删除</a>
	  </td>
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
	String querystr = "op=" + op + "&by=" + by + "&typeCode=" + StrUtil.UrlEncode(typeCode) + "&what=" + StrUtil.UrlEncode(what);
    out.print(paginator.getCurPageBlock("?"+querystr));
%></td>
  </tr>
</table>
<HR noShade SIZE=1>
</body>
<script language="javascript">
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.pwd.value!=form1.pwd_confirm.value)
		errmsg += "密码与确认密码不致，请检查！\n"
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}
//-->
</script>
</html>