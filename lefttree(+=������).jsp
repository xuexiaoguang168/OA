<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.Leaf" %>
<%@ page import="com.redmoon.forum.plugin.*" %>
<%@ page import="java.util.*" %>
<HTML> 
<HEAD>
<TITLE>菜单</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css.css">
<%@ include file="inc/nocache.jsp"%>
<style type="text/css">
.style1 {font-size: 10}
</STYLE>
<script language="JavaScript">
<!--
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}

function displaysubdiv()
{
  var args = displaysubdiv.arguments;
  var num = args[0];
  var islayer2 = false; //是否为第二个层次
  if (num>100)
  	islayer2 = true;

	divobj = findObj("div"+num);
	if (divobj==null)
		return;
	subdivobj = findObj("subdiv"+num);
	chainimgobj = findObj("chainimg"+num);
	folderimgobj = findObj("folderimg"+num);

	if (divobj.isopen==1)
	{
		subdivobj.style.display = "none"
		divobj.isopen = 0;
		chainimgobj.src = "images/left/tplus.gif"
		if (!islayer2)
			folderimgobj.src = "images/left/icon_folder.gif"
	}
	else
	{
		subdivobj.style.display = ""
		divobj.isopen = 1;
		chainimgobj.src = "images/left/tminus.gif"
		if (!islayer2)
			folderimgobj.src = "images/left/icon_folderopen.gif"
	}
}

function openWin(url)
{
  var newwin=window.open(url,"_blank");
}

function loadOfficeUI(url)
{
	window.top.setUI("office");
	window.top.mainFrame.location.href = url
}
//-->
</script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR>
</HEAD>
<BODY bgColor=fff7dd leftMargin=0 topMargin=0 rightMargin=0 marginwidth="0" marginheight="0" class=menu 
ondragstart=self.event.returnValue=false 
onselectstart=self.event.returnValue=false>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<table border="0" cellpadding="0" cellspacing="0">
<tr><td height="22"><B><img src="images/smileface.gif" width="15" height="15" align="absmiddle">&nbsp;<a href="javascript:loadOfficeUI('user_edit.jsp');window.top.hideOnline()"><span class="right-title"><%=privilege.getUser(request)%></span></a></B>   <a href="javascript:checkall()"><u>展开/收缩</u></a></td></tr></table>
<DIV><IMG align=absMiddle alt="" border=0 id=chainimgX src="images/left/tminus.gif"> <IMG align=absMiddle alt=Folder 
src="images/left/icon-address.gif">&nbsp; <A class="item" href="javascript:loadOfficeUI('desktop.jsp');window.top.hideOnline()" 
>我的办公桌</A></DIV>
<DIV id="div1" style="cursor:hand" onClick="displaysubdiv(1)" isopen=1> <IMG align=absMiddle alt="" border=0 id=chainimg1 src="images/left/tminus.gif"> 
  <img align=absMiddle alt="" border=0 class=havechild id=folderimg1 src="images/left/icon_folderopen.gif">&nbsp;行政管理</DIV>
<DIV id="subdiv1"> 
<div>
	<IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-notice.gif"><A class=folderlink href="javascript:loadOfficeUI('doc_list_notice.jsp?dir_code=notice');window.top.hideOnline()" 
> 公共通知
    </A><br>
</div>
  <div id="div106" style="cursor:hand" onClick="displaysubdiv(106, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg106 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-checkflow.gif">  工作流 <br>
</div>
  <DIV id="subdiv106"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-work.gif"> <A class=folderlink href="javascript:loadOfficeUI('flow_initiate1.jsp');window.top.hideOnline()" 
>发起流程<br>
  </A><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-work.gif"> <a class=folderlink href="javascript:loadOfficeUI('flow_list_mine.jsp');window.top.hideOnline()" 
