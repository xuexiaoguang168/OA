<%@ page contentType="text/html; charset=utf-8"
import = "java.io.*"
import = "cn.js.fan.util.*"
import = "com.redmoon.chat.*"
%>
<%
String mode = ParamUtil.get( request, "mode" );
ChatClient cc = new ChatClient();
String room = ParamUtil.get( request, "room" );
String user = ParamUtil.get( request, "user" );
%>
<script>
function showmsg(msg) {
    if (typeof(window.parent.chatappletarea.showmsg)=="function")
		window.parent.chatappletarea.showmsg(msg);
}
</script>
<%
if ( mode.equals("send") ) {
	String message = ParamUtil.get( request, "message" );
	out.print(message);
	String ret = cc.send(user, room, message);
%>
<script>
<%=ret%>
</script>	
<%}%>

<%
if ( mode.equals("jumptoroom") ) {
	String newroom = ParamUtil.get( request, "newroom" );
	String ret = cc.jumptoroom(user, room, newroom);
%>
<script>
<%=ret%>
window.parent.chatappletarea.location.href = "chatapplet.jsp?nick=<%=StrUtil.UrlEncode(user)%>&room=<%=StrUtil.UrlEncode(newroom)%>&reloadreason=jumptoroom";
</script>	
<%}%>

<%
if ( mode.equals("rename") ) {
	String newuser = ParamUtil.get( request, "newuser" );
	String ret = cc.ReName(user, room, newuser);
	if ( ret==newuser ) {
%>
	<script>
	window.parent.chatappletarea.location.href = "chatapplet.jsp?nick=<%=StrUtil.UrlEncode(newuser)%>&room=<%=StrUtil.UrlEncode(room)%>";
	</script>
<%	
	}
	else {
%>
	<script>
	<%=ret%>
	</script>
<%
	}
}%>

<%
if ( mode.equals("roominfo") ) {
	String ret = cc.getRoomInfo(user, room);
%>
	<script>
	<%=ret%>
	</script>
<%}%>

<%
if ( mode.equals("getuserinfo") ) {
	String whichuser = ParamUtil.get(request, "nick");
	String ret = cc.getUserInfo(user, room, whichuser);
%>
	<script>
	<%=ret%>
	</script>
<%}%>

<%
if ( mode.equals("sendAnnounce") ) {
	String announce = ParamUtil.get(request, "announce");
	String ret = cc.sendAnnounce(user, room, announce);
%>
	<script>
	<%=ret%>
	</script>
<%}%>

<%
if ( mode.equals("kicksb") ) {
	String sb = ParamUtil.get(request, "sb");
	String ret = cc.kicksb(user, room, sb);
%>
	<script>
	<%=ret%>
	</script>
<%}%>


