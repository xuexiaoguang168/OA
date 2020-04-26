<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发送</title>
</head>
<script>
function SendMsg(user, room, message) {
	form1.user.value = user;
	form1.room.value = room;
	form1.message.value = message;
	form1.mode.value = "send";
	form1.submit();
}
function JumpToRoom(user, room, newroom) {
	form1.user.value = user;
	form1.room.value = room;
	form1.newroom.value = newroom;
	form1.mode.value = "jumptoroom";
	form1.submit();
}

function rename(user, room, newuser) {
	form1.user.value = user;
	form1.room.value = room;
	form1.newuser.value = newuser;
	form1.mode.value = "rename";
	form1.submit();
}

function getRoomInfo(user, room) {
	form1.user.value = user;
	form1.room.value = room;
	form1.mode.value = "roominfo";
	form1.submit();
}

function getUserInfo(user, room, nick) {
	form1.user.value = user;
	form1.room.value = room;
	form1.nick.value = nick;
	form1.mode.value = "getuserinfo";
	form1.submit();
}

function sendAnnounce(user, room, str) {
	form1.user.value = user;
	form1.room.value = room;
	form1.announce.value = str;
	form1.mode.value = "sendAnnounce";
	form1.submit();
}

function KickSb(user, room, sb) {
	form1.user.value = user;
	form1.room.value = room;
	form1.sb.value = sb;
	form1.mode.value = "kicksb";
	form1.submit();
}
</script>
<body>
<form action="sender_do.jsp?" id="form1" name="form1" target="senderdoFrame">
   用户名
   <input name="user">
   <br>
  房间
   <input name="room">
   <br>
  消息
<input name="message">
<br>
  新用户名
<input name="newuser">
<br>
  取用户信息
<input name="nick">
<br>
  踢除
<input name="sb">
<br>
  茶室公告
<input name="announce">
<br>
模式
<input name="mode"><br>
新房间
<input name="newroom">
</form>
</body>
</html>
