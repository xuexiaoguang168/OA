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
String priv = "admin";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td height="28" class="head">工作流序列号管理</td>
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

String op = ParamUtil.get(request, "op");
String by = ParamUtil.get(request, "by");
String what = ParamUtil.get(request, "what");

String action = ParamUtil.get(request, "action");
if (action.equals("del")) {
	try {
		int id = ParamUtil.getInt(request, "id");
		WorkflowSequenceDb wsd = new WorkflowSequenceDb();
		wsd = wsd.getWorkflowSequenceDb(id);
		wsd.del();
		out.print(StrUtil.Alert_Redirect("删除完毕！", "?op=" + op + "&by=" + by + "&what=" + StrUtil.UrlEncode(what)));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
}

if (action.equals("add")) {
	String name = ParamUtil.get(request, "name").trim();
	long beginIndex = ParamUtil.getLong(request, "beginIndex");
	long curIndex = ParamUtil.getLong(request, "curIndex");
	int len = ParamUtil.getInt(request, "length");
	if (name.equals("")) {
		out.print(StrUtil.Alert_Back("请填写序列名称！"));
	}
	else {
		WorkflowSequenceDb wsd = new WorkflowSequenceDb();
		wsd.setBeginIndex(beginIndex);
		wsd.setCurIndex(curIndex);
		wsd.setLength(len);
		wsd.setName(name);
		if (wsd.create()) {
			out.print(StrUtil.Alert("操作成功！"));
		}
		else
			out.print(StrUtil.Alert_Back("操作失败！"));
	}
}

if (action.equals("modify")) {
	String name = ParamUtil.get(request, "name").trim();
	long beginIndex = ParamUtil.getLong(request, "beginIndex");
	long curIndex = ParamUtil.getLong(request, "curIndex");
	int len = ParamUtil.getInt(request, "length");
	int id = ParamUtil.getInt(request, "id");
	if (name.equals("")) {
		out.print(StrUtil.Alert_Back("请填写序列名称！"));
	}
	else {
		WorkflowSequenceDb wsd = new WorkflowSequenceDb();
		wsd = wsd.getWorkflowSequenceDb(id);
		wsd.setBeginIndex(beginIndex);
		wsd.setCurIndex(curIndex);
		wsd.setLength(len);
		wsd.setName(name);
		if (wsd.save()) {
			out.print(StrUtil.Alert("操作成功！"));
		}
		else
			out.print(StrUtil.Alert_Back("操作失败！"));
	}
}

WorkflowSequenceDb wf = new WorkflowSequenceDb();

String sql = "select id from flow_sequence order by name asc";
if (op.equals("search")) {
	if (by.equals("name")) {
		sql = "select id from flow_sequence where name like " + StrUtil.sqlstr("%" + what + "%") +  " order by name asc";
	}
}

ListResult lr = wf.listResult(sql, curpage, pagesize);
int total = lr.getTotal();
Paginator paginator = new Paginator(request, total, pagesize);
// 设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0) {
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
	<option value="name">名称</option>
	</select>
	&nbsp;
	<input name="what" >
	&nbsp;
	<input value="搜索" type=submit></td>
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
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="6%">标识</td>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="29%">名称</td>
      <td class="thead" noWrap width="12%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">当前索引</td>
      <td class="thead" noWrap width="13%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">管理</td>
    </tr>
    <%
Leaf ft = new Leaf();	
UserMgr um = new UserMgr();
int i = 0;
while (ir.hasNext()) {
	i ++;
 	WorkflowSequenceDb wsd = (WorkflowSequenceDb)ir.next(); 
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
	<form name="form<%=i%>" action="?action=modify" method=post>
      <td style="PADDING-LEFT: 10px">
      <img src="images/arrow.gif" align="absmiddle">&nbsp;<%=wsd.getId()%>
	  <input name="id" type="hidden" value="<%=wsd.getId()%>">	  </td>
      <td style="PADDING-LEFT: 10px">&nbsp;&nbsp;
		<input name="name" value="<%=wsd.getName()%>" size="40">
		<input name="beginIndex" value="<%=wsd.getBeginIndex()%>" type=hidden>	  </td>
      <td><input name="curIndex" value="<%=wsd.getCurIndex()%>">
        <input name="length" value="<%=wsd.getLength()%>" size="10" type="hidden"></td>
      <td><input type=submit value=修改>&nbsp;&nbsp;
		<a href="javascript: if (confirm('您确定要删除吗?')) window.location.href='?action=del&id=<%=wsd.getId() + "&op=" + op + "&by=" + by + "&what=" + StrUtil.UrlEncode(what)%>'">删除</a>	  </td>
	  </form>
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
  <tr>
    <td align="right"><table width="381" border="0" align="center" class="singleboarder">
	<form action="?action=add" method=post>
      <tr>
        <td colspan="2" align="center" class="thead">添加序列</td>
      </tr>
      <tr>
        <td width="65" align="center">序列名称</td>
        <td width="302" align="left"><input name="name" value="">
          <input name="beginIndex" id="beginIndex" value="1" type=hidden></td>
      </tr>
      
      <tr>
        <td align="center">当前索引</td>
        <td align="left"><input name="curIndex" id="curIndex" value="1">
          <input name="length" id="length" value="0" type="hidden"></td>
      </tr>
      
      <tr>
        <td colspan="2" align="center"><input type="submit" value=" 确  定 "></td>
        </tr>
      </form>
    </table></td>
  </tr>
</table>
</body>
<script language="javascript">
<!--
//-->
</script>
</html>