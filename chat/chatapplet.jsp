<%@ page contentType="text/html; charset=utf-8"
import = "java.io.*"
import = "cn.js.fan.util.*"
import = "com.redmoon.oa.person.*"
import = "com.redmoon.oa.*"
import = "com.redmoon.oa.pvg.Privilege"
%>
<%@ page import="com.redmoon.chat.ChatClient"%>
<%@ page import="java.util.Properties" %>
<%
Privilege privilege = new Privilege();

UserSetupDb usd = new UserSetupDb();
usd = usd.getUserSetupDb(privilege.getUser(request));

// 本页用于刷新各种数据
// request.setCharacterEncoding("utf-8");
String nick,room;
nick = ParamUtil.get( request, "nick" );
room = request.getParameter("room");
// System.out.println("chatapplet.jsp1 nick=" + nick + " room=" + room);
room = ParamUtil.get( request, "room" );
// System.out.println("chatapplet.jsp2 nick=" + nick + " room=" + room);
%>
<html>
<head>
<title>refresher</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src='../dwr/interface/MessageDb.js'></script>
<script src='../dwr/engine.js'></script>
<script src='../dwr/util.js'></script>
<script>
var userName = "<%=privilege.getUser(request)%>";

function getNewMsg(userName) {
  try {
  	divMsg.innerHTML = "";
  	MessageDb.getNewMsgsOfUser(showMsgWin, userName);
  }
  catch (e) {
  	// alert(e);
  }
}
  
var msgWin;
var width = 320;
var height = 183;
function showMsgWin(msg) {
  if (msg.length>0) {
	  for (var data in msg) {
		// alert("data=" + data);
		// alert(msg[data].title);
		var id = msg[data].id
		var title = msg[data].title;
		var sender = msg[data].sender;
		divMsg.innerHTML += "<input name='ids' value='" + msg[data].id + "' type=hidden><a href='javascript:showmsg(" + msg[data].id + ")'>" + msg[data].title + "</a>&nbsp;&nbsp;" + msg[data].senderRealName + "&nbsp;[" + msg[data].rq + "]<BR>";
	  }
  	  if (msgWin!=null) {
	  	// msgWin.close()
		// msgWin = null;
		try {
			msgWin.focus();
			msgWin.getMsg();
		}
		catch (e) {
		  msgWin = null;
		  msgWin = window.open("../message_oa/newmsg.jsp","_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=" + window.screen.availHeight + ",left=" + window.dialogLeft + ",width="+width+",height="+height);
		}
	  }
	  else
		  // 打开窗口，传递消息
		  msgWin = window.open("../message_oa/newmsg.jsp","_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=" + window.screen.availHeight + ",left=" + window.dialogLeft + ",width="+width+",height="+height);
  }
}

function getDivMsg() {
	return divMsg.innerHTML;
}

function refreshMsg() {
	getNewMsg(userName);
}
</script>
<script language="JavaScript" type="text/javascript">
var nick,room;
nick = "<%=nick%>"
room = "<%=room%>"

function GetData(url) {
	try {
    	DataLoader.src = url;
    } catch(e) {
        return false;
    }
}

function GetMsg(url) {
	try {
    	MsgLoader.src = url;
    } catch(e) {
        return false;
    }
}

function GetUserList() {
	try {
    	UserListLoader.src = "chatclient.jsp?mode=list&user=" + getUserUTF8() + "&room=" + getRoomUTF8();
    } catch(e) {
        return false;
    }
}

var timeoutid
var count = 0;

function getUser() {
	return nick;
}

function getRoom() {
	return room;
}

var timeoutid;
var userlisttimespace;
var olduserlisttime = 0

var oldmsgtime = 0;
var msgtimespace;

<%
// 取刷新时间
com.redmoon.oa.Config cfg = new com.redmoon.oa.Config();
String refresh_talk = cfg.get("refresh_talk");
String refresh_userlist = cfg.get("refresh_userlist");
String refresh_message = cfg.get("refresh_message");
%>

var refresh_talk = <%=refresh_talk%>;
var refresh_userlist = <%=refresh_userlist%>;
var refresh_message = <%=refresh_message%>;

function refresh()
{
	var d = new Date();
	sec = d.getSeconds()
	userlisttimespace = sec-olduserlisttime
	if(userlisttimespace<0)
		userlisttimespace += 60
	if (userlisttimespace>=refresh_userlist) {
		olduserlisttime = sec;
		GetUserList();
	}
	
	<%if (usd.isMsgWinPopup()) {%>
	msgtimespace = sec - oldmsgtime;
	if (msgtimespace<0)
		msgtimespace += 60;
	if (msgtimespace>=refresh_message) {
		// 刷新消息
		oldmsgtime = sec;
		refreshMsg();
	}
	<%}%>

	var url = "chatclient.jsp?mode=poll&room=" + getRoomUTF8() + "&user=" + getUserUTF8();
	GetData( url );
	timeoutid = window.setTimeout("refresh()", refresh_talk); // 每隔3秒钟刷新一次
}

function getRoomUTF8()
{
  return myroom.innerHTML;
}

