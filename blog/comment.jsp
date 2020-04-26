<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.plugin.DefaultRender"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="org.jdom.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String userName = privilege.getUser(request);
if (userName.equals(""))
	userName = ParamUtil.get(request, "userName");
String blogUserDir = ParamUtil.get(request, "blogUserDir");
String skinPath = "skin/default";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><lt:Label res="res.label.blog.comment" key="title"/></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<%@ include file="../inc/nocache.jsp"%>
<LINK href="../common.css" type=text/css rel=stylesheet>
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
.style1 {color: #FFFFFF}
.style3 {color: #FFFFFF; font-weight: bold; }
</STYLE>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY leftmargin="0" topMargin=0>
<iframe width=0 height=0 src="" id="hiddenframe"></iframe>
<jsp:useBean id="Topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice" />
<%
		// 安全验证
		if (!privilege.isUserLogin(request)) {
			out.print(StrUtil.makeErrMsg(SkinUtil.LoadString(request, "err_not_login")));
			return;
		}
		
		String privurl = StrUtil.getUrl(request);
		
		String strcurpage = StrUtil.getNullString(request.getParameter("CPages"));
		if (strcurpage.equals(""))
			strcurpage = "1";
		if (!StrUtil.isNumeric(strcurpage)) {
			out.print(StrUtil.makeErrMsg(SkinUtil.LoadString(request, "err_id")));
			return;
		}
		
		String sql;
		sql = "select id from sq_message where replyRootName=" + StrUtil.sqlstr(userName) + " and isBlog=1 ORDER BY lydate desc";

		MsgDb msgdb = new MsgDb();
	    int total = 0;
		int pagesize = 20;
		int curpage = Integer.parseInt(strcurpage);
		
		ListResult lr = msgdb.list(sql, curpage, pagesize);
		total = lr.getTotal();
		
		Paginator paginator = new Paginator(request, total, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
		
        Iterator irmsg = lr.getResult().iterator();
%>
  <table width="98%" border="0" class="p9">
    <tr> 
      <td width="44%" align="left"> 
	  </td>
      <td width="56%" align="right"><%=paginator.getPageStatics(request)%></td>
    </tr>
  </table>
  <%		
String id="",topic = "",name="",lydate="",rename="",redate="";
int level=0,iselite=0,islocked=0,expression=0;
int i = 0,recount=0,hit=0,type=0;
ForumDb forum = new ForumDb();
%>
<%
while (irmsg.hasNext()) {
	 	  msgdb = (MsgDb) irmsg.next(); 
		  i++;
		  id = ""+msgdb.getId();
		  topic = msgdb.getTitle();
		  name = msgdb.getName();
		  lydate = com.redmoon.forum.ForumSkin.formatDateTime(request, msgdb.getAddDate());
	  %>
<table bordercolor=#edeced cellspacing=0 cellpadding=5 width="98%" align=center border=0>
    <tbody>
      <tr>
        <td height="24" align=left bgcolor=#f8f8f8 onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''"><a target=_blank href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(msgdb.getName())%>"><%=msgdb.getName()%>&nbsp;&nbsp;</a>
          <%if (rename.equals("")) {%>
          <%=lydate%>
          <%}else{
			String str = SkinUtil.LoadString(request,"res.label.blog.comment", "date");
			str = StrUtil.format(str, new Object[] {lydate});
		  %>
          <a href="userinfo.jsp?username=<%=StrUtil.UrlEncode(rename,"utf-8")%>" title="<%=str%>"><%=rename%></a>
          <%=redate%>
          <%}%>
&nbsp;&nbsp;<a href="../forum/deltopic.jsp?delid=<%=msgdb.getId()%>&privurl=<%=privurl%>"><lt:Label key="op_del"/></a>&nbsp;&nbsp;&nbsp;
<lt:Label res="res.label.blog.comment" key="article"/>
<%
long rootid = msgdb.getRootid();
MsgDb rootMsgDb = msgdb.getMsgDb(rootid);
%>
<a href="../forum/showblog.jsp?rootid=<%=rootid%>" target="_blank"><%=rootMsgDb.getTitle()%></a>
</td>
      </tr>
      <tr> 
        <td align=left bgcolor=#f8f8f8 onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''">
	<%
	DefaultRender render = new DefaultRender();
	out.print(render.RenderContent(request, msgdb));
	%>	</td>
      </tr>
      <tr>
        <td align=left background="../images/comm_dot.gif" height=1></td>
      </tr>
      <tr>
        <td align=left>&nbsp;</td>
      </tr>
    </tbody>
</table>
<%}%>
  <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td height="23" align="right"> 
         
          <%
				String querystr = "";
				out.print(paginator.getPageBlock(request,"listtopic.jsp?"+querystr));
				%>
      &nbsp;&nbsp;</td>
    </tr>
</table> 
  <TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
  <TBODY>
  <TR>
    <TD width="70%">&nbsp;</TD>
    <TD width="40%">&nbsp;</TD></TR></TBODY></TABLE></CENTER>
</BODY></HTML>
