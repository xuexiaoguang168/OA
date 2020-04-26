<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.oa.person.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

UserSetupDb usd = new UserSetupDb();
usd = usd.getUserSetupDb(privilege.getUser(request));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>聊天显示</title>
<SCRIPT LANGUAGE=javascript>
<!--
// 播放声音
function MM_controlSound(sndAction,_sndObj) { //v2.0
	try {
		var sndObj = eval( _sndObj );
		if (sndObj != null) {
			if (sndAction=='stop') {
				sndObj.stop();
			} else {
				if (navigator.appName == 'Netscape' ) {
						sndObj.play();
				} else {
					if (document.MM_WMP_DETECTED == null) {
						document.MM_WMP_DETECTED = false;
						var i;
						for( i in sndObj )
							if ( i == "ActiveMovie" ) {
								document.MM_WMP_DETECTED = true;
								break; 
							}
					}
					if (document.MM_WMP_DETECTED)
						sndObj.play();
					else if ( sndObj.FileName )
						sndObj.run();
				}
			}
		}
	}
	catch (e) {}
}

function notify() {
	<%if (usd.isChatSoundPlay()) {%>
		MM_controlSound('play','document.player','../sounds/msg.wav')
	<%}%>
	<%if (usd.isChatIconShow()) {%>
		notify_flash_lb();
	<%}%>
}

var notifyTimeOutId = 0;
var notifyCount = 0;
function notify_flash_lb()
{
	if (notifyCount==1) {
		notifyCount = 0;
		try {
			window.top.bottomFrame.layer_lb.style.display = "none";	
		}
		catch (e) {
		}
		return;
	}
	try {
		window.top.bottomFrame.layer_lb.style.display = "";
	}
	catch (e) {
	}
	notifyCount = 1;
	notifyTimeOutId = window.setTimeout("notify_flash_lb()", 5000); // 每隔5000毫秒钟刷新一次
}

// cookie操作
function getCookieVal(offset)
{
	var endstr=document.cookie.indexOf(";",offset);
	if(endstr==-1)
		endstr=document.cookie.length;
	return unescape(document.cookie.substring(offset,endstr));
}

function GetCookie(name)
{
	var arg=name+"=";
	var alen=arg.length;
	var clen=document.cookie.length;
	var i=0;
	while(i<clen)
	{
		var j=i+alen;
		if(document.cookie.substring(i,j)==arg)
			return getCookieVal(j);
		i=document.cookie.indexOf(" ",i)+1;
		if(i==0) 
			break;
	}
	return null;
}

//盯人
function lookat(sb)
{
	var checkObj = eval("document.body");
	//判断对象是否为空
	if (checkObj == null)
		return;	

	if(sb!="")
	{
		var rng = document.body.createTextRange();
		if (rng.findText(sb,-1,6)==true)//向前搜索大小写敏感，匹配整字
		{
		    var left,top;
		    left = rng.offsetLeft;
		    top = rng.offsetTop;
		    indicator.style.left = left+15;
		    indicator.style.top = top+document.body.scrollTop;
		    indicator.style.display = "";
		    //rng.select();
			//rng.scrollIntoView();
		}
		else
		{
			indicator.style.display = "none";
		}
	}
}