function getUserUTF8()
{
	return mynick.innerHTML;
}

function showStatus(msg) {
	window.status = msg;
}

function addnicks(users)
{
  var ary = users.split(",");
  var len = ary.length;
  var str = "", user="";
  for (i=0; i<len; i++)
  {
  	user = ary[i];	
	str += "<a href=javascript:window.parent.talkarea.getname('" +user+ "')>[" +user+ "]</a><br>"
  }
  if (typeof(window.parent.nickarea)=="object")
	  if (typeof(window.parent.nickarea.s_nicknamelist)=="object")
		window.parent.nickarea.s_nicknamelist.innerHTML = str;
}

function rename(newuser)
{
    if (typeof(window.parent.senderFrame.rename)=="function")
		window.parent.senderFrame.rename(getUser(), getRoom(), newuser);
}

function jumptoroom(room)
{
    if (typeof(window.parent.senderFrame.JumpToRoom)=="function")
		window.parent.senderFrame.JumpToRoom(getUser(), getRoom(), room);
}

function sendAnnounce(str)
{
    if (typeof(window.parent.senderFrame.sendAnnounce)=="function")
		window.parent.senderFrame.sendAnnounce(getUser(), getRoom(), str);
}

function kicksb(sb)
{
    if (typeof(window.parent.senderFrame.KickSb)=="function")
		window.parent.senderFrame.KickSb(getUser(), getRoom(), sb);
}

function getRoomInfo() {
    if (typeof(window.parent.senderFrame.getRoomInfo)=="function")
		window.parent.senderFrame.getRoomInfo(getUser(), getRoom());
}

function getUserInfo(user) {
    if (typeof(window.parent.senderFrame.getUserInfo)=="function")
		window.parent.senderFrame.getUserInfo(getUser(), getRoom(), user);
}

function showtalk(msg)
{
	if (typeof(window.parent.showchatarea)=="object")
		if (typeof(window.parent.showchatarea.parsemyshow)=="function")
			window.parent.showchatarea.parsemyshow(msg);
}

function roomlist() {
	window.parent.nickarea.location.href = "roomlist.jsp?user=" + getUserUTF8() + "&room=" + getRoomUTF8();
}

function showmsg(msg)
{
  msg = "<table><tr><td>"+msg+"</td></tr></table>"
  if (typeof(window.parent.showchatarea.showchat)=="function")
    window.parent.showchatarea.showchat(msg,1);
}

function send(msg)
{
  if (typeof(window.parent.senderFrame.SendMsg)=="function")
    window.parent.senderFrame.SendMsg(getUser(), getRoom(), msg);
}

function window_onload()
{
  refresh();

  if (typeof(window.parent.nickarea)=="object")
  	if (typeof(window.parent.nickarea.room)=="object")
	  window.parent.nickarea.room.innerText = getRoom();

  if (typeof(window.parent.talkarea)=="object")  
	  if (typeof(window.parent.talkarea.setmynick)=="function") {
		window.parent.talkarea.setmynick(getUser())
	  }
  if (typeof(window.parent.talkarea)=="object")  
	  if (typeof(window.parent.nickarea.setroom)=="function")
		window.parent.nickarea.setroom(getRoom());
}

function window_onunload() {
<%
	String reloadreason = ParamUtil.get( request, "reloadreason" );
	//当jumptoroom reload时并不logout
	if (!reloadreason.equals("jumptoroom")) {
%>	
	LogoutScript.src = "chatclient.jsp?mode=Logout&user=" + getUserUTF8() + "&room=" + getRoomUTF8();
<%}%>	
	clearTimeout(timeoutid);
}
//-->
</SCRIPT>
<script id="DataLoader" language="JavaScript" type="text/javascript" defer></script>
<script id="MsgLoader" language="JavaScript" type="text/javascript" defer></script>
<script id="UserListLoader" language="JavaScript" type="text/javascript" defer></script>
<script id="LogoutScript" language="JavaScript" type="text/javascript" defer></script>
</head>
<body onLoad="return window_onload()" onUnload="return window_onunload()">
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
用户: <span id="mynick" name="mynick"><%=StrUtil.UrlEncode(nick)%></span>
房间: <span id="myroom" name="myroom"><%=StrUtil.UrlEncode(room)%></span>
<%
if (!privilege.isUserLogin( request )) {
	out.print( StrUtil.Alert_Back( "您尚未登录OA，请从正确的入口进入!" ) );
    return;
}
//登录聊天室
ChatClient cc = new ChatClient();
try {
	// cfgparser.parse("config_oa.xml");
	// Properties props = cfgparser.getProps();
	// 当jumtptoroom时，因为室中已有nick，所以不需要再login
	System.out.println("chatapplet.jsp nick=" + nick + " room=" + room);
	if ( !reloadreason.equals("jumptoroom") && cc.login( request, nick, room ) ) {
		out.print( StrUtil.ShowStatus( cc.getReturnMsg() ) );
	}
}
catch ( ErrMsgException e ) {
	out.println( StrUtil.ShowStatus(e.getMessage()) );
	return;
}
%>
<div id="divMsg" name="divMsg"></div>
</body>
</html>
