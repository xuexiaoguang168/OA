<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.db.Paginator"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/DirListTag.tld" prefix="dirlist" %>
<html>
<head>
<title><%=Global.AppName%> - 列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="common.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
String dir_code = ParamUtil.get(request, "dir_code");
if (dir_code.equals("")) {
	out.print(fchar.makeErrMsg("类别编码不能为空！"));
	return;
}
Leaf lf = new Leaf();
lf = lf.getLeaf(dir_code);
Document document = new Document();
%>
<table width="100%" height="577" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="0%" height="575" valign="top" bgcolor="#CCCCCC"></td>
    <td width="100%" valign="top"><%
		String sql="select id from document where class1=" + StrUtil.sqlstr(dir_code);
		
		if (!SecurityUtil.isValidSql(sql)) {
			out.print(fchar.p_center("标识非法！"));
			return;
		}
		
		int pagesize = 20;
		
	    int total = document.getDocCount(sql);

		int curpage,totalpages;
		Paginator paginator = new Paginator(request, total, pagesize);
        //设置当前页数和总页数
	    totalpages = paginator.getTotalPages();
		curpage	= paginator.getCurrentPage();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
      <table width="92%" border="0" align="center" class="p9">
        <tr>
          <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
        </tr>
      </table>
      <table width=98% height="28" border=0 align="center" cellpadding="0" cellspacing="1" class="p9">
        <%@ taglib uri="/WEB-INF/tlds/DocListTag.tld" prefix="dl" %>
        <dl:DocListTag action="list" query="" dirCode="<%=dir_code%>" start="<%=(curpage-1)*pagesize%>" end="<%=curpage*pagesize%>">
        <dl:DocListItemTag field="title" mode="detail">
		<tr bgcolor="#F0F0F0">
          <td width="78%" height=23 align="left">&nbsp;<img src="images/pin_icon_03.gif" align="absbottom">&nbsp;<a href="doc_show.jsp?id=$id">$title</a></td>
          <td width="22%" align="center">[$modifiedDate]</td>
        </tr>
		</dl:DocListItemTag>
        </dl:DocListTag>
      </table>
      <table width="96%"  border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="right">
<%
	String querystr = "dir_code=" + StrUtil.UrlEncode(dir_code);
    out.print(paginator.getCurPageBlock("doc_list.jsp?"+querystr));
%>       </td>
        </tr>
    </table></td>
  </tr>
</table>
<br>
</body>
</html>