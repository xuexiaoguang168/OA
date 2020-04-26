<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.cms.*" %>
<%@ page import="com.redmoon.oa.pvg.*" %>
<html>
<head>
<title>文件列表</title>
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
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="dir" scope="page" class="cn.js.fan.module.cms.Directory"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_READ)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String sql = "select class1,title,id,isHome,examine,modifiedDate,color,isBold,expire_date from document";
String op = StrUtil.getNullString(request.getParameter("op"));
String dir_code = ParamUtil.get(request, "dir_code");
LeafPriv lp = new LeafPriv();
if (!dir_code.equals("")) {
	lp.setDirCode(dir_code);
	if (!lp.canUserSee(privilege.getUser(request))) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
Leaf leaf = dir.getLeaf(dir_code);
String dir_name = "";
if (leaf!=null)
	dir_name = leaf.getName();
if (op.equals("del")) {
	int id = ParamUtil.getInt(request, "id");
	try {
		if (docmanager.del(request, id, privilege))
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_operate_success"), "document_list_m.jsp?dir_code=" + StrUtil.UrlEncode(dir_code)));
		else
			out.print(StrUtil.Alert("删除失败！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
		return;
	}
	op = "";
}

if (op.equals("delBatch")) {
	try {
		docmanager.delBatch(request);
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_operate_success"), "document_list_m.jsp?dir_code=" + StrUtil.UrlEncode(dir_code)));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
		return;
	}
	op = "";
}

if (op.equals("passExamine")) {
	try {
		docmanager.passExamineBatch(request);
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_operate_success"), "document_list_m.jsp?dir_code=" + StrUtil.UrlEncode(dir_code)));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
		return;
	}
	op = "";
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">
	  	<%if (!dir_code.equals("") && lp.canUserModify(privilege.getUser(request))) {%>
        <a href="dir_frame.jsp?root_code=<%=StrUtil.UrlEncode(dir_code)%>" target="_parent">管理目录</a>
        &nbsp;&nbsp;|
        <%}%>
&nbsp;
      <%
	  if (!op.equals("search")) {
	  	if (leaf!=null && leaf.isLoaded()) {
			Leaf lf = leaf;
			String navstr = "";
			String parentcode = lf.getParentCode();
			Leaf plf = new Leaf();
			while (!parentcode.equals("root")) {
				plf = plf.getLeaf(parentcode);
				if (plf==null || !plf.isLoaded())
					break;
				if (plf.getType()==Leaf.TYPE_LIST && plf.getChildCount()!=0)
					navstr = "<a href='dir_frame.jsp?root_code=" + StrUtil.UrlEncode(plf.getCode()) + "'>" + plf.getName() + "</a>&nbsp;>>&nbsp;" + navstr;
				else if (plf.getType()==Leaf.TYPE_LIST && plf.getChildCount()==0)
					navstr = "<a href='document_list_m.jsp?dir_code=" + StrUtil.UrlEncode(plf.getCode()) + "'>" + plf.getName() + "</a>&nbsp;>>&nbsp;" + navstr;
				else
					navstr = plf.getName() + "</a>&nbsp;>>&nbsp;" + navstr;
				
				parentcode = plf.getParentCode();
			}
			out.print(navstr + lf.getName());
		}
	}
	else
		out.print("搜索结果");
		%></td>
    </tr>
  </tbody>
</table>
<%
String what = "";
String kind = "";
if (op.equals("search")) {
	kind = ParamUtil.get(request, "kind");
	what = ParamUtil.get(request, "what");
	if (kind.equals("title"))
		sql += " where examine=" + Document.EXAMINE_PASS + " and title like "+StrUtil.sqlstr("%"+what+"%");
	// else if (kind.equals("content"))
	// 	sql += " where content like " + StrUtil.sqlstr("%" + what + "%");
	else
		sql += " where examine=" + Document.EXAMINE_PASS + " and keywords like " + StrUtil.sqlstr("%" + what + "%");
}
else {
	if (!dir_code.equals(""))
		sql += " where class1=" + StrUtil.sqlstr(dir_code);
	if (!dir_code.equals("") && !lp.canUserModify(privilege.getUser(request))) {
		sql += " and examine=" + Document.EXAMINE_PASS;
		sql += " order by isHome desc, modifiedDate desc";
	}
	else
		sql += " order by examine asc, isHome desc, modifiedDate desc";
}

String strcurpage = StrUtil.getNullString(request.getParameter("CPages"));
if (strcurpage.equals(""))
	strcurpage = "1";
if (!StrUtil.isNumeric(strcurpage)) {
	out.print(StrUtil.makeErrMsg("标识非法！"));
	return;
}
int pagesize = 15;
int curpage = Integer.parseInt(strcurpage);
PageConn pageconn = new PageConn(Global.defaultDB, Integer.parseInt(strcurpage), pagesize);
ResultIterator ri = pageconn.getResultIterator(sql);
ResultRecord rr = null;

Paginator paginator = new Paginator(request, pageconn.getTotal(), pagesize);
//设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}
%>
<br>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" class="p9">
    <tr>
  <form name="form1" action="document_list_m.jsp?op=search" method="post">
      <td width="82%" align="center">按
        <select name="kind">
          <option value="title">标题</option>
          <option value="keywords">关键字</option>
        </select>
&nbsp;
<input name=what size=20>
&nbsp;
<input name="submit" type=submit value="搜索"></td>
  </form>
      <td width="18%" align="center"><%if (!dir_code.equals("") && leaf.getType()==2) {%>
        <input name="image" type=image 
onClick="javascript:window.location.href='../fwebedit.jsp?op=add&dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name, "utf-8")%>';" src="images/btn_add.gif" width=80 
height=20>
      <%}%></td>
    </tr>
</table>
<br>
<table width="92%" border="0" align="center" class="p9">
  <tr>
    <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
  </tr>
</table>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="1" cellPadding="3" width="98%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="55%">标题</td>
      <td class="thead" noWrap width="15%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">修改时间</td>
      <td class="thead" noWrap width="11%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">审核状态</td>
      <td class="thead" noWrap width="19%"><img src="images/tl.gif" align="absMiddle" width="10" height="15">管理</td>
    </tr>
    <%
while (ri.hasNext()) {
 	rr = (ResultRecord)ri.next(); 
	boolean isHome = rr.getInt("isHome")==1?true:false;
	String color = StrUtil.getNullStr(rr.getString("color"));
	boolean isBold = rr.getInt("isBold")==1;
	java.util.Date expireDate = rr.getDate("expire_date");
	%>
    <tr onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" class="tbg1">
      <td><input name="ids" type="checkbox" value="<%=rr.getInt("id")%>">
      <%if (DateUtil.compare(new java.util.Date(), expireDate)==2) {%>
	  	<a href="../doc_show.jsp?id=<%=rr.getInt("id")%>" title="<%=rr.getString(2)%>">
		<%
		if (isBold)
			out.print("<B>");
		if (!color.equals("")) {
		%>
			<font color="<%=color%>">
		<%}%>
		<%=(String)rr.get(2)%>
		<%if (!color.equals("")) {%>
		</font>
		<%}%>
		<%
		if (isBold)
			out.print("</B>");
		%>
		</a>
	  <%}else{%>
	  	<a href="../doc_show.jsp?id=<%=rr.getInt("id")%>" title="<%=rr.getString(2)%>"><%=(String)rr.get(2)%></a>
	  <%}%>	  </td>
      <td><%
	  java.util.Date d = rr.getDate("modifiedDate");
	  if (d!=null)
	  	out.print(DateUtil.format(d, "yy-MM-dd HH:mm"));
	  %>      </td>
      <td align="center">
	  <%
	  int examine = rr.getInt("examine");
	  if (examine==0)
	  	out.print("<font color='blue'>未审核</font>");
	  else if (examine==1)
	  	out.print("<font color='red'>未通过</font>");
	  else
	  	out.print("已通过");
	  %>	  </td>
      <td align="left"><a href="../fwebedit.jsp?op=edit&id=<%=rr.getInt("id")%>&dir_code=<%=StrUtil.UrlEncode((String)rr.get(1))%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>">编辑</a> <a onClick="return confirm('您确定要删除吗？')" href="document_list_m.jsp?op=del&id=<%=rr.getString(3)%>&dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>">删除</a> <a href="../doc_show.jsp?id=<%=rr.getInt("id")%>">查看</a>&nbsp;<a href="document_list_m.jsp?op=passExamine&dir_code=<%=StrUtil.UrlEncode(dir_code)%>&ids=<%=rr.getInt("id")%>">通过</a></td>
    </tr>
    <%}%>
  </tbody>
</table>
<table width="96%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2" align="right">&nbsp;</td>
  </tr>
  <tr>
    <td width="55%" align="left"><input name="button3" type="button" onClick="selAllCheckBox('ids')" value="全选">
&nbsp;&nbsp;
<input name="button3" type="button" onClick="clearAllCheckBox('ids')" value="清除选择">
&nbsp;
<input name="button3" type="button" onClick="doDel()" value="删除">
&nbsp;
<input name="button32" type="button" onClick="passExamineBatch()" value="通过"></td>
    <td width="45%" align="right"><%
	String querystr = "op="+op+"&what="+StrUtil.UrlEncode(what) + "&dir_code=" + StrUtil.UrlEncode(dir_code) + "&op=" + op + "&kind=" + kind + "&what=" + StrUtil.UrlEncode(what);
    out.print(paginator.getCurPageBlock("document_list_m.jsp?"+querystr));
%></td>
  </tr>
</table>
</body>
<script src="../inc/common.js"></script>
<script>
function doDel() {
	var ids = getCheckboxValue("ids");
	if (ids=="") {
		alert("请选择文章！");
		return;
	}
	window.location.href = "?op=delBatch&dir_code=<%=StrUtil.UrlEncode(dir_code)%>&ids=" + ids;
}

function passExamineBatch() {
	var ids = getCheckboxValue("ids");
	if (ids=="") {
		alert("请选择文章！");
		return;
	}
	window.location.href = "?op=passExamine&dir_code=<%=StrUtil.UrlEncode(dir_code)%>&ids=" + ids;
}

function selAllCheckBox(checkboxname){
	var checkboxboxs = document.all.item(checkboxname);
	if (checkboxboxs!=null)
	{
		// 如果只有一个元素
		if (checkboxboxs.length==null) {
			checkboxboxs.checked = true;
		}
		for (i=0; i<checkboxboxs.length; i++)
		{
			checkboxboxs[i].checked = true;
		}
	}
}

function clearAllCheckBox(checkboxname) {
	var checkboxboxs = document.all.item(checkboxname);
	if (checkboxboxs!=null)
	{
		// 如果只有一个元素
		if (checkboxboxs.length==null) {
			checkboxboxs.checked = false;
		}
		for (i=0; i<checkboxboxs.length; i++)
		{
			checkboxboxs[i].checked = false;
		}
	}
}
</script>
</html>