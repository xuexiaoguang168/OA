<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.nav.*"%>
<%@ page import="com.redmoon.forum.err.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ page import="com.redmoon.forum.miniplugin.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt"%>
<%@ taglib uri="/WEB-INF/tlds/AdTag.tld" prefix="ad"%>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice" />
<%
Privilege privilege1 = new Privilege();

// 登记访客
try {
	privilege1.enrolGuest(request,response);
}
catch (UserArrestedException e) {
	response.sendRedirect("info.jsp?info=" + StrUtil.UrlEncode(e.getMessage()));
	return;
}
// 刷新在位时间
userservice.refreshStayTime(request,response);

String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();

//seo
com.redmoon.forum.util.SeoConfig scfg = new com.redmoon.forum.util.SeoConfig();
String seoTitle = scfg.getProperty("seotitle");
String seoKeywords = scfg.getProperty("seokeywords");
String seoDescription = scfg.getProperty("seodescription");
String seoHead = scfg.getProperty("seohead");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><%=Global.AppName%> <%=seoTitle%></TITLE>
<%=seoHead%>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META name="keywords" content="<%=seoKeywords%>">
<META name="description" content="<%=seoDescription%>">
<LINK href="<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
</STYLE>
<SCRIPT>
function openWin(url,width,height)
{
  var newwin = window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,top=50,left=120,width="+width+",height="+height);
}

function loadonline(boardcode){
	var targetImg =eval("document.all.followImg000");
	var targetDiv =eval("document.all.followDIV000");
	if (targetImg.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg)){
		if (targetDiv.style.display!='block')
		{
			targetDiv.style.display="block";
			targetImg.src="images/minus.gif";
			advance.innerText="<lt:Label res="res.label.forum.index" key="close_online"/>";
			if (targetImg.loaded=="no")
				document.frames["hiddenframe"].location.replace("online.jsp?boardcode="+boardcode);
		}
		else
		{
			targetDiv.style.display="none";
			targetImg.src="images/plus.gif";
			advance.innerText="<lt:Label res="res.label.forum.index" key="show_online"/>"
		}
	}
}
</SCRIPT>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY leftmargin="0" topMargin=0>
<%
UserSession.setBoardCode(request, "");
UserMgr um = new UserMgr();
%>
<%@ include file="inc/header.jsp"%>
<iframe width=0 height=0 src="" id="hiddenframe"></iframe>
<ad:AdTag type="<%=AdDb.TYPE_TEXT%>" boardCode="<%=Leaf.CODE_ROOT%>"></ad:AdTag>
<table width="98%" border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="<%=skin.getTableBorderClr()%>">
  <tr>
    <td colspan="2" align="right" class="td_title"><a href="rss.jsp"><img src="../images/rss.gif" alt="rss订阅" width="36" height="14" border="0" align="absmiddle"></a>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%"><%
if (!privilege1.isUserLogin(request)) {%>
	<table width="98%" align="center" border="0">
	<form action="../login.jsp" method=post>
      <tbody>
        <tr align="center">
          <td colspan="3">&nbsp;
            <lt:Label res="res.label.forum.index" key="welcome"/><%=Global.AppName%><lt:Label res="res.label.forum.index" key="need_regist"/></td>
          </tr>
        <tr>
          <td align="center"><lt:Label res="res.label.forum.index" key="username"/></td>
          <td width="28%"><input maxlength=15 size=10 name="name" style="width:80"></td>
        <td width="45%">
		<%
        com.redmoon.forum.Config cfg = new com.redmoon.forum.Config();
        if (cfg.getBooleanProperty("forum.loginUseValidateCode")) {
		%>
		<lt:Label res="res.label.forum.index" key="validate_code"/>
          <input name="validateCode" type="text" size="1">
          <img src='../validatecode.jsp' border=0 align="absmiddle" style="cursor:hand" onClick="this.src='../validatecode.jsp'" alt="<lt:Label res="res.label.forum.index" key="refresh_validatecode"/>">
		<%}%>		  </td>
        </tr>
        <tr>
          <td width="27%" align="center"><lt:Label res="res.label.forum.index" key="pwd"/></td>
          <td><input type=password maxlength=15 size=10 name="pwd" style="width:80"></td>
        <td>
<lt:Label res="res.label.forum.index" key="todayis"/> 
              <script language=JavaScript>
today=new Date();
function initArray(){
this.length=initArray.arguments.length
for(var i=0;i<this.length;i++)
this[i+1]=initArray.arguments[i]  }
var d=new initArray(
"<lt:Label res="res.label.forum.index" key="Sunday"/>",
"<lt:Label res="res.label.forum.index" key="Monday"/>",
"<lt:Label res="res.label.forum.index" key="Tursday"/>",
"<lt:Label res="res.label.forum.index" key="Wensday"/>",
"<lt:Label res="res.label.forum.index" key="Thursday"/>",
"<lt:Label res="res.label.forum.index" key="Friday"/>",
"<lt:Label res="res.label.forum.index" key="Saturday"/>");
document.write(
" ",
today.getYear(),"<lt:Label res="res.label.forum.index" key="year"/>",
today.getMonth()+1,"<lt:Label res="res.label.forum.index" key="month"/>",
today.getDate(),"<lt:Label res="res.label.forum.index" key="day"/>",
"" ); 
</script>		</td>
        </tr>
        <tr>
          <td width="27%" align="center"><lt:Label res="res.label.forum.index" key="login_type"/></td>
          <td><select name=covered>
            <option value=0 selected type='checkbox' checked><lt:Label res="res.label.forum.index" key="login_not_hide"/></option>
            <option value=1><lt:Label res="res.label.forum.index" key="login_hide"/></option>
          </select>
&nbsp;</td>
          <td><select name="loginSaveDate">
            <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_NONE%>" selected><lt:Label res="res.label.forum.index" key="cookie_not_save"/></option>
            <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_DAY%>"><lt:Label res="res.label.forum.index" key="cookie_save_day"/></option>
            <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_MONTH%>"><lt:Label res="res.label.forum.index" key="cookie_save_month"/></option>
            <option value="<%=com.redmoon.forum.Privilege.LOGIN_SAVE_YEAR%>"><lt:Label res="res.label.forum.index" key="cookie_save_year"/></option>
          </select>
&nbsp;
<input type='submit' name='Submit' value='<lt:Label res="res.label.forum.index" key="commit"/>'></td>
        </tr>
      </tbody></form>
    </table>
    <%}else{%>	
    <table width="98%" align="center" border="0">
      <tbody>
        <tr>
          <td align="middle" width="88" rowspan="6">
<%
UserDb me = new UserDb();
me = me.getUser(privilege1.getUser(request));
String myface = StrUtil.getNullString(me.getMyface());
%>
<%if (myface.equals("")) {%>
	<img src="images/face/<%=StrUtil.getNullString(me.getRealPic())%>" width=64 title="<%=me.getName()%>">
<%}else{%>
	<img src="../images/myface/<%=myface%>" width=64 title="<%=me.getName()%>"> 
<%}%>		  
		  </td>
        </tr>
        <tr>
          <td height="22">
	<jsp:useBean id="Msg" scope="page" class="com.redmoon.forum.message.MessageMgr"/>
	<%
	int msgcount = 0;
	msgcount = Msg.getNewMsgCount(request);
	%>
	<%if (msgcount>0) {%>
		<script language=javascript>
		openWin("../message/message.jsp",320,260);
		</script>
	<%}%>		  
		  <a href="../usercenter.jsp"><%=um.getUser(me.getName()).getNick()%></a>&nbsp;&nbsp;<a href="javascript:hopenWin('../message/message.jsp',320,260)">
		  <lt:Label res="res.label.forum.index" key="msgbox"/>(<font class="redfont"><%=msgcount%></font>)</a></td>
          <td colspan="2"><lt:Label res="res.label.forum.index" key="last_login"/><%=DateUtil.format(me.getLastTime(), "yyyy-MM-dd")%></td>
        </tr>
        <tr>
          <td colspan="3" height="1" class="sererate"></td>
        </tr>
        <tr>
          <td height="20"><strong>: : </strong><a href="myfriend.jsp">
            <lt:Label res="res.label.forum.index" key="myfriend"/>            
          </a></td>
          <td><strong>: : </strong>
		  <a href="javascript:hopenWin('../message/send.jsp',320,260)"><lt:Label res="res.label.forum.index" key="msg_send"/></a></td>
        </tr>
        <tr>
          <td height="20"><strong>: : </strong><a href="mytopic.jsp?action=mytopic"><lt:Label res="res.label.forum.index" key="mytopic"/></a></td>
          <td><strong>: : </strong><a href="mytopic.jsp?action=myreply"><lt:Label res="res.label.forum.index" key="mytopic_attend"/></a></td>
        </tr>
        <tr>
          <td height="20"><strong>: : </strong><a href="myfavoriate.jsp"><lt:Label res="res.label.forum.index" key="myfavoriate"/></a></td>
          <td><lt:Label res="res.label.forum.index" key="rank"/><%=me.getLevelDesc()%></td>
        </tr>
      </tbody>
    </table>
<%}%>	
	</td>
    <td>
	<%
	ForumDb forum = new ForumDb();
	forum = forum.getForumDb();
	%>
	<table width="98%" align="center" border="0">
      <tbody>
        <tr>
          <td height="22"><lt:Label res="res.label.forum.index" key="all_user_count"/><b><%=forum.getUserCount()%></b></td>
          <td><a href="../listmember.jsp"><lt:Label res="res.label.forum.index" key="user_new"/></a> [<a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(forum.getUserNew())%>" target="_blank"><b><%=um.getUser(forum.getUserNew()).getNick()%></b></a>]</td>
        </tr>
        <tr>
          <td colSpan="2" height="1" class="sererate"></td>
        </tr>
        <tr>
          <td height="20"><lt:Label res="res.label.forum.index" key="today_post"/><b><%=forum.getTodayCount()%></b> <lt:Label res="res.label.forum.index" key="pian"/></td>
          <td><lt:Label res="res.label.forum.index" key="topic_count"/><b><%=forum.getTopicCount()%></b>
            <lt:Label res="res.label.forum.index" key="pian"/></td>
        </tr>
        <tr>
          <td height="20"><lt:Label res="res.label.forum.index" key="yestoday_post"/><b><%=forum.getYestodayCount()%></b>
            <lt:Label res="res.label.forum.index" key="pian"/></td>
          <td><lt:Label res="res.label.forum.index" key="post_count"/><b><%=forum.getPostCount()%></b>
            <lt:Label res="res.label.forum.index" key="pian"/></td>
        </tr>
        <tr>
          <td height="20" colSpan="2"><lt:Label res="res.label.forum.index" key="most_post"/><b><%=forum.getMaxCount()%></b> <lt:Label res="res.label.forum.index" key="pian"/> 
          &nbsp;&nbsp;
          <lt:Label res="res.label.forum.index" key="most_post_date"/><%=DateUtil.format(forum.getMaxDate(), "yyyy-MM-dd")%>&nbsp;&nbsp;
          &nbsp;</td>
        </tr>
      </tbody>
    </table></td>
  </tr>
</table>
<%
MiniPluginMgr mpm = new MiniPluginMgr();
MiniPluginUnit indexUnit = mpm.getMiniPluginUnit("index_new_elite_top");
if (indexUnit!=null && indexUnit.isPlugin()) {
%>
<%@ include file="miniplugin/index/newelitetop.jsp"%>
<%}%>
<br>
<CENTER>
  <TABLE width="98%" height="24" border=0 align=center cellPadding=0 cellSpacing=1>
    <TBODY>
      <TR bgColor=#ffffff> 
        <TD width="10%"> 
	&nbsp;<img src="images/announce.gif" width="18" height="18" align="absmiddle">&nbsp;
	<lt:Label res="res.label.forum.index" key="notice"/>
	<marquee>
	</marquee>
        </TD>
      <TD width="90%"><marquee scrollamount="3" scrolldelay="30" height="24" align="middle" onMouseOver="this.stop()" onMouseOut="this.start()">
      <%
	Vector vnotice = forum.getAllNotice();
	if (vnotice.size()!=0) {
		Iterator irnotice = vnotice.iterator();
		while (irnotice.hasNext()) {
			MsgDb md = (MsgDb)irnotice.next();%>
			<a href="<%=ForumPage.getShowTopicPage(request, md.getId())%>"> 
			<%
			String color = StrUtil.getNullString(md.getColor());
			String tp = md.getTitle();
			if (!color.equals(""))
				tp = "<font color='" + color + "'>" + tp + "</font>";
			if (md.isBold())
				tp = "<B>" + tp + "</B>";
			%>
			<%=tp%>&nbsp;[<%=com.redmoon.forum.ForumSkin.formatDate(request, md.getAddDate())%>]
			</a>&nbsp;&nbsp;&nbsp;&nbsp;
      <%}
	}%>
      </marquee></TD>
      </TR>
    </TBODY>
  </TABLE>  
<%
PluginMgr pmnote = new PluginMgr();
MsgMgr mm = new MsgMgr();

String boardField = ParamUtil.get(request, "boardField");
if (boardField.equals("")) {
	LeafChildrenCacheMgr dlcm = new LeafChildrenCacheMgr("root");
	java.util.Vector vt = dlcm.getChildren();
	Iterator ir = vt.iterator();
	while (ir.hasNext()) {
		Leaf leaf = (Leaf) ir.next();
		String parentCode = leaf.getCode();
		if (leaf.getIsHome()) {
	%>
	<table bordercolor=<%=skin.getTableBorderClr()%> cellspacing=0 cellpadding=0 width="98%" align=center border=1>
	  <tbody>
		<tr align="left">
		  <td colspan="4" noWrap class="td_title">
		  <span class="text_title">&nbsp; <%=leaf.getName()%>       </span></td>
	    </tr>
	<%
		MsgDb md = null;
		LeafChildrenCacheMgr dl = new LeafChildrenCacheMgr(parentCode);
		java.util.Vector v = dl.getChildren();
		Iterator ir1 = v.iterator();
		while (ir1.hasNext()) {
			Leaf lf = (Leaf) ir1.next();
			md = mm.getMsgDb(lf.getAddId());
			if (lf.getIsHome()) {
	%>	  
		  <tr><td width="49" align="center">
		  <%if (lf.isLocked()) {%>
			  <img alt="<lt:Label res="res.label.forum.index" key="board_lock"/>" src="<%=skinPath%>/images/board_lock.gif">
		  <%}else{%>
			  <%if (lf.getTodayCount()>0) {%>
				  <img alt="<lt:Label res="res.label.forum.index" key="board_new"/>" src="<%=skinPath%>/images/board_new.gif">
			  <%}else{%>
				  <img alt="<lt:Label res="res.label.forum.index" key="board_nonew"/>" src="<%=skinPath%>/images/board_nonew.gif">
			  <%}%>
		  <%}%>
		  </td>
			<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0" >
					  <tr>
						<td width="47%" height="23">
						『 <a href="<%=ForumPage.getListTopicPage(request, lf.getCode())%>">
						<%if (lf.getColor().equals("")) {%>
						<%=lf.getName()%>
						<%}else{%>
						<font color="<%=lf.getColor()%>"><%=lf.getName()%></font>
						<%}%>
						</a> 』
						<%
						int chcount = lf.getChildCount();
						if (chcount>0) {
							out.print("(" + chcount + ")");
						}
						%>
						<%
						/*
						Vector vplugin = pmnote.getAllPluginUnitOfBoard(lf.getCode());
						if (vplugin.size()>0) {
							out.print("<font color=#aaaaaa>");
							Iterator irpluginnote = vplugin.iterator();
							while (irpluginnote.hasNext()) {
								PluginUnit pu = (PluginUnit)irpluginnote.next();
								out.print(pu.getName(request) + "&nbsp;");
							}
							out.print("</font>");
						}
						*/
						%>
						</td>
					  <td width="23%" rowspan="2" align="right" valign="middle">
					  <%
					  String logo = StrUtil.getNullString(lf.getLogo());
					  if (!logo.equals("")) {
					  %>
					  <img src="images/board_logo/<%=logo%>" align="absmiddle">&nbsp;&nbsp;
					  <%}%>
					  </td>
						<td width="30%" rowspan="2"><table width="100%">
						<tr>
						  <td>
						  <%
						  MsgDb mdb = mm.getMsgDb(md.getRootid());
						  %>
						  <lt:Label res="res.label.forum.index" key="topic"/>                          
						  <a title="<%=mdb.getTitle()%>" href="<%=ForumPage.getShowTopicPage(request, mdb.getId())%>"><%=StrUtil.toHtml(StrUtil.getLeft(mdb.getTitle(), 60))%></a></td>
						</tr>
						<tr>
						  <td>
						  <%if (md.isLoaded()) {%>
							  <%if (md.getReplyid()==-1) {%>
							  <lt:Label res="res.label.forum.index" key="topic_post"/>                              
							  <%}else{%>
							  <lt:Label res="res.label.forum.index" key="topic_reply"/>                              
							  <%}%><a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(md.getName())%>"><%=um.getUser(md.getName()).getNick()%></a>
						  <%}%>
						  </td>
						</tr>
						<tr>
						  <td><lt:Label res="res.label.forum.index" key="topic_date"/>
					      <%=com.redmoon.forum.ForumSkin.formatDateTime(request, md.getAddDate())%>&nbsp;<img src="images/lastpost.gif" width="11" height="10"></td>
						</tr>
					  </table></td>
					  </tr>
					  <tr>
						<td height="23">
						<img src="images/readme.gif" width="10" height="10">&nbsp;<%=lf.getDescription()%>
						<%if (chcount>0) {%>
							<table width="100%" height="22" border="0" cellpadding="2" cellspacing="0">
							  <tr><td>
							&nbsp;
							<%
							LeafChildrenCacheMgr lfc = new LeafChildrenCacheMgr(lf.getCode()); 
							Vector chv = lfc.getLeafChildren();
							Iterator chir = chv.iterator();
							while (chir.hasNext()) {
								Leaf chlf = (Leaf) chir.next();
							%>
								<a href="<%=ForumPage.getListTopicPage(request, chlf.getCode())%>"><%=chlf.getName()%>&nbsp;</a>
							<%}%>
						  </td></tr></table>
						<%}%>
						</td>
					  </tr>
					  <tr>
						<td height="23" colspan="2" bgcolor="#EEEEEE">&nbsp;
						  <lt:Label res="res.label.forum.index" key="board_manager"/>                          
						  <%
						  Vector managers = mm.getBoardManagers(lf.getCode());
						  Iterator irmgr = managers.iterator();
						  while (irmgr.hasNext()) {
							UserDb user = (UserDb) irmgr.next();
						  %>
						  <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(user.getName())%>"><%=user.getNick()%></a>&nbsp;
						  <%}%>
						</td>
					  <td height="23" valign="center" bgcolor="#EEEEEE">&nbsp;<img alt="今日发贴数" src="images/Forum_today.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTodayCount()%>&nbsp;&nbsp;<img alt="主题贴数" src="images/Forum_topic.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTopicCount()%>&nbsp;&nbsp;<img src="images/Forum_post.gif" alt="发贴总数" width="25" height="10" align="absmiddle">&nbsp;<%=lf.getPostCount()%></td>
					  </tr>
					</table>
			</td>
		  </tr>
		  <%}%>
		<%}%>
	  </tbody>
	</table><br>
	<%	}
	}
} else {
	Leaf leaf = new Leaf();
	leaf = leaf.getLeaf(boardField);
	if (leaf==null) {
		out.print(StrUtil.Alert_Back(boardField + "not found."));
		return;
	}
%>
    <table bordercolor=<%=skin.getTableBorderClr()%> cellspacing=0 cellpadding=0 width="98%" align=center border=1>
      <tbody>
        <tr align="left">
          <td colspan="4" noWrap class="td_title"><span class="text_title">&nbsp; <%=leaf.getName()%> </span></td>
        </tr>
        <%
		MsgDb md = new MsgDb();
		LeafChildrenCacheMgr dl = new LeafChildrenCacheMgr(boardField);
		java.util.Vector v = dl.getChildren();
		Iterator ir1 = v.iterator();
		while (ir1.hasNext()) {
			Leaf lf = (Leaf) ir1.next();
			md = md.getMsgDb(lf.getAddId());
			if (lf.getIsHome()) {
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
              <%}%>
          </td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0" >
              <tr>
                <td width="47%" height="23"> 『 <a href="<%=ForumPage.getListTopicPage(request, lf.getCode())%>">
                  <%if (lf.getColor().equals("")) {%>
                  <%=lf.getName()%>
                  <%}else{%>
                  <font color="<%=lf.getColor()%>"><%=lf.getName()%></font>
                  <%}%>
                  </a> 』
                  <%
						int chcount = lf.getChildCount();
						if (chcount>0) {
							out.print("(" + chcount + ")");
						}
						%>
                  <%
						/*
						Vector vplugin = pmnote.getAllPluginUnitOfBoard(lf.getCode());
						if (vplugin.size()>0) {
							out.print("<font color=#aaaaaa>");
							Iterator irpluginnote = vplugin.iterator();
							while (irpluginnote.hasNext()) {
								PluginUnit pu = (PluginUnit)irpluginnote.next();
								out.print(pu.getName(request) + "&nbsp;");
							}
							out.print("</font>");
						}
						*/
						%>
                </td>
                <td width="23%" rowspan="2" align="right" valign="middle"><%
					  String logo = StrUtil.getNullString(lf.getLogo());
					  if (!logo.equals("")) {
					  %>
                    <img src="images/board_logo/<%=logo%>" align="absmiddle">&nbsp;&nbsp;
                    <%}%>
                </td>
                <td width="30%" rowspan="2"><table width="100%" >
                    <tr>
                      <td><%
						  MsgDb mdb = mm.getMsgDb(md.getRootid());
						  %>
                        <lt:Label res="res.label.forum.index" key="topic"/>
                        <a title="<%=mdb.getTitle()%>" href="<%=ForumPage.getShowTopicPage(request, mdb.getId())%>"><%=StrUtil.toHtml(StrUtil.getLeft(mdb.getTitle(), 60))%></a></td>
                    </tr>
                    <tr>
                      <td><%if (md.isLoaded()) {%>
                          <%if (md.getReplyid()==-1) {%>
                          <lt:Label res="res.label.forum.index" key="topic_post"/>
                          <%}else{%>
                          <lt:Label res="res.label.forum.index" key="topic_reply"/>
                          <%}%>
                        <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(md.getName())%>"><%=um.getUser(md.getName()).getNick()%></a>
                        <%}%>
                      </td>
                    </tr>
                    <tr>
                      <td><lt:Label res="res.label.forum.index" key="topic_date"/>
                      <%=com.redmoon.forum.ForumSkin.formatDateTime(request, md.getAddDate())%>&nbsp;<img src="images/lastpost.gif" width="11" height="10"></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td height="23"><img src="images/readme.gif" width="10" height="10">&nbsp;<%=lf.getDescription()%>
                    <%if (chcount>0) {%>
                    <table width="100%" height="22" border="0" cellpadding="2" cellspacing="0">
                      <tr>
                        <td>&nbsp;
                            <%
							LeafChildrenCacheMgr lfc = new LeafChildrenCacheMgr(lf.getCode()); 
							Vector chv = lfc.getLeafChildren();
							Iterator chir = chv.iterator();
							while (chir.hasNext()) {
								Leaf chlf = (Leaf) chir.next();
							%>
                            <a href="<%=ForumPage.getListTopicPage(request, chlf.getCode())%>"><%=chlf.getName()%>&nbsp;</a>
                            <%}%>
                        </td>
                      </tr>
                    </table>
                  <%}%>
                </td>
              </tr>
              <tr>
                <td height="23" colspan="2" bgcolor="#EEEEEE"><lt:Label res="res.label.forum.index" key="board_manager"/>
                <%
						  Vector managers = mm.getBoardManagers(lf.getCode());
						  Iterator irmgr = managers.iterator();
						  while (irmgr.hasNext()) {
							UserDb user = (UserDb) irmgr.next();
						  %>
                    <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(user.getName())%>"><%=user.getNick()%></a>&nbsp;
                    <%}%>
                </td>
                <td height="23" valign="center" bgcolor="#EEEEEE">&nbsp;<img alt="今日发贴数" src="images/Forum_today.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTodayCount()%>&nbsp;&nbsp;<img alt="主题贴数" src="images/Forum_topic.gif" width="25" height="10" align="absmiddle">&nbsp;&nbsp;<%=lf.getTopicCount()%>&nbsp;&nbsp;<img src="images/Forum_post.gif" alt="发贴总数" width="25" height="10" align="absmiddle">&nbsp;<%=lf.getPostCount()%></td>
              </tr>
          </table></td>
        </tr>
        <%}%>
        <%}%>
      </tbody>
    </table>
    <%}%>

<%if (forum.isShowLink()) {%>
<TABLE borderColor="<%=skin.getTableBorderClr()%>" cellSpacing=0 cellPadding=4 width="98%" align=center 
border=1>
  <TBODY>
    <TR>
      <TD class="td_title"><lt:Label res="res.label.forum.index" key="link"/></TD>
    </TR>
    <TR>
      <TD height="22" 
    colSpan=4>
	<table width=100% align=center>
                <%
				LinkDb ld = new LinkDb();
				String listsql = "select id from " + ld.getTableName() + " where userName=" + StrUtil.sqlstr(ld.USER_SYSTEM) + " and kind=" + StrUtil.sqlstr(ld.KIND_DEFAULT) + " order by sort";
				Iterator irlink = ld.list(listsql).iterator();
				int m = 0;
				while (irlink.hasNext())
				{
					ld = (LinkDb) irlink.next();
					if (m==0)
						out.print("<tr>");
				%>
					<td align=center><a target="_blank" href="<%=ld.getUrl()%>" title="<%=ld.getTitle()%>">
					<%if (ld.getImage()!=null && !ld.getImage().equals("")) {%>
						<img src="../<%=ld.getImage()%>" border=0>
					<%}else{%>
						<%=ld.getTitle()%>
					<%}%>
					</a></td>
                <%
					m ++;
					if (m==8) {
						out.print("</tr>");
						m = 0;
					}
				}
				if (m!=8)
					out.print("</tr>");
				%>	
	</table>
		</TD>
    </TR>
  </TBODY>
</TABLE>
<br>
<%}%>
<TABLE borderColor="<%=skin.getTableBorderClr()%>" cellSpacing=0 cellPadding=4 width="98%" align=center 
border=1>
    <TBODY>
      <TR>
        <TD background="<%=skinPath%>/images/bg1.gif" class="online"><span>
<%
OnlineInfo oli = new OnlineInfo();
int allcount = oli.getAllCount();
int allusercount = oli.getAllUserCount();
int allguestcount = allcount - allusercount;
%>
<lt:Label res="res.label.forum.index" key="online"/>
<%=allcount%> 
<lt:Label res="res.label.forum.index" key="ren"/>
<lt:Label res="res.label.forum.index" key="online_reg_count"/> <%=allusercount%> <lt:Label res="res.label.forum.index" key="ren"/>
<lt:Label res="res.label.forum.index" key="online_guest_count"/> <%=allguestcount%> <lt:Label res="res.label.forum.index" key="ren"/>&nbsp;<lt:Label res="res.label.forum.index" key="today_post"/> <b><%=forum.getTodayCount()%></b> &nbsp;
		<A title="<lt:Label res="res.label.forum.index" key="show_online"/>" href="javascript:loadonline('')"><IMG id=followImg000 style="CURSOR: hand" 
      src="images/plus.gif" border=0 loaded="no"> <SPAN id=advance><lt:Label res="res.label.forum.index" key="online_list"/></SPAN></A>
<lt:Label res="res.label.forum.index" key="create_date"/><%=com.redmoon.forum.ForumSkin.formatDateTime(request, forum.getCreateDate())%>	|&nbsp;<lt:Label res="res.label.forum.index" key="online_max_count"/><%=forum.getMaxOnlineCount()%>
<lt:Label res="res.label.forum.index" key="ren"/>
&nbsp;<%=com.redmoon.forum.ForumSkin.formatDateTime(request, forum.getMaxOnlineDate())%></span></TD>
      </TR>
      <TR>
        <TD 
    colSpan=4 
    style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"><DIV id="followDIV000" name="followDIV000">
            <div style="display:none; BORDER-RIGHT: black 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: black 1px solid; PADDING-LEFT: 2px; PADDING-BOTTOM: 2px; MARGIN-LEFT: 18px; BORDER-LEFT: black 1px solid; WIDTH: 240px; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: black 1px solid; BACKGROUND-COLOR: lightyellow" 
      onclick="loadonline('')"><lt:Label res="res.label.forum.index" key="wait"/></DIV>
        </div></TD>
      </TR>
    </TBODY>
  </TABLE>
  <TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
  <TBODY>
  <TR>
    <TD width="70%">&nbsp;      </TD>
    <TD width="40%">&nbsp;</TD></TR></TBODY></TABLE>
  <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="29" align="center"><IMG src="<%=skinPath%>/images/board_nonew.gif" alt=<lt:Label res="res.label.forum.index" key="board_nonew"/> width="24" height="24" align=absMiddle> <lt:Label res="res.label.forum.index" key="board_nonew"/>      
      　　<IMG src="<%=skinPath%>/images/board_new.gif" alt=<lt:Label res="res.label.forum.index" key="board_new"/> width="24" height="24" align=absMiddle> <lt:Label res="res.label.forum.index" key="board_new"/>      
      　　<IMG src="<%=skinPath%>/images/board_lock.gif" alt=<lt:Label res="res.label.forum.index" key="board_lock"/> width="24" height="24" align=absMiddle> <lt:Label res="res.label.forum.index" key="board_locked"/></td>
    </tr>
  </table>
</CENTER>
<jsp:include page="inc/footer.jsp" />
</BODY></HTML>