>我的流程</a><br>
<!--<NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-work.gif"> <a class=folderlink href="javascript:loadOfficeUI('flow_list_monitored.jsp');window.top.hideOnline()" 
>监控流程</a><br>
-->
<NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-work.gif"> <a class=folderlink href="javascript:loadOfficeUI('flow_query_frame.jsp');window.top.hideOnline()" 
>工作查询</a><br>
  <NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-check.gif"> <a class=folderlink href="javascript:loadOfficeUI('flow_list_done.jsp');window.top.hideOnline()" 
>已办流程</a><br>
  <NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-check.gif"> <a class=folderlink href="javascript:loadOfficeUI('flow_list_doingorreturn.jsp');window.top.hideOnline()" 
>待办流程</a>
</div>
    
  <div>
    <NOBR><nobr><img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doc.gif"> <a class=folderlink href="javascript:loadOfficeUI('fileark/fileark_frame.jsp')" 
>文件柜</a> <br>
    <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-depart.gif"> <A class=folderlink href="javascript:loadOfficeUI('task.jsp');window.top.hideOnline()" 
>任务督办</A> <br>
    <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-writedoc.gif"> <A class=folderlink href="javascript:loadOfficeUI('workplan/workplan_list.jsp');window.top.hideOnline()" 
>工作计划</A> <br>
    <div id="div101" style="cursor:hand" onClick="displaysubdiv(101, true)" isopen=1>	  
      <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg101 src="images/left/tminus.gif"><IMG id=folderimg101 align=absMiddle alt=Folder 
src="images/left/icon-kaoqin.gif"> 员工事务 <br>
</div>
<div id="subdiv101">
	<img align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-leave.gif"> <a class=folderlink href="javascript:loadOfficeUI('mywork.jsp');window.top.hideOnline()" 
>工作记事</a> <br>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><img align=absMiddle alt=Folder 
src="images/left/icon-memorabilia.gif"> <A class=folderlink href="javascript:loadOfficeUI('kaoqin.jsp');window.top.hideOnline()" 
>员工考勤</A>
	<br>
</div>
</DIV>
  <div><nobr><img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><img align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"> <a href="javascript:loadOfficeUI('organize.jsp')" 
>组织机构</a></DIV>
</DIV>
<DIV id=div4 style="cursor:hand" onClick="displaysubdiv(4)" isopen=1> <IMG align=absMiddle alt="" border=0 id=chainimg4 src="images/left/tminus.gif"> 
  <IMG align=absMiddle alt="" border=0 id=folderimg4 src="images/left/icon_folderopen.gif"> 
  个人助理</DIV>
<DIV id=subdiv4> 
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><img src="netdisk/images/disk.gif" width="16" height="9">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('netdisk/netdisk_frame.jsp');window.top.hideOnline()" >网络硬盘</A>  </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doc.gif">&nbsp;<A class=folderlink href="javascript:loadOfficeUI('address/address_frame.jsp');window.top.hideOnline()" >&nbsp;通讯录</A>  </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-plan.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('plan.jsp');window.top.hideOnline()" 
>日程安排</A> </DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doc.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('user_proxy.jsp');window.top.hideOnline()" 
>设置代理</A> </DIV>  
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-receive.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('message_oa/message.jsp');window.top.hideOnline()" >短消息</A></DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('user/control_panel.jsp');window.top.hideOnline()"   
>控制面板</A></DIV>
</DIV>
<DIV id=div5 style="cursor:hand" onClick="displaysubdiv(5)" isopen=1> <IMG align=absMiddle alt="" border=0 id=chainimg5 src="images/left/tminus.gif"> 
  <IMG align=absMiddle alt="" border=0 id=folderimg5 src="images/left/icon_folderopen.gif"> 
  个人信箱</DIV>
<DIV id=subdiv5> 
    <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-send.gif"> <A class=folderlink href="javascript:loadOfficeUI('mail/mail_frame.jsp');window.top.hideOnline()" 
