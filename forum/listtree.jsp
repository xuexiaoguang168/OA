<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../common.css" type=text/css rel=stylesheet>
<title>listtree</title>
</head>
<body>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<div id="newdiv" name="newdiv">
<%	
long rootid = ParamUtil.getLong(request, "id");
String boardcode = ParamUtil.get(request, "boardcode");
String sql = "select id from sq_message where rootid=" + rootid + " and check_status=" + MsgDb.CHECK_STATUS_PASS + " ORDER BY orders";
String id="",name="",lydate="",content="",topic="";
int layer = 1;
int i = 1;

UserMgr um = new UserMgr();
UserDb ud = null;
MsgDb md = new MsgDb();
long totalMsg = md.getMsgCount(sql, boardcode, rootid);
MsgBlockIterator irmsg = md.getMsgs(sql, boardcode, rootid, 0, totalMsg);
if (irmsg.hasNext()) {
	// 跳过根贴
	irmsg.next();
}
// 写跟贴
while (irmsg.hasNext()) {
	  i++;
	  md = (MsgDb)irmsg.next();
	  id = "" + md.getId();
	  name = md.getName();
	  layer = md.getLayer();
	  topic = md.getTitle();
	  ud = um.getUser(name);
 %>
<table cellspacing=0 cellpadding=0 width="100%" align=center border=0>
  <tbody>
  <tr> 
    <td noWrap align=left height="13"> 
      <%
		int pagesize = 10;
		int CPages = (int)Math.ceil((double)i/pagesize);
		layer = layer-1;
		for (int k=1; k<=layer-1; k++)
		{%>
		<img src="" width=18 height=1>
		<%}%>
      <img src="images/join.gif" width="18" height="16">
	  <a href="<%=ForumPage.getShowTopicPage(request, rootid, CPages, id)%>"><%=topic%></a> 
 <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=ud.getNick()%></a>&nbsp;&nbsp;[<%=com.redmoon.forum.ForumSkin.formatDateTime(request, md.getAddDate())%>]	  </td>
  </tr>
  </tbody> 
</table>
<%
}
%>
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
if (trim(newdiv.innerHTML)!="")
{
	window.parent.followDIV<%=rootid%>.innerHTML = newdiv.innerHTML;
}
window.parent.followImg<%=rootid%>.loaded = "yes";
//-->
</script>
</html>
