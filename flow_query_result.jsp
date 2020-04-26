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
<title>工作流查询结果</title>
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
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td height="28" class="head">工作流查询结果&nbsp;</td>
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

String sql = "select id from flow";
String query = ParamUtil.get(request, "query");
if (!query.equals("")) // 分页传过来的sql
	sql = query;
else {
	if (op.equals("queryFlow")) {
		String typeCode = ParamUtil.get(request, "typeCode");
		String title = ParamUtil.get(request, "title");
		int title_cond = ParamUtil.getInt(request, "title_cond");
		String fDate = ParamUtil.get(request, "fromDate");
		String tDate = ParamUtil.get(request, "toDate");
		String fEndDate = ParamUtil.get(request, "fromBeginDate");
		String tEndDate = ParamUtil.get(request, "toEndDate");
		int status = ParamUtil.getInt(request, "status");
		sql = "select id from flow where type_code=" + StrUtil.sqlstr(typeCode);
		if (!title.equals("")) {
			if (title_cond==0) {
				sql += " and title like " + StrUtil.sqlstr("%" + title + "%");
			}
			else if (title_cond==1) {
				sql += " and title=" + StrUtil.sqlstr(title);
			}
		}
		if (!fDate.equals("")) {
			sql += " and BEGIN_DATE>=" + StrUtil.sqlstr(fDate);
		}
		if (!tDate.equals("")) {
			sql += " and BEGIN_DATE<=" + StrUtil.sqlstr(tDate);
		}
		if (!fEndDate.equals("")) {
			sql += " and END_DATE>=" + StrUtil.sqlstr(fEndDate);
		}
		if (!tEndDate.equals("")) {
			sql += " and END_DATE<=" + StrUtil.sqlstr(tEndDate);
		}
		if (status!=1000) {
			sql += " and status=" + status;
		}
	}
	else if (op.equals("queryForm")) {
		String typeCode = ParamUtil.get(request, "typeCode");
		Leaf lf = new Leaf();
		lf = lf.getLeaf(typeCode);
		FormDb fd = new FormDb();
		fd = fd.getFormDb(lf.getFormCode());
		Iterator ir = fd.getFields().iterator();
		sql = "select flowId from " + fd.getTableNameByForm() + " where flowTypeCode=" + StrUtil.sqlstr(typeCode);
		while (ir.hasNext()) {
			FormField ff = (FormField)ir.next();
			String value = ParamUtil.get(request, ff.getName());
			String name_cond = ParamUtil.get(request, ff.getName() + "_cond");
			if (ff.getType().equals(ff.TYPE_DATE) || ff.getType().equals(ff.TYPE_DATE_TIME)) {
				String fDate = ParamUtil.get(request, ff.getName() + "FromDate");
				String tDate = ParamUtil.get(request, ff.getName() + "ToDate");
				if (!fDate.equals(""))
					sql += " and " + ff.getName() + ">=" + StrUtil.sqlstr(fDate);
				if (!tDate.equals(""))
					sql += " and " + ff.getName() + "<=" + StrUtil.sqlstr(tDate);
			}
			else {
				if (name_cond.equals("0")) {
					if (!value.equals("")) {
						sql += " and " + ff.getName() + " like " + StrUtil.sqlstr("%" + value + "%");
					}
				}
				else if (name_cond.equals("1")) {
					if (!value.equals("")) {
						sql += " and " + ff.getName() + "=" + StrUtil.sqlstr(value);
					}
				}
			}
		}
	}
}

WorkflowDb wf = new WorkflowDb();
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
<br>
<table width="92%" border="0" align="center" class="p9">
  <tr>
    <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
  </tr>
</table>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="1" cellPadding="3" width="99%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="27%">标题</td>
      <td class="thead" noWrap width="19%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">类型</td>
      <td class="thead" noWrap width="18%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">发起时间</td>
      <td class="thead" noWrap width="15%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">发起人</td>
      <td class="thead" noWrap width="11%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">状态</td>
      <td class="thead" noWrap width="10%"><img src="admin/images/tl.gif" align="absMiddle" width="10" height="15">管理</td>
    </tr>
    <%
Leaf ft = new Leaf();	
UserMgr um = new UserMgr();
while (ir.hasNext()) {
 	WorkflowDb wfd = (WorkflowDb)ir.next(); 
	%>
    <tr onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" class="tbg1">
      <td>&nbsp;&nbsp;<a href="flow_modify.jsp?flowId=<%=wfd.getId()%>" title="<%=wfd.getTitle()%>"><%=StrUtil.getLeft(wfd.getTitle(), 24)%></a></td>
      <td>
	  <%
	  Leaf lf = ft.getLeaf(wfd.getTypeCode());
	  if (lf!=null)
	  	out.print(lf.getName());
	  %>	  </td>
      <td><%=DateUtil.format(wfd.getMydate(), "yy-MM-dd HH:mm:ss")%> </td>
      <td><%=um.getUserDb(wfd.getUserName()).getRealName()%></td>
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
	String querystr = "op="+op + "&query=" + StrUtil.UrlEncode(sql);
    out.print(paginator.getCurPageBlock("?"+querystr));
%></td>
  </tr>
</table>
</body>
<script language="javascript">
<!--
//-->
</script>
</html>