<%@ page contentType="text/html; charset=utf-8"
import = "java.io.*"
import = "cn.js.fan.util.*"
import = "java.net.URLEncoder"
%>
<%
String nick,room;
nick = ParamUtil.get( request, "nick" );
room = ParamUtil.get( request, "room" );
%>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>聊天室</title>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
//分屏
var issplit = false
function split()
{
        issplit = !issplit
        if (issplit)
                splitframe.rows = "*,50%"
        else
                splitframe.rows = "*,0%"
}

function getissplit()
{
        return issplit
}

//-->
</SCRIPT>
</head>

<frameset rows="83%,*" framespacing="0" border="0" frameborder="0">
  <frameset cols="*,19%">
    <frameset rows="*,40">
      <frameset id="splitframe" rows="*,0" framespacing=1>
      <frame name="showchatarea" src="showchat.htm" scrolling="auto">
      <frame name="secretarea" scrolling="auto" src="secret.htm" marginwidth="0" marginheight="0">
      </frameset>
      <frame name="chatappletarea" src="chatapplet.jsp?nick=<%=StrUtil.UrlEncode(nick)%>&room=<%=StrUtil.UrlEncode(room)%>" scrolling="auto">
    </frameset>
    <frame name="nickarea" src="nicklist.htm" scrolling="auto">
  </frameset>
  <frame name="talkarea" src="talk.jsp" scrolling="no">
  <noframes>
  <body>

  <p>此网页使用了框架，但您的浏览器不支持框架。</p>

  </body>
  </noframes>
</frameset>

</html>
