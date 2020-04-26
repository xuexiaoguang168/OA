<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ page import="com.redmoon.forum.plugin2.*"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%@ taglib uri="/WEB-INF/tlds/AdTag.tld" prefix="ad"%>
<%
String querystring = StrUtil.getNullString(request.getQueryString());
String privurl=request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");

if (!privilege.isUserLogin(request)) {
	if (!ForumDb.getInstance().canGuestSeeTopic()) {
		response.sendRedirect("../info.jsp?op=login&info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "info_please_login")) + "&privurl=" + privurl);
		return;	
	}
}

long rootid;
try {
	rootid = ParamUtil.getLong(request, "rootid");
}
catch (Exception e) {
	out.println(StrUtil.Alert(SkinUtil.LoadString(request, SkinUtil.ERR_ID))); // "标识非法！"));
	return;
}

long showid = 0;
try {
	showid = ParamUtil.getLong(request, "showid");//显示内容的贴子ID
}
catch (Exception e) {
	showid = rootid;
}

UserMgr um = new UserMgr();

MsgDb msgdb = new MsgDb();
msgdb = msgdb.getMsgDb(showid);
// 如果被删除后该贴已不存
if (!msgdb.isLoaded()) {
	showid = rootid;
	msgdb = msgdb.getMsgDb(showid);
	if (!msgdb.isLoaded()) {
		out.print(cn.js.fan.web.SkinUtil.makeInfo(request, SkinUtil.LoadString(request, "res.label.forum.showtopic", "topic_lost"))); // "该贴已不存在！"));
		return;
	}
}

MsgDb rootMsgDb = msgdb.getMsgDb(rootid);

if (rootMsgDb.getCheckStatus()==MsgDb.CHECK_STATUS_NOT && !privilege.isMasterLogin(request)) {
	response.sendRedirect("../info.jsp?info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "res.label.forum.showtopic", "check_not")) + "&privurl=" + privurl);	
	return;
}

String boardcode = msgdb.getboardcode();

if (!privilege.canUserDo(request, boardcode, "enter_board")) {
	response.sendRedirect("../info.jsp?info= " + StrUtil.UrlEncode(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

if (!privilege.canUserDo(request, boardcode, "view_topic")) {
	response.sendRedirect("../info.jsp?info= " + StrUtil.UrlEncode(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

try {
	privilege.checkCanEnterBoard(request, boardcode);
}
catch (ErrMsgException e) {
	response.sendRedirect("../info.jsp?info=" + StrUtil.UrlEncode(e.getMessage()));
	return;
}

Leaf msgLeaf = new Leaf();
msgLeaf = msgLeaf.getLeaf(boardcode);
String boardname = "";
if (msgLeaf!=null)
	boardname = msgLeaf.getName();

UserSession.setBoardCode(request, msgdb.getboardcode());

// 取得皮肤路径
String skincode = "";
if (msgLeaf!=null)
	msgLeaf.getSkin();
if (skincode.equals("") || skincode.equals(UserSet.defaultSkin)) {
	skincode = UserSet.getSkin(request);
	if (skincode==null || skincode.equals(""))
		skincode = UserSet.defaultSkin;
}	
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
String skinPath = skin.getPath();

com.redmoon.forum.Config cfg1 = new com.redmoon.forum.Config();
int msgTitleLengthMin = cfg1.getIntProperty("forum.msgTitleLengthMin");
int msgTitleLengthMax = cfg1.getIntProperty("forum.msgTitleLengthMax");
int msgLengthMin = cfg1.getIntProperty("forum.msgLengthMin");
int msgLengthMax = cfg1.getIntProperty("forum.msgLengthMax");
int maxAttachmentCount = cfg1.getIntProperty("forum.maxAttachmentCount");
int maxAttachmentSize = cfg1.getIntProperty("forum.maxAttachmentSize");

//seo
com.redmoon.forum.util.SeoConfig scfg = new com.redmoon.forum.util.SeoConfig();
String seoTitle = scfg.getProperty("seotitle");
String seoKeywords = scfg.getProperty("seokeywords");
String seoHead = scfg.getProperty("seohead");
String seoDescription = StrUtil.left(msgdb.getContent(),100);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><%=msgdb.getTitle()%> - <%=Global.AppName%> <%=seoTitle%></TITLE>
<%=seoHead%>
<META http-equiv=Content-Type content=text/html; charset=utf-8>
<META name="keywords" content="<%=seoKeywords%>">
<META name="description" content="<%=StrUtil.toHtml(seoDescription)%>">
<LINK href="<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<LINK href="images/bbs.ico" rel="SHORTCUT ICON">
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
</STYLE>

<SCRIPT language=JavaScript>
<!--
function zoomimg(o){
	return;
	var zoom = parseInt(o.style.zoom, 10)||100;
	zoom += event.wheelDelta/12;
	if (zoom>0)
		o.style.zoom = zoom + "%";
	return false;
}

function SymError()
{
  return true;
}

window.onerror = SymError;

//-->
</SCRIPT>

<SCRIPT language=JavaScript src="images/nereidFade.js"></SCRIPT>
<SCRIPT>
function checkclick(msg){if(confirm(msg)){event.returnValue=true;}else{event.returnValue=false;}}
function copyText(obj) {var rng = document.body.createTextRange();rng.moveToElementText(obj);rng.select();rng.execCommand('Copy');}
var i=0;
function formCheck()
{
	i++;
	if (document.frmAnnounce.topic.value.length<<%=msgTitleLengthMin%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_title"/><%=msgTitleLengthMin%>");
		return false;
	}	

	if (document.frmAnnounce.topic.value.length><%=msgTitleLengthMax%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_large_title"/><%=msgTitleLengthMax%>");
		return false;
	}	
	if (document.frmAnnounce.Content.value.length<<%=msgLengthMin%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_content"/><%=msgLengthMin%>");
		return false;
	}
	if (document.frmAnnounce.Content.value.length><%=msgLengthMax%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_large_content"/><%=msgLengthMax%>");
		return false;
	}
	if (i>1) 
	{
		document.frmAnnounce.submit1.disabled = true;
	}
	return true;
}
function presskey(eventobject) { 
	if(event.ctrlKey && window.event.keyCode==13) {
		i++;
		if (i>1) {
			alert('<lt:Label res="res.label.forum.showtopic" key="wait"/>');
			return false;
		}
		this.document.frmAnnounce.submit();
	}
}
</SCRIPT>
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
body {
	margin-top: 0px;
}
</STYLE>
<META content="MSHTML 6.00.2800.1126" name=GENERATOR></HEAD>
<BODY text=#000000 vLink=#000000 aLink=#000000 link=#000000 bgColor=#ffffff leftMargin=0 marginwidth="0">
<%@ include file="inc/header.jsp"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:include page="inc/position.jsp" flush="true">
<jsp:param name="boardcode" value="<%=StrUtil.UrlEncode(boardcode)%>" /> 
</jsp:include>
<ad:AdTag type="<%=AdDb.TYPE_TEXT%>" boardCode="<%=boardcode%>"></ad:AdTag>
<%
if (msgdb.getCheckStatus()==msgdb.CHECK_STATUS_NOT) {
	if (!privilege.isMasterLogin(request)) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "res.label.forum.showtopic", "check_not")));
		return;
	}
}
else if (msgdb.getCheckStatus()==msgdb.CHECK_STATUS_DUSTBIN) {
	if (!privilege.isMasterLogin(request)) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "res.label.forum.showtopic", "check_dustbin")));
		return;
	}
}
%>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice"/>
<%
// 每隔5分钟刷新在位时间
userservice.refreshStayTime(request, response);

