<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.base.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../common.css" type=text/css rel=stylesheet>
<title>online</title>
</head>
<body>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<div id="newdiv" name="newdiv">
<table width="100%">
  <tr><td>
  <%
String querystring = StrUtil.getNullString(request.getQueryString());
String privurl = request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");
String boardcode = StrUtil.getNullString(request.getParameter("boardcode"));

String sql = "";
if (boardcode.equals(""))
	sql = "select name from sq_online ORDER BY logtime";
else
	sql = "select name from sq_online where boardcode="+StrUtil.sqlstr(boardcode)+" ORDER BY logtime";
	
if (!SecurityUtil.isValidSql(sql)) {
	out.print(StrUtil.p_center(SkinUtil.LoadString(request, SkinUtil.ERR_SQL)));
	return;
}
		
OnlineUserDb ou = new OnlineUserDb();
int total = ou.getObjectCount(sql);

int pagesize = total; 	// 20;

int curpage,totalpages;
Paginator paginator = new Paginator(request, total, pagesize);
// 设置当前页数和总页数
totalpages = paginator.getTotalPages();
curpage	= paginator.getCurrentPage();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}	

ObjectBlockIterator oir = ou.getOnlineUsers(sql, (curpage-1)*pagesize, curpage*pagesize);

String id="",name="",ip="",logtime="",doing="",myface="";
boolean isguest = false;
String RealPic = "";
boolean covered = false;
int layer = 1;
int i = 1;
UserDb user = new UserDb();

int rowCount = 7; // 一行显示7个用户
int n = 0;
	while (oir.hasNext()) 
	{
		if (n==0)
			out.print("<tr>");
		ou = (OnlineUserDb) oir.next();
		i++;
		name = ou.getName();
		logtime = DateUtil.format(ou.getLogTime(), "yyyy-MM-dd HH:mm:ss");
		doing = ou.getDoing();
		isguest = ou.isGuest();
		covered = ou.isCovered();
		if (!isguest)
			user = user.getUser(name);
		RealPic = StrUtil.getNullString(user.getRealPic());
		myface = StrUtil.getNullString(user.getMyface());
		out.print("<td width='14%'>");
		if (!isguest) {
			if (!covered) {
	%>
			  <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>">
			  <%if (myface.equals("")) {%>
				  <img src="images/face/<%=RealPic%>" width=16 height=16 align="absmiddle" border=0> 
			  <%}else{%>
				  <img src="../images/myface/<%=myface%>" width=16 height=16 align="absmiddle" border="0">
			  <%}%>  
			  <%=user.getNick()%></a>&nbsp; 
    <% 		}
			else { %>
			 <img src="images/guest.gif" align="absmiddle">&nbsp;<%=SkinUtil.LoadString(request, "res.label.forum.index", "login_hide")%>
	<%		}	
		}
		else {
	%>
        <img src="images/guest.gif" align="absmiddle">&nbsp;<%=SkinUtil.LoadString(request, "res.label.forum.index", "guest")%> 
        <%}
		out.print("</td>");
		n ++;
		if (n>=rowCount) {
			n = 0;
			out.print("</tr>");
		}
	}
if (n<rowCount) {
	out.print("</tr>");
}
%>
</td></tr></table>
</div>
</body>
<SCRIPT language=javascript>
<!--
function trim(str){
    	var i = 0;
        while ((i < str.length)&&((str.charAt(i) == " ")||(str.charAt(i) == "　"))){i++;}
    	var j = str.length-1;
    	while ((j >= 0)&&((str.charAt(j) == " ")||(str.charAt(j) == "　"))){j--;}
    	if( i > j ) 
    		return "";
    	else
    		return str.substring(i,j+1);
}
var str = trim(newdiv.innerHTML);
if (str!="")
{
	window.parent.followDIV000.innerHTML = str;
}
window.parent.followImg000.loaded = "yes";
//-->
</script>
</html>