>收发邮件</A></DIV>
    <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doc.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('mail/pop3_setup.jsp');window.top.hideOnline()" 
>配置邮箱</A> </DIV>
</DIV>
  <DIV id=div3 style="cursor:hand" onClick="displaysubdiv(3)" isopen=1> <IMG align=absMiddle alt="" border=0 id=chainimg3 src="images/left/tminus.gif"> 
  <IMG align=absMiddle alt="" border=0 id=folderimg3 src="images/left/icon_folderopen.gif"> 
  交流中心</DIV>
<DIV id=subdiv3>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"> <A href="javascript:openWin('jump.jsp?fromWhere=oa&toWhere=forum')" 
>社区</A> </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-internet.gif">&nbsp;&nbsp;<A href="javascript:openWin('jump.jsp?fromWhere=oa&toWhere=blog')" 
>博客</A> </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-chat.gif"> <A href="javascript:window.top.setUI('chat')" 
>讨论</A> </DIV>
  </DIV>
<DIV id=div2 onClick="displaysubdiv(2)" isopen=1 style="cursor:hand"> <IMG align=absMiddle alt="" border=0 id=chainimg2 src="images/left/tminus.gif"> 
  <IMG align=absMiddle alt="" border=0 id=folderimg2 src="images/left/icon_folderopen.gif"> 
  公共信息</DIV>
<DIV id=subdiv2>
<div id="div110" style="cursor:hand" onClick="displaysubdiv(110, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg110 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-guestbookm.gif"> 图书管理 <br>
</div>
  <DIV id="subdiv110"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-guestbookm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('book/book_add.jsp');window.top.hideOnline()" 
>图书添加</A><a class=folderlink href="javascript:loadOfficeUI('flow_list_mine.jsp');window.top.hideOnline()" 
></a><br>
      <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-guestbookm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('book/book_list.jsp');window.top.hideOnline()" 
>图书借阅</A><a class=folderlink href="javascript:loadOfficeUI('flow_list_mine.jsp');window.top.hideOnline()" 
></a><br>
        <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-guestbookm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('book/book_return_list.jsp');window.top.hideOnline()" 
>图书归还</A><a class=folderlink href="javascript:loadOfficeUI('flow_list_mine.jsp');window.top.hideOnline()" 
></a><br>
      <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-guestbookm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('book/book_type_list.jsp');window.top.hideOnline()" 
>图书类别</A><a class=folderlink href="javascript:loadOfficeUI('flow_list_mine.jsp');window.top.hideOnline()" 
></a><br>
    <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-guestbookm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('book/book_query.jsp');window.top.hideOnline()" 
>查询图书<br>
  </A><NOBR><NOBR></div>
<div id="div111" style="cursor:hand" onClick="displaysubdiv(111, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg111 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"> 办公用品<br>
</div>
  <DIV id="subdiv111"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"><A class=folderlink href="javascript:loadOfficeUI('officeequip/officeequip_type_list.jsp');window.top.hideOnline()" 
> 类别管理</A><br>
  <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"><A class=folderlink href="javascript:loadOfficeUI('officeequip/officeequip_all_list.jsp');window.top.hideOnline()" 
> 全部用品</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"><A class=folderlink href="javascript:loadOfficeUI('officeequip/officeequip_receive_search.jsp');window.top.hideOnline()" 
> 领用查询</A><br>
  <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"><A class=folderlink href="javascript:loadOfficeUI('officeequip/officeequip_receive.jsp');window.top.hideOnline()" 
> 领用登记</A><br>
  <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"><A class=folderlink href="javascript:loadOfficeUI('officeequip/officeequip_add.jsp');window.top.hideOnline()" 
> 入库登记</A><br>
  <IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"><a class=folderlink href="javascript:loadOfficeUI('officeequip/officeequip_borrow.jsp');window.top.hideOnline()" 
