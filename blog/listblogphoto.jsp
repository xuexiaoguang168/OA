<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="com.redmoon.forum.MsgDb"%>
<%@ page import="com.redmoon.forum.person.UserDb"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.module.photo.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<html>
<head>
<%
String title = SkinUtil.LoadString(request,"res.label.blog.list", "listblogphoto_title");
title = StrUtil.format(title, new Object[] {Global.AppName});
%>
<title><%=title%></title>
<LINK href="common.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style1 {font-size: 14px;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<%@ include file="blog_header.jsp"%>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><%		
		String privurl = StrUtil.getUrl(request);
		
		PhotoDb pd = new PhotoDb();
		
		String strcurpage = StrUtil.getNullString(request.getParameter("CPages"));
		if (strcurpage.equals(""))
			strcurpage = "1";
		if (!StrUtil.isNumeric(strcurpage)) {
			out.print(StrUtil.makeErrMsg(SkinUtil.LoadString(request, "err_id")));
			return;
		}
		
		String sql;
		sql = "select id from " + pd.getTableName() + " ORDER BY addDate desc";

	    int total = 0;
		int pagesize = 20;
		int curpage = Integer.parseInt(strcurpage);
		
		ListResult lr = pd.ListPhotos(sql, curpage, pagesize);
		if (lr!=null) {
			total = lr.getTotal();
			
			Paginator paginator = new Paginator(request, total, pagesize);
			// 设置当前页数和总页数
			int totalpages = paginator.getTotalPages();
			if (totalpages==0)
			{
				curpage = 1;
				totalpages = 1;
			}
			
			Iterator irphoto = lr.getResult().iterator();
	%>
		  <table width="98%" border="0" class="p9">
			<tr>
			  <td width="44%" align="left"></td>
			  <td width="56%" align="right"><%=paginator.getPageStatics(request)%></td>
			</tr>
		  </table>
		  <%
		while (irphoto.hasNext()) {
			  pd = (PhotoDb) irphoto.next(); 
		  %>
		  <table bordercolor=#edeced cellspacing=0 cellpadding=5 width="98%" align=center border=0>
			<tbody>
			  <tr>
				<td width="77%" align=left bgcolor=#f8f8f8><a href="showphoto.jsp?id=<%=pd.getId()%>&userName=<%=StrUtil.UrlEncode(pd.getUserName())%>"><%=pd.getTitle()%></a></td>
				<td width="23%" align=left bgcolor=#f8f8f8><%=pd.getAddDate()%></td>
			  </tr>
			  <tr>
				<td height=1 colspan="2" align=left background="../images/comm_dot.gif"></td>
			  </tr>
			</tbody>
		  </table>
		  <%}%>
		  <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
			<tr>
			  <td height="23" align="right"><%
					String querystr = "";
					out.print(paginator.getPageBlock(request,"?"+querystr));
					%>
				&nbsp;&nbsp;</td>
			</tr>
		  </table>
	  <%}%>
    </td>
    <td width="2"></td>
    <td width="260" valign="top" bgcolor="#F7F7F7" class="line4t"><%@ include file="blog_left.jsp"%></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
</table>
<%@ include file="footer.jsp"%>
</body>
</html>