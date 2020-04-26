<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.cloudwebsoft.framework.db.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<title><lt:Label res="res.label.forum.boardstatus" key="board_status"/> - <%=Global.AppName%></title>
<style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
-->
</style></head>
<body>
<%@ include file="inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
//安全验证
String targeturl = StrUtil.getUrl(request);
//if (!privilege.isUserLogin(request)) {
	//response.sendRedirect("door.jsp?targeturl="+targeturl);
	//return;
//}
%>
<%
		String type = ParamUtil.get(request, "type");
		String statusDesc = "";
		if (type.equals(""))
			type = "today_count";
		if (type.equals("today_count"))
			statusDesc = SkinUtil.LoadString(request, "res.label.forum.boardstatus", "today_count");
		else if (type.equals("topic_count"))
			statusDesc = SkinUtil.LoadString(request, "res.label.forum.boardstatus", "topic_count"); // "主题贴数";
		else if (type.equals("post_count"))
			statusDesc = SkinUtil.LoadString(request, "res.label.forum.boardstatus", "post_count"); // "总贴子数";
		else if (type.equals("online"))
			statusDesc = SkinUtil.LoadString(request, "res.label.forum.boardstatus", "online_diagram"); // "在线图示";
		else {
			out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "res.label.forum.boardstatus", "err_type")));
			return;
		}
		String sql = "";
		ResultRecord rr = null;
		JdbcTemplate jt = new JdbcTemplate(new DataSource());
		if (type.equals("online"))
			sql = "select count(*) from sq_online";
		else
			sql = "select sum(" + type + ") from sq_board where isHome=1 and islocked=0";
		ResultIterator ri = jt.executeQuery(sql);
		double total = 0;
		if (ri.hasNext()) {
			rr = (ResultRecord)ri.next();
			if (type.equals("online"))
				total = rr.getLong(1);
			else
				total = rr.getDouble(1);
		}
		if (type.equals("online"))
			sql = "select name,code from sq_board where code<>'root' and isHome=1 and islocked=0 order by name desc";
		else
			sql = "select " + type + ",name from sq_board where code<>'root' and isHome=1 and islocked=0 ORDER BY " + type + " desc";
		jt = new JdbcTemplate(new DataSource());
		ri = jt.executeQuery(sql);
%>
  <div align="center"><br>
    <strong><font color="#6666DF"><%=statusDesc%></font><br>
    <br>
    </strong></div>
<TABLE width="98%" 
border=0 align=center cellPadding=2 cellSpacing=1 bgcolor="#edeced">
    <TBODY>
      <TR align=center bgColor=#f8f8f8 class="td_title"> 
        <TD width=18% height=23><lt:Label res="res.label.forum.boardstatus" key="board"/></TD>
        <TD width=57% height=23><lt:Label res="res.label.forum.boardstatus" key="diagram"/></TD>
        <TD width=11%><lt:Label res="res.label.forum.boardstatus" key="perception"/></TD>
        <TD width=14% height=23><%=statusDesc%></TD>
      </TR>
      <%		
int barId = 0;
long count = 0;
String name = "";
String width = "";
while (ri.hasNext()) {
 	    rr = (ResultRecord)ri.next();
		if (type.equals("online")) {
			name = rr.getString(1);
			sql = "select count(*) from sq_online where boardcode=?";
			jt = new JdbcTemplate(new DataSource());
			ResultIterator ri2 = jt.executeQuery(sql, new Object[] { rr.getString(2) });
			if (ri2.hasNext()) {
				ResultRecord rr2 = (ResultRecord)ri2.next();
				count = rr2.getLong(1);
			}
		}
		else {
			count = rr.getLong(1);
			name = rr.getString(2);
		}
		if (total!=0)
			width = Math.round((double)count/total*100) + "%";		
%>
      <TR align=center bgColor=#f8f8f8> 
        <TD height=23 align="left"><%=name%></TD>
        <TD height=23 align="left">
		<img src="images/vote/bar<%=barId%>.gif" width=<%=width%> height=10>&nbsp;		</TD>
        <TD align="center"><%=width%></TD>
        <TD height=23 align="left"><%=count%></TD>
      </TR>
<%
	barId ++;
	if (barId==10)
		barId = 0;			
}%>
<%if (type.equals("online")) {
	sql = "select count(*) from sq_online where boardcode is null";
	jt = new JdbcTemplate(new DataSource());
	ResultIterator ri2 = jt.executeQuery(sql); // , new Object[] { null });
	if (ri2.hasNext()) {
		ResultRecord rr2 = (ResultRecord)ri2.next();
		count = rr2.getLong(1);
		if (total!=0)
			width = Math.round((double)count/total*100) + "%";		
	}
%>
      <TR align=center bgColor=#f8f8f8> 
        <TD width=18% height=23 align="left"><lt:Label res="res.label.forum.boardstatus" key="other_pos"/></TD>
        <TD width=57% height=23 align="left"><img src="images/vote/bar0.gif" width=<%=width%> height=10>&nbsp;</TD>
        <TD width=11% align="center"><%=width%></TD>
        <TD width=14% height=23 align="left"><%=count%></TD>
      </TR>
<%}%>
      <TR align=center bgColor=#f8f8f8> 
        <TD width=18% height=23 align="left"><strong><lt:Label res="res.label.forum.boardstatus" key="sum"/></strong></TD>
        <TD width=57% height=23 align="left"></TD>
        <TD width=11% align="left">&nbsp;</TD>
        <TD width=14% height=23 align="left"><strong><%=(int)total%></strong></TD>
      </TR>
    </TBODY>
</TABLE>
<%@ include file="inc/footer.jsp"%>
</body>
</html>
