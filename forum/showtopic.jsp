<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin2.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%@ taglib uri="/WEB-INF/tlds/AdTag.tld" prefix="ad"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
long pageBeginTime =  System.currentTimeMillis();

String querystring = StrUtil.getNullString(request.getQueryString());
String privurl = request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring);

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

MsgDb msgdb = new MsgDb();
msgdb = msgdb.getMsgDb(rootid);

if (msgdb.getCheckStatus()==MsgDb.CHECK_STATUS_NOT && !privilege.isMasterLogin(request)) {
	response.sendRedirect("../info.jsp?info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "res.label.forum.showtopic", "check_not")) + "&privurl=" + privurl);	
	return;
}

// 保存下来，以用于快速回复区的插件提示
MsgDb rootMsgDb = msgdb;

if (!msgdb.isLoaded()) {
	out.print(cn.js.fan.web.SkinUtil.makeInfo(request, SkinUtil.LoadString(request, "res.label.forum.showtopic", "topic_lost"))); // "该贴已不存在！"));
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

String boardname = msgLeaf.getName();

UserSession.setBoardCode(request, boardcode);

// 取得皮肤路径
String skincode = msgLeaf.getSkin();
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
<HTML>
<HEAD>
<TITLE><%=msgdb.getTitle()%> - <%=Global.AppName%> <%=seoTitle%></TITLE>
<%=seoHead%>
<META http-equiv=Content-Type content=text/html; charset=utf-8>
<META name="keywords" content="<%=seoKeywords%>">
<META name="description" content="<%=StrUtil.toHtml(seoDescription)%>">
<LINK href="<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
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
	var zoom = parseInt(o.style.zoom, 10)||100; // 如果parsInt的结果为NaN，则zoom的值为100
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
function checkclick(msg)
{
	if(confirm(msg))
		event.returnValue=true;
	else
		event.returnValue=false;
}

function copyText(obj) {
	var rng = document.body.createTextRange();
	rng.moveToElementText(obj);
	rng.select();
	rng.execCommand('Copy');
}

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
<META content="MSHTML 6.00.2800.1126" name=GENERATOR>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></HEAD>
<BODY text=#000000 vLink=#000000 aLink=#000000 link=#000000 bgColor=#ffffff leftMargin=0 marginwidth="0">
<%@ include file="inc/header.jsp"%>
<jsp:include page="inc/position.jsp" flush="true">
<jsp:param name="boardcode" value="<%=StrUtil.UrlEncode(boardcode)%>" /> 
</jsp:include>
<ad:AdTag type="<%=AdDb.TYPE_TEXT%>" boardCode="<%=boardcode%>"></ad:AdTag>
<ad:AdTag type="<%=AdDb.TYPE_FLOAT%>" boardCode="<%=boardcode%>"></ad:AdTag>
<ad:AdTag type="<%=AdDb.TYPE_COUPLE%>" boardCode="<%=boardcode%>"></ad:AdTag>
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
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice"/>
<%
// 刷新在位时间
userservice.refreshStayTime(request, response);

String sqlt = "select id from sq_thread where boardcode=" + StrUtil.sqlstr(boardcode)+"  ORDER BY msg_level desc,redate desc";
ThreadBlockIterator irthread = msgdb.getThreads(sqlt, boardcode, 0, 200);
irthread.setIndex(msgdb);

UserMgr um = new UserMgr();

PluginMgr pmnote = new PluginMgr();
Vector vplugin = pmnote.getAllPluginUnitOfBoard(boardcode);
if (vplugin.size()>0) {
	Iterator irpluginnote = vplugin.iterator();
	while (irpluginnote.hasNext()) {
		PluginUnit pu = (PluginUnit)irpluginnote.next();
		IPluginUI ipu = pu.getUI(request, response, out);
		IPluginViewShowMsg pv = ipu.getViewShowMsg(boardcode, msgdb);
		String note = pv.render(UIShowMsg.POS_NOTE);
		if (pv.IsPluginBoard() && !note.equals("")) {
	%>
	<TABLE borderColor="<%=skin.getTableBorderClr()%>" height=25 cellSpacing=0 cellPadding=1 rules=rows 
	width="98%" align=center bgColor=#ffffff border=1 class="table_normal">
	  <TBODY>
		<TR>
		  <TD><!--plugin rule-->
			<%out.print(pu.getName(request) + "&nbsp;" + note + "<BR>");%>
		  </TD>
		</TR>
	  </TBODY>
	</TABLE><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr><td height="5"></td></tr>
	</table>
	<%
		}
		boolean isShow = false;
		if (pu.getType().equals(pu.TYPE_BOARD))
			isShow = true;
		else if (pu.getType().equals(pu.TYPE_TOPIC)) {
			if (pu.getUnit().isPluginMsg(msgdb.getId()))
				isShow = true;
		}
		if (isShow)		
			pv.render(UIShowMsg.POS_AFTER_NOTE);	
	}
}%>
<%
		String showUserName = ParamUtil.get(request, "showUserName");
		String sql = SQLBuilder.getShowtopicSql(request, response, out, rootMsgDb, showUserName);	// "select id from sq_message where rootid=" + rootid + " ORDER BY lydate asc"; //orders"; 这样会使得顺序上不按时间，平板式时会让人觉得奇怪

		int pagesize = 10;

	    long totalmsg = msgdb.getMsgCount(sql, boardcode, rootid);
		
		ForumPaginator paginator = new ForumPaginator(request, totalmsg, pagesize);
		int curpage = paginator.getCPage(request);
		//设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0) {
			curpage = 1;
			totalpages = 1;
		}
		
		int start = (curpage-1)*pagesize;
		int end = curpage*pagesize;
		
        MsgBlockIterator irmsg = msgdb.getMsgs(sql, boardcode, rootid, start, end);
%>
<TABLE cellSpacing=0 cellPadding=0 width="98%" align=center border=0>
  <TBODY>
  <TR>
      <TD width="40%" height=35 align="left">
		<%
		String addpage = "addtopic_new.jsp";
		String replypage = "addreply_new.jsp";
		if (msgLeaf.getWebeditAllowType()==Leaf.WEBEDIT_ALLOW_TYPE_REDMOON_FIRST) {
			addpage = "addtopic_we.jsp";
			replypage = "addreply_we.jsp";
		}
		%>	  
	  <a href="<%=addpage%>?boardcode=<%=boardcode%>&privurl=<%=privurl%>"><img 
            src="<%=skinPath%>/images/post_<%=SkinUtil.getLocale(request)%>.gif" border=0 width=99 height=25 alt="<lt:Label res="res.label.forum.showtopic" key="addtopic"/>"></a>
			<a href="<%=replypage%>?boardcode=<%=boardcode%>&replyid=<%=rootid%>&privurl=<%=privurl%>"> <img height=25 src="<%=skinPath%>/images/newreply_<%=SkinUtil.getLocale(request)%>.gif" width=99 border=0 alt="<lt:Label res="res.label.forum.showtopic" key="addreply"/>"></a>
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
			Vector vplugin2 = msgLeaf.getAllPlugin2();
			Iterator irplugin2 = vplugin2.iterator();
			while (irplugin2.hasNext()) {
				com.redmoon.forum.plugin2.Plugin2Unit p2u = (com.redmoon.forum.plugin2.Plugin2Unit)irplugin2.next();
			%>
				<a href="<%=addpage%>?plugin2Code=<%=p2u.getCode()%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&privurl=<%=privurl%>"><img src="<%=skinPath + "/images/" + p2u.getButton()%>_<%=SkinUtil.getLocale(request)%>.gif" border="0"></a>
        	<%}%>	  </TD>
      <TD width="27%" height="35" align="center"><lt:Label res="res.label.forum.showtopic" key="hit_begin"/> <b><span id="spanhit" name="spanhit"><%=rootMsgDb.getHit() + 1%></span></b><lt:Label res="res.label.forum.showtopic" key="hit_end"/>&nbsp;&nbsp;<a href="<%=ForumPage.getShowTopicPage(request, 1, rootid, rootid, 1, "")%>" title="<lt:Label res="res.label.forum.showtopic" key="tree_view"/>"><img border=0 src="images/treeview.gif"></a>&nbsp;&nbsp;
        <%
		if (irthread.hasPrevious()) {
			MsgDb prevMsg = (MsgDb)irthread.previous();
			irthread.next();
		%>
			<A href="<%=ForumPage.getShowTopicPage(request, prevMsg.getId())%>"><IMG alt=<lt:Label res="res.label.forum.showtopic" key="show_pre"/> src="images/prethread.gif" border=0></A>
	  	<%}%>&nbsp;&nbsp;
        <A href="javascript:location.reload()"><IMG alt=<lt:Label res="res.label.forum.showtopic" key="refresh"/> src="images/refresh.gif" border=0></A>
        &nbsp;
        <%if (irthread.hasNext()) {
        	MsgDb nextMsg = (MsgDb)irthread.next();
		%>
        	<A href="<%=ForumPage.getShowTopicPage(request, nextMsg.getId())%>"><IMG alt=<lt:Label res="res.label.forum.showtopic" key="show_after"/> src="images/nextthread.gif" border=0></A>
        <%}else{%>
        	&nbsp;
        <%}%></TD>
      <TD width="33%" align="right"><%
      out.print(paginator.getShowTopicCurPageBlock(request, rootid, "up"));
	%></TD>
  </TR></TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="98%" align=center bgColor=#d3d3d3 
border=0>
  <TBODY>
  <TR>
    <TD>
      <TABLE cellSpacing=1 cellPadding=6 width="100%" border=0>
        <TBODY></TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE borderColor="<%=skin.getTableBorderClr()%>" cellSpacing=0 background="<%=skinPath%>/images/bg1.gif" cellPadding=0 width="98%" align=center 
border=1>
  <TBODY>
  <TR>
    <TD height=26>
      <TABLE width="100%" height="26" border="0" cellpadding="0" cellspacing="0">
        <TBODY>
        <TR>
          <TD>　<B><span class="text_title"><lt:Label res="res.label.forum.showtopic" key="topic"/></span></B><span id=spanroottopic name=spanroottopic class="text_title"><%=StrUtil.toHtml(rootMsgDb.getTitle())%></span></TD>
              <TD align=right>
			  <%
			  String allclr = "#ffffff";
			  String rootclr = "#ffffff";
			  if (showUserName.equals(rootMsgDb.getName())) {
			  	rootclr = "yellow";
			  }
			  else {
			  	allclr = "yellow";
			  }
			  %>
			  <a href="showtopic.jsp?rootid=<%=rootid%>"><font color="<%=allclr%>">[<lt:Label res="res.label.forum.showtopic" key="all_user"/>]</font></a> <a href="showtopic.jsp?rootid=<%=rootid%>&showUserName=<%=StrUtil.UrlEncode(rootMsgDb.getName())%>"><font color="<%=rootclr%>">[<lt:Label res="res.label.forum.showtopic" key="root_user"/>]</font></a> <A href="javascript:window.print()"><FONT 
            color=#ffffff>[<lt:Label res="res.label.forum.showtopic" key="print"/>]</FONT></A> <A 
            href="javascript:window.external.AddFavorite(location.href,document.title)"><FONT 
            color=#ffffff>[<lt:Label res="res.label.forum.showtopic" key="favoriate"/>]</FONT></A> </TD>
        </TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<%
// 取得显示设置
BoardRenderDb boardRender = new BoardRenderDb();
boardRender = boardRender.getBoardRenderDb(boardcode);
IPluginRender render = boardRender.getRender();

String name="",lydate="",content="",topic="";
String RegDate="",Gender="",RealPic="",email="",sign="",myface="";
int experience=0;
int addcount=0;
long id;
int credit=0;
int islocked=0,iselite=0,lylevel=0,isguide=0;
int type=0;
int myfacewidth=120,myfaceheight=150;
int show_ubbcode=1,show_smile=1;
int iswebedit = 0;
int i = 0;
Vector v_ad = AdDb.getADOnBoard(boardcode, AdDb.TYPE_TOPIC_BOTTOM);
int ad_count = 0;
while (irmsg.hasNext()) {
	  msgdb = (MsgDb)irmsg.next();
	  i++;
	  id = msgdb.getId();
	  name = msgdb.getName();
	  topic = msgdb.getTitle();
	  content = msgdb.getContent();
	  lydate = com.redmoon.forum.ForumSkin.formatDateTime(request, msgdb.getAddDate());
	  type = msgdb.getType();
	  islocked = msgdb.getIsLocked();
	  iselite = msgdb.getIsElite();
	  lylevel = msgdb.getLevel();
	  iswebedit = msgdb.getIsWebedit();
	  show_ubbcode = msgdb.getShowUbbcode();
	  show_smile = msgdb.getShowSmile();

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
		myface = StrUtil.getNullString(user.getMyface());
		myfacewidth = user.getMyfaceWidth();
		myfaceheight = user.getMyfaceHeight();
%>
<TABLE borderColor="<%=skin.getTableBorderClr()%>" cellSpacing=0 cellPadding=0 width="98%" align=center border=1>
  <TBODY>
  <TR>
    <TD vAlign=top align=left height=78>
      <TABLE cellSpacing=0 cellPadding=3 width="100%" border=0>
        <TBODY>
        <TR>
              <TD vAlign=top width=150 height=106> <table cellspacing=0 cellpadding=0 width="80%" align=center 
border=0>
                  <tbody>
                    <tr> 
                      <td align=left> <table style="FILTER: glow(color=a4b6d7)">
                          <caption>
                          <b><font style="FONT-SIZE: 10pt" color=#ffffff><%=user.getNick()%></font></b>
                          </caption>
                        </table>
						<%
						  UserGroupDb ugd = user.getUserGroupDb();
						  if (!ugd.getCode().equals(UserGroupDb.EVERYONE)) {
						  	out.print("<table><tr><td>" + ugd.getDesc() + "</td></tr></table>");
						  }
						%>
                      </td>
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
							<BR><img src="../images/flower.gif">&nbsp;(<%=up.getInt("flower_count")%>)&nbsp;&nbsp;&nbsp;
							<img src="../images/egg.gif">&nbsp;(<%=up.getInt("egg_count")%>)
						<%}
						%>
					  </td>
                    </tr>
                  </tbody>
                </table>
                <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td align="center">
						<% 
						if (rootid==id) { // 当为根贴时可置为被锁定
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
                      <%}%></td>
                  </tr>
                </table></TD>
          <TD width=9 height=126 rowspan="2" align=middle vAlign=bottom>
            <TABLE height="100%" cellSpacing=0 cellPadding=0 width=1 
            bgColor="<%=skin.getTableBorderClr()%>">
              <TBODY>
              <TR>
                <TD width=1></TD></TR></TBODY></TABLE></TD>
          <TD vAlign=top align=left height=106>
            <TABLE style="TABLE-LAYOUT: fixed; WORD-BREAK: break-all" 
            height="100%" cellSpacing=0 cellPadding=0 width="99%" border=0>
              <TBODY> 
              <TR height=20> 
                      <TD colSpan=3> <a name=#<%=id%>></a> 
					  <A href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"> 
                        <IMG src="images/profile.gif" alt=<%=StrUtil.toHtml(user.getNick())%><lt:Label res="res.label.forum.showtopic" key="user_info"/> 
                  border=0 align="absmiddle"></A>&nbsp;&nbsp;&nbsp;<a 
                  href="#" onClick="hopenWin('../message/send.jsp?receiver=<%=StrUtil.UrlEncode(name,"utf-8")%>',320,260)"><img src="images/pm.gif" alt="<lt:Label res="res.label.forum.showtopic" key="send_short_msg"/><%=StrUtil.toHtml(user.getNick())%>" 
                  border=0 align="absmiddle"></a>&nbsp;&nbsp;&nbsp;<A href="mailto:<%=StrUtil.toHtml(email)%>"><IMG src="images/email.gif" 
                  alt="<lt:Label res="res.label.forum.showtopic" key="send_email"/><%=StrUtil.toHtml(user.getNick())%>" border=0 align="absmiddle"></A>&nbsp;&nbsp;&nbsp;<A 
                  href="javascript:copyText(document.all.content<%=i%>);"><IMG 
                  src="images/copy.gif" alt=<lt:Label res="res.label.forum.showtopic" key="topic_copy"/> border=0 align="absmiddle"></A>&nbsp;&nbsp;
				  <a href="addreply_new.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>&replyid=<%=id%>&quote=1&privurl=<%=privurl%>" class="normal"><IMG src="images/reply.gif" alt=<lt:Label res="res.label.forum.showtopic" key="topic_quote"/> 
                  border=0 align="absmiddle"></A>&nbsp;&nbsp;
                        <% if (islocked==0) {%>
                        <a href="addreply_new.jsp?boardcode=<%=boardcode%>&replyid=<%=id%>&privurl=<%=privurl%>"><IMG src="images/replynow.gif" 
                  alt=<lt:Label res="res.label.forum.showtopic" key="topic_reply"/> 
              border=0 align="absmiddle"></A> 
                        <%}%>
				<%if (!user.getHome().equals("")) {%>		
				&nbsp;&nbsp;<a href="<%=user.getHome()%>" target="_blank"><img src="images/home.gif" width="16" alt="<lt:Label res="res.label.forum.showtopic" key="home"/>" height="16" border="0" align="absmiddle"></a>
				<%}%>
                        <%if (Global.hasBlog) {%>&nbsp;&nbsp;<a title="<lt:Label res="res.label.forum.showtopic" key="blog"/>" href="../blog/myblog.jsp?userName=<%=StrUtil.UrlEncode(name)%>"><img src="images/favorite.gif" border="0" align="absmiddle"></a>
              	<%}%>
				<%
				if (cfg1.getBooleanProperty("forum.isShowQQ") && !user.getOicq().equals("")) {%>
				&nbsp;&nbsp;<a title="<lt:Label res="res.label.forum.showtopic" key="send_qq_msg"/><%=user.getName()%>" href="http://wpa.qq.com/msgrd?V=1&amp;Uin=<%=user.getOicq()%>&amp;Site=By CWBBS&amp;Menu=yes" target="_blank"><img src="http://wpa.qq.com/pa?p=1:<%=user.getOicq()%>:4" align="middle" border="0"></a>
				<%}%>
				</TD>
			  </TR>
              <TR height=8> 
                <TD colSpan=3> 
                  <HR width="100%" color="<%=skin.getTableBorderClr()%>" SIZE=1>                </TD>
              </TR>
              <TR> 
                <TD width="21%" height=2>                </TD>
              </TR>			  
              <TR>
                <TD height="30" colSpan=3>
					<%=render.RenderTitle(request, msgdb)%>
              </TR>
              <TR vAlign=top> 
                <TD colSpan=3>
<%
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
<table width="99%" height="140"  border="0" cellpadding="0" cellspacing="0">
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
					String showVoteUser = ParamUtil.get(request, "showVoteUser");
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
					<tr><td colspan="2" align="center"><input type="button" value="<lt:Label res="res.label.forum.showtopic" key="vote_show_user"/>" onClick="window.location.href='?rootid=<%=rootid%>&showVoteUser=1'">
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
				 <span id="content<%=i%>" name="content<%=i%>">
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
                   	</span>
					</td>
                  </tr>
                </table>                  
                <table width="99%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td valign="bottom"><%
				if (!sign.equals(""))
				{
					out.print("<font color=#777777>----------------------------------------------</font><BR>");
					sign = StrUtil.toHtml(sign);
					if (cfg1.getBooleanProperty("forum.sign_ubb"))
						out.print(StrUtil.ubb(request, sign, true));
					else
						out.print(sign);
					//out.print("<BR><font color=#777777>----------------------------------------------</font><BR>");
				}
				%></td>
                          </tr>
                        </table>                      </TD>
              </TR>
              <TR vAlign=top height=20>
                <TD colspan="3"></TD>
                </TR>
              </TBODY> 
            </TABLE>          </TD></TR>
        <TR bgColor=#ffffff>
          <TD align="center"><%
			String ip = "";
			if (privilege.isMasterLogin(request))
	            ip=msgdb.getIp();
			else
				ip = SkinUtil.LoadString(request, "res.label.forum.showtopic", "ip_view_not"); // "您无权察看";
          %>
            <img src="images/system.gif" alt="IP：<%=ip%>" align="absmiddle"> <%=lydate%></TD>
          <TD align=right>
			<hr width="100%" color="<%=skin.getTableBorderClr()%>" size=1>		  
		    <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="76%">
				<%
				if (v_ad.size()>0) {
					if (ad_count < v_ad.size()) {
						AdDb ad = (AdDb)v_ad.get(ad_count);
						ad_count ++;
						if (ad_count == v_ad.size())
							ad_count = 0;
				%>
					<%=ad.render(request)%>
				<%	}
				}
				%>
				</td>
                <td width="24%" align="right">
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
                  <a class="nav" href='#' onMouseOver="showmenu(event, &quot;<%=mstr%>&quot;, 0)"><img src="images/edit.gif" border=0 align="absmiddle"></a>&nbsp;
                  <%if (msgdb.getReplyid()==-1) {%>
                  <lt:Label res="res.label.forum.showtopic" key="topic_owner"/>
                  <%}else{%>
                  <%=(curpage-1)*pagesize+i%>&nbsp;
                  <lt:Label res="res.label.forum.showtopic" key="topic_floor"/>
                  <%}%>
&nbsp;&nbsp;<a href="#top"><img src="<%=skinPath%>/images/go_top.gif" alt="<lt:Label res="res.label.forum.showtopic" key="go_top"/>" align="absmiddle" border=0></a></td>
              </tr>
            </table>
		    </TD>
        </TR>
        </TBODY></TABLE></TD></TR></TBODY></TABLE>
<%
}
if (paginator.getCurPage()==1) {
	rootMsgDb.increaseHit();
}
%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" class="9black">
  <tr>
    <td height="5" colspan="2" align="left"></td>
  </tr>
  <tr> 
    <td width="12%" height="23" align="left">
	<select name="selboard" onChange="if(this.options[this.selectedIndex].value!=''){location='listtopic.jsp?' + this.options[this.selectedIndex].value;}">
      <option value="" selected><lt:Label res="res.label.forum.showtopic" key="sel_board"/></option>
      <%
LeafChildrenCacheMgr dlcm = new LeafChildrenCacheMgr("root");
java.util.Vector vt = dlcm.getChildren();
Iterator ir = vt.iterator();
while (ir.hasNext()) {
	Leaf leaf = (Leaf) ir.next();
	String parentCode = leaf.getCode();
	if (leaf.getIsHome()) {
%>
      <option style="BACKGROUND-COLOR: #f8f8f8" value="">╋ <%=leaf.getName()%></option>
      <%
	LeafChildrenCacheMgr dl = new LeafChildrenCacheMgr(parentCode);
	java.util.Vector v = dl.getChildren();
	Iterator ir1 = v.iterator();
	while (ir1.hasNext()) {
		Leaf lf = (Leaf) ir1.next();
%>
      <option value="boardcode=<%=StrUtil.UrlEncode(lf.getCode(),"utf-8")%>&boardname=<%=StrUtil.UrlEncode(lf.getName(),"utf-8")%>">　├『<%=lf.getName()%>』</option>
      <%}
	  }
}%>
    </select></td>
    <td width="88%" height="23" align="right" valign="baseline"><%
      out.print(paginator.getShowTopicCurPageBlock(request, rootid, "down"));
	%>    </td>
  </tr>
</table>
<%
if (privilege.isUserLogin(request)) {
	if (privilege.canUserDo(request, boardcode, "reply_topic")) {
%>
<BR>
<TABLE cellSpacing=0 width="98%" align=center bgColor=#d3d3d3 border=0>
  <TBODY>
  <TR>
    <TD height=1></TD></TR></TBODY></TABLE>
<TABLE style="BORDER-COLLAPSE: collapse" borderColor=#d3d3d3 height=120 
cellSpacing=0 cellPadding=5 width="98%" align=center border=1>
  <TBODY>
<FORM name="frmAnnounce" onSubmit="return formCheck()" action="addquickreplytodb.jsp?privurl=<%=privurl%>" method="post">
  <TR>
    <TD background="<%=skinPath%>/images/bg1.gif" width=158 height=26 bgColor=#007dc6 class="text_title">&nbsp; 
      <lt:Label res="res.label.forum.showtopic" key="quick_reply"/></TD>
        <TD background="<%=skinPath%>/images/bg1.gif" height="26" bgcolor="#007dc6">&nbsp; </TD>
    </TR>
  <TR bgColor=#ffffff>
    <TD height=20 colspan="2">
<%	
if (vplugin.size()>0) {
	Iterator irplugin = vplugin.iterator();
	while (irplugin.hasNext()) {
		PluginUnit pu = (PluginUnit)irplugin.next();
		IPluginUI ipu = pu.getUI(request, response, out);
		IPluginViewShowMsg pv = ipu.getViewShowMsg(boardcode, rootMsgDb);
		
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
%>	</TD>
    </TR>
  <TR bgColor=#ffffff>
    <TD height=20>
      <lt:Label res="res.label.forum.showtopic" key="quick_reply_title"/>
    </TD>
    <TD height=20><input name="topic" value="<%=SkinUtil.LoadString(request, "res.label.forum.showtopic", "reply") + StrUtil.toHtml(rootMsgDb.getTitle())%>" size="40">
      <input type=hidden name="replyid" value="<%=rootid%>">
      <input type=hidden name="boardcode" value="<%=boardcode%>">
      <%
if (cfg1.getBooleanProperty("forum.addUseValidateCode")) {
%>
      <lt:Label res="res.label.forum.showtopic" key="input_validatecode"/>
      <input name="validateCode" type="text" size="1">
      <img src='../validatecode.jsp' border=0 align="absmiddle" style="cursor:hand" onClick="this.src='../validatecode.jsp'" alt="<lt:Label res="res.label.forum.index" key="refresh_validatecode"/>">
      <%}%></TD>
  </TR>
  <TR bgColor=#ffffff>
    <TD width="158" rowspan="4">
      &nbsp;&nbsp;<lt:Label res="res.label.forum.showtopic" key="sel_emote"/>
        <iframe src="iframe_browlist.jsp" height="120"  width="98%" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
      <input type="hidden" name="expression" value="25">
      <BR>
          <INPUT 
      type=checkbox value=0 name=show_ubbcode>
          <lt:Label res="res.label.forum.showtopic" key="forbid_ubb"/><BR> 
          <INPUT type=checkbox 
      value=0 name=show_smile>
        <lt:Label res="res.label.forum.showtopic" key="forbid_emote"/></TD>
  <TD>
		<TEXTAREA onkeydown=presskey() name=Content rows=6 cols=79 style="width:610"></TEXTAREA> 
        <BR>      </TD>
  </TR>
  
  <TR bgColor=#ffffff>
    <TD vAlign=top align=left><iframe src="iframe_emotequick.jsp" height="35" width="610" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe></TD>
  </TR>
  <TR bgColor=#ffffff>
    <TD vAlign=top align=left><input tabindex=4 type=submit value="Ctrl+Enter <lt:Label res="res.label.forum.showtopic" key="reply_topic"/>" name=submit1>
  <input onClick="checkclick('<lt:Label res="res.label.forum.showtopic" key="confirm_clear_content"/>')" type=reset value="<lt:Label res="res.label.forum.showtopic" key="re_write"/>" name=reset></TD>
  </TR>
  </TBODY>
  </FORM>
</TABLE>
<%}
}%>
<table width="50%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" align="center"><%
long pageEndTime =  System.currentTimeMillis();
long t = pageEndTime - pageBeginTime;
	%>
        <lt:Label res="res.label.forum.listtopic" key="page_run"/>
        <%=t%>
        <lt:Label res="res.label.forum.listtopic" key="mili_second"/></td>
  </tr>
</table>
<%@ include file="inc/footer.jsp"%>
</BODY>
</HTML>