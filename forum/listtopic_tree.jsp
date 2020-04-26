<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.err.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="org.jdom.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.module.pvg.*" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%@ taglib uri="/WEB-INF/tlds/AdTag.tld" prefix="ad"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
long pageBeginTime =  System.currentTimeMillis();

String boardcode = ParamUtil.get(request, "boardcode");
if (boardcode.equals("")) {
	out.print(StrUtil.Alert_Back(cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.listtopic", "need_board")));
	return;
}

Leaf curleaf = new Leaf();
curleaf = curleaf.getLeaf(boardcode);
if (curleaf==null || !curleaf.isLoaded()) {
	out.print(StrUtil.makeErrMsg(cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.listtopic", "no_board")));
	return;
}

try {
	privilege.checkCanEnterBoard(request, boardcode);
}
catch (ErrMsgException e) {
	response.sendRedirect("../info.jsp?info=" + StrUtil.UrlEncode(e.getMessage()));
	// e.printStackTrace();
	return;
}

String boardname = curleaf.getName();

String strThreadType = ParamUtil.get(request, "threadType");
int threadType = ThreadTypeDb.THREAD_TYPE_NONE;
if (StrUtil.isNumeric(strThreadType)) {
	threadType = Integer.parseInt(strThreadType);
}

UserSession.setBoardCode(request, boardcode);

// 取得皮肤路径
String skincode = curleaf.getSkin();

if (skincode.equals("") || skincode.equals(UserSet.defaultSkin)) {
	skincode = UserSet.getSkin(request);
	if (skincode==null || skincode.equals(""))
		skincode = UserSet.defaultSkin;
}
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
String skinPath = skin.getPath();

String op = StrUtil.getNullString(request.getParameter("op"));

//seo
com.redmoon.forum.util.SeoConfig scfg = new com.redmoon.forum.util.SeoConfig();
String seoTitle = scfg.getProperty("seotitle");
String seoKeywords = scfg.getProperty("seokeywords");
String seoDescription = scfg.getProperty("seodescription");
String seoHead = scfg.getProperty("seohead");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><%=boardname%> - <%=Global.AppName%> <%=seoTitle%></TITLE>
<%=seoHead%>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META name="keywords" content="<%=seoKeywords%>">
<META name="description" content="<%=seoDescription%>">
<style>
<!--
#navDiv {
      float:left;
      width:100%;
      line-height:normal;
      }
#navDiv td {
      float:left;
      background:url("images/tag_l.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
  height:100%;
}
#navDiv span {
      float:left;
      display:block;
      background:url("images/tag_r.gif") no-repeat right top;
      padding:5px 5px 5px 0px;
      color:#FFF;
  height:100%;
  text-align: center;
  vertical-align: middle;
}
#navDiv span {float:none;}
#navDiv a {
color:#FFF;
}
#navDiv .td_hover {
      background-position:0% -42px;
}
#navDiv .td_hover span {
      background-position:100% -42px;
}
#navDiv .header {
      background-position:0% -42px;
  
}
#navDiv .header span {
      background-position:100% -42px;
}
-->
</style>
<LINK href="<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<SCRIPT>
function openWin(url,width,height)
{
  var newwin = window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,top=50,left=120,width="+width+",height="+height);
}

function loadonline(boardcode){
	var targetImg = eval("document.all.followImg000");
	var targetDiv = eval("document.all.followDIV000");
	if (targetImg.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg)){
		if (targetDiv.style.display!='block')
		{
			targetDiv.style.display="block";
			targetImg.src="images/minus.gif";
			advance.innerText="<lt:Label res="res.label.forum.listtopic" key="close_online"/>";
			if (targetImg.loaded=="no")
				document.frames["hiddenframe"].location.replace("online.jsp?boardcode="+boardcode);
		}
		else
		{
			targetDiv.style.display="none";
			targetImg.src="images/plus.gif";
			advance.innerText="<lt:Label res="res.label.forum.listtopic" key="show_online"/>"
		}
	}
}

// 展开帖子
function loadThreadFollow(b_id,t_id,getstr){
	var targetImg2 =eval("document.all.followImg" + t_id);
	var targetTR2 =eval("document.all.follow" + t_id);
	if (targetImg2.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg2)){
		if (targetTR2.style.display!="")
		{
			targetTR2.style.display="";
			targetImg2.src="<%=skinPath%>/images/minus.gif";
		}else{
			targetTR2.style.display="none";
			targetImg2.src="<%=skinPath%>/images/plus.gif";
		}
	}
}
</SCRIPT>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
<style type="text/css">
<!--
#navDiv {      float:left;
      width:100%;
      line-height:normal;
}
-->
</style>
</HEAD>
<BODY leftmargin="0" topMargin=0>
<%@ include file="inc/header.jsp"%>
<%@ include file="inc/position.jsp"%>
<%@ include file="../inc/inc.jsp"%>
<ad:AdTag type="<%=AdDb.TYPE_TEXT%>" boardCode="<%=boardcode%>"></ad:AdTag>
<jsp:useBean id="Topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice" />
<%
String querystring = StrUtil.getNullString(request.getQueryString());
String privurl=request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");

// 登记访客
try {
	privilege.enrolGuest(request,response);
}
catch (UserArrestedException e) {
	response.sendRedirect("info.jsp?info=" + StrUtil.UrlEncode(e.getMessage()));
	return;
}

// 刷新在位时间
userservice.refreshStayTime(request,response);

String timelimit = request.getParameter("timelimit");
if (timelimit==null)
	timelimit = "all";

String brule = StrUtil.getNullString(curleaf.getBoardRule());
if (!brule.equals("")) {%>
<TABLE bordercolor="<%=skin.getTableBorderClr()%>" height=25 cellSpacing=0 cellPadding=2 rules=rows 
width="98%" align=center bgColor=#ffffff border=1 class="table_normal">
  <TBODY>
    <TR>
      <TD><lt:Label res="res.label.forum.listtopic" key="rule"/>
	  <%=brule%>
	  </TD>
    </TR>
  </TBODY>
</TABLE>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>
<%}%>
<%	
PluginMgr pm = new PluginMgr();
Vector vplugin = pm.getAllPluginUnitOfBoard(boardcode);
if (vplugin.size()>0) {
	Iterator irplugin = vplugin.iterator();
	while (irplugin.hasNext()) {
		PluginUnit pu = (PluginUnit)irplugin.next();
		IPluginUI ipu = pu.getUI(request, response, out);
		IPluginViewListThread pv = ipu.getViewListThread(boardcode);
		String rule = pv.render(UIListThread.POS_RULE);
		if (!rule.equals("") && pv.IsPluginBoard()) {
%>
<TABLE bordercolor="<%=skin.getTableBorderClr()%>" height=25 cellSpacing=0 cellPadding=2 rules=rows width="98%" align=center bgColor=#ffffff border=1 class="table_normal">
  <TBODY>
    <TR>
      <TD>
<!--plugin rule--><%out.print(pu.getName(request) + ":&nbsp;" + rule + "<BR>");%>
	  </TD>
    </TR>
  </TBODY>
</TABLE>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>
<%		}
	}
}%>
<%if (curleaf.getChildCount()>0) {
	if (curleaf.getDisplayStyle()==Leaf.DISPLAY_STYLE_VERTICAL) {
%>
  <br>
  <table bordercolor="<%=skin.getTableBorderClr()%>" cellspacing=0 cellpadding=0 width="98%" align=center border=1 class="table_normal">
    <tbody>
      <tr align="left">
        <td height="26" colspan="4" nowrap background="<%=skinPath%>/images/bg1.gif"><span class="text_title">&nbsp; <%=boardname%> </span></td>
      </tr>
      <%
	PluginMgr pmnote = new PluginMgr();
  	MsgDb md = new MsgDb();
	LeafChildrenCacheMgr lccm = new LeafChildrenCacheMgr(boardcode);
	java.util.Vector v3 = lccm.getChildren();
	Iterator ir3 = v3.iterator();
	while (ir3.hasNext()) {
		Leaf lf = (Leaf) ir3.next();
		md = md.getMsgDb(lf.getAddId());
%>
      <tr>
        <td width="49" align="center"><%if (lf.isLocked()) {%>
          <img alt="<lt:Label res="res.label.forum.index" key="board_lock"/>" src="<%=skinPath%>/images/board_lock.gif">
          <%}else{%>
          <%if (lf.getTodayCount()>0) {%>
          <img alt="<lt:Label res="res.label.forum.index" key="board_new"/>" src="<%=skinPath%>/images/board_new.gif">
          <%}else{%>
          <img alt="<lt:Label res="res.label.forum.index" key="board_nonew"/>" src="<%=skinPath%>/images/board_nonew.gif">
          <%}%>
        <%}%></td>
        <td><table width="100%" height="65" border="0" cellpadding="0" cellspacing="0" >
            <tr>
              <td width="47%" height="23">『 <a href="<%=ForumPage.getListTopicPage(request, lf.getCode())%>"><%=lf.getName()%></a> 』
                  <%
Vector vplugin1 = pmnote.getAllPluginUnitOfBoard(lf.getCode());
if (vplugin1.size()>0) {
	out.print("<font color=#aaaaaa>");
	Iterator irpluginnote = vplugin1.iterator();
	while (irpluginnote.hasNext()) {
		PluginUnit pu = (PluginUnit)irpluginnote.next();
		out.print(pu.getName(request) + "&nbsp;");
	}
	out.print("</font>");
}
%>
              </td>
              <td width="23%" rowspan="2" align="right" valign="middle"><%
				  String logo = StrUtil.getNullString(lf.getLogo());
				  if (!logo.equals("")) {
				  %>
                  <img src="images/board_logo/<%=logo%>" align="absmiddle">&nbsp;&nbsp;
                  <%}%>
              </td>
              <td width="30%" rowspan="2"><table width="100%" border="0" cellpadding="0" >
                <tr>
                  <td><lt:Label res="res.label.forum.listtopic" key="topic"/><a href="<%=ForumPage.getShowTopicPage(request, md.getId())%>"><%=md.getTitle()%></a></td>
                </tr>
                <tr>
                  <td><lt:Label res="res.label.forum.listtopic" key="post"/>
                    <%if (md.isLoaded()) {%>
                      <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(md.getName())%>"><%=md.getName()%></a>
                      <%}%>
                  </td>
                </tr>
                <tr>
                  <td><lt:Label res="res.label.forum.listtopic" key="date"/><%=DateUtil.format(md.getAddDate(), "yy-MM-dd HH:mm")%>&nbsp;<img src="images/lastpost.gif" width="11" height="10"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><img src="images/readme.gif" width="10" height="10">&nbsp;<%=lf.getDescription()%> </td>
            </tr>
            <tr>
              <td height="23" colspan="2" bgcolor="#EEEEEE">&nbsp;<lt:Label res="res.label.forum.listtopic" key="manager"/>
                  <%
	  MsgMgr mm = new MsgMgr();
	  Vector managers = mm.getBoardManagers(lf.getCode());
	  Iterator irmgr = managers.iterator();
	  while (irmgr.hasNext()) {
	  	UserDb user = (UserDb) irmgr.next();
	  %>
                  <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(user.getName())%>"><%=user.getName()%></a>&nbsp;
                  <%}%>
              </td>
              <td height="23" valign="center" bgcolor="#EEEEEE">&nbsp;<img alt="<lt:Label res="res.label.forum.listtopic" key="today_post"/>" src="images/Forum_today.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTodayCount()%>&nbsp;&nbsp;<img alt="<lt:Label res="res.label.forum.listtopic" key="topic_count"/>" src="images/Forum_topic.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTopicCount()%>&nbsp;&nbsp;<img src="images/Forum_post.gif" alt="<lt:Label res="res.label.forum.listtopic" key="post_count"/>" width="25" height="10" align="absmiddle">&nbsp;<%=lf.getPostCount()%></td>
            </tr>
        </table></td>
      </tr>
      <%}%>
    </tbody>
</table>
  <br>
<%}else{%>
  <br>
  <table bordercolor="<%=skin.getTableBorderClr()%>" cellspacing=0 cellpadding=0 width="98%" align=center border=1 class="table_normal">
    <tbody>
      <%
	PluginMgr pmnote = new PluginMgr();	
  	MsgDb md = new MsgDb();
	LeafChildrenCacheMgr lccm = new LeafChildrenCacheMgr(boardcode);
	java.util.Vector v3 = lccm.getChildren();
	Iterator ir3 = v3.iterator();
	int colCount = 4;
	int curCol = 0;
	while (ir3.hasNext()) {
		Leaf lf = (Leaf) ir3.next();
		md = md.getMsgDb(lf.getAddId());
		if (curCol==0)
			out.print("<tr>");
%>
        <td><table width="100%" height="65" border="0" cellpadding="0" cellspacing="0" >
            <tr>
              <td width="47%" height="22" align="center">『 <a href="<%=ForumPage.getListTopicPage(request, lf.getCode())%>"><%=lf.getName()%></a> 』
<%
Vector vplugin1 = pmnote.getAllPluginUnitOfBoard(lf.getCode());
if (vplugin1.size()>0) {
	out.print("<font color=#aaaaaa>");
	Iterator irpluginnote = vplugin1.iterator();
	while (irpluginnote.hasNext()) {
		PluginUnit pu = (PluginUnit)irpluginnote.next();
		out.print(pu.getName(request) + "&nbsp;");
	}
	out.print("</font>");
}
%>              </td>
            </tr>
            <tr>
              <td align="center" style="padding:5px">
			      <%
				  String logo = StrUtil.getNullString(lf.getLogo());
				  if (!logo.equals("")) {
				  %>
                <img src="images/board_logo/<%=logo%>" align="absmiddle" alt="<%=lf.getDescription()%>">&nbsp;&nbsp;
              <%}%></td>
            </tr>
            <tr>
              <td height="23" align="center" bgcolor="#EEEEEE">              &nbsp;<img alt="<lt:Label res="res.label.forum.listtopic" key="today_post"/>" src="images/Forum_today.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTodayCount()%>&nbsp;&nbsp;<img alt="<lt:Label res="res.label.forum.listtopic" key="topic_count"/>" src="images/Forum_topic.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTopicCount()%>&nbsp;&nbsp;<img src="images/Forum_post.gif" alt="<lt:Label res="res.label.forum.listtopic" key="post_count"/>" width="25" height="10" align="absmiddle">&nbsp;<%=lf.getPostCount()%></td>
            </tr>
        </table></td>
      <%
	  	curCol++;
	  	if (curCol==colCount) {
		    out.print("</tr>");
			curCol = 0;
		}
	  }
	  int tds = colCount - curCol;
	  if (curCol!=0 && tds!=0) {
	  	for (int k=0; k<tds; k++) {
			out.print("<td>&nbsp;</td>");
		}
		out.print("</tr>");
	  }
	  %>
    </tbody>
</table>
  <br>  
  <%}
}%>
  <TABLE cellSpacing=0 cellPadding=2 width="98%" align=center border=0>
    <TBODY>
      <TR> 
        <TD width="50%"><%
		String addpage = "addtopic_new.jsp";
		if (curleaf.getWebeditAllowType()==Leaf.WEBEDIT_ALLOW_TYPE_REDMOON_FIRST)
			addpage = "addtopic_we.jsp";
		%>
		<A href="<%=addpage%>?boardcode=<%=boardcode%>&threadType=<%=threadType%>&privurl=<%=privurl%>"> 
          <IMG src="<%=skinPath%>/images/post_<%=SkinUtil.getLocale(request)%>.gif" border=0 width=99 height=25 alt="<lt:Label res="res.label.forum.listtopic" key="post_btn"/>"></A>
		<a href="<%=addpage%>?isvote=1&boardcode=<%=boardcode%>&threadType=<%=threadType%>&privurl=<%=privurl%>"><img src="<%=skinPath%>/images/votenew_<%=SkinUtil.getLocale(request)%>.gif" border=0 width=99 height=25 alt="<lt:Label res="res.label.forum.listtopic" key="vote_btn"/>"></a>
		<%
		if (vplugin.size()>0) {
			Iterator irplugin = vplugin.iterator();
			while (irplugin.hasNext()) {
				PluginUnit pu = (PluginUnit)irplugin.next();
				IPluginUI ipu = pu.getUI(request, response, out);
				IPluginViewListThread pv = ipu.getViewListThread(boardcode);
				if (pv.IsPluginBoard() && pu.getType().equals(pu.TYPE_TOPIC) && !pu.getButton().equals("")) {%>
					<a href="<%=addpage%>?pluginCode=<%=pu.getCode()%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&threadType=<%=threadType%>&privurl=<%=privurl%>"><img src="<%=skinPath + "/" + pu.getButton()%>_<%=SkinUtil.getLocale(request)%>.gif" border="0"></a>
				<%}
			}
		}
		%>
		<%
			Vector vplugin2 = curleaf.getAllPlugin2();
			Iterator irplugin2 = vplugin2.iterator();
			while (irplugin2.hasNext()) {
				com.redmoon.forum.plugin2.Plugin2Unit p2u = (com.redmoon.forum.plugin2.Plugin2Unit)irplugin2.next();
			%>
				<a href="<%=addpage%>?plugin2Code=<%=p2u.getCode()%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&threadType=<%=threadType%>&privurl=<%=privurl%>"><img src="<%=skinPath + "/images/" + p2u.getButton()%>_<%=SkinUtil.getLocale(request)%>.gif" border="0"></a>
		<%}%>	    </TD>
        <TD align="right">
<%
int msgcount = 0;
if (privilege.isUserLogin(request)) {
%>
<jsp:useBean id="Msg" scope="page" class="com.redmoon.forum.message.MessageMgr"/>
<%
	msgcount = Msg.getNewMsgCount(request);
%>
<%if (msgcount>0) {%>
<script language=javascript>
		openWin("../message/message.jsp",320,260);
		</script>
<%
	}
}
%>
<%if (msgcount>0) {%>
<a href="javascript:openWin('../message/message.jsp',320,260)"><font color="#CC0000"><img src="images/brow/17.gif" border="0" align="absmiddle">&nbsp; <%=msgcount%>
<lt:Label res="res.label.forum.listtopic" key="new_short_msg"/>
</font></a>
<%}%>&nbsp;<a href="<%=ForumPage.getListTopicPage(request, boardcode)%>" title="<lt:Label res="res.label.forum.showtopic" key="flat_view"/>"><img border=0 src="images/flatview.gif"></a>&nbsp;<a href="listtopic.jsp?op=showelite&boardcode=<%=boardcode%>">
<lt:Label res="res.label.forum.listtopic" key="elite"/>
</a>
          <SELECT onChange="if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value;}" 
      name=select2>
	  <OPTION selected><lt:Label res="res.label.forum.listtopic" key="manager"/></OPTION>
	  <OPTION>-------</OPTION>
	  <%
	  String username = privilege.getUser(request);

	  // 置用户所在版块
	  if (username!=null && !username.equals("")) {
	  	OnlineUserDb ou = new OnlineUserDb();
		ou = ou.getOnlineUserDb(username);
		ou.setUserInBoard(boardcode);
	  }
	  
	  MsgMgr mm = new MsgMgr();
	  Vector managers = mm.getBoardManagers(boardcode);
	  Iterator irmgr = managers.iterator();
	  boolean isUserBoardManager = false;
	  while (irmgr.hasNext()) {
	  	UserDb user = (UserDb) irmgr.next();
		if (user.getName().equals(username))
			isUserBoardManager = true;
	  %>
	  <OPTION value="../userinfo.jsp?username=<%=StrUtil.UrlEncode(user.getName())%>"><%=user.getNick()%></OPTION>
	  <%}%>
	  </SELECT>&nbsp; <SELECT onChange="if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value+'&op=<%=op%>';}" 
      name=seltimelimit>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=all" selected><lt:Label res="res.label.forum.listtopic" key="topic_all"/></OPTION>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=1"><lt:Label res="res.label.forum.listtopic" key="topic_one_day"/></OPTION>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=2"><lt:Label res="res.label.forum.listtopic" key="topic_two_day"/></OPTION>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=7"><lt:Label res="res.label.forum.listtopic" key="topic_week"/></OPTION>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=15"><lt:Label res="res.label.forum.listtopic" key="topic_half_month"/></OPTION>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=30"><lt:Label res="res.label.forum.listtopic" key="topic_one_month"/></OPTION>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=60"><lt:Label res="res.label.forum.listtopic" key="topic_two_month"/></OPTION>
		<OPTION value="listtopic.jsp?boardcode=<%=boardcode%>&timelimit=180"><lt:Label res="res.label.forum.listtopic" key="topic_half_year"/></OPTION>
		</SELECT>
		<script language=javascript>
		</script>
		<script language=javascript><!--
		seltimelimit.value = "listtopic.jsp?boardcode=<%=boardcode%>&timelimit=<%=timelimit%>"
		//-->
		</script>
		&nbsp;		
		<A href="javascript:this.location.reload()" title="<lt:Label res="res.label.forum.listtopic" key="refresh"/>"><IMG src="images/refresh.gif" border=0></A>
	  &nbsp;<a href="rss.jsp?boardCode=<%=StrUtil.UrlEncode(boardcode)%>"><img src="../images/rss.gif" alt="rss<lt:Label res="res.label.forum.listtopic" key="subscription"/>" width="36" height="14" border="0" align="absmiddle"></a></TD>
      </TR>
    </TBODY>
</TABLE>
  <table align="center" width="98%">
    <tr>
      <td height="2px"></td>
    </tr>
  </table>
  <%
ThreadTypeDb ttd = new ThreadTypeDb();
Vector ttv = ttd.getThreadTypesOfBoard(boardcode);
if (ttv.size()>0) {
%>
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="5"></td>
    </tr>
    <tr>
      <td><div id="navDiv">
          <table cellpadding="0" cellspacing="1">
            <tr>
              <%
Iterator ir = ttv.iterator();
String className = "";
while (ir.hasNext()) {
	ttd = (ThreadTypeDb)ir.next();
	if (ttd.getId()==threadType)
		className = "td_hover";
	else
		className = "";
	String ttName = ttd.getName();
	if (!ttd.getColor().equals(""))
		ttName = "<font color='" + ttd.getColor() + "'>" + ttName + "</font>";		
%>
              <td class="<%=className%>" onMouseOver="this.className='td_hover'" onMouseOut="this.className='<%=className%>'"><span><a href="<%=ForumPage.getListTopicPage(request, boardcode, 1, 1, ttd.getId())%>"><%=ttName%></a></span></td>
              <%}
	if (threadType==ThreadTypeDb.THREAD_TYPE_NONE)
		className = "td_hover";
	else
		className = "";
%>
              <td class="<%=className%>" onMouseOver="this.className='td_hover'" onMouseOut="this.className='<%=className%>'"><span><a href="<%=ForumPage.getListTopicPage(request, boardcode, 1, 1, ThreadTypeDb.THREAD_TYPE_NONE)%>">
                <lt:Label res="res.label.forum.listtopic" key="topic_all"/>
              </a></span></td>
            </tr>
          </table>
      </div></td>
    </tr>
  </table>
  <%}%>
  <%
String sql = SQLBuilder.getListtopicSql(boardcode, op, timelimit, threadType);

MsgDb msgdb = new MsgDb();
int total = msgdb.getThreadsCount(sql, boardcode);

int pagesize = 20;
		
ForumPaginator paginator = new ForumPaginator(request, total, pagesize);
int curpage = paginator.getCPage(request);
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}
		
long start = (curpage-1)*pagesize;
long end = curpage*pagesize;
		
ThreadBlockIterator irmsg = msgdb.getThreads(sql, boardcode, start, end);
%>
  <TABLE borderColor=#edeced cellSpacing=0 cellPadding=1 width="98%" align=center border=1 class="list">
    <TBODY>
      <TR height=25> 
        <TD height="26" colSpan=3 align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title">
		<lt:Label res="res.label.forum.listtopic" key="topis_list"/></TD>
        <TD width=91 height="26" align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="author"/></TD>
        <TD width=55 height="26" align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="reply"/></TD>
        <TD width=55 height="26" align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="hit"/></TD>
        <TD width=80 height="26" align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="list_title_date"><lt:Label res="res.label.forum.listtopic" key="reply_date"/></TD>
      </TR>
    </TBODY>
  </TABLE>
<%		
String id="",topic = "",name="",lydate="",rename="",redate="";
int level=0,iselite=0,islocked=0,expression=0;
int i = 0,recount=0,hit=0,type=0;
// 取出论坛置顶的贴子
ForumDb forum = new ForumDb();
long[] topmsgs = forum.getTopMsgs();
int tlen = topmsgs.length;
com.redmoon.forum.person.UserMgr um = new com.redmoon.forum.person.UserMgr();
UserDb ud = null;
UserDb reUserDb = null;
while (i<tlen) {
	 	  msgdb = msgdb.getMsgDb((int)topmsgs[i]);
		  i++;
		  id = ""+msgdb.getId();
		  topic = StrUtil.toHtml(msgdb.getTitle());
		  name = msgdb.getName();
		  ud = um.getUser(name);
		  lydate = com.redmoon.forum.ForumSkin.formatDateTime(request, msgdb.getAddDate());
		  recount = msgdb.getRecount();
		  hit = msgdb.getHit();
		  expression = msgdb.getExpression();
		  type = msgdb.getType();
		  iselite = msgdb.getIsElite();
		  islocked = msgdb.getIsLocked();
		  level = msgdb.getLevel();
		  rename = StrUtil.getNullString(msgdb.getRename());
		  if (!rename.equals(""))
			  reUserDb = um.getUser(rename);
		  redate = com.redmoon.forum.ForumSkin.formatDateTime(request, msgdb.getRedate());
	  %>
<table class="list" bordercolor="<%=skin.getTableBorderClr()%>" cellspacing=0 cellpadding=1 width="98%" align=center border=1>
    <tbody>
      <tr> 
        <td noWrap align=middle width=30 bgcolor=#f8f8f8> 
				<%if (recount>20){ %>
					<img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_hot"/>" src="<%=skinPath%>/images/f_hot.gif"> 
				<%}
	  			else if (recount>0) {%>
					<img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_reply"/>" src="<%=skinPath%>/images/f_new.gif">
				<%}
	  			else {%>
					<img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_no_reply"/>" src="<%=skinPath%>/images/f_norm.gif">
				<%}%>		</td>
        <td class="list_td_emote" align=middle width=17 bgcolor=#ffffff> <% String urlboardname = StrUtil.UrlEncode(boardname,"utf-8"); %> <a href="<%=ForumPage.getShowTopicPage(request, 1, msgdb.getId(), msgdb.getId(), 1, "")%>" target=_blank> 
          <% 
		  if (islocked==1) { %>
          <IMG height=15 alt="" src="<%=skinPath%>/images/f_locked.gif" width=17 border=0> 
          <% }
		  else {
			  if (type==1) { %>
          <IMG height=15 alt="" src="<%=skinPath%>/images/f_poll.gif" width=17 border=0> 
          <%}else { %>
          <img src="images/brow/<%=expression%>.gif" border=0> 
          <%}
		  } %>
          </a></td>
        <td onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''" align=left bgcolor=#f8f8f8><%
		if (recount>0) {
		%>
          <img id=followImg<%=id%> title="<lt:Label res="res.label.forum.listtopic" key="collapse_reply"/>" style="CURSOR: hand" onClick="loadThreadFollow(<%=id%>,<%=id%>,'&boardcode=<%=boardcode%>')" src="<%=skinPath%>/images/minus.gif" loaded="no">
          <% }else { %>
    <img id=followImg<%=id%> title="<lt:Label res="res.label.forum.listtopic" key="no_reply"/>" src="<%=skinPath%>/images/minus.gif" loaded="no">
    <% } %>
    <strong><lt:Label res="res.label.forum.listtopic" key="top"/></strong>
    <!--<a href="showtopic_tree.jsp?rootid=<%=id%>">（树形）<%=topic%></a>-->
    <%
		  String attIcon = MsgUtil.getIconImg(msgdb);
		  if (!attIcon.equals("")) {
		  	out.print("<img src='../images/fileicon/" + attIcon + "'>");
		  }
		  %>
    <a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId())%>">
    <%
		String color = StrUtil.getNullString(msgdb.getColor());
		String tp = topic;
		if (!color.equals(""))
			tp = "<font color='" + color + "'>" + tp + "</font>";
		if (msgdb.isBold())
			tp = "<B>" + tp + "</B>";
	%>
    <%=tp%> </a>
    <%if (iselite==1) { %>
    <IMG src="images/topicgood.gif">
    <%}%>
    <%
		//计算共有多少页回贴
		int allpages = Math.round((float)recount/10+0.5f);
		if (allpages>1)
		{
			int pg = allpages;
			if (allpages>10)
				pg = 10;
		 	out.print("[");
			for (int m=1; m<=pg; m++)
			{%>
    <a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId(), m)%>"><%=m%></a>
    <%}
			if (allpages>10) {%>
...<a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId(), allpages)%>"><%=allpages%></a>
<%}
		  	out.print("]");
		}%></td>
        <td class="list_td" align=middle width=91 bgcolor=#ffffff> <% if (privilege.getUser(request).equals(name)) { %> <IMG height=14 src="<%=skinPath%>/images/my.gif" 
            width=14> <% } %> <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=ud.getNick()%></a> </td>
        <td align=middle width=55 bgcolor=#f8f8f8><%=recount%></td>
        <td align=middle width=55 bgcolor=#ffffff class="list_td"><%=hit%></td>
        <td align=left width=80 bgcolor=#f8f8f8 class="list_date">&nbsp;
          <%if (rename.equals("")) {%>
          <%=lydate%>
          <%}else{%>
          <%=redate%>
		  &nbsp;|&nbsp;
          <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(rename,"utf-8")%>" title="<lt:Label res="res.label.forum.listtopic" key="topic_date"/><%=lydate%>"><%=reUserDb.getNick()%></a>
        <%}%>        </td>
      </tr>
<%	  
String sql2 = "select id from sq_message where rootid="+msgdb.getId()+" ORDER BY orders";
long totalMsg = msgdb.getMsgCount(sql2, boardcode, msgdb.getId());
if (totalMsg>1) {
%>
      <tr id=follow<%=id%>> 
        <td noWrap align=middle width=30>&nbsp;</td>
        <td align=middle width=17 class="list_td_emote">&nbsp;</td>
        <td align=left colspan="5"> 
<%		
int layer = 1;
MsgBlockIterator irmsg2 = msgdb.getMsgs(sql2, boardcode, msgdb.getId(), 0, totalMsg);
if (irmsg2.hasNext()) {
	// 跳过根贴
	irmsg2.next();
}
// 写跟贴
while (irmsg2.hasNext()) {
	  i++;
	  MsgDb md = (MsgDb)irmsg2.next();
	  id = "" + md.getId();
	  name = md.getName();
	  layer = md.getLayer();
	  topic = md.getTitle();
	  lydate = DateUtil.format(md.getAddDate(), "MM-dd HH:mm");
	  ud = um.getUser(name);
 %>
<table cellspacing=0 cellpadding=0 width="100%" align=center border=0>
  <tbody> 
  <tr> 
    <td height="13" align=left noWrap> 
      <%
		int pagesize2 = 10;
		int CPages = (int)Math.ceil((double)i/pagesize2);
		layer = layer-1;
		for (int k=1; k<=layer-1; k++)
		{%>
		<img src="" width=18 height=1>
		<%}%>
      <img src="images/join.gif" width="18" height="16">
	  <a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId(), CPages, id)%>"><%=topic%></a>&nbsp;&nbsp;<a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=ud.getNick()%></a>&nbsp;&nbsp;[<%=com.redmoon.forum.ForumSkin.formatDateTime(request, md.getAddDate())%>]</td>
    </tr>
<%}%>  
  </tbody> 
</table>
<%
}
%>		
        </td>
      </tr>
    </tbody>
</table>
<%}%>
<table bordercolor=<%=skin.getTableBorderClr()%> width="98%" border="1" align="center" cellpadding="1" cellspacing="0" class="list">
  <tr>
    <td width="30">&nbsp;</td>
    <td><strong>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic"/></strong></td>
  </tr>
</table>
<%
while (irmsg.hasNext()) {
  msgdb = (MsgDb) irmsg.next(); 
  i++;
  id = ""+msgdb.getId();
  topic = StrUtil.toHtml(msgdb.getTitle());
  name = msgdb.getName();
  ud = um.getUser(name);
  lydate = com.redmoon.forum.ForumSkin.formatDateTime(request, msgdb.getAddDate());
  recount = msgdb.getRecount();
  hit = msgdb.getHit();
  expression = msgdb.getExpression();
  type = msgdb.getType();
  iselite = msgdb.getIsElite();
  islocked = msgdb.getIsLocked();
  level = msgdb.getLevel();
  rename = msgdb.getRename();
  if (!rename.equals(""))
	  reUserDb = um.getUser(rename);
  redate = com.redmoon.forum.ForumSkin.formatDateTime(request, msgdb.getRedate());
%>
<table class="list" bordercolor="<%=skin.getTableBorderClr()%>" cellspacing=0 cellpadding=1 width="98%" align=center border=1>
    <tbody>
      <tr> 
        <td noWrap align=middle width=30 bgcolor=#f8f8f8>
		<% if (level==MsgDb.LEVEL_TOP_BOARD) { %>
		<IMG alt="" src="<%=skinPath%>/images/f_top.gif" border=0> 
        <% } 
		else {
				if (recount>20){ %> <img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_hot"/>" src="<%=skinPath%>/images/f_hot.gif"> <%}
	  			else if (recount>0) {%> <img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_reply"/>" src="<%=skinPath%>/images/f_new.gif"> <%}
	  			else {%> <img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_no_reply"/>" src="<%=skinPath%>/images/f_norm.gif"> <%}
	 	}%>
		</td>
        <td class="list_td_emote" align=middle width=17 bgcolor=#ffffff> <% String urlboardname = StrUtil.UrlEncode(boardname,"utf-8"); %> <a href="<%=ForumPage.getShowTopicPage(request, 1, msgdb.getId(), msgdb.getId(), 1, "")%>" target=_blank> 
          <% 
		  if (islocked==1) { %>
          <IMG height=15 alt="" src="<%=skinPath%>/images/f_locked.gif" width=17 border=0> 
          <% }
		  else {
			  if (type==1) { %>
          <IMG height=15 alt="" src="<%=skinPath%>/images/f_poll.gif" width=17 border=0> 
          <%}else { %>
          <img src="images/brow/<%=expression%>.gif" border=0> 
          <%}
		  } %>
          </a></td>
        <td onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''" align=left bgcolor=#f8f8f8> <%
		if (recount>0) {
		%>
          <img id=followImg<%=id%> title="<lt:Label res="res.label.forum.listtopic" key="collapse_reply"/>" style="CURSOR: hand" onClick="loadThreadFollow(<%=id%>,<%=id%>,'&boardcode=<%=boardcode%>')" src="<%=skinPath%>/images/minus.gif" loaded="no">
          <% }else { %>
          <img id=followImg<%=id%> title="<lt:Label res="res.label.forum.listtopic" key="no_reply"/>" src="<%=skinPath%>/images/minus.gif" loaded="no">
          <% } %> <!--<a href="showtopic_tree.jsp?rootid=<%=id%>">（树形）<%=topic%></a>--> 
		  <%
		  String attIcon = MsgUtil.getIconImg(msgdb);
		  if (!attIcon.equals("")) {
		  	out.print("<img src='../images/fileicon/" + attIcon + "'>");
		  }
		  %>
		<a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId())%>"> 
		<%
		String color = StrUtil.getNullString(msgdb.getColor());
		String tp = topic;
		if (!color.equals(""))
			tp = "<font color='" + color + "'>" + tp + "</font>";
		if (msgdb.isBold())
			tp = "<B>" + tp + "</B>";
		%>
		<%=tp%>
		</a>
			<%if (iselite==1) { %>
				<IMG src="images/topicgood.gif">
			<%}%>
		  <%
		// 计算共有多少页回贴
		int allpages = Math.round((float)recount/10+0.5f);
		if (allpages>1)
		{
			int pg = allpages;
			if (allpages>10)
				pg = 10;
		 	out.print("[");
			for (int m=1; m<=pg; m++)
			{%> 
				<a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId(), m)%>"><%=m%></a> 
			<%}
			if (allpages>10) {%>
				...<a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId(), allpages)%>"><%=allpages%></a>
			<%}
		  	out.print("]");
		}%> 
	    </td>
        <td class="list_td" align=middle width=91 bgcolor=#ffffff> <% if (privilege.getUser(request).equals(name)) { %> <IMG height=14 src="<%=skinPath%>/images/my.gif" 
            width=14> <% } %> <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=ud.getNick()%></a> </td>
        <td align=middle width=55 bgcolor=#f8f8f8><%=recount%></td>
        <td align=middle width=55 bgcolor=#ffffff class="list_td"><%=hit%></td>
        <td align=left width=80 bgcolor=#f8f8f8 class="list_date"> 
		  &nbsp;
		  <%if (rename==null || rename.equals("")) {
				  	if (lydate!=null) {
					%>
          <%=lydate%>
          <%}
				  }else{%>
          <%=redate%>
		  &nbsp;|&nbsp;
          <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(rename,"utf-8")%>" title="<lt:Label res="res.label.forum.listtopic" key="topic_date"/><%=lydate%>"><%=reUserDb.getNick()%></a>
        <%}%></td>
      </tr>
<%	  
String sql2 = "select id from sq_message where rootid="+msgdb.getId()+" ORDER BY orders";
long totalMsg = msgdb.getMsgCount(sql2, boardcode, msgdb.getId());
if (totalMsg>1) {
%>
      <tr id=follow<%=id%>> 
        <td noWrap align=middle width=30>&nbsp;</td>
        <td align=middle width=17 class="list_td_emote">&nbsp;</td>
        <td onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''" align=left colspan="5">
<%		
int layer = 1;
MsgBlockIterator irmsg2 = msgdb.getMsgs(sql2, boardcode, msgdb.getId(), 0, totalMsg);
if (irmsg2.hasNext()) {
	// 跳过根贴
	irmsg2.next();
}
// 写跟贴
i=0;
while (irmsg2.hasNext()) {
	  i++;
	  MsgDb md = (MsgDb)irmsg2.next();
	  id = "" + md.getId();
	  name = md.getName();
	  layer = md.getLayer();
	  topic = md.getTitle();
	  lydate = DateUtil.format(md.getAddDate(), "MM-dd HH:mm");
	  ud = um.getUser(name);	  
 %>
<table cellspacing=0 cellpadding=0 width="100%" align=center border=0>
  <tbody> 
  <tr> 
    <td noWrap align=left height="13"> 
      <%
		int pagesize2 = 10;
		int CPages = (int)Math.ceil((double)i/pagesize2);
		layer = layer-1;
		for (int k=1; k<=layer-1; k++)
		{%>
		<img src="" width=18 height=1>
		<%}%>
      <img src="images/join.gif" width="18" height="16">
	  <a href="<%=ForumPage.getShowTopicPage(request, msgdb.getId(), CPages, id)%>"><%=topic%></a> <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=ud.getNick()%></a>&nbsp;&nbsp;[<%=com.redmoon.forum.ForumSkin.formatDateTime(request, md.getAddDate())%>]</td>
  </tr>
  </tbody> 
</table>
<%
}
%>		
	</td>
      </tr>
<%}%>	  
    </tbody>
</table>
<%}%>
  <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr>
      <td width="11%" align="right"><select name="selboard" onChange="if(this.options[this.selectedIndex].value!=''){location='listtopic.jsp?' + this.options[this.selectedIndex].value;}">
        <option value="" selected><lt:Label res="res.label.forum.listtopic" key="sel_board"/></option>
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
		String selected = boardcode.equals(lf.getCode())?"selected":"";
%>
        <option value="boardcode=<%=StrUtil.UrlEncode(lf.getCode(),"utf-8")%>&boardname=<%=StrUtil.UrlEncode(lf.getName(),"utf-8")%>" <%=selected%>>　├『<%=lf.getName()%>』</option>
        <%}
	}
}%>
      </select></td> 
      <td width="60" height="23" align="left"> 
          <%if (privilege.isManager(request, boardcode)) {%>
          <a href="manager/boardRule.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>"><lt:Label res="res.label.forum.listtopic" key="manage_board"/></a>
          <%}%>          &nbsp;</td>
      <td width="74%" align="right"><%
				String querystr = "boardcode=" + boardcode + "&op=" + op + "&threadType=" + threadType;
				if (op.equals(""))
					out.print(paginator.getListTopicCurPageBlock(request, boardcode, 1, threadType));
				else
					out.print(paginator.getCurPageBlock(request, "listtopic.jsp?"+querystr));
				%></td>
    </tr>
</table> 
  <TABLE borderColor=#cccccc cellSpacing=0 cellPadding=4 width="98%" align=center 
border=1>
    <TBODY>
      <TR>
        <TD height="26" background="<%=skinPath%>/images/bg1.gif" class="online">
<%
OnlineInfo oli = new OnlineInfo();
int boardcount = oli.getBoardCount(boardcode);
int boardusercount = oli.getBoardUserCount(boardcode);
int boardguestcount = boardcount - boardusercount;
%>
	<lt:Label res="res.label.forum.listtopic" key="online"/> <%=oli.getAllCount()%> <lt:Label res="res.label.forum.listtopic" key="ren"/>&nbsp;<lt:Label res="res.label.forum.listtopic" key="cur_board"/> <%=boardcount%> <lt:Label res="res.label.forum.listtopic" key="ren"/>&nbsp;<lt:Label res="res.label.forum.listtopic" key="regist_user"/> <%=boardusercount%> <lt:Label res="res.label.forum.listtopic" key="ren"/>&nbsp;
	<lt:Label res="res.label.forum.listtopic" key="guest"/> <%=boardguestcount%> <lt:Label res="res.label.forum.listtopic" key="ren"/>&nbsp;<lt:Label res="res.label.forum.listtopic" key="today_post"/> <%=curleaf.getTodayCount()%> &nbsp;
	<A title="<lt:Label res="res.label.forum.listtopic" key="show_online"/>" href="javascript:loadonline('<%=boardcode%>')"><IMG id=followImg000 style="CURSOR: hand" 
      src="images/plus.gif" border=0 loaded="no">
	<SPAN id=advance><lt:Label res="res.label.forum.listtopic" key="show_online"/></SPAN></A></TD>
      </TR>
      <TR>
        <TD 
    style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" 
    colSpan=4><DIV id="followDIV000" name="followDIV000">
            <div style="display:none; BORDER-RIGHT: black 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: black 1px solid; PADDING-LEFT: 2px; PADDING-BOTTOM: 2px; MARGIN-LEFT: 18px; BORDER-LEFT: black 1px solid; WIDTH: 240px; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: black 1px solid; BACKGROUND-COLOR: lightyellow" 
      onclick="loadonline('<%=boardcode%>')"><lt:Label res="res.label.forum.listtopic" key="wait_online"/></DIV>
        </div></TD>
      </TR>
    </TBODY>
  </TABLE>
  <TABLE width="98%" border=0 align="center" cellPadding=0 cellSpacing=0>
  <TBODY>
  <TR>
    <TD><TABLE width="100%" border=0 align="center" 
      cellPadding=0 cellSpacing=4 borderColor=#111111 style="BORDER-COLLAPSE: collapse">
      <TBODY>
        <TR>
          <TD noWrap width=200><IMG height=12 alt="" 
            src="<%=skinPath%>/images/f_new.gif" width=18 border=0>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic_reply"/></TD>
          <TD noWrap width=100><IMG height=12 alt="" 
            src="<%=skinPath%>/images/f_hot.gif" width=18 border=0>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic_hot"/> </TD>
          <TD noWrap width=100><IMG height=15 alt="" 
            src="<%=skinPath%>/images/f_locked.gif" width=17 border=0>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic_lock"/></TD>
          <TD noWrap width=150><IMG src="images/topicgood.gif"> <lt:Label res="res.label.forum.listtopic" key="topic_elite"/></TD>
          <TD noWrap width=150><IMG height=15 alt="" src="images/top_forum.gif" width=15 border=0>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic_all_top"/></TD>
        </TR>
        <TR>
          <TD noWrap width=200><IMG height=12 alt="" 
            src="<%=skinPath%>/images/f_norm.gif" width=18 border=0>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic_no_reply"/></TD>
          <TD noWrap width=100><IMG height=15 alt="" 
            src="<%=skinPath%>/images/f_poll.gif" width=17 border=0>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic_vote"/></TD>
          <TD noWrap width=100><IMG height=15 alt="" 
            src="<%=skinPath%>/images/f_top.gif" width=15 border=0>&nbsp;<lt:Label res="res.label.forum.listtopic" key="topic_top"/></TD>
          <TD noWrap width=150><IMG height=14 src="<%=skinPath%>/images/my.gif" 
            width=14> <lt:Label res="res.label.forum.listtopic" key="topic_my"/></TD>
          <TD noWrap width=150>&nbsp;</TD>
        </TR>
      </TBODY>
    </TABLE></TD>
</TR></TBODY></TABLE>
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
	<%
long pageEndTime =  System.currentTimeMillis();
long t = pageEndTime - pageBeginTime;
	%>
	<lt:Label res="res.label.forum.listtopic" key="page_run"/><%=t%><lt:Label res="res.label.forum.listtopic" key="mili_second"/>	</td>
  </tr>
</table>
<jsp:include page="inc/footer.jsp" />
</BODY></HTML>
