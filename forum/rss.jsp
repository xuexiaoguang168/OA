<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.tools.*"%>
<%@ page import="cn.js.fan.util.ParamUtil"%>
<%
RSSGenerator rg = new RSSGenerator();
String boardCode = ParamUtil.get(request, "boardCode");
String op = ParamUtil.get(request, "op");
if (!op.equals("blog")) {
	if (boardCode.equals(""))
		rg.generateForumRSS(out, "rss_1.0", 20);
	else
		rg.generateBoardRSS(out, "rss_1.0", 20, boardCode);
}
else {
	String userName = ParamUtil.get(request, "userName");
	String blogUserDir = ParamUtil.get(request, "blogUserDir");
	rg.generateUserBlogRSS(out, "rss_1.0", 10, userName, blogUserDir);
}
%>
