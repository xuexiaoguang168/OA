<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.blog.UserConfigDb"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin2.*"%>
<%@ page import="com.redmoon.forum.plugin.sweet.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
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
// 保存下来，以用于快速回复区的插件提示
MsgDb rootMsgDb = msgdb;

if (!msgdb.isLoaded()) {
	out.print(cn.js.fan.web.SkinUtil.makeInfo(request, SkinUtil.LoadString(request, "res.label.forum.showtopic", "topic_lost"))); // "该贴已不存在！"));
	return;
}
String boardcode = msgdb.getboardcode();
String userName = msgdb.getName();

// 检查是否可以进入版块
EntranceMgr em = new EntranceMgr();
Vector vEntrancePlugin = em.getAllEntranceUnitOfBoard(boardcode);
if (vEntrancePlugin.size()>0) {
	Iterator irpluginentrance = vEntrancePlugin.iterator();
	while (irpluginentrance.hasNext()) {
		EntranceUnit eu = (EntranceUnit)irpluginentrance.next();
		IPluginEntrance ipe = eu.getEntrance();
		try {
			ipe.canEnter(request, boardcode);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
			return;
		}
	}
}

com.redmoon.forum.Leaf msgLeaf = new com.redmoon.forum.Leaf();
msgLeaf = msgLeaf.getLeaf(boardcode);
String boardname = msgLeaf.getName();

UserConfigDb ucd = new UserConfigDb();
ucd = ucd.getUserConfigDb(userName);
if (!ucd.isLoaded()) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.forum.showblog","has_not_active_blog")));
	return;	
}

String skinPath = "skin/" + ucd.getSkin();

com.redmoon.forum.Config cfg1 = new com.redmoon.forum.Config();
int msgTitleLengthMin = cfg1.getIntProperty("forum.msgTitleLengthMin");
int msgTitleLengthMax = cfg1.getIntProperty("forum.msgTitleLengthMax");
int msgLengthMin = cfg1.getIntProperty("forum.msgLengthMin");
int msgLengthMax = cfg1.getIntProperty("forum.msgLengthMax");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE><%=msgdb.getTitle()%> - <%=Global.AppName%></TITLE>
<META http-equiv=Content-Type content=text/html; charset=utf-8>
<LINK href="../blog/<%=skinPath%>/skin.css" type=text/css rel=stylesheet>
<LINK href="../blog/images/bbs.ico" rel="SHORTCUT ICON">
<STYLE>TABLE {
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
	var zoom = parseInt(o.style.zoom, 10)||100; //如果parsInt的结果为NaN，则zoom的值为100
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
<SCRIPT language=JavaScript src="../blog/images/nereidFade.js"></SCRIPT>
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
	
	document.frmAnnounce.Content.value = getHtml();
	
	if (document.frmAnnounce.topic.value.length<<%=msgTitleLengthMin%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_title"/><%=msgTitleLengthMin%>");
		return false;
	}	

	if (document.frmAnnounce.topic.value.length><%=msgTitleLengthMax%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_title"/><%=msgTitleLengthMin%>");
		return false;
	}	
	if (document.frmAnnounce.Content.value.length<<%=msgLengthMin%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_title"/><%=msgTitleLengthMin%>");
		return false;
	}
	if (document.frmAnnounce.Content.value.length><%=msgLengthMax%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_title"/><%=msgTitleLengthMin%>");
		return false;
	}		
	
	if (i>1) 
	{
		document.frmAnnounce.submit1.disabled = true;
	}
	return true;
}

function presskey(eventobject)
{
	if(event.ctrlKey && window.event.keyCode==13)
	{
		i++;
		if (i>1) 
		{
			alert('<lt:Label res="res.label.forum.showtopic" key="wait"/>');
			return false;
		}
		this.document.form.submit();
	}
}
</SCRIPT>
<STYLE>
body {
	margin-top: 0px;
}
</STYLE>
<META content="MSHTML 6.00.2800.1126" name=GENERATOR>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></HEAD>
<BODY>
<%@ include file="../blog/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String querystring = StrUtil.getNullString(request.getQueryString());
String privurl=request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");
String sqlt = "";
String op = ParamUtil.get(request, "op");
%>
<%
		String sql = "select id from sq_message where rootid=" + rootid + " ORDER BY lydate asc";//orders"; 这样会使得顺序上不按时间，平板式时会让人觉得奇怪
		
		int pagesize = 10;
		
	    long totalmsg = msgdb.getMsgCount(sql, boardcode, rootid);
		if (op.equals("allcomm"))
			pagesize = (int)totalmsg;

		Paginator paginator = new Paginator(request, totalmsg, pagesize);
		int curpage = paginator.getCurPage();
		
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
		
		long start = (curpage-1)*pagesize;
		long end = curpage*pagesize;
		
        MsgBlockIterator irmsg = msgdb.getMsgs(sql, boardcode, rootid, start, end);
%>
<%
// 取得显示设置
BoardRenderDb boardRender = new BoardRenderDb();
boardRender = boardRender.getBoardRenderDb(boardcode);
// IPluginRender render = boardRender.getRender();
IPluginRender render = new com.redmoon.forum.plugin.render.RenderMM();

String name="",lydate="",content="",topic="";
String RegDate="",Gender="",email="",sign="";
int experience=0;
int addcount=0;
long id;
int credit=0;
int islocked=0,iselite=0,lylevel=0,isguide=0;
String roottopic = "";
int type=0;
int show_ubbcode=1,show_smile=1;
int iswebedit = 0;
int i = 0;
// 显示文章
if (true) {
	 	  msgdb = rootMsgDb; 
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
		  if (i==1)
		  {
		  	roottopic = topic;
			%>
			<script language="JavaScript">
			spanroottopic.innerHTML = '<%=StrUtil.toHtml(roottopic)%>';
			spanhit.innerHTML = '<%=msgdb.getHit()+1%>';
			</script>
			<%
		  }
		  UserDb user = new UserDb();
		  user = user.getUser(name);
		Gender = user.getGender();
		if (Gender.equals("M"))
			Gender = SkinUtil.LoadString(request, "res.label.forum.showtopic", "sex_man"); // "男";
		else if (Gender.equals("F"))
			Gender = SkinUtil.LoadString(request, "res.label.forum.showtopic", "sex_woman"); // "女";
		else
			Gender = SkinUtil.LoadString(request, "res.label.forum.showtopic", "sex_none"); // "不详";
		RegDate = DateUtil.format(user.getRegDate(), "yyyy-MM-dd");
		experience = user.getExperience();
		credit = user.getCredit();
		addcount = user.getAddCount();
		email = user.getEmail(); 
		sign = user.getSign();
%>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class=blog_table_main>
              <tr>
                <td width="220" valign="top"><%@ include file="../blog/left.jsp"%></td>
                <td valign="top" class="blog_td_main"><TABLE width="100%" 
            height="100%" border=0 align="center" cellPadding=5 cellSpacing=0 class=table_main_text style="TABLE-LAYOUT: fixed; WORD-BREAK: break-all">
                  <TBODY>
                    <TR height=100%>
                      <TD height="22" class="showblog_td_title"><B><span class="text_title"><lt:Label res="res.label.forum.showtopic" key="topic"/><%=msgdb.getTitle()%></span></B></TD>
                      <TD width="34%" class="showblog_td_title"><lt:Label res="res.label.forum.showblog" key="add_date"/><%=lydate%>&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD colSpan=2 class="blog_td_spacer_down"></TD>
                    </TR>
                    <TR>
                      <TD class="showblog_td_author"><lt:Label res="res.label.forum.showblog" key="author"/><%=user.getNick()%>&nbsp;
                      <%
						OnlineUserDb ou = new OnlineUserDb();
						ou = ou.getOnlineUserDb(user.getName());
						if (ou.isLoaded())
							out.print(SkinUtil.LoadString(request,"res.label.forum.showblog","online"));
						else
							out.print(SkinUtil.LoadString(request,"res.label.forum.showblog","offline"));
						%></TD>
                      <TD class="showblog_td_author"><%=SkinUtil.LoadString(request, "res.label.forum.showtopic", "reply")%><%=totalmsg-1%>&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.forum.showblog" key="view"/><%=msgdb.getHit()%></TD>
                    </TR>
                    <TR vAlign=top>
                      <TD colSpan=2><%
				MsgPollDb mpd = null;
				mpd = render.RenderVote(request, msgdb);
				if (type==1 && mpd!=null) {%>
                              <table width="100%" border="1" cellpadding="4" cellspacing="0" borderColor="#edeced">
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
                                    <td colspan="2" bgcolor="#EBECED"><b>
                                      <lt:Label res="res.label.forum.showtopic" key="vote"/>
                                      <%
						  java.util.Date epDate = mpd.getDate("expire_date");
						  if (epDate!=null) {%>
                                      &nbsp;
                                      <lt:Label res="res.label.forum.showtopic" key="vote_expire_date"/>
                                      &nbsp;<%=ForumSkin.formatDate(request, epDate)%>
                                      <%}%>
                                      <%if (mpd.getInt("max_choice")==1) {%>
                                      <lt:Label res="res.label.forum.showtopic" key="vote_type_single"/>
                                      <%}else{%>
                                      <lt:Label res="res.label.forum.showtopic" key="vote_type_multiple"/>
                                      <%=mpd.getInt("max_choice")%>
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
                                    <td width="46%"><%=k+1%>.
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
								UserMgr um2 = new UserMgr();
								String userNames = "";
								for (int n=0; n<userLen; n++) {
									UserDb ud = um2.getUser(userAry[n]);
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
                                  <tr>
                                    <td colspan="2" align="center"><input name="button" type="button" onClick="window.location.href='?rootid=<%=rootid%>&showVoteUser=1'" value="<lt:Label res="res.label.forum.showtopic" key="vote_show_user"/>">
                                      &nbsp;
                                      <%
					if (epDate!=null) {
						if (DateUtil.compare(epDate, new java.util.Date()) == 1) {
					%>
                                      <input name="submit" type="submit" value="<lt:Label res="res.label.forum.showtopic" key="vote"/>">
                                      <%}else{%>
                                      <b>
                                        <lt:Label res="res.label.forum.showtopic" key="vote_end"/>
                                      </b>
                                      <%}
					}else{%>
                                      <input name="submit" type="submit" value="<lt:Label res="res.label.forum.showtopic" key="vote"/>">
                                      <%}%>
                                      <input type=hidden name=boardcode value="<%=boardcode%>">
                                      <input type=hidden name=boardname value="<%=boardname%>">
                                      <input type=hidden name=voteid value="<%=id%>">
                                    </td>
                                  </tr>
                                </form>
                              </table>
					<%}%>
                        <span name="content<%=i%>"><br>
                     <%
					if (!msgdb.getPlugin2Code().equals("")) {
						Plugin2Mgr p2m = new Plugin2Mgr();
						Plugin2Unit p2u = p2m.getPlugin2Unit(msgdb.getPlugin2Code());
						out.print(p2u.getUnit().getRender().rend(request, msgdb));
					}							  
					out.print(render.RenderContent(request, msgdb));
					// if (msgdb.getIsWebedit()==msgdb.WEBEDIT_REDMOON) {
						String att = render.RenderAttachment(request, msgdb);
						if (!att.equals(""))
							out.print("<BR>" + att);
					//}	
					%>
                        </span></TD>
                    </TR>
                    <TR vAlign=top>
                      <TD colspan="2" height=1 background="../blog/skin/default/images/dot.gif"></TD>
                    </TR>
                    <TR vAlign=top height=20>
                      <TD height="26" colspan="2" valign="middle" class="blog_td_seperate"><lt:Label res="res.label.forum.showblog" key="link"/><%=Global.getRootPath()%>/blog/showblog.jsp?rootid=<%=rootid%></TD>
                    </TR>
                  </TBODY>
                </TABLE>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                  <table width="100%" border="0" class="table_main_text">
                    <tr>
                      <td colspan="2" class="showblog_td_title">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.forum.showblog" key="comments"/></td>
                    </tr>
                    <tr>
                      <td width="1"></td>
                      <td><%
if (irmsg.hasNext() && curpage==1) {
	irmsg.next(); // 跳过root贴子
}		  
while (irmsg.hasNext()) {
	msgdb = (MsgDb)irmsg.next();
	lydate = DateUtil.format(msgdb.getAddDate(), "yy-MM-dd HH:mm");
	if (lydate.length()>=19)
	 	lydate = lydate.substring(0,19);

	%>
                        <table width="80%" border="0" cellpadding="5">
                          <tr>
                            <td width="20%" align="right">─ <lt:Label res="res.label.forum.showblog" key="commenter"/><a name="#<%=msgdb.getId()%>"></a></td>
                            <td width="80%"><%=um.getUser(msgdb.getName()).getNick()%>&nbsp;&nbsp;&nbsp;&nbsp;<%=lydate%> </td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td><%
		out.print(render.RenderContent(request, msgdb));
	%></td>
                          </tr>
                          <tr>
                            <td class="blog_td_spacer_down"></td>
                            <td height=1 class="blog_td_spacer_down"></td>
                          </tr>
                        </table>
                        <%}%>
                        <%
}
if (paginator.getCurPage()==1) {
	rootMsgDb.increaseHit();
}
%>
<%
if (!op.equals("allcomm")) {%>
                        <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
                          <tr>
                            <td width="2%" height="23">&nbsp;</td>
                            <td width="76%" valign="baseline" height="23"><div align="right">
                                <%
	  String querystr = "&rootid="+rootid;
 	  out.print(paginator.getCurPageBlock("?boardcode=" + boardcode + querystr));
	%>
                            </div></td>
                            <td width="22%" height="23">&nbsp;</td>
                          </tr>
                        </table>
<%}%>						
						
                        <%if (!privilege.isUserLogin(request)) {%>
						<table width="100%" border="0">
                          <tr>
                            <td align="right">&gt;&gt; <lt:Label res="res.label.forum.showblog" key="please"/><a href="../door.jsp"><lt:Label res="res.label.forum.showblog" key="login"/></a><lt:Label res="res.label.forum.showblog" key="msg"/><a href="../regist.jsp"><lt:Label res="res.label.forum.showblog" key="reg"/></a>？&nbsp;&nbsp;&nbsp;</td>
                          </tr>
                        </table>
						<%}else{%>

                          <table style="BORDER-COLLAPSE: collapse" bordercolor=#d3d3d3 height=120 
cellspacing=0 cellpadding=5 width="98%" align=center border=1>
                        <form name="frmAnnounce" onSubmit="return formCheck()" action="addquickreplytodb.jsp?privurl=<%=privurl%>" method=post>
                            <tbody>
                              <tr>
                                <td height=26 colspan="2" align="center" class="td_comment_bar">
								<a name="comment"></a>
								&nbsp; 
                                  <lt:Label res="res.label.forum.showblog" key="comment"/></td>
                              </tr>
                              <tr bgcolor=#ffffff>
                                <td height=20>&nbsp;&nbsp;<lt:Label res="res.label.forum.showtopic" key="quick_reply_title"/></td>
                                <td width="354" height=20><input name="topic" value="<%="Re："+roottopic%>" size="40">
                                    <input type=hidden name="replyid" value="<%=rootid%>">
                                    <input type=hidden name="boardcode" value="<%=boardcode%>">
                                    <input type=hidden name="isWebedit" value="1">
                                    <input type=hidden name="expression" value="25">
          <%
if (cfg1.getBooleanProperty("forum.addUseValidateCode")) {
%>
          <br>
          <lt:Label res="res.label.forum.showtopic" key="input_validatecode"/>
<input name="validateCode" type="text" size="1">
<img src='../validatecode.jsp' border=0 align="absmiddle">
<%}%>									
								</td>
                              </tr>
                              <tr bgcolor=#ffffff>
                                <td width=67>&nbsp;&nbsp;
                                <lt:Label res="res.label.forum.showblog" key="content"/><br></td>
                                <td valign=top><div align=left>
                                    <%
		String rpath = request.getContextPath();
		%>
            <textarea id="Content" name="Content" style="display:none"></textarea>
            <link rel="stylesheet" href="<%=rpath%>/editor/edit.css">
            <script src="<%=rpath%>/editor/DhtmlEdit.js"></script>
            <script src="<%=rpath%>/editor/editjs.jsp"></script>
            <script src="<%=rpath%>/editor/editor_s.jsp"></script>
            <script>
				setHtml(form1.boardRule);
			</script>
                                    <br>
            <input tabindex=4 type=submit value="<lt:Label res="res.label.forum.showblog" key="comment"/>" name=submit1>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input onClick="checkclick('<lt:Label res="res.label.forum.showtopic" key="confirm_clear_content"/>')" type=reset value=" <lt:Label res="res.label.forum.showtopic" key="re_write"/> " name=reset>
                                </div></td>
                              </tr>
                        </form>
                            </tbody>
                          </table>
                      <%}%></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
<%@ include file="../blog/footer.jsp"%>
</BODY>
</HTML>
