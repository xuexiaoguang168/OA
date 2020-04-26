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
<title>我参与的流程列表</title>
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

String op = StrUtil.getNullString(request.getParameter("op"));
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td height="28" class="head"><span class="STYLE5">我参与的工作流</span>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="flow_list_mine.jsp">我发起的工作流</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="flow_list_done.jsp">历史办理记录</a></td>
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

WorkflowDb wf = new WorkflowDb();

ListResult lr = wf.listUserAttended(privilege.getUser(request), curpage, pagesize);
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
<br>
<table width="92%" border="0" align="center" class="p9">
  <tr>
    <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
  </tr>
</table>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="1" cellPadding="3" width="99%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="35%">标题</td>
      <td class="thead" noWrap width="18%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
      <td class="thead" noWrap width="16%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">开始时间</td>
      <td class="thead" noWrap width="12%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">发起人</td>
      <td class="thead" noWrap width="10%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">状态</td>
      <td class="thead" noWrap width="9%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">管理</td>
    </tr>
    <%
Leaf ft = new Leaf();	
com.redmoon.oa.person.UserMgr um = new com.redmoon.oa.person.UserMgr();
while (ir.hasNext()) {
 	WorkflowDb wfd = (WorkflowDb)ir.next(); 
	UserDb user = null;
	if (wfd.getUserName()!=null)
		user = um.getUserDb(wfd.getUserName());
	String userRealName = "";
	if (user!=null)
		userRealName = user.getRealName();	
	%>
    <tr onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" class="tbg1">
      <td>&nbsp;&nbsp;<a href="flow_modify.jsp?flowId=<%=wfd.getId()%>" title="<%=wfd.getTitle()%>"><%=StrUtil.getLeft(wfd.getTitle(), 40)%></a></td>
      <td>
	  <%
	  Leaf lf = ft.getLeaf(wfd.getTypeCode());
	  if (lf!=null)
	  	out.print(lf.getName());
	  %>	  </td>
      <td><%=DateUtil.format(wfd.getBeginDate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=userRealName%></td>
      <td><%=wfd.getStatusDesc()%>	  </td>
      <td align="center"><a href="flow_modify.jsp?flowId=<%=wfd.getId()%>">查看/修改</a></td>
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