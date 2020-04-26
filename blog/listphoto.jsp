<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.module.photo.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String userName = ParamUtil.get(request, "userName");
if (userName.equals("")) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.list","not_name")));
	return;
}

UserConfigDb ucd = new UserConfigDb();
ucd = ucd.getUserConfigDb(userName);
if (!ucd.isLoaded()) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.blog.list","activate_blog_fail")));
	return;	
}

String skinPath = "skin/" + ucd.getSkin();
%>
<html>
<head>
<title><%=ucd.getPenName()%> - <%=Global.AppName%></title>
<LINK href="<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@ include file="header.jsp"%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class=blog_table_main>
  <tr>
    <td width="220"><%@ include file="left.jsp"%></td>
    <td valign="top" class="blog_td_main"><%		
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
		sql = "select id from " + pd.getTableName() + " where userName=" + StrUtil.sqlstr(userName) + " ORDER BY addDate desc";

	    int total = 0;
		int pagesize = 20;
		int curpage = Integer.parseInt(strcurpage);
		
		ListResult lr = pd.ListPhotos(sql, curpage, pagesize);
		if (lr!=null)
			total = lr.getTotal();
		
		Paginator paginator = new Paginator(request, total, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
		
        Iterator irphoto = null;
		if (lr!=null)
			irphoto = lr.getResult().iterator();
%>
      <table width="98%" border="0" class="p9">
        <tr>
          <td width="44%" align="left"></td>
          <td width="56%" align="right"><%=paginator.getPageStatics(request)%></td>
        </tr>
      </table>
      <%		
String id="",topic = "",name="",lydate="",rename="",redate="";
int level=0,iselite=0,islocked=0,expression=0;
int i = 0,recount=0,hit=0,type=0;
ForumDb forum = new ForumDb();
%>
      <%
if (irphoto!=null)	  
	while (irphoto.hasNext()) {
	 	  pd = (PhotoDb) irphoto.next(); 
		  i++;
	  %>
      <table bordercolor=#edeced cellspacing=0 cellpadding=5 width="98%" align=center border=0>
        <tbody>
          
          <tr>
            <td width="77%" align=left bgcolor=#f8f8f8><a href="showphoto.jsp?id=<%=pd.getId()%>&userName=<%=StrUtil.UrlEncode(userName)%>"><%=pd.getTitle()%></a></td>
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
				out.print(paginator.getPageBlock(request,"listtopic.jsp?"+querystr));
				%>
            &nbsp;&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<%@ include file="footer.jsp"%>
</body>
</html>