var infg = "#$#"
function parsemyshow(myshow)
{
	var aryword,tk
	tk = ""
	var nick,saytoname,talktime,color,say
	var talknum = 0
	var ismine=0
	if (myshow=="")
		return
	
	var mynick;
	if (typeof(window.parent.chatappletarea.getUser)=="function") {
		mynick = window.parent.chatappletarea.getUser();
	}
	
	aryword = myshow.split(infg)
	nick = aryword[0]
		if (nick!="yxbulletin")
		{
			talktime = aryword[1]
			if (aryword[2]=="y")
				srt = "[秘]"
			else
				srt = ""
			saytoname = aryword[3]
			expression = aryword[4]
			addimg = aryword[5]
			if (addimg!="")
				addimg="<IMG src=images/addimgs/" + addimg+".gif>"
			
			color = aryword[6]
			say = aryword[7]
			if (!isnickshield(nick))//nick被屏蔽
			{
				if (aryword[2]=="y")
				{
					if (saytoname==mynick)
						ismine = 2//别人对自己说的话
					else if (nick==mynick)
						ismine = 1//自己对别人
					else
						tk="";//别人秘谈的话则紧接着读下一条
				}
				else
				{
					if (saytoname==mynick) {
						ismine = 2 // 别人对自己说的话
						notify();
					}
					else if (nick==mynick)
						ismine = 1 // 自己所说的话
					else
						ismine = 3 // 不是属于自己的话即公共的话，不是秘谈
				}
				if (ismine) {
					tk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>"+srt+
						"</font><font color='#0000FF'><a href=javascript:window.parent.talkarea.getname('"+ nick +
						 "')>" +nick+"</a>" +expression+"对<a href=javascript:window.parent.talkarea.getname('"+
						 saytoname+"') style='COLOR: salmon'>"+saytoname+"</a>"+addimg+"说：</font><font color=#"+
						 color+">"+say+"</font><font size=2 style='COLOR: mediumslateblue'>["+talktime+"]</font></td></tr></table>"
				}
			}
			else
				tk = ""//被屏蔽
		}
		else
		{
			action = aryword[1]
			user = aryword[2]
			switch (action)
			{
				case "login":tk = user+"进入聊天室！"+"<br>";break
				case "logout":tk = user+"退出聊天室！"+"<br>";break
				case "Dropping":tk = user+"悄悄地退出了聊天室！"+"<br>";break;
				case "rename":tk = user+"已更名为"+aryword[3]+"<br>";break;
				case "info":tk=user+"<br>";break;
				case "kicksb":
					if (user == mynick)
					{
						tk = "对不起，您已经被踢出聊天室！"+"<br>";
						tk = "<table><tr><td>" + tk + "</td></tr></table>"
						showchat(tk,1);
						//用新页面的URL替换当前的历史纪录，这样浏览历史记录中就只有一个页面，后退按钮永远不会变为可用
						window.top.location.replace("../exit_oa.jsp?iskicked=yes");
					}
					else
						tk = user+"被踢出聊天室！<br>";
					break;
				
				default:return
			}
			tk = "<table><tr><td>" + tk + "</td></tr></table>"
			ismine = 3//公共消息

		}
		
		showchat(tk,ismine)
		
		//使跟踪lookat
		lookat(GetCookie("lookat"));

}

var issplit = false;
function getissplit()
{
	return window.parent.getissplit()
}

function showchat(tk,ismine)
{
	if (tk=="")
		return;
	if (ismine==2 && typeof(top.chatappletarea.msgbtn)=="object")
		top.chatappletarea.msgbtn.click();//当有别人对自己说的话时，向foashell传递消息
	if (typeof(document.all.talkspan)!="object")
		return;
	if (ismine>=2 && typeof(window.parent.chatappletarea.playMsgAudio)=="function") {
			window.parent.chatappletarea.playMsgAudio();
	}

	if (getissplit() && ismine>=1 && ismine!=3)
		window.parent.secretarea.inserttk(tk)//在scretarea插入对自己的话
	else//在showchatarea正文部分插入茶室内新说的话
	{
		if (tk!="")
			talkspan.insertAdjacentHTML("BeforeEnd" ,tk)
	}
}

var autoScrollOn = 1;
var scrollOnFunction;
var scrollOffFunction; 
function scrollit()
{
	autoScrollOn=1;StartUp();return true;
}
function scrollWindow( )
{
	if ( autoScrollOn == 1 )
	{
		self.scroll(0, 65000);
		this.scroll(0, 65000);
		setTimeout("scrollWindow()",300);
	}
}
 
function scrollOn( )
{
autoScrollOn = 1;scrollWindow( );
}
  
function scrollOff( )
{autoScrollOn = 0;}
  
function StartUp( )
{
	this.onblur  = scrollOnFunction; 
	this.onfocus = scrollOffFunction;
    scrollWindow( );
}
scrollOnFunction = new Function("scrollOn( )")
scrollOffFunction = new Function("scrollOff( )")
StartUp();

var shieldnicks=""
function doshieldsb(nick)
{
	
	var d,t
	t=""
	var c = ":";
	d = new Date();
	t += d.getHours() + c;
	t += d.getMinutes() + c;
	t += d.getSeconds() 
	var	dotk
	if (isnickshield(nick))
		dotk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>[秘]</font><font color='#0000FF'>聊天室答复：</font><font color=#000000>呢称"+nick+"已被屏蔽！</font><font size=2 style='COLOR: mediumslateblue'>[" + t + "]</font></td></tr></table>"
	else
	{
		shieldnicks += "#"+nick
  		dotk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>[秘]</font><font color='#0000FF'>聊天室答复：</font><font color=#000000>屏蔽了呢称"+nick+"！</font><font size=2 style='COLOR: mediumslateblue'>[" + t + "]</font></td></tr></table>"
  	}
	talkspan.insertAdjacentHTML("BeforeEnd" ,dotk)
}