> 借出登记</a><br>
    <NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-download.gif"><a class=folderlink href="javascript:loadOfficeUI('officeequip/officeequip_return_list.jsp');window.top.hideOnline()" 
> 归还用品</a><br>
  <NOBR></div>  
  <div id="div112" style="cursor:hand" onClick="displaysubdiv(112, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg112 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forumm.gif"> 资产管理<br>
</div>
<DIV id="subdiv112"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forumm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('asset/asset_add.jsp');window.top.hideOnline()" 
>资产登记
  </A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forumm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('asset/asset_query.jsp');window.top.hideOnline()" 
>资产查询</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forumm.gif"></span> <A class=folderlink href="javascript:loadOfficeUI('asset/asset_list.jsp');window.top.hideOnline()" 
>资产管理</A><br>
    <NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><span style="cursor:hand"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forumm.gif"></span> <a class=folderlink href="javascript:loadOfficeUI('asset/asset_type_list.jsp');window.top.hideOnline()" 
>资产类别</a><br>
  <NOBR></div>
  
<div id="div113" style="cursor:hand" onClick="displaysubdiv(113, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg113 src="images/left/tminus.gif"><IMG 
src="images/left/icon-vehicle.gif" alt=Folder width="16" height="16" align=absMiddle> 车辆管理<br>
</div>
<DIV id="subdiv113"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG 
src="images/left/icon-vehicle.gif" alt=Folder width="16" height="16" align=absMiddle></span> <A class=folderlink href="javascript:loadOfficeUI('flow_initiate1.jsp?op=pc');window.top.hideOnline()" 
>使用申请
  </A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG 
src="images/left/icon-vehicle.gif" alt=Folder width="16" height="16" align=absMiddle></span> <A class=folderlink href="javascript:loadOfficeUI('vehicle/vehicle_apply_list.jsp');window.top.hideOnline()" 
>使用管理</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG 
src="images/left/icon-vehicle.gif" alt=Folder width="16" height="16" align=absMiddle></span> <A class=folderlink href="javascript:loadOfficeUI('vehicle/vehicle_maintenance_list.jsp');window.top.hideOnline()" 
>维护管理</A><br>
    <NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG 
src="images/left/icon-vehicle.gif" alt=Folder width="16" height="16" align=absMiddle></span> <a class=folderlink href="javascript:loadOfficeUI('vehicle/vehicle_list.jsp');window.top.hideOnline()" 
>信息管理</a><br>
    <NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><span style="cursor:hand"><IMG 
src="images/left/icon-vehicle.gif" alt=Folder width="16" height="16" align=absMiddle></span> <a class=folderlink href="javascript:loadOfficeUI('vehicle/vehicle_type_list.jsp');window.top.hideOnline()" 
>类型管理</a><br>
    <NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><span style="cursor:hand"><IMG 
src="images/left/icon-vehicle.gif" alt=Folder width="16" height="16" align=absMiddle></span> <a class=folderlink href="javascript:loadOfficeUI('vehicle/vehicle_driver_list.jsp');window.top.hideOnline()" 
>驾&nbsp;&nbsp;驶&nbsp;&nbsp;员</a><br>
  <NOBR></div>
  
  <div id="div114" style="cursor:hand" onClick="displaysubdiv(114, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg114 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"> 会议申请与安排<br>
</div>
<DIV id="subdiv114"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('flow_initiate1.jsp?op=hysqd');window.top.hideOnline()" 
> 使用申请
  </A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('meeting/boardroom_apply_list.jsp');window.top.hideOnline()" 