// 取得显示设置
BoardRenderDb boardRender = new BoardRenderDb();
boardRender = boardRender.getBoardRenderDb(boardcode);
IPluginRender render = boardRender.getRender();
	
int hit = 0;
int islocked = 0,iselite=0,lylevel=0;

long id;
int experience,credit,addcount;
String name="",lydate="",content="",topic="",showtopic="";
String email="",sign="";
String RegDate="",Gender="",RealPic="";
String myface="";
int myfacewidth=120,myfaceheight=150,iswebedit = 0;
int show_ubbcode=1,show_smile=1;
int orders = 1,type=0, isguide=0;
int pagesize = 10;
int CPages = 1;
	id = msgdb.getId();
	name = msgdb.getName();
	topic = msgdb.getTitle();
	showtopic = topic;
	content = msgdb.getContent();
    lydate = com.redmoon.forum.ForumSkin.formatDateTime(request, msgdb.getAddDate());
	orders = msgdb.getOrders();
	CPages = (int)Math.ceil((double)orders/pagesize);
	type = msgdb.getType();
	islocked = msgdb.getIsLocked();
	iselite = msgdb.getIsElite();
	lylevel = msgdb.getLevel();
	show_ubbcode = msgdb.getShowUbbcode();
	show_smile = msgdb.getShowSmile();
    iswebedit = msgdb.getIsWebedit();
	
	UserDb user = um.getUser(name);
	RealPic = user.getRealPic();
	Gender = StrUtil.getNullStr(user.getGender());
		if (Gender.equals("M"))
			Gender = SkinUtil.LoadString(request, "res.label.forum.showtopic", "sex_man"); // "男";
		else if (Gender.equals("F"))
			Gender = SkinUtil.LoadString(request, "res.label.forum.showtopic", "sex_woman"); // "女";
		else
			Gender = SkinUtil.LoadString(request, "res.label.forum.showtopic", "sex_none"); // "不详";
	RegDate = com.redmoon.forum.ForumSkin.formatDate(request, user.getRegDate());
	experience = user.getExperience();
	credit = user.getCredit();
	addcount = user.getAddCount();
	email = user.getEmail(); 
	sign = StrUtil.getNullStr(user.getSign());
	myface = StrUtil.getNullStr(user.getMyface());
	myfacewidth = user.getMyfaceWidth();
	myfaceheight = user.getMyfaceHeight();

	String sqlt = "select id from sq_thread where boardcode=" + StrUtil.sqlstr(boardcode)+"  ORDER BY msg_level desc,redate desc";
	ThreadBlockIterator irthread = msgdb.getThreads(sqlt, boardcode, 0, 200);
	irthread.setIndex(msgdb);
