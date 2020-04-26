<%@ page contentType="text/html; charset=utf-8"
import = "java.io.*"
import = "cn.js.fan.util.*"
import = "com.redmoon.chat.*"
%>
<%
String mode = ParamUtil.get( request, "mode" );
String param = ParamUtil.get( request, "param" );

ChatClient cc = new ChatClient();
String room = ParamUtil.get( request, "room" );
String user = ParamUtil.get( request, "user" );
String ret = "";
if ( mode.equals("poll") ) {
	ret = cc.poll( user, room );
	//System.out.println( ret );
	out.println( ret );
}
if ( mode.equals("list") ) {
	ret = cc.pollList(user, room);
	out.println( ret );
}
if ( mode.equals("roomlist") ) {
	ret = "parseRooms('" + cc.roomlist(user, room) + "')";
	out.println( ret );
}
if ( mode.equals("Logout") ) {
	ret = cc.logout(user, room);
	out.println( ret );
}
%>