> 使用管理</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('meeting/boardroom_m.jsp');window.top.hideOnline()" 
> 会议室管理</A>
</div><NOBR>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG 
src="images/left/help.gif" alt=Folder width="20" height="17" align=absMiddle> <A class=folderlink href="help/frame.html" target="_blank" 
>帮助</A> </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-tel.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('address/address_frame.jsp?type=<%=com.redmoon.oa.address.AddressDb.TYPE_PUBLIC%>&mode=show');window.top.hideOnline()" 
>公共通讯录</A> </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doctype.gif">&nbsp;&nbsp;<A class=folderlink href="activex/oa_client.EXE" 
>下载控件</A> </DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-zipcode.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('zipcode.jsp');window.top.hideOnline()" 
>邮编区号</A> </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-calendar.gif">&nbsp;&nbsp;<A class=folderlink  href="javascript:loadOfficeUI('util/wnl/wnl.htm');window.top.hideOnline()" 
>万年历</A> </DIV>
</DIV>
<DIV id=div50 style="cursor:hand" onClick="displaysubdiv(50)" isopen=1> <IMG align=absMiddle alt="" border=0 id=chainimg50 src="images/left/tminus.gif"> 
  <IMG align=absMiddle alt="" border=0 id=folderimg50 src="images/left/icon_folderopen.gif"> 
  人事管理</DIV>
<DIV id=subdiv50> 
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif"> <A class=folderlink href="javascript:loadOfficeUI('archive_simple/user_archive_frame.jsp');window.top.hideOnline()" >档案管理</A>(简版)  </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif"><A class=folderlink href="javascript:loadOfficeUI('archive_simple/user_archive_list.jsp');window.top.hideOnline()" 
> 档案列表</A>(简版)</DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif"> <A class=folderlink href="javascript:loadOfficeUI('archive_simple/user_archive_search.jsp');window.top.hideOnline()"   
>档案查询</A>(简版)</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif"> <A class=folderlink href="javascript:loadOfficeUI('archive_simple/user_archive_stat.jsp');window.top.hideOnline()"   
>档案分析</A>(简版)</DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('archive/archive_user_frame.jsp');window.top.hideOnline()"
>档案管理</A>(政府版)</DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('archive/archive_query_sel_dept.jsp');window.top.hideOnline()"   
>预设查询</A>(政府版)</DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('archive/archive_query_save_list.jsp');window.top.hideOnline()"   
>档案查询</A>(政府版)</DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('archive/archive_user_search.jsp');window.top.hideOnline()"   
>用户查询</A>(政府版)</DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('archive/archive_user_his_list.jsp');window.top.hideOnline()" 
>历史记录</A>(政府版)</DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-userinfo.gif">&nbsp;&nbsp;<A class=folderlink href="javascript:loadOfficeUI('archive/archive_basicdata_list.jsp');window.top.hideOnline()"   
>数据维护</A>(政府版)</DIV>
</div>
<DIV id=div51 style="cursor:hand" onClick="displaysubdiv(51)" isopen=1> <IMG align=absMiddle alt="" border=0 id=chainimg51 src="images/left/tminus.gif"> 
  <IMG align=absMiddle alt="" border=0 id=folderimg51 src="images/left/icon_folderopen.gif"> 
  销售管理</DIV>
<DIV id=subdiv51> 
<div id="div120" style="cursor:hand" onClick="displaysubdiv(120, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg120 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"> 客户管理 <br>
</div>
<DIV id="subdiv120"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif">&nbsp;<A class=folderlink href="javascript:loadOfficeUI('sales/customer_list.jsp');window.top.hideOnline()" 
>我的客户</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('sales/linkman_list.jsp');window.top.hideOnline()" 
> 我的联系人</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('sales/customer_list.jsp?action=manage');window.top.hideOnline()" 
> 客户管理</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('sales/linkman_list.jsp?action=manage');window.top.hideOnline()" 
> 联系人管理</A><br>
  <NOBR></div>