%>
<%	
PluginMgr pmnote = new PluginMgr();
Vector vplugin = pmnote.getAllPluginUnitOfBoard(boardcode);
if (vplugin.size()>0) {
Iterator irpluginnote = vplugin.iterator();
while (irpluginnote.hasNext()) {
	PluginUnit pu = (PluginUnit)irpluginnote.next();
	IPluginUI ipu = pu.getUI(request, response, out);
	IPluginViewShowMsg pv = ipu.getViewShowMsg(boardcode, msgdb);
	String rule = pv.render(UIShowMsg.POS_NOTE);
	if (!rule.equals("") && pv.IsPluginBoard()) {
%>
<TABLE borderColor="<%=skin.getTableBorderClr()%>" height=25 cellSpacing=0 cellPadding=1 rules=rows 
width="98%" align=center border=1 class="table_normal">
  <TBODY>
    <TR>
      <TD>
<!--plugin rule--><%out.print(pu.getName(request) + "&nbsp;" + rule + "<BR>");%>
      </TD>
    </TR>
  </TBODY>
</TABLE><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>
<%		}
	}
}%>
<TABLE cellSpacing=0 cellPadding=0 width="98%" align=center border=0>
  <TBODY>
  <TR>
    <TD width="49%" height=35>
		<%
		String addpage = "addtopic_new.jsp";
		String replypage = "addreply_new.jsp";
		if (msgLeaf.getWebeditAllowType()==Leaf.WEBEDIT_ALLOW_TYPE_REDMOON_FIRST) {
			addpage = "addtopic_we.jsp";
			replypage = "addreply_we.jsp";
		}
		%>	  
		<a href="<%=addpage%>?boardcode=<%=StrUtil.UrlEncode(boardcode)%>&privurl=<%=privurl%>"><img src="<%=skinPath%>/images/post_<%=SkinUtil.getLocale(request)%>.gif" border=0 width=99 height=25 alt="<lt:Label res="res.label.forum.showtopic" key="addtopic"/>"></a>
		<a href="<%=replypage%>?boardcode=<%=StrUtil.UrlEncode(boardcode)%>&replyid=<%=rootid%>&privurl=<%=privurl%>"> <img height=25 src="<%=skinPath%>/images/newreply_<%=SkinUtil.getLocale(request)%>.gif" width=99 border=0 alt="<lt:Label res="res.label.forum.showtopic" key="addreply"/>"></a>
        <%
		if (vplugin.size()>0) {
			Iterator irplugin = vplugin.iterator();
			while (irplugin.hasNext()) {
				PluginUnit pu = (PluginUnit)irplugin.next();
				IPluginUI ipu = pu.getUI(request, response, out);
				IPluginViewListThread pv = ipu.getViewListThread(boardcode);
				if (pv.IsPluginBoard() && pu.getType().equals(pu.TYPE_TOPIC) && !pu.getButton().equals("")) {%>
        <a href="<%=addpage%>?pluginCode=<%=pu.getCode()%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&privurl=<%=privurl%>"><img src="<%=skinPath + "/" + pu.getButton()%>_<%=SkinUtil.getLocale(request)%>.gif" border="0"></a>
        <%}
			}
		}
		%>
        <%
			if (msgLeaf!=null) {
				Vector vplugin2 = msgLeaf.getAllPlugin2();
				Iterator irplugin2 = vplugin2.iterator();
				while (irplugin2.hasNext()) {
					com.redmoon.forum.plugin2.Plugin2Unit p2u = (com.redmoon.forum.plugin2.Plugin2Unit)irplugin2.next();
				%>
      <a href="<%=addpage%>?plugin2Code=<%=p2u.getCode()%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&privurl=<%=privurl%>"><img src="<%=skinPath + "/images/" + p2u.getButton()%>_<%=SkinUtil.getLocale(request)%>.gif" border="0"></a>
      <%}
			}
		  %>	</TD>
    <TD width="51%" height=35 align="right">
	<FONT color=#333333><lt:Label res="res.label.forum.showtopic" key="hit_begin"/> <B><span id="spanhit" name="spanhit"></span></B> <lt:Label res="res.label.forum.showtopic" key="hit_end"/></FONT>&nbsp;&nbsp;
	  <a href="<%=ForumPage.getShowTopicPage(request, rootid, CPages, "" + showid)%>" title="<lt:Label res="res.label.forum.showtopic" key="flat_view"/>"><img border=0 src="images/flatview.gif"></a>&nbsp;&nbsp;
<%  if (irthread.hasPrevious()) {
        MsgDb prevMsg = (MsgDb)irthread.previous();
        // advance the iterator pointer back to the original index
        irthread.next();
%>
	  <A href="<%=ForumPage.getShowTopicPage(request, 1, prevMsg.getRootid(), prevMsg.getRootid(), 1, "")%>"><IMG alt=<lt:Label res="res.label.forum.showtopic" key="show_pre"/> src="images/prethread.gif" border=0></A>
	  <%}%>
	  &nbsp;&nbsp;<A href="javascript:location.reload()"><IMG alt=<lt:Label res="res.label.forum.showtopic" key="refresh"/> src="images/refresh.gif" border=0></A>　
<%  if (irthread.hasNext()) {
        MsgDb nextMsg = (MsgDb)irthread.next();
%>
	  <A href="<%=ForumPage.getShowTopicPage(request, 1, nextMsg.getRootid(), nextMsg.getRootid(), 1, "")%>"><IMG alt=<lt:Label res="res.label.forum.showtopic" key="show_after"/> src="images/nextthread.gif" 
      border=0></A>
<%  } else { %>
    &nbsp;
<%  } %>	  </TD></TR></TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="98%" align=center bgColor=#d3d3d3 
border=0>
  <TBODY>
  <TR>
    <TD>
      <TABLE cellSpacing=1 cellPadding=6 width="100%" border=0>
        <TBODY></TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE borderColor=#d3d3d3 cellSpacing=0 cellPadding=0 width="98%" align=center 
border=1>
  <TBODY>
  <TR >
    <TD height=26>
      <TABLE width="100%" height="26" background="<%=skinPath%>/images/bg1.gif">
        <TBODY>
        <TR>
          <TD class="text_title"><lt:Label res="res.label.forum.showtopic" key="topic"/><%=StrUtil.toHtml(topic)%></TD>
              <TD align=right><A href="javascript:window.print()"><FONT 
            color=#ffffff>[<lt:Label res="res.label.forum.showtopic" key="print"/>]</FONT></A> <A 
            href="javascript:window.external.AddFavorite(location.href,document.title)"><FONT 
            color=#ffffff>[<lt:Label res="res.label.forum.showtopic" key="favoriate"/>]</FONT></A> <A 
            onclick=document.all.WebBrowser.ExecWB(4,1) 
            href="http://bbs.downlove.com/showtopic.asp?id=23111&amp;forumid=16&amp;page=1#"></A> 
              </TD>
            </TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<table bordercolor="<%=skin.getTableBorderClr()%>" cellspacing=0 cellpadding=0 width="98%" align=center 