function doacceptsb(nick)
{
	var d,t
	t=""
	var c = ":";
	d = new Date();
	t += d.getHours() + c;
	t += d.getMinutes() + c;
	t += d.getSeconds()
	var temp = shieldnicks+"#"
	var dotk = ""
	var which = "#"+nick+"#"
	if (temp.search(which,"i")==-1)
  	{
  		//没有找到解禁的呢称
  		dotk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>[秘]</font><font color='#0000FF'>聊天室答复：</font><font color=#000000>呢称"+nick+"未曾被屏蔽！</font><font size=2 style='COLOR: mediumslateblue'>[" + t + "]</font></td></tr></table>"
		talkspan.insertAdjacentHTML("BeforeEnd" ,dotk)
		return
	}
	var regwhich = new RegExp(which,"i")
	shieldnicks = temp.replace(regwhich,"#")
	if (shieldnicks.length==1)
		shieldnicks = ""//如果是仅剩一个字符#则直接清空以免被else后的语句置为带有一个空格的字符串
	if (shieldnicks.charAt(shieldnicks.length-1)=="#")
	{
		shieldnicks.substr(0,shieldnicks.length-1)
	}
  	dotk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>[秘]</font><font color='#0000FF'>聊天室答复：</font><font color=#000000>解禁了呢称"+nick+"！</font><font size=2 style='COLOR: mediumslateblue'>[" + t + "]</font></td></tr></table>"
	talkspan.insertAdjacentHTML("BeforeEnd" ,dotk)
}

function doshieldlist()
{
	var dotk=""
	var d,t
	t=""
	var c = ":";
	d = new Date();
	t += d.getHours() + c;
	t += d.getMinutes() + c;
	t += d.getSeconds()
  	if (shieldnicks=="")
  	{
  		dotk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>[秘]</font><font color='#0000FF'>聊天室答复：</font><font color=#000000>没有被屏蔽的呢称！</font><font size=2 style='COLOR: mediumslateblue'>[" + t + "]</font></td></tr></table>"
		talkspan.insertAdjacentHTML("BeforeEnd" ,dotk)
		return
	}
	var aryNick,tempnicks
	tempnicks = shieldnicks
	tempnicks = tempnicks.substr(1,tempnicks.length-1)//去掉第一个#
	aryNick = tempnicks.split("#")
  		dotk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>[秘]</font><font color='#0000FF'>聊天室答复：</font><font color=#000000>被屏蔽的呢称有--"
	for (i=0; i<aryNick.length; i++)
	{
		dotk += aryNick[i]+"  "
	}
	dotk +="！</font><font size=2 style='COLOR: mediumslateblue'>[" + t + "]</font></td></tr></table>"
	talkspan.insertAdjacentHTML("BeforeEnd" ,dotk)
}
function doclearlist()
{
	shieldnicks = ""
  	var dotk = ""
	var d,t
	t=""
	var c = ":";
	d = new Date();
	t += d.getHours() + c;
	t += d.getMinutes() + c;
	t += d.getSeconds()
  	dotk = "<table class='p10'><tr><td width='100%'><font color='ff00ff'>[秘]</font><font color='#0000FF'>聊天室答复：</font><font color=#000000>已清除所有被屏蔽的呢称！</font><font size=2 style='COLOR: mediumslateblue'>[" + t + "]</font></td></tr></table>"
	talkspan.insertAdjacentHTML("BeforeEnd" ,dotk)
}
function isnickshield(nick)
{
	if (shieldnicks=="")
		return false
	var temp = shieldnicks+"#"
	var dotk = ""
	var which = "#"+nick+"#"
	if (temp.search(which,"i")==-1)
  		//没有找到解禁的呢称
		return false
	return true
}
//-->
</SCRIPT>
<STYLE type=text/css><!--
body {  font-family: "宋体";font-size : 10pt;}
.p11 {  font-family: "宋体"; font-size: 11pt}
.p10 {  font-family: "宋体"; font-size: 11pt}
a{text-transform: none; text-decoration: none;color:#228b22}
a:hover {text-decoration: none; color: #ff00ff;}
--></STYLE>

<link href="common.css" rel="stylesheet" type="text/css">
</head>
<body>
<EMBED NAME='player' SRC='../sounds/msg.wav' LOOP=false AUTOSTART=false MASTERSOUND HIDDEN=true WIDTH=100 HEIGHT=50></EMBED> 
<IMG alt=锁定 id=indicator src="images/DOGGIE.GIF" style="DISPLAY: none; LEFT: 51px; POSITION: absolute; TOP: 616px"> 
<span id=talkspan name=talkspan></span>

</body>
</html>