<div id="div121" style="cursor:hand" onClick="displaysubdiv(121, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg121 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"> 销售管理 <br>
</div>
<DIV id="subdiv121">
<NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif">&nbsp;<A class=folderlink href="javascript:loadOfficeUI('sales/product_list.jsp');window.top.hideOnline()" 
>产品信息</A><br>
<NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif">&nbsp;<A class=folderlink href="javascript:loadOfficeUI('sales/product_service_list.jsp');window.top.hideOnline()" 
>服务型产品</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('sales/contract_list.jsp');window.top.hideOnline()" 
> 销售合同管理</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('sales/product_sell_list.jsp?action=manage');window.top.hideOnline()" 
> 产品销售记录</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('sales/product_service_sell_list.jsp?action=manage');window.top.hideOnline()" 
> 服务销售记录</A><br>
  <NOBR></div>
<div id="div122" style="cursor:hand" onClick="displaysubdiv(122, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg122 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"> 供应商 <br>
</div>
<DIV id="subdiv122"><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif">&nbsp;<A class=folderlink href="javascript:loadOfficeUI('sales/provider_info_list.jsp');window.top.hideOnline()" 
>供应商信息</A><br>
<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forum.gif"><A class=folderlink href="javascript:loadOfficeUI('sales/provider_contact_list.jsp?action=manage');window.top.hideOnline()" 
> 供应联系人</A><br>
  <NOBR></div>  
</div>
<%
String priv="admin";
if (privilege.isUserHasAnyAdminPriv(request))
{
	// out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
%>
<DIV id=div8 style="cursor:hand" onClick="displaysubdiv(8)" isopen=1> <IMG align=absMiddle alt="" border=0 id=chainimg8 src="images/left/tminus.gif"> 
  <IMG align=absMiddle alt="" border=0 id=folderimg8 src="images/left/icon_folderopen.gif"> 
  超级管理</DIV>
<DIV id=subdiv8> 
<div id="div117" style="cursor:hand" onClick="displaysubdiv(117, true)" isopen=1> <img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle alt="" border=0 id=chainimg117 src="images/left/tminus.gif"><img align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> 组织机构</div>
    <div id="subdiv117" name="subdiv117">
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"> <A  class=folderlink href="javascript:loadOfficeUI('admin/dept_frame.jsp')">部门管理</A> </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"><A class=folderlink href="javascript:loadOfficeUI('admin/post_frame.jsp')"> 部门人员</A> </DIV>
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/user_list.jsp')" 
>用户管理</A></DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
		src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/rank_list.jsp')" 
>职级管理</A></DIV>
</div>
<div id="div119" style="cursor:hand" onClick="displaysubdiv(119, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg119 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> 权限管理<br>
</div>
    <DIV id="subdiv119">
  <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/user_role_m.jsp')" 
>角色管理</A></DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/user_group_m.jsp')" 
>用户组管理</A></DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
		src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/priv_m.jsp')" 
>权限名称</A></DIV>
</DIV>
    <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-user.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/netdisk_public_dir_frame.jsp')" 
>公共共享</A></DIV>
    <DIV><NOBR>
    <div id="div107" style="cursor:hand" onClick="displaysubdiv(107, true)" isopen=1> <img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle alt="" border=0 id=chainimg107 src="images/left/tminus.gif"><img align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> 文件柜</div>
    <div id="subdiv107" name="subdiv107"><img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('cms/dir_frame.jsp')" 
		>文件目录</A>
		<NOBR><br>
		<img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
		src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doctype.gif"> <A  class=folderlink href="javascript:loadOfficeUI('cms/document_list_m.jsp')">文件列表</A>
	</DIV>
    <div id="div105" style="cursor:hand" onClick="displaysubdiv(105, true)" isopen=1> <img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle alt="" border=0 id=chainimg105 src="images/left/tminus.gif"><img align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> 工作流</div>
    <div id="subdiv105" name="subdiv105"><img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/flow_dir_frame.jsp')">流程管理</A><br>
      <img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/flow_predefine_frame.jsp')">预设流程</A><NOBR><br><img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif">&nbsp;<A class=folderlink href="javascript:loadOfficeUI('admin/form_m.jsp')">预设表单</A><NOBR><br>
	<img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
		src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doctype.gif"> <A class=folderlink href="javascript:loadOfficeUI('admin/flow_sequence_list.jsp')">序列控件</A></DIV>	
    
    <IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> <A  class=folderlink href="javascript:loadOfficeUI('address/address_frame.jsp?type=<%=com.redmoon.oa.address.AddressDb.TYPE_PUBLIC%>')" 
>通 讯 录</A>
    <div id="div108" style="cursor:hand" onClick="displaysubdiv(108, true)" isopen=1> <img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle alt="" border=0 id=chainimg108 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-forumm.gif"> 论坛管理 </div>
        <div id="subdiv108" name="subdiv107"><img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/admin/dir_frame.jsp')" 
		>版块管理</A><NOBR><br>
<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/admin/forum_m.jsp')" 
		>论坛过滤</A>	<NOBR><br>
<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/admin/link.jsp')" 
		>友情链接</A>	<NOBR><br>		
<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/admin/entrance.jsp')" 
		>进入方式</A><br>
<%
PluginMgr pm = new PluginMgr();
Vector v = pm.getAllPlugin();
Iterator ir = v.iterator();
while (ir.hasNext()) {
	PluginUnit pu = (PluginUnit)ir.next();
	if (pu!=null && !pu.getAdminEntrance().trim().equals("")) {
%>	

			  <img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A href="forum/forum/<%=pu.getAdminEntrance()%>" target=mainFrame><%=pu.LoadString(request, "adminMenuItem")%></A>
		<BR>
<%	}
}%>
		<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif">  <A class=folderlink href="javascript:loadOfficeUI('forum/admin/render.jsp')" 
		>贴子显示</A><br>
        <img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/admin/config_m.jsp')" 
		>论坛配置</A><br>
		<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/topic_m.jsp')" 
		>贴子管理</A><br>		
        <img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><img align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <a class=folderlink href="javascript:loadOfficeUI('forum/admin/ad_topic_bottom.jsp')" 
		>广告贴子</a><br>
        <img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/admin/setup_user_level.jsp')" 
		>等级管理</A><br>
        <img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('forum/admin/user_group_m.jsp')" 
		>用户组</A><br>
	<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<IMG align=absMiddle 
		src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doctype.gif"> <A  class=folderlink href="javascript:loadOfficeUI('forum/admin/user_m.jsp')">用户管理</A>	</DIV>
  </DIV>

        <div id="div109" style="cursor:hand" onClick="displaysubdiv(109, true)" isopen=1> <img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle alt="" border=0 id=chainimg109 src="images/left/tminus.gif"><img align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> 博客管理 </div>
        <div id="subdiv109" name="subdiv109">
		<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('blog/admin/dir_frame.jsp')" 
		>分类管理</A>	<NOBR><br>
<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<img align=absMiddle 
		src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doc.gif"> <A class=folderlink href="javascript:loadOfficeUI('blog/admin/home.jsp')" 
		>博客首页</A>			
		<NOBR><br>
	<img align=absMiddle src="images/left/i.gif">&nbsp;&nbsp;<img align=absMiddle src="images/left/i.gif">&nbsp;<IMG align=absMiddle 
		src="images/left/l.gif"><IMG align=absMiddle alt=Folder 
		src="images/left/icon-doctype.gif"> <A  class=folderlink href="javascript:loadOfficeUI('blog/admin/blog_list.jsp')">博客列表</A>	</DIV>
    <DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-chatm.gif"> <a  href="javascript:loadOfficeUI('chat/manage/manage.jsp')">讨论管理</a></DIV>
<div id="div104" style="cursor:hand" onClick="displaysubdiv(104, true)" isopen=1>
	<IMG align=absMiddle src="images/left/i.gif">&nbsp; <IMG align=absMiddle alt="" border=0 id=chainimg104 src="images/left/tminus.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> 系统管理<br>
</div>
    <DIV id="subdiv104"><nobr><img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> <A  class=folderlink href="javascript:loadOfficeUI('admin/cache.jsp')" 
>系统环境</A><A  class=folderlink href="javascript:loadOfficeUI('admin/bak_m.jsp')" 
><br>
      </A><nobr><img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> <A  class=folderlink href="javascript:loadOfficeUI('admin/bak_m.jsp')" 
>系统备份</A><br>
<nobr><img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><img align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon-doctype.gif"> <A  class=folderlink href="javascript:loadOfficeUI('admin/log_list.jsp')" 
>系统日志</A><br>
<nobr><img align=absMiddle src="images/left/i.gif">&nbsp; <img align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/l.gif"><img align=absMiddle alt=Folder 
src="images/left/icon-noticem.gif"> <a  href="javascript:loadOfficeUI('admin/config_m.jsp')">配置管理</a></DIV>
</DIV>
<%
}
%>
<DIV><IMG align=absMiddle alt="" border=0 id=chainimglast src="images/left/tlast.gif"><IMG src="images/left/icon-exit.gif" alt="" border=0 
align=absMiddle> <A 
href="exit_oa.jsp" target="mainFrame">退出</A></DIV>
</BODY>
<script language="JavaScript1.2">
<!--
/**
* Get cookie routine by Shelley Powers 
* (shelley.powers@ne-dev.com)
*/

function get_cookie(Name) {
	var search = Name + "="
	var returnvalue = "";
	if (document.cookie.length > 0) {
		offset = document.cookie.indexOf(search)
		// if cookie exists
		if (offset != -1) { 
			offset += search.length
			// set index of beginning of value
			end = document.cookie.indexOf(";", offset);
			// set index of end of cookie value
			if (end == -1) end = document.cookie.length;
			returnvalue=unescape(document.cookie.substring(offset, end))
		}
	}
	return returnvalue;
}
//document.cookie=window.location.pathname+"="
if (get_cookie(window.location.pathname) != ''){
	var openresults=get_cookie(window.location.pathname).split("|")
	for (i=0; i<openresults.length; i++){
		displaysubdiv(openresults[i]);
	}
}

var isopen = true;
function checkall(){
	var divobj,subdivobj,chainimgobj,folerimgobj;
	var islayer2 = false;
	for (i=1; i<=150; i++) 
	{
		divobj = findObj("div"+i);
		if (divobj==null)
			continue;
		subdivobj = findObj("subdiv"+i);
		chainimgobj = findObj("chainimg"+i);
		folderimgobj = findObj("folderimg"+i);
		if (i>=100)
			islayer2 = true;
		else
			islayer2 = false;
		if (!isopen)
		{
			subdivobj.style.display = "none"
			divobj.isopen = 0;
			chainimgobj.src = "images/left/tplus.gif"
			if (!islayer2)
				folderimgobj.src = "images/left/icon_folder.gif"
		}
		else
		{
			subdivobj.style.display = ""
			divobj.isopen = 1;
			chainimgobj.src = "images/left/tminus.gif"
			if (!islayer2)
				folderimgobj.src = "images/left/icon_folderopen.gif"
		}
	}
	isopen = !isopen
}

function check(){
	var openones = "";
	for (i=1; i<=150; i++) 
	{
		divobj = findObj("div"+i);
		if (divobj==null)
			continue;
		if (divobj.isopen==0)
			if (openones=="")	
				openones = i;//利用cookie记录下呈关闭状态的div的编号
			else
				openones += "|"+i;
	}
	var expdate = new Date();
	var expday = 60
	expdate.setTime(expdate.getTime() +  (24 * 60 * 60 * 1000 * expday));
	
	document.cookie=window.location.pathname+"="+openones+" ;expires="+expdate.toGMTString();
}

if (document.all)
	document.body.onunload=check

//-->
</script>
</HTML>