border=1>
  <tbody> 
  <tr> 
    <td valign=top align=left height=78> 
      <table cellspacing=0 cellpadding=3 width="100%" border=0>
        <tbody> 
        <tr bgcolor=#ffffff> 
          <td valign=top width=150 height=106> 
            <table cellspacing=0 cellpadding=0 width="80%" align=center 
border=0>
                  <tbody>
                    <tr> 
                      <td align=left> <table style="FILTER: glow(color=a4b6d7)">
                          <caption>
                          <b><font style="FONT-SIZE: 10pt" 
                    color=#ffffff><%=user.getNick()%></font></b> 
                          </caption>
                        </table>
                        <%
						  UserGroupDb ugd = user.getUserGroupDb();
						  if (!ugd.getCode().equals(UserGroupDb.EVERYONE)) {
						  	out.print("<table><tr><td>" + ugd.getDesc() + "</td></tr></table>");
						  }
						%></td>
                    </tr>
                    <tr> 
                      <td align=left height=42> <%if (myface.equals("")) {%> <img src="images/face/<%=RealPic%>"> 
                        <%}else{%> <img src="../images/myface/<%=myface%>" width=<%=myfacewidth%> height=<%=myfaceheight%>> 
                        <%}%> </td>
                    </tr>
                    <tr> 
                      <td align=left height=17> 
						<img src="images/<%=user.getLevelPic()%>"> 
                        <%=Gender%></td>
                    </tr>
                    <tr> 
                      <td align=left height=54>
					    <lt:Label res="res.label.forum.showtopic" key="rank"/><%=user.getLevelDesc()%><br>
                        <lt:Label res="res.label.forum.showtopic" key="experience"/><%=experience%><br>
                        <lt:Label res="res.label.forum.showtopic" key="credit"/><%=credit%><br>
						<%
						ScoreMgr sm = new ScoreMgr();
						ScoreUnit su = sm.getScoreUnit("gold");
						// out.print(StrUtil.toHtml(su.getName()));
						out.print(su.getName(request));
						%>：<%=user.getGold()%><br>
                        <lt:Label res="res.label.forum.showtopic" key="topic_count"/><%=addcount%> <br>
                        <lt:Label res="res.label.forum.showtopic" key="topic_elite"/><%=user.getEliteCount()%><br>
                        <lt:Label res="res.label.forum.showtopic" key="reg_date"/><%=RegDate%>	<br>
                        <lt:Label res="res.label.forum.showtopic" key="online_status"/><%
						OnlineUserDb ou = new OnlineUserDb();
						ou = ou.getOnlineUserDb(user.getName());
						if (ou.isLoaded())
							out.print(SkinUtil.LoadString(request, "res.label.forum.showtopic", "online_status_yes")); // "在线");
						else
							out.print(SkinUtil.LoadString(request, "res.label.forum.showtopic", "online_status_no")); // "离线");
						%>
                        <%
						if (cfg1.getBooleanProperty("forum.showFlowerEgg")) {
							UserPropDb up = new UserPropDb();
							up = up.getUserPropDb(user.getName());
						%>
                        <BR>
                        <img src="../images/flower.gif">&nbsp;(<%=up.getInt("flower_count")%>)&nbsp;&nbsp;&nbsp; <img src="../images/egg.gif">&nbsp;(<%=up.getInt("egg_count")%>)
                        <%}
						%></td>
                    </tr>
                  </tbody>
                </table>
            <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center"><br>
                  <%
				  	if (rootid==id) {
						// 当为根贴时可置为被锁定
						String toptitle="",locktitle="",elitetitle="",guidetitle="";
						int dotop = (lylevel==MsgDb.LEVEL_TOP_BOARD)?0:MsgDb.LEVEL_TOP_BOARD;
						if (dotop==MsgDb.LEVEL_TOP_BOARD)
							toptitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "top_board"); // "版块置顶";
						else
							toptitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "top_none"); // "取消置顶";
						
						int dolock = (islocked==1)?0:1;
						if (dolock==1)
							locktitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "lock"); // "锁定";
						else
							locktitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "unlock"); // "解锁";
						int doelite = (iselite==1)?0:1;
						if (doelite==1)
							elitetitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "elite"); // "置为精华";
						else
							elitetitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "elite_not"); // "取消精华";
						
						if (privilege.isMasterLogin(request)) {
							// 全局置顶
							String alltoptitle="";
							int doalltop = (lylevel==MsgDb.LEVEL_TOP_FORUM)?MsgDb.LEVEL_TOP_BOARD:MsgDb.LEVEL_TOP_FORUM;
							if (doalltop==MsgDb.LEVEL_TOP_FORUM)
								alltoptitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "top_forum"); // "论坛置顶";
							else
								alltoptitle = SkinUtil.LoadString(request, "res.label.forum.showtopic", "top_board"); // "版块置顶";
						%>
                      <a title="<%=toptitle%>" href="manager/manage.jsp?privurl=<%=privurl%>&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>&action=setOnTop&id=<%=id%>&value=<%=doalltop%>"><img height=15 alt="<%=alltoptitle%>" src="images/top_forum.gif" width=15 border=0></a>&nbsp;
                      <%}%>
                      <a title="<%=toptitle%>" href="manager/manage.jsp?privurl=<%=privurl%>&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>&action=setOnTop&id=<%=id%>&value=<%=dotop%>"><img height=15 alt="<%=toptitle%>" src="images/f_top.gif" width=15 border=0></a>&nbsp;
					  <a href="manager/manage.jsp?privurl=<%=privurl%>&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>&action=setLocked&id=<%=id%>&value=<%=dolock%>"><img height=15 alt="<%=locktitle%>" src="images/f_locked.gif" width=17 border=0></a>&nbsp;
					  <a title="<%=elitetitle%>" href="manager/manage.jsp?privurl=<%=privurl%>&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>&action=setElite&id=<%=id%>&value=<%=doelite%>"><img alt="<%=elitetitle%>" src="images/topicgood.gif" border=0></a>&nbsp;
					  <a href="manager/changecolor.jsp?id=<%=id%>"><img src="images/color.gif" alt="<lt:Label res="res.label.forum.showtopic" key="change_color"/>" width="18" height="18" border="0"></a>&nbsp;
					  <a title="<lt:Label res="res.label.forum.showtopic" key="change_board"/>" href="manager/changeboard.jsp?privurl=<%=privurl%>&title=<%=StrUtil.UrlEncode(topic,"utf-8")%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>&id=<%=id%>"><img src="images/zhuan.gif" width="16" height="16" border="0"></a>
                      <%}%>
					  </td>
              </tr>
            </table></td>
          <td width=9 height=126 rowspan="2" align=middle valign=bottom> 
            <table height="100%" cellspacing=0 cellpadding=0 width=1 bgcolor="<%=skin.getTableBorderClr()%>">
              <tbody> 
              <tr> 
                <td width=1></td>
              </tr>
              </tbody>
            </table>          </td>
          <td valign=top align=left height=106> 
            <table style="TABLE-LAYOUT: fixed;WORD-BREAK: break-all" 
            height="100%" cellspacing=0 cellpadding=0 width="99%" border=0>
                  <tbody>
                    <tr height=20> 
                      <td> <a name=#content<%=id%>></a> <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name,"utf-8")%>"> 
                        <img src="images/profile.gif" alt="<%=StrUtil.toHtml(user.getNick())%><lt:Label res="res.label.forum.showtopic" key="user_info"/>" 
                  border=0 align="absmiddle"></a>&nbsp;&nbsp;&nbsp;<a 
                  href="#" onClick="hopenWin('../message/send.jsp?receiver=<%=StrUtil.UrlEncode(name,"utf-8")%>',320,260)"><img src="images/pm.gif" alt="<lt:Label res="res.label.forum.showtopic" key="send_short_msg"/><%=StrUtil.toHtml(user.getNick())%>" 
                  border=0 align="absmiddle"></a>&nbsp;&nbsp;&nbsp;<a href="mailto:<%=StrUtil.toHtml(email)%>"><img src="images/email.gif" 
                  alt=<lt:Label res="res.label.forum.showtopic" key="send_email"/><%=user.getNick()%> border=0 align="absmiddle"></a>&nbsp;&nbsp; <a 
                  href="javascript:copyText(document.all.topiccontent);"><img 
                  src="images/copy.gif" alt=<lt:Label res="res.label.forum.showtopic" key="topic_copy"/> border=0 align="absmiddle"></a>&nbsp;&nbsp; 
                        <a href="addreply_new.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>&hit=<%=hit%>&replyid=<%=id%>&quote=1&privurl=<%=privurl%>" class="normal"><IMG src="images/reply.gif" alt=<lt:Label res="res.label.forum.showtopic" key="topic_quote"/> 
                  border=0 align="absmiddle"></A>&nbsp;&nbsp; 
                        <% if (islocked==0) { %>
                        <a href="addreply_new.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>&hit=<%=hit%>&replyid=<%=id%>&privurl=<%=privurl%>"><img src="images/replynow.gif" 
                  alt=<lt:Label res="res.label.forum.showtopic" key="topic_reply"/> 
                  border=0 align="absmiddle"></a> 
                        <% } %>
				<%if (!user.getHome().equals("")) {%>		
				&nbsp;&nbsp;<a href="<%=user.getHome()%>" target="_blank"><img alt="<lt:Label res="res.label.forum.showtopic" key="home"/>" src="images/home.gif" width="16" height="16" border="0" align="absmiddle"></a>
				<%}%>						
				<%if (Global.hasBlog) {%>&nbsp;&nbsp;<a title="<lt:Label res="res.label.forum.showtopic" key="blog"/>" href="../blog/myblog.jsp?userName=<%=StrUtil.UrlEncode(name)%>"><img src="images/favorite.gif" border="0" align="absmiddle"></a>
                    <%if (cfg1.getBooleanProperty("forum.isShowQQ") && !user.getOicq().equals("")) {%>
                    &nbsp;&nbsp;<a title="<lt:Label res="res.label.forum.showtopic" key="send_qq_msg"/><%=user.getName()%>" href="http://wpa.qq.com/msgrd?V=1&amp;Uin=<%=user.getOicq()%>&amp;Site=By CWBBS&amp;Menu=yes" target="_blank"><img src="http://wpa.qq.com/pa?p=1:<%=user.getOicq()%>:4" align="absmiddle" border="0"></a>
                    <%}%>
&nbsp;                    <a href="#<%=id%>"><lt:Label res="res.label.forum.showtopic" key="position"/></a>
					<%}%>					</td>
                    </tr>
                    <tr height=8> 
                      <td> <hr width="100%" color="<%=skin.getTableBorderClr()%>" size=1>                      </td>
                    </tr>
                    <tr>
                      <td height="30">
						<%=render.RenderTitle(request, msgdb)%>
					  </td>
                    </tr>
                    <tr valign=top> 
                      <td>                        <%
