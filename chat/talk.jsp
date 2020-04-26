<%@ page contentType="text/html; charset=utf-8" %>
<HTML><HEAD><TITLE>发言区</TITLE>
<LINK rel="stylesheet" type="text/css" href="common.css">
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
var nick
// 在chatapplet.jsp中被调用
function setmynick(user)
{
  	if (typeof(mynick)!="object")
		return;
	mynick.innerText = user
	nick = user
}

function getmynick()
{
	return nick;
}

function nickarealist(what)
{
	if(what=="users")
		window.parent.nickarea.location.href="nicklist.htm";
	if(what=="rooms")
	{
      //当用户的消息队列为空时会阻塞30秒,因为在chatapplet中poll在pollList之前会导致房间名单也得不到刷新
      //所以在点击talkarea中"名单"的时候,主动调用chatapplet中的pollList()
      //将调用函数放在roomlist.htm的window_onload()中
	  //window.parent.nickarea.location.href="roomlist.htm";
	  //或
	  //window.parent.nickarea.location.href="chatservice?mode=roomlist1";//出错
	   if (typeof(window.parent.chatappletarea.roomlist)=="function")
			window.parent.chatappletarea.roomlist()
	}
}

var oldtalk = ""
function formtalk_onsubmit()
{
	var talk = formtalk.talk.value
	if(talk =="")
	{
		alert("发言内容不能为空！")
		return false
	}
	var infg = "#$#"
	//*************var re = new RegExp("\$", "i")//因为$，*在正则表达式中有特殊意义，所以需采取不同的方法
	if ( talk.search(/[#][$][#]/i)!=-1 ||  talk.search("[*][$][*]","i")!=-1)// /*$*/会出错
	{
		alert("话中不能带有#$#或*$* ！")//前者为句中分隔符，后者为句间分隔符
		return false
	}
	//talk.replace(/\"/i,"}");
	if (oldtalk==talk)
	{
		alert("请不要说重复的话！")
		return false
	}
	else
		oldtalk = talk
	tmpDate = new Date();
	var h = ""+tmpDate.getHours();
	if (h.length==1)
		h = "0"+h;
	var m = ""+tmpDate.getMinutes();
	if (m.length==1)
		m = "0"+h;
	var s = ""+tmpDate.getSeconds();
	if (s.length==1)
		s = "0"+s;
	
	talktime = h+":"+m+":"+s;
	if (formtalk.chksecret.checked)
		isSecret = "y"
	else
		isSecret = "n"
	talkmsg = talktime + infg + isSecret + infg + formtalk.saytoname.value + infg +
		formtalk.Expression.value  + infg + formtalk.addimg.value + infg + formtalk.fontcolor.value + infg + talk
	if (typeof(window.parent.chatappletarea.send)=="function")
		window.parent.chatappletarea.send(talkmsg)

	// 往聊天显示区添加发话的内容
	var srt="",addimg="",tk="",nick="我",expression="";
	if (isSecret == "y")
		srt = "[秘]"
	else
		srt = ""
	if (formtalk.addimg.value!="")
		addimg="<IMG src=images/addimgs/" + formtalk.addimg.value+".gif>"
	tk = "<table class='p9'><tr><td width='100%'><font color='ff00ff'>"+srt+
		"</font><font color='#0000FF'><a href=javascript:window.parent.talkarea.getname('"+ nick + 
		 "')>" +nick+"</a>" +expression+"对<a href=javascript:window.parent.talkarea.getname('"+ 
		 formtalk.saytoname.value+"') style='COLOR: salmon'>"+formtalk.saytoname.value+"</a>"+addimg+"说：</font><font color=#"+
		 formtalk.fontcolor.value+">"+talk+"</font><font style='COLOR: mediumslateblue'>["+talktime+"]</font></td></tr></table>"
	if (typeof(window.parent.showchatarea.showchat)=="function")
		window.parent.showchatarea.showchat(tk,1);
		
	formtalk.talk.value=""
	formtalk.talk.focus()

	return false;
}

var freshnicklist = true


var isLoaded = false
function window_onload() {
	isLoaded = true
}

function GetLoadInfo()
{
	return isLoaded
}

function window_onunload() {

}

function changefreshnicklist(isfresh)//上句中在isfresh中加var错，使得找不到对象
{
	freshnicklist = isfresh
}

function getname(str){
formtalk.saytoname.value = str;
}

function chksecret_onclick()
{
	if(formtalk.saytoname.value == "大家" || formtalk.saytoname.value=="")
	{
		formtalk.chksecret.checked = false
		alert("不能对大家秘谈！")
	}
}

function freshnicklist_onsubmit() 
{
 location.reload(true)
 return true
}

function refreshself()
{
 location.reload(true)
}

function selaction_onchange()
{
	if(formtalk.selaction.value == "无")
		return;
	if (formtalk.selaction.value == "clearscreen")
	{
		//清屏
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.talkspan.outerHTML="<span id=talkspan name=talkspan></span>"
		formtalk.selaction.selectedIndex = 0
	}
	if(formtalk.selaction.value =="lookat")
	{
		r = window.prompt("请输入您想要锁定的人名","")
		formtalk.hiddenaction.value = r
		if( r==null)
		{
			formtalk.selaction.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("请输入要盯的人名！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		SetCookie("lookat",r);
		formtalk.selaction.selectedIndex = 0
	}
	
	if (formtalk.selaction.value == "roominfo")
	{
		if (typeof(window.parent.chatappletarea.getRoomInfo)=="function")
			window.parent.chatappletarea.getRoomInfo();
		formtalk.selaction .selectedIndex = 0
	}
	if(formtalk.selaction.value =="viewnickinfo")
	{
		r = window.prompt("请输入用户名称","")
		formtalk.hiddenaction.value = r
		if( r==null)
		{
			formtalk.selaction.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("您想看谁的信息？请在对话框中输入！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		if (typeof(window.parent.chatappletarea.getRoomInfo)=="function")
			window.parent.chatappletarea.getUserInfo(r);
		formtalk.selaction .selectedIndex = 0
	}
	if(formtalk.selaction.value =="sendannounce")
	{
		r = window.prompt("请输入本讨论室公告！","")
		formtalk.hiddenaction.value = r
		if( r==null)
		{
			formtalk.selaction.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("未输入公告信息！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		if (typeof(window.parent.chatappletarea.sendAnnounce)=="function")
			window.parent.chatappletarea.sendAnnounce(r);
		formtalk.selaction .selectedIndex = 0
	}
	if(formtalk.selaction.value =="kicksb")
	{
		r = window.prompt("请输入踢谁！（注意：踢人一次损失点数50）","")
		formtalk.hiddenaction.value = r
		if( r==null)
		{
			formtalk.selaction.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("请输入踢谁！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		if (typeof(window.parent.chatappletarea.kicksb)=="function")
			window.parent.chatappletarea.kicksb(r);
		formtalk.selaction .selectedIndex = 0
	}

}

function kicksb_onchange() 
{
	if( formtalk.kicksb.value == "admin")
	{
		alert("您无权踢出master！")
		formtalk.kicksb.selectedIndex = 0;
		return
	}
	if( formtalk.kicksb.value !="无" )
	{
		r = confirm("是否真的要踢出"+formtalk.kicksb .value +"？踢人一次，自己可是要消耗点数50的啊！")
		if(!r)
			return
		formtalk.hiddentalk.value = "毫不留情地踢出:"+formtalk.kicksb.value
		formtalk.submit()
		formtalk.kicksb.selectedIndex = 0
	}
}

function document_oncontextmenu() {
//event.returnValue = false
}

function fontcolor_onchange() {
formtalk.talk.style .color = formtalk.fontcolor.value ;
}

function lybt_onclick() {
 lywindow=window.open('../MsgBoard/lyframe.asp','lywindow','',true)
 lywindow.moveTo(0,0)
 lywindow.resizeTo(screen.availWidth,screen.availHeight)
 lywindow.outerWidth=screen.availWidth
 lywindow.outerHeight=screen.availHeight
}

function colorpat()
{
this.showchat=""
this.secret=""
this.talkline1=""
this.talkline2=""
this.nicklist=""
}

//cookie操作
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
function SetCookie(name,value)
{	
	var argv=SetCookie.arguments;
	var argc=SetCookie.arguments.length;
	var expires=(2<argc)?argv[2]:null;
	var path=(3<argc)?argv[3]:null;
	var domain=(4<argc)?argv[4]:null;
	var secure=(5<argc)?argv[5]:false;
	document.cookie=name+"="+escape(value)+((expires==null)?"":("; expires="+expires.toGMTString()))+((path==null)?"":("; path="+path))+((domain==null)?"":("; domain="+domain))+((secure==true)?"; secure":"");
}

function rename()
{
	var nick = window.prompt("请输入新的称呼！","")
	if( nick==null)
	{
		return 
	}
	if( nick=="" )
	{
		window.alert("未输入新的称呼！")
		return;
	}
	//检验换的呢称是否合法
	var errmsg=""
	if(nick.search(/#/i)!=-1)
		errmsg += "\n呢称中不能含有#!"
	if(nick.length>8)
		errmsg += "\n呢称不得超过8个字符!"
	if (errmsg!="")
	{
		window.alert(errmsg)
		return
	}

	if (typeof(window.parent.chatappletarea)=="object")
		window.parent.chatappletarea.rename(nick)
}

function changemynick(str)
{
	mynick.innerText = str
}
function selfilter_onchange() {
	if(formtalk.selfilter.value =="shieldsb")
	{
		r = window.prompt("想要屏蔽谁？请输入！","")
		if( r==null)
		{
			formtalk.selfilter.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("未输入想要屏蔽的呢称！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doshieldsb(r)
		formtalk.selfilter.selectedIndex = 0
	}
	if(formtalk.selfilter.value =="acceptsb")
	{
		r = window.prompt("想要解禁谁？请输入！","")
		if( r==null)
		{
			formtalk.selfilter.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("未输入想要解禁的呢称！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doacceptsb(r)
		formtalk.selfilter.selectedIndex = 0
	}
	if(formtalk.selfilter.value =="shieldlist")
	{
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doshieldlist()
		formtalk.selfilter.selectedIndex = 0
	}
	if(formtalk.selfilter.value =="clearlist")
	{
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doclearlist()
		formtalk.selfilter.selectedIndex = 0
	}
}
function selfilter_onchange() {
	if(formtalk.selfilter.value =="shieldsb")
	{
		r = window.prompt("想要屏蔽谁？请输入！","")
		if( r==null)
		{
			formtalk.selfilter.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("未输入想要屏蔽的呢称！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doshieldsb(r)
		formtalk.selfilter.selectedIndex = 0
	}
	if(formtalk.selfilter.value =="acceptsb")
	{
		r = window.prompt("想要解禁谁？请输入！","")
		if( r==null)
		{
			formtalk.selfilter.selectedIndex = 0
			return 
		}
		if( r=="" )
		{
			window.alert("未输入想要解禁的呢称！")
			formtalk.selaction.selectedIndex = 0
			return;
		}
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doacceptsb(r)
		formtalk.selfilter.selectedIndex = 0
	}
	if(formtalk.selfilter.value =="shieldlist")
	{
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doshieldlist()
		formtalk.selfilter.selectedIndex = 0
	}
	if(formtalk.selfilter.value =="clearlist")
	{
		if (window.parent.showchatarea.document.all)
			window.parent.showchatarea.doclearlist()
		formtalk.selfilter.selectedIndex = 0
	}
}
//-->
</SCRIPT>
<SCRIPT event=oncontextmenu for=document language=javascript>
<!--
 document_oncontextmenu()
 //-->
</SCRIPT>
</HEAD>
<BODY style="background-image: url('images/chat-back.gif')" leftmargin="0" topmargin="0" rightmargin="0" marginwidth="0" marginheight="0" onLoad="return window_onload()" 
onunload="return window_onunload()"  language=javascript>
  <table class="p9" width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
<FORM action="" target="_self" language=javascript method=post name=formtalk onSubmit="return formtalk_onsubmit()">
    <tr id="talkline1" height="45%"> 
      <td>&nbsp;<span id="mynick">我</span> 
        <select name="Expression" size="1" class="formface" style="BACKGROUND-COLOR: lightgoldenrodyellow; COLOR: mediumslateblue; HEIGHT: 21px; WIDTH: 61px"> 
          <option selected value="">无表情 
          <option value="悄悄地">悄悄 
          <option value="兴高采烈地">高兴 
          <option value="微微笑着">微笑 
          <option value="哈!哈!哈!地笑着">大笑叁声 
          <option value="笑嘻嘻">嘻笑 
          <option value="奸笑着">奸笑 
          <option value="毛手毛脚地">毛手毛脚 
          <option value="嘟着嘴">嘟嘴 
          <option value="快要哭着">快要哭 
          <option value="拳打脚踢地">拳打脚踢 
          <option value="不怀好意地">不怀好意 
          <option value="遗憾地">遗憾 
          <option value="瞪大了眼睛,很讶异地">讶异 
          <option value="幸福地">幸福 
          <option value="翻箱倒柜地">翻箱倒柜 
          <option value="悲伤地">悲伤 
          <option value="淫淫笑着">淫淫笑 
          <option value="流着口水">流口水 
          <option value="正气凛然地">正气凛然 
          <option value="生气地">生气 
          <option value="大声地">大声 
          <option value="傻乎乎地">傻乎乎 
          <option value="一付很满足的样子">很满足 
          <option value="手足无措地">手足无措 
          <option value="很无辜地">无辜 
          <option value="喃喃自语地">喃喃自语 
          <option value="恶狠狠地瞪着眼">瞪眼 
          <option value="快要吐地">想吐 
          <option value="感到不舒服地">不舒服 
          <option value="无精打采地">无精打采 
          <option value="依依不舍地">依依不舍 
          <option value="吐着白沫地">白沫 
          <option value="掩饰不住狂喜的心情">狂喜 
          <option value="笑呵呵一拱手">拱手 

          <option value="很有礼貌地作了一揖">作揖 
          <option value="咳!慨叹万千">慨叹 
          <option value="深深地鞠躬">致歉 
          <option value="望着窗外细雨淅淅，不由得双眼朦胧地">伤感 
          <option value="含泪要哭">含泪 
          <option value="想到伤心处，泪流如注">大哭 
          <option value="抱头放声大哭">痛哭 
          <option value="好怕怕呀...">害怕 
          <option value="感到很是奇特">奇特 
          <option value="眯着小眼睛道">眯眼 
          <option value="咯咯一笑，很大方的">大方 
          <option value="脸上泛起了红晕,">脸红 
          <option value="气愤地嚷道">生气 
          <option value="提高嗓门">大声 
          <option value="运足气一声断喝">断喝 
          <option value="一脸的迷茫">迷茫 
          <option value="无奈地耸耸肩">耸肩 
          <option value="使劲敲敲自己脑门">拍脑 
          <option value="看着别人谈笑，无聊的很">无聊 
          <option value="顾作沉思状">沉思 
          <option value="一付无辜的样子">无辜 
          <option value="不舒服地">不适 
          <option value="不爽地">不爽</option>
        </select>
        <input id="saytoname" name="saytoname" value="大家" size="1" class="stedit" style="BACKGROUND-COLOR: lightgoldenrodyellow; COLOR: blue; HEIGHT: 21px; WIDTH: 56px" readonly> 
        图案  
        <select name="addimg" style="BACKGROUND-COLOR: black; COLOR: lime">
          <option value="" selected>不贴图 
          <option value="0">招手女孩
          <option value="1">无忧女孩
          <option value="11">欢迎女孩 
          <option value="2">欢迎男孩 
          <option value="3">高兴男孩 
          <option value="26">高兴女孩</option>          <option value="4">月亮女孩
          <option value="5">思念女孩 
          <option value="6">信件 
          <option value="7">爱心 
          <option value="8">电话
          <option value="9">下跪 
          <option value="10">非常正确 

          <option value="12">为什么呀 
          <option value="13">口水横流 
          <option value="14">闹钟 
          <option value="15">哭泣女孩
          <option value="16">可爱天使 
          <option value="17">狗狗 
          <option value="18">狡黠女孩 
          <option value="19">大吃一惊 
          <option value="20">爱心</option>
          <option value="21">炸弹</option>
          <option value="22">水雷</option>
          <option value="23">千夫指</option>
          <option value="24">停止</option>
          <option value="25">水果女孩</option>
        </select>
        字体颜色 
        <SELECT NAME="fontcolor" class="formface" style="BACKGROUND-COLOR: #ffffee; HEIGHT: 21px; WIDTH: 70px" LANGUAGE=javascript onChange="return fontcolor_onchange()">
          <option style="COLOR: #000000" value="000000" selected>绝对黑色 
          <option style="COLOR: #000088" value="000088">深蓝忧郁 
          <option style="COLOR: #0000ff" value="0000ff">草原之蓝 
          <option style="COLOR: #008800" value="008800">橄榄树绿 
          <option style="COLOR: #008888" value="008888">灰蓝种族 
          <option style="COLOR: #0088ff" value="0088ff">海洋之蓝 
          <option style="COLOR: #00a010" value="00a010">绿色回忆 
          <option style="COLOR: #1100ff" value="1100ff">蓝色月光 
          <option style="COLOR: #111111" value="111111">夜幕低垂 
          <option style="COLOR: #333333" value="333333">灰色轨迹 
          <option style="COLOR: #50b000" value="50b000">春草青青 
          <option style="COLOR: #880000" value="880000">暗夜兴奋 
          <option style="COLOR: #8800ff" value="8800ff">发亮蓝紫 
          <option style="COLOR: #888800" value="888800">卡其制服 
          <option style="COLOR: #888888" value="888888">伦敦灰雾 
          <option style="COLOR: #8888ff" value="8888ff">兴奋过蓝 
          <option style="COLOR: #aa00cc" value="aa00cc">紫的拘谨 
          <option style="COLOR: #aaaa00" value="aaaa00">流金岁月 
          <option style="COLOR: #ccaa00" value="ccaa00">卡布其诺 
          <option style="COLOR: #ff0000" value="ff0000">正宗喜红 
          <option style="COLOR: #ff0088" value="ff0088">爱的暗示 
          <option style="COLOR: #ff00ff" value="ff00ff">红的发紫 
          <option style="COLOR: #ff8800" value="ff8800">黄金岁月 
          <option style="COLOR: #ff0005" value="ff0005">红袍飘飘 
          <option style="COLOR: #ff88ff" value="ff88ff">紫金绣帖 
          <option style="COLOR: #ee0005" value="ee0005">焚心似火 
          <option style="COLOR: #ee01ff" value="ee01ff">红粉佳人 
          <option style="COLOR: #3388aa" value="3388aa">我不知道</option>
        </SELECT>
        <INPUT type="checkbox" id="chksecret" name="chksecret"     
      LANGUAGE=javascript onClick="return chksecret_onclick()">
        秘谈 <A href="javascript:split()" target=_self>分屏</a>&nbsp;<a href="javascript:nickarealist('rooms')">房间</a>&nbsp;<a href="javascript:nickarealist('users')">名单</a> <!--<a href="javascript:rename()" language=javascript target=_self>在线改名</a>-->
        <!--<select id=selfilter name="selfilter" style="BACKGROUND-COLOR: black; COLOR: yellow; HEIGHT: 22px; WIDTH: 78px" language=javascript onChange="return selfilter_onchange()"> 
          <option selected value="-1">-过 滤-</option>
          <option value="shieldsb">屏蔽某人</option>
          <option value="acceptsb">解禁某人</option>
          <option value="shieldlist">屏蔽名单</option>
          <option value="clearlist">清除名单</option>
        </select>-->
        <select id=select name=selaction style="BACKGROUND-COLOR: black; COLOR: yellow; HEIGHT: 22px; WIDTH: 85px" language=javascript onChange="return selaction_onchange()"> 
          <option selected value="无">-动&nbsp;&nbsp;作-</option>
          <option value="clearscreen">清&nbsp;&nbsp;&nbsp;&nbsp;屏</option>
          <option value="lookat">锁定对象</option>
          <option value="roominfo">本室信息</option>
          <option value="viewnickinfo">用户信息</option>
          <option value="sendannounce">发布公告</option>
        </select></td>
    </tr>
    <tr id="talkline2" height="55%"> 
      <td valign="center">&nbsp;说 
        <input  name="talk" size="150" style="BACKGROUND-COLOR: #ffffee; HEIGHT: 21px; WIDTH: 350px">
        <INPUT name=B1  type =submit class="singleboarder" style="CURSOR: hand; HEIGHT: 24px; WIDTH: 37px"  value="发言">
        <INPUT name=B2 type=reset class="singleboarder" style="CURSOR: hand; HEIGHT: 24px; WIDTH: 39px"  value="取消">
      </td>
    <input type="hidden" id="hiddenaction" name="hiddenaction" >
    </tr>
</FORM>
  </table>
</BODY>
<SCRIPT LANGUAGE=javascript>
<!--
//分屏
function split()
{
	window.top.split()
}

function button2_onclick() {
	//execAsynch()//异步远程调用刷新
	return true;
}

function button1_onclick() {
//window.parent.nickarea.location.reload(true)//这样会出现需重新发送信息的对话框
window.parent.nickarea.location.href = "nicklist.asp"
}


//-->
</SCRIPT>

</html>