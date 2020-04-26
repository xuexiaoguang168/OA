<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Properties" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserLogin(request))
{
	out.println(fchar.Alert_Redirect("您未登录或您的登录已过期，请重新登录！", "index.jsp"));
	return;
}

String nick,room;
nick = privilege.getUser(request);
cfgparser.parse("config_oa.xml");
Properties props = cfgparser.getProps();
room = props.getProperty("defaultroom");
// System.out.println("oa.jsp room=" + room);
if (nick==null || room==null) {
	out.print(fchar.makeErrMsg("名称和房间不能为空！"));
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=props.getProperty("enterprise")%></title>
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

var UI_status  = "office"
var showtreemenu = true;
var showonline = false;

function setUI(status)
{
	UI_status = status;
	if (status=="office")
	{
	    if (showtreemenu)
		{
			if (showonline)
				middleFrame.cols = "190,*,0,0"
			else
				middleFrame.cols = "190,*,0,0"
		}
		else
		{
			if (showonline)
				middleFrame.cols = "0,*,0,128"
			else
				middleFrame.cols = "0,*,0,0"
		}
		allFrame.rows = "83,*,0,0,26,0,0"
	}
	if (status=="chat")
	{
		if (showtreemenu)
		{
			if (showonline)
				middleFrame.cols = "190,0,*,128"
			else
				middleFrame.cols = "190,0,*,0"
		}
		else
		{
			if (showonline)
				middleFrame.cols = "0,0,*,128"
			else
				middleFrame.cols = "0,0,*,0"
		}
		allFrame.rows = "83,*,0,80,26,0,0"
	}
}

function setTreeMenu()
{
	showtreemenu = !showtreemenu 
	if (showtreemenu)
	{
		if (showonline)
		{
			if (UI_status=="chat")
				middleFrame.cols = "190,0,*,128"
			else
				middleFrame.cols = "190,*,0,128"
		}
		else
		{
			if (UI_status=="chat")
				middleFrame.cols = "190,0,*,0"
			else
				middleFrame.cols = "190,*,0,0"
		}
	}
	else
	{
		if (showonline)
		{
			if (UI_status=="chat")
				middleFrame.cols = "0,0,*,128"			
			else
				middleFrame.cols = "0,*,0,128"
		}
		else
		{
			if (UI_status=="chat")
				middleFrame.cols = "0,0,*,0"
			else
				middleFrame.cols = "0,*,0,0"
		}
	}
}

function hideOnline()
{
		//showonline = false;
		if (showtreemenu)
		{
			if (UI_status=="chat")
				middleFrame.cols = "190,0,*,0"
			else
				middleFrame.cols = "190,*,0,0"
		}
		else
		{
			if (UI_status=="chat")
				middleFrame.cols = "0,0,*,0"
			else
				middleFrame.cols = "0,*,0,0"
		}
}

function setOnline()
{
	showonline = !showonline
	if (showonline)
	{
		if (showtreemenu)
		{
			if (UI_status=="chat")
				middleFrame.cols = "190,0,*,128"			
			else
				middleFrame.cols = "190,*,0,128"
		}
		else
		{
			if (UI_status=="chat")
				middleFrame.cols = "0,0,*,128"
			else
				middleFrame.cols = "0,*,0,128"
		}
	}
	else
	{
		if (showtreemenu)
		{
			if (UI_status=="chat")
				middleFrame.cols = "190,0,*,0"
			else
				middleFrame.cols = "190,*,0,0"
		}
		else
		{
			if (UI_status=="chat")
				middleFrame.cols = "0,0,*,0"
			else
				middleFrame.cols = "0,*,0,0"
		}
	}
}
//屏蔽F5键
function document.onkeydown(){
if(event.keyCode==116){event.keyCode=0;event.returnValue=false;}
}
//-->
</SCRIPT>
</head>
<frameset id="allFrame" rows="83,*,0,0,26,0,0" frameborder="NO" border="0" framespacing="0">
  <frame src="top.jsp" name="topFrame" scrolling="NO" noresize >
  <frameset id="middleFrame" cols="190,*,0,0" frameborder="NO" border="0" framespacing="0">
	  <frame src="left.jsp" name="leftFrame" noresize scrolling="no">
	  <frame src="desktop.jsp" name="mainFrame">
      <frameset id="splitframe" rows="*,0" framespacing=1>
		  <frame name="showchatarea" src="chat/showchat.jsp" scrolling="auto">
		  <frame name="secretarea" scrolling="auto" src="chat/secret.htm" marginwidth="0" marginheight="0">
      </frameset>
	  <frame src="chat/nicklist.htm" name="nickarea">
  </frameset>
  <frame src="chat/chatapplet.jsp?nick=<%=StrUtil.UrlEncode(nick)%>&room=<%=StrUtil.UrlEncode(room)%>" name="chatappletarea" scrolling="no" noresize>
  <frame name="talkarea" src="chat/talk.jsp" scrolling="no">
  <frame src="bottom.htm" name="bottomFrame" scrolling="NO" noresize>
  <frame src="chat/sender.jsp" name="senderFrame" scrolling="NO" noresize>
  <frame src="chat/sender_do.jsp" name="senderdoFrame" scrolling="NO" noresize>
</frameset>
<noframes><body>

</body></noframes>
</html>