if (vplugin.size()>0) {
	Iterator irplugin = vplugin.iterator();
	while (irplugin.hasNext()) {
		PluginUnit pu = (PluginUnit)irplugin.next();
		IPluginUI ipu = pu.getUI(request, response, out);
		IPluginViewShowMsg pv = ipu.getViewShowMsg(boardcode, msgdb);
		if (pv.IsPluginBoard()) {
			boolean isShow = false;
			if (pu.getType().equals(pu.TYPE_BOARD))
				isShow = true;
			else if (pu.getType().equals(pu.TYPE_TOPIC)) {
				if (pu.getUnit().isPluginMsg(msgdb.getId()))
					isShow = true;
			}
			if (isShow)
				out.print(pu.getName(request) + "&nbsp;" + pv.render(UIShowMsg.POS_BEFORE_MSG) + "<BR>");
		}
	}
}
%>
                        <table width="99%" height="120"  border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td valign="top">
<%
				MsgPollDb mpd = null;
				mpd = render.RenderVote(request, msgdb);
				if (type==1 && mpd!=null) {%>
				<table width="100%" border="1" cellpadding="4" cellspacing="0" borderColor="<%=skin.getTableBorderClr()%>">
				<%
					String ctlType = "radio";
					if (mpd.getInt("max_choice")>1)
						ctlType = "checkbox";
					Vector options = mpd.getOptions(msgdb.getId());
					int len = options.size();
					String showVoteUser = ParamUtil.get(request, "showVoteUser");
					
					int[] re = new int[len];
					int[] bfb = new int[len];
					int total = 0;
					int k = 0;
					for (k=0; k<len; k++) {
						MsgPollOptionDb opt = (MsgPollOptionDb)options.elementAt(k);					
						re[k] = opt.getInt("vote_count");
						total += re[k];
					}
					if (total!=0) {
						for (k=0; k<len; k++) {
							bfb[k] = (int)Math.round((double)re[k]/total*100);
						}
					}
					%>
                    <form action="vote.jsp?privurl=<%=privurl%>" name=formvote method="post">
						<tr>
						  <td colspan="2" bgcolor="#EBECED">
						  <b><lt:Label res="res.label.forum.showtopic" key="vote"/>
						  <%
						  java.util.Date epDate = mpd.getDate("expire_date");
						  if (epDate!=null) {%>
						  	&nbsp;<lt:Label res="res.label.forum.showtopic" key="vote_expire_date"/>
						  	&nbsp;<%=ForumSkin.formatDate(request, epDate)%>
						  <%}%>
						  <%if (mpd.getInt("max_choice")==1) {%>
						  	<lt:Label res="res.label.forum.showtopic" key="vote_type_single"/>
						  <%}else{%>
						  	<lt:Label res="res.label.forum.showtopic" key="vote_type_multiple"/><%=mpd.getInt("max_choice")%>
						  <%}%>
						  </b></td>
						</tr>
						<tr>
					<%
					int barId = 0;
					for (k=0; k<len; k++) {
						MsgPollOptionDb opt = (MsgPollOptionDb)options.elementAt(k);
					%>
					<td width="46%">
                        <%=k+1%>.
                        <input type="<%=ctlType%>" name=votesel value="<%=k%>">
						&nbsp;<%=opt.getString("content")%></td>
					<td width="54%"><img src=images/vote/bar<%=barId%>.gif width="<%=bfb[k]-8%>%" height=10>&nbsp;&nbsp;<strong><%=re[k]%>
					  <lt:Label res="res.label.forum.showtopic" key="vote_unit"/>
					</strong>&nbsp;<%=bfb[k]%>%
						<%
						if (showVoteUser.equals("1")) {
							String[] userAry = StrUtil.split(opt.getString("vote_user"), ",");
							if (userAry!=null) {
								int userLen = userAry.length;
								String userNames = "";
								for (int n=0; n<userLen; n++) {
									UserDb ud = um.getUser(userAry[n]);
									if (userNames.equals(""))
										userNames = ud.getNick();
									else
										userNames += ",&nbsp;" + ud.getNick();
								}
								out.print(userNames);
							}
						}
						%>
						</td>
						</tr>
  					<%
						barId ++;
						if (barId==10)
							barId = 0;				
					}%>
					<tr><td colspan="2" align="center"><input name="button" type="button" onClick="window.location.href='?rootid=<%=rootid%>&showid=<%=showid%>&showVoteUser=1'" value="<lt:Label res="res.label.forum.showtopic" key="vote_show_user"/>">
					  &nbsp;
					<%
					if (epDate!=null) {
						if (DateUtil.compare(epDate, new java.util.Date()) == 1) {
					%>
						<input value="<lt:Label res="res.label.forum.showtopic" key="vote"/>" type="submit">
						<%}else{%>
						<b>
						<lt:Label res="res.label.forum.showtopic" key="vote_end"/>
						</b>
						<%}
					}else{%>
						<input value="<lt:Label res="res.label.forum.showtopic" key="vote"/>" type="submit">
					<%}%>					
					<input type=hidden name=boardcode value="<%=boardcode%>">
                    <input type=hidden name=boardname value="<%=boardname%>">
                    <input type=hidden name=voteid value="<%=id%>">
					</td>
					</tr>
                      </form>
				</table>
				 <%}%>							
				<%if (msgdb.isRootMsg()) {%>
					<ad:AdTag type="<%=AdDb.TYPE_TOPIC_RIGHT%>" boardCode="<%=boardcode%>"></ad:AdTag>
				<%}%>					
					<span id="topiccontent" name="topiccontent">
                    <%
					if (!msgdb.getPlugin2Code().equals("")) {
						Plugin2Mgr p2m = new Plugin2Mgr();
						Plugin2Unit p2u = p2m.getPlugin2Unit(msgdb.getPlugin2Code());
						out.print(p2u.getUnit().getRender().rend(request, msgdb));
					}					
					out.print(render.RenderContent(request, msgdb));
					// if (msgdb.getIsWebedit()==msgdb.WEBEDIT_REDMOON) {
						String att = render.RenderAttachment(request, msgdb);
						out.print(att);
					// }					
					%>
                            </span></td>
                          </tr>
                        </table>
                        <span name="topiccontent">                        </span>  
                        <table width="99%"  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><%
				if (!sign.equals("")) {
					out.print("<font color=#777777>----------------------------------------------</font><BR>");
					sign = StrUtil.toHtml(sign);
					if (cfg1.getBooleanProperty("forum.sign_ubb"))
						out.print(StrUtil.ubb(request, sign, true));
					else
						out.print(sign);
				}
				%>                            </td>
                          </tr>
                      </table></td>
                    </tr>
                  </tbody>
                </table></td>
        </tr>
        <tr bgcolor=#ffffff>
          <td align="center"><%
			String ip = "";
			if (privilege.isMasterLogin(request))
	            ip=msgdb.getIp();
			else
				ip = SkinUtil.LoadString(request, "res.label.forum.showtopic", "ip_view_not"); // "您无权察看";
          %>
            <img src="images/system.gif" alt="IP：<%=ip%>" align="absmiddle"> <%=lydate%></td>
          <td align=right>
			<hr width="100%" color="<%=skin.getTableBorderClr()%>" size=1>
		<%if (privilege.isMasterLogin(request)) {%>
			IP: <%=msgdb.getIp()%>&nbsp;
		<%}%>			
			<%
		  String editpage = "edittopic_new.jsp";
		  if (iswebedit==MsgDb.WEBEDIT_UBB) {
		  	editpage = "edittopic.jsp";
		  } else if (iswebedit==MsgDb.WEBEDIT_REDMOON) {
		  	editpage = "edittopic_we.jsp";
		  }
		  String mstr = "<a href='addfriend.jsp?friend=" + StrUtil.UrlEncode(name) + "'>" + SkinUtil.LoadString(request, "res.label.forum.showtopic", "add_friend") + "</a>";
		  mstr += "<a href='myfavoriate.jsp?op=add&privurl=" + privurl + "&id=" + rootid + "'>" + SkinUtil.LoadString(request, "res.label.forum.showtopic", "add_favoriate") + "</a>";
		  mstr += "<a href=" + editpage + "?boardcode=" + StrUtil.UrlEncode(boardcode) + "&editid=" + id + "&privurl=" + privurl + ">" + SkinUtil.LoadString(request, "res.label.forum.showtopic", "topic_edit") + "</a>";
		  mstr += "<a onClick=checkclick('" + SkinUtil.LoadString(request, "res.label.forum.showtopic", "topic_del_confirm") + "') href=deltopic.jsp?" + "boardcode=" + StrUtil.UrlEncode(boardcode) + "&delid=" + id + "&privurl=" + privurl + ">" + SkinUtil.LoadString(request, "res.label.forum.showtopic", "topic_del") + "</a>";
		  %>
            <a class="nav" href='#' onMouseOver="showmenu(event, &quot;<%=mstr%>&quot;, 0)"><img src="images/edit.gif" border=0 align="absmiddle"></a></td>
        </tr>
        </tbody>
      </table>
    </td>
  </tr>
  </tbody>
</table>
<%
if (showid==rootid) {
	rootMsgDb.increaseHit();
}

String sql = "";
// sql = "select id from sq_message where rootid=" + rootid + " ORDER BY orders";
sql = SQLBuilder.getShowtopictreeSql(rootid);
long totalMsg = msgdb.getMsgCount(sql, boardcode, rootid);
MsgBlockIterator irmsg = msgdb.getMsgs(sql, boardcode, rootid, 0, totalMsg);

int layer = 1;
int i = 1;
if (irmsg.hasNext())
{
// 写根贴
MsgDb md = (MsgDb) irmsg.next();
id = md.getId();
topic = md.getTitle();
hit = md.getHit();
%>
<script language="JavaScript">
spanhit.innerHTML = '<%=hit%>';
</script>
<table bordercolor=#edeced cellspacing=0 cellpadding=1 width="98%" align=center border=1>
  <tbody> 
  <tr> 
    <td noWrap align=left bgcolor=#f8f8f8 height="21" width="3%">
	<img src="images/1.gif" border=0>
	</td>
    <td noWrap align=left bgcolor=#f8f8f8 height="21" width="97%">
	<a name=#<%=id%>></a>
	<% if (id!=showid) { %>
	<a href="<%=ForumPage.getShowTopicPage(request, 1, rootid, id, 1, "")%>"><%=StrUtil.toHtml(topic)%></a></td>
	<% } else { %>
	<font color=red><%=StrUtil.toHtml(topic)%></font>
	<% }%> 
  </tr>
  </tbody> 
</table>
<%
}
		// 写跟贴
		while (irmsg.hasNext())
		{
		  i++;
		  MsgDb md = (MsgDb) irmsg.next();
		  
		  id = md.getId();
		  name = md.getName();
		  layer = md.getLayer();
		  topic = md.getTitle();
		  content = md.getContent();
		  lydate = com.redmoon.forum.ForumSkin.formatDateTime(request, md.getAddDate());
	  %>
<table cellspacing=0 cellpadding=0 width="98%" align=center 
border=0>
  <tbody> 
  <tr> 
    <td noWrap align=left bgcolor=#f8f8f8 height="13" width="3%">&nbsp; </td>
    <td noWrap align=left bgcolor=#f8f8f8 height="13" width="97%"> 
    <%
	layer = layer-1;
	for (int k=1; k<=layer-1; k++)
	{ %>
      <img src="" width=18 height=1> 
      <% }%>
      <img src="images/join.gif" width="18" height="16">
	 <%
	  if (id!=showid) { %>
	  <a href="<%=ForumPage.getShowTopicPage(request, 1, rootid, id, 1, "")%>"><%=StrUtil.toHtml(topic)%></a>
	  <a target="_blank" href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(md.getName())%>"><%=um.getUser(md.getName()).getNick()%></a>&nbsp;&nbsp;[<%=lydate%>]
	  <% } else { %>
	  <font color=red><%=StrUtil.toHtml(topic)%></font><a name="#<%=showid%>"></a>&nbsp;&nbsp;
	  <a href="#content<%=showid%>"><lt:Label res="res.label.forum.showtopic" key="go_topic"/></a>
	  <%}%>
	  </td>
  </tr>
  </tbody> 
</table>
<%
	}
%>
<%if (privilege.isUserLogin(request)) {
	if (privilege.canUserDo(request, boardcode, "reply_topic")) {
%>
<FORM id="frmAnnounce" name="frmAnnounce" onSubmit="return formCheck()" action="addquickreplytodb.jsp?privurl=<%=privurl%>" method=post>
  <TABLE style="BORDER-COLLAPSE: collapse" borderColor=#d3d3d3 height=120 
cellSpacing=0 cellPadding=5 width="98%" align=center border=1>
  <TBODY>
  <TR>
    <TD width=158 background="<%=skinPath%>/images/bg1.gif" height=20 class="text_title">&nbsp;
      <lt:Label res="res.label.forum.showtopic" key="quick_reply"/></TD>
    <TD background="<%=skinPath%>/images/bg1.gif"><B><FONT color=#ffffff>
	</FONT></B>	</TD></TR>
  <TR>
    <TD height=20 colspan="2"><%	
if (vplugin.size()>0) {
	Iterator irplugin = vplugin.iterator();
	while (irplugin.hasNext()) {
		PluginUnit pu = (PluginUnit)irplugin.next();
		IPluginUI ipu = pu.getUI(request, response, out);
		IPluginViewShowMsg pv = ipu.getViewShowMsg(boardcode, msgdb);
		if (pv.IsPluginBoard()) {
			boolean isShow = false;
			if (pu.getType().equals(pu.TYPE_BOARD))
				isShow = true;
			else if (pu.getType().equals(pu.TYPE_TOPIC)) {
				if (pu.getUnit().isPluginMsg(rootMsgDb.getId()))
					isShow = true;
			}
			if (isShow) {		
				if (!pu.getAddReplyPage().equals("")) {
	%>
					<jsp:include page="<%=pu.getAddReplyPage()%>" flush="true">
					<jsp:param name="msgRootId" value="<%=rootid%>" /> 
					<jsp:param name="isQuickReply" value="true" /> 
					</jsp:include>
	<%			}
				else {
					out.print(pu.getName(request) + "&nbsp;" + pv.render(UIShowMsg.POS_QUICK_REPLY_NOTE) + "<BR>");
					out.print(pv.render(UIShowMsg.POS_QUICK_REPLY_ELEMENT) + "<BR>");
				}
			}
		}
	}
}
%></TD>
    </TR>
  <TR bgColor=#ffffff>
    <TD height=20>
      <lt:Label res="res.label.forum.showtopic" key="quick_reply_title"/>    </TD>
    <TD height=20><input name="topic" value="<%=SkinUtil.LoadString(request, "res.label.forum.showtopic", "reply") + StrUtil.toHtml(showtopic)%>" size="40">
        <input type=hidden name="replyid" value="<%=rootid%>">
        <input type=hidden name="boardcode" value="<%=boardcode%>">
          <%
if (cfg1.getBooleanProperty("forum.addUseValidateCode")) {
%>
          <lt:Label res="res.label.forum.showtopic" key="input_validatecode"/>
          <input name="validateCode" type="text" size="1">
<img src='../validatecode.jsp' border=0 align="absmiddle" style="cursor:hand" onClick="this.src='../validatecode.jsp'" alt="<lt:Label res="res.label.forum.index" key="refresh_validatecode"/>">
<%}%>		</TD>
  </TR>
  <TR bgColor=#ffffff>
        <TD width=158 rowspan="3"><iframe src="iframe_browlist.jsp" height="120"  width="98%" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
          <input type="hidden" name="expression" value="25">
          <BR>
          <input type=checkbox value=0 name=show_ubbcode>
          <lt:Label res="res.label.forum.showtopic" key="forbid_ubb"/>
          <BR>
        <INPUT type=checkbox 
      value=0 name=show_smile>
        <lt:Label res="res.label.forum.showtopic" key="forbid_emote"/></TD>
    <TD vAlign=top align=left>
      <TEXTAREA onkeydown=presskey() id=Content name=Content rows=6 cols=79 style="width:615"></TEXTAREA> 
      <BR>      </TD></TR>
  <TR bgColor=#ffffff>
    <TD vAlign=top align=left><iframe src="iframe_emotequick.jsp" height="38" width="615" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe></TD>
  </TR>
  <TR bgColor=#ffffff>
    <TD vAlign=top align=left><input tabindex=4 type=submit value="Ctrl+Enter <lt:Label res="res.label.forum.showtopic" key="reply_topic"/>" name=submit1>
  <input onClick="checkclick('<lt:Label res="res.label.forum.showtopic" key="confirm_clear_content"/>')" type=reset value="<lt:Label res="res.label.forum.showtopic" key="re_write"/>" name=reset></TD>
  </TR>
  </TBODY></TABLE>
  <table cellspacing=0 width="98%" align=center bgcolor=#d3d3d3 border=0>
    <tbody>
      <tr> 
        <td height=1></td>
      </tr>
    </tbody>
  </table>
</FORM>
<%}
}%>
<%@ include file="inc/footer.jsp"%>
</BODY>
</HTML>
