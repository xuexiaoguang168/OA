<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
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

// 取得显示的年月 
int year, month, day = 1;
try {
	year = ParamUtil.getInt(request, "y");
	month = ParamUtil.getInt(request, "m");
	day = ParamUtil.getInt(request, "d");
}
catch (Exception e) {
    Calendar cal = Calendar.getInstance();
    year = cal.get(cal.YEAR);
    month = cal.get(cal.MONTH) + 1;
}

String skinPath = "skin/" + ucd.getSkin();
%>
<html>
<head>
<title><%=ucd.getTitle()%> - <%=ucd.getPenName()%> - <%=Global.AppName%></title>
<LINK href="<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@ include file="header.jsp"%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class=blog_table_main>
  <tr>
    <td width="220"><%@ include file="left.jsp"%></td>
    <td valign="top" class="blog_td_main"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_main_text">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="3%" class="blog_td_title">&nbsp;</td>
		<%
		String log_list = SkinUtil.LoadString(request,"res.label.blog.list", "log_list");
		log_list = StrUtil.format(log_list, new Object[] {year,month,day});
		%>
            <td width="97%" class="blog_td_title"><%=log_list%></td>
          </tr>
        </table>
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="57%" align="center" class="listdayblog_td_title"><lt:Label res="res.label.blog.list" key="title"/></td>
              <td width="21%" align="center" class="listdayblog_td_title"><lt:Label res="res.label.blog.list" key="date"/></td>
              <td width="12%" align="center" class="listdayblog_td_title"><lt:Label res="res.label.blog.list" key="browse"/></td>
              <td width="10%" align="center" class="listdayblog_td_title"><lt:Label res="res.label.blog.list" key="comment"/></td>
            </tr>
          </table>
          <%
		  UserBlog ub = new UserBlog(userName);
		  Vector v = ub.getBlogDayList(year, month, day);
		  Iterator ir = v.iterator();
		  MsgDb md;
		  while (ir.hasNext()) {
		  	md = (MsgDb)ir.next();
		  %>
          <table width="100%" border="0" cellpadding="5" cellspacing="0">
            <tr>
              <td width="57%"><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>"><%=md.getTitle()%></a></td>
              <td width="21%" align="center"><%=DateUtil.format(md.getAddDate(), "yy-MM-dd HH:mm")%></td>
              <td width="12%" align="center"><%=md.getHit()%></td>
              <td width="10%" align="center"><%=md.getRecount()%></td>
            </tr>
            <tr>
              <td colspan="4" class="blog_td_spacer_down"></td>
              </tr>
          </table>
          <%
		  }
		  %></td>
      </tr>
    </table></td>
  </tr>
</table>
<%@ include file="footer.jsp"%>
</body>
</html>