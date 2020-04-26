<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.ad.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="com.redmoon.forum.security.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.Leaf"%>
<%@ taglib uri="/WEB-INF/tlds/AdTag.tld" prefix="ad_header"%>
<%
if (ForumDb.getInstance().getStatus()==ForumDb.STATUS_STOP) {
	String hUrl = StrUtil.getUrl(request);
	// 防止进入info.jsp页面时反复redirect
	if (hUrl.indexOf("info.jsp")==-1) {
		response.sendRedirect(Global.getRootPath() + "/info.jsp?info=" + cn.js.fan.util.StrUtil.UrlEncode(ForumDb.getInstance().getReason()));
		return;
	}
}
%>
<script language="JavaScript">
function hopenWin(url,width,height) {
  var newwin = window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,top=50,left=120,width="+width+",height="+height);
}
</script>
<%
com.redmoon.forum.security.IPMonitor ipm = new com.redmoon.forum.security.IPMonitor();
String rootpath = request.getContextPath(); // 当运用于hopenWin中时，rootpath会为空字符串
if (!ipm.isIPCanVisit(request.getRemoteAddr())) {
	String hUrl = StrUtil.getUrl(request);
	// 防止进入info.jsp页面时反复redirect
	if (hUrl.indexOf("info.jsp")==-1) {
		response.sendRedirect(rootpath + "/info.jsp?info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "res.label.forum.inc.header", "ipvisitlist")));
		return;
	}
}

TimeConfig tc = new TimeConfig();
if (tc.isVisitForbidden(request)) {
	String hUrl = StrUtil.getUrl(request);
	if (hUrl.indexOf("info.jsp")==-1) {
		String str = SkinUtil.LoadString(request, "res.label.forum.inc.header", "time_visit_forbid");
		str = StrUtil.format(str, new Object[] {tc.getProperty("forbidVisitTime1"), tc.getProperty("forbidVisitTime2")});
		response.sendRedirect(rootpath + "/info.jsp?info=" + StrUtil.UrlEncode(str));
		return;
	}
}

// String rootpath = Global.getRootPath();	// "http://" + Global.server + ":" + Global.port + "/" + Global.virtualPath; // "http://www.zjrj.cn";
String hboardcode,hboardname;
hboardcode = ParamUtil.get(request, "boardcode");
hboardname = ParamUtil.get(request, "boardname");
if (hboardcode==null)
	hboardcode = "";
if (hboardname == null)
	hboardname = "";
hboardname = cn.js.fan.util.StrUtil.UrlEncode(hboardname);

String hSessionBoardCode = UserSession.getBoardCode(request);
ThemeMgr tm = new ThemeMgr();
Theme hTheme = tm.getTheme("default");
if (!hSessionBoardCode.equals("")) {
	Leaf hleaf = new Leaf();
	hleaf = hleaf.getLeaf(hSessionBoardCode);
	String theme = "";
	if (hleaf!=null)
		theme = hleaf.getTheme();
	if (theme==null || theme.equals(""))
		;
	else {
		Theme t = tm.getTheme(theme);
		if (t!=null) {
			hTheme = t;
		}
	}
}
%>
<script language="JavaScript" src="<%=rootpath%>/forum/inc/main.js"></script>
<table class="table_banner" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	<table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="0" bgcolor="#D0D0CF"></td>
      </tr>
      <tr>
        <td height="<%=hTheme.getHeight()%>" background="<%=rootpath%><%=hTheme.getPath() + "/" + hTheme.getBanner()%>">
		<div align="center" style="width:100%;float:inherit; padding-left:250px; padding-top:10px; padding-bottom:10px; padding-right:20px">
		<ad_header:AdTag type="<%=AdDb.TYPE_HEADER%>" boardCode="<%=hSessionBoardCode%>"></ad_header:AdTag>		
		</div>
		</td>
      </tr>
      <tr>
        <td class="table_nav" height="22">
<%
SkinMgr hskmgr = new SkinMgr();
Vector hv = hskmgr.getAllSkin();
Iterator hir = hv.iterator();
String hskinmenu = "";
while (hir.hasNext()) {
	Skin hskin = (Skin) hir.next();
	if (hskinmenu.equals(""))
		hskinmenu += "<a href=" + rootpath + "/forum/userset.jsp?op=setSkin&skinCode=" + hskin.getCode() + ">" + hskin.getName() + "</option>";
	else
		hskinmenu += "<BR><a href=" + rootpath + "/forum/userset.jsp?op=setSkin&skinCode=" + hskin.getCode() + ">" + hskin.getName() + "</option>";
}

String hstatusmenu = "";
hstatusmenu += "<a href=" + rootpath + "/forum/boardstatus.jsp?type=today_count>" + cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.inc.header", "today_count") + "</a>";
hstatusmenu += "<a href=" + rootpath + "/forum/boardstatus.jsp?type=topic_count>" + cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.inc.header", "topic_count") + "</a>";
hstatusmenu += "<a href=" + rootpath + "/forum/boardstatus.jsp?type=post_count>" + cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.inc.header", "post_count") + "</a>";
hstatusmenu += "<a href=" + rootpath + "/forum/boardstatus.jsp?type=online>" + cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.inc.header", "online") + "</a>";
hstatusmenu += "<a href=" + rootpath + "/forum/showonline.jsp>" + cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.inc.header", "online_detail") + "</a>";
hstatusmenu += "<a href=" + rootpath + "/forum/score_rule.jsp>" + cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.score_rule", "score_rule") + "</a>";
hstatusmenu += "<a href=" + rootpath + "/forum/rank.jsp>" + cn.js.fan.web.SkinUtil.LoadString(request, "res.label.forum.inc.header", "rank") + "</a>";
%>				  
		&nbsp;<a class="nav" href='<%=rootpath%>/index.jsp'><lt:Label res="res.label.forum.inc.header" key="home"/></a> <img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle">&nbsp;<a class="nav" href='<%=rootpath%>/forum/index.jsp'><lt:Label res="res.label.forum.inc.header" key="forum"/></a><img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle" /> <a class="nav" href='<%=rootpath%>/door.jsp?privurl=<%=cn.js.fan.util.StrUtil.getUrl(request)%>'><lt:Label res="res.label.forum.inc.header" key="login"/></a>&nbsp;<img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle"> <a class="nav" href='<%=rootpath%>/usercenter.jsp'>
		<lt:Label res="res.label.forum.inc.header" key="user_center"/></a><img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle" /> <a class="nav" href='#' onmouseover='showmenu(event,&quot;<%=hskinmenu%>&quot;, 0)'><lt:Label res="res.label.forum.inc.header" key="style"/></a><img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle" />  <a class="nav" href='#' onmouseover="showmenu(event, '<%=hstatusmenu%>', 0)"><lt:Label res="res.label.forum.inc.header" key="forum_status"/></a>&nbsp;<img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle" />&nbsp;<a class="nav" href='<%=rootpath%>/listmember.jsp'><lt:Label res="res.label.forum.inc.header" key="member"/></a> <img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle"> <a class="nav" href='<%=rootpath%>/forum/search_do.jsp?selboard=allboard'><lt:Label res="res.label.forum.inc.header" key="new_tipic"/></a> <img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle"> <a class="nav" href='<%=rootpath%>/forum/treasure.jsp'><lt:Label res="res.label.forum.inc.header" key="treasure"/></a>&nbsp;<img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle"> <a class="nav" href='<%=rootpath%>/forum/search.jsp?boardcode=<%=hboardcode%>&boardname=<%=hboardname%>'><lt:Label res="res.label.forum.inc.header" key="search"/></a> <img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle" /> <a class="nav" href='javascript:hopenWin(&quot;<%=rootpath%>/message/message.jsp&quot;,320,260)'><lt:Label res="res.label.forum.inc.header" key="short_msg"/></a>
<%if (Global.hasBlog) {%>		
	<img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle" /> <a class="nav" href='<%=rootpath%>/blog/index.jsp'><lt:Label res="res.label.forum.inc.header" key="blog"/></a>
<%}%>&nbsp;<img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle"> <a class="nav" href="<%=rootpath%>/prison.jsp"><lt:Label res="res.label.forum.inc.header" key="prision"/>
</a> <img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle" /> <a class="nav" href="#" onclick="window.open('<%=rootpath%>/jump.jsp?fromWhere=forum&amp;toWhere=oa')">办公</a> <img src="<%=rootpath%>/forum/images/split.gif" width="7" height="18" align="absmiddle"> <a class="nav" href='<%=rootpath%>/exit.jsp'>
<lt:Label res="res.label.forum.inc.header" key="exit"/></a> </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<table width="98%"  border="0" align="center">
  <tr>
    <td height="10"></td>
  </tr>
</table>
<div class=menuskin id=popmenu 
      onmouseover="clearhidemenu();highlightmenu(event,'on')" 
      onmouseout="highlightmenu(event,'off');dynamichide(event)" style="Z-index:100"></div>
<iframe width=0 height=0 src="" id="hiddenframe"></iframe>
