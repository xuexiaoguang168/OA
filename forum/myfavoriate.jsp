<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String querystring = StrUtil.getNullString(request.getQueryString());
if (!privilege.isUserLogin(request))
	response.sendRedirect("index.jsp");
String username = privilege.getUser(request);
%>
<jsp:useBean id="favoriate" class="com.redmoon.forum.Favoriate" scope="page"/>
<%
		String sql = "";
		String op = StrUtil.getNullString(request.getParameter("op"));
		String myboardname = "", myboardcode = "";
		if ( op.equals("add"))
		{
			String id = StrUtil.getNullString(request.getParameter("id"));
			if (!StrUtil.isNumeric(id))
			{
				out.print(StrUtil.Alert(SkinUtil.LoadString(request, SkinUtil.ERR_ID)));
			}
			else
			{
				boolean re = false;
				try {
					re = favoriate.Add(request, username, id);
					if (re) {
						out.println(StrUtil.Alert_Back(SkinUtil.LoadString(request, "info_op_success")));
						return;
					}
				}
				catch (ErrMsgException e) {
					out.println(StrUtil.Alert_Back(e.getMessage()));
					return;
				}
			}
		}
		if ( op.equals("del"))
		{
			String id = StrUtil.getNullString(request.getParameter("id"));
			if (!StrUtil.isNumeric(id))
			{
				out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
			}
			else
			{
				if (favoriate.Remove(request, username, id))
					out.println(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
				else
					out.println(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_fail")));
			}
		}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><lt:Label res="res.label.forum.myfavoriate" key="myfavoriate"/> - <%=Global.AppName%></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<%@ include file="../inc/nocache.jsp"%>
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
body {
	margin-left: 0px;
	margin-top: 0px;
}
</STYLE>
<SCRIPT>
// 展开帖子
function loadThreadFollow(b_id,t_id,getstr){
	var targetImg2 =eval("document.all.followImg" + t_id);
	var targetTR2 =eval("document.all.follow" + t_id);
	if (targetImg2.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg2)){
		if (targetTR2.style.display!="")
		{
			targetTR2.style.display="";
			targetImg2.src="images/minus.gif";
			if (targetImg2.loaded=="no"){
				document.frames["hiddenframe"].location.replace("listtree.jsp?id="+b_id+getstr);
			}
		}else{
			targetTR2.style.display="none";
			targetImg2.src="images/plus.gif";
		}
	}
}
</SCRIPT>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY>
<%@ include file="inc/header.jsp"%>
<%@ include file="../inc/inc.jsp"%>
<%
		String ids = favoriate.getIDS(username);
		if (ids==null || ids.equals("")) {
			out.println(SkinUtil.makeInfo(request, SkinUtil.LoadString(request, "res.label.forum.myfavoriate", "none")));
			return;
		}
		
		sql = "select id from sq_message where id in (" + ids + ") ORDER BY msg_level desc,lydate desc";
			
			int pagesize = 10;
			Paginator paginator = new Paginator(request);
			int curpage = paginator.getCurPage();
			
			MsgDb msgdb = new MsgDb();
			
			ListResult lr = msgdb.list(sql, curpage, pagesize);
			int total = lr.getTotal();
			Vector v = lr.getResult();
	        Iterator ir = null;
			if (v!=null)
				ir = v.iterator();

			paginator.init(total, pagesize);
			//设置当前页数和总页数
			int totalpages = paginator.getTotalPages();
			if (totalpages==0)
			{
				curpage = 1;
				totalpages = 1;
			}		
%>
<CENTER>
  <TABLE borderColor=#edeced height=25 cellSpacing=0 cellPadding=1 rules=rows width="98%" align=center border=1 class="table_normal">
  <TBODY>
  <TR>
        <TD><a>
          <lt:Label res="res.label.forum.inc.position" key="cur_position"/>
        </a>&nbsp;<a href="<%=rootpath%>/forum/index.jsp"><lt:Label res="res.label.forum.inc.position" key="forum_home"/></a>&nbsp;&nbsp;<B>&raquo;</B> 
        <lt:Label res="res.label.forum.myfavoriate" key="myfavoriate"/>&nbsp;(<%=total%><lt:Label key="tiao"/>)</TD>
        <TD align=right>&nbsp; </TD>
  </TR></TBODY></TABLE><BR>
<TABLE borderColor=#edeced cellSpacing=0 cellPadding=1 width="98%" align=center 
border=1>
  <TBODY>
  <TR height=25>
    <TD height="26" colSpan=3 align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="topis_list"/></TD>
    <TD width=91 align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="author"/></TD>
    <TD width=55 align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="reply"/></TD>
    <TD width=55 align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="hit"/></TD>
    <TD width=80 align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.listtopic" key="reply_date"/></TD>
        <TD width=91 align=middle noWrap background="<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.forum.myfavoriate" key="of_board"/>|<lt:Label key="op"/></TD>
  </TR>
  </TBODY></TABLE>
<%	
String id="",topic = "",name="",lydate="",rename="",redate="", title="";
int level=0,iselite=0,islocked=0,expression=0;
int i = 0,recount=0,hit=0,type=0;
int count=0;
Leaf lf = new Leaf();
UserMgr um = new UserMgr();
UserDb user = null;
while (ir!=null && ir.hasNext()) {
		  msgdb = (MsgDb)ir.next();
		  i++;
		  id = ""+msgdb.getId();
		  lf = lf.getLeaf(msgdb.getboardcode());
		  title = msgdb.getTitle();
		  name = msgdb.getName();
		  user = um.getUser(name);
		  lydate = com.redmoon.forum.ForumSkin.formatDate(request, msgdb.getAddDate());
		  recount = msgdb.getRecount();
		  hit = msgdb.getHit();
		  expression = msgdb.getExpression();
		  type = msgdb.getType();
		  iselite = msgdb.getIsElite();
		  islocked = msgdb.getIsLocked();
		  level = msgdb.getLevel();
		  rename = msgdb.getRename();
		  redate = DateUtil.format(msgdb.getRedate(), "yy-MM-dd HH:mm");
		  if (redate!=null && redate.length()>=19)
		  	redate = redate.substring(5,16);
	  %>
  <table bordercolor=#edeced cellspacing=0 cellpadding=1 width="98%" align=center border=1>
    <tbody> 
    <tr> 
        <td noWrap align=middle width=30 bgcolor=#f8f8f8> 
      <%if (recount>20){ %>
          <img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_hot"/>" src="images/f_hot.gif"> 
          <%}
	  else if (recount>0) {%>
          <img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_reply"/>" src="images/f_new.gif"> 
          <%}
	  else {%>
          <img alt="<lt:Label res="res.label.forum.listtopic" key="open_topic_no_reply"/>" src="images/f_norm.gif"> 
          <%}%>
	    </td>
        <td align=middle width=17 bgcolor=#ffffff> 
          <% String urlboardname = StrUtil.UrlEncode(myboardname,"utf-8"); %>
		   <a href="showtopic_tree.jsp?boardcode=<%=myboardcode%>&hit=<%=(hit+1)%>&boardname=<%=urlboardname%>&rootid=<%=id%>" target=_blank> 
          <% if (type==1) { %>
          <IMG height=15 alt="" src="images/f_poll.gif" width=17 border=0>
		  <%}else { %>
		  <img src="images/brow/<%=expression%>.gif" border=0>
		  <%}%>
		  </a></td>
        <td onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''" align=left bgcolor=#f8f8f8> 
        <%
		if (recount==0) {
		%>
          <img id=followImg<%=id%> title="<lt:Label res="res.label.forum.listtopic" key="extend_reply"/>" src="images/minus.gif" loaded="no"> 
          <% }else { %>
          <img id=followImg<%=id%> title="<lt:Label res="res.label.forum.listtopic" key="extend_reply"/>" style="CURSOR: hand" 
      onClick=loadThreadFollow(<%=id%>,<%=id%>,"&boardcode=<%=myboardcode%>&hit=<%=hit+1%>&boardname=<%=urlboardname%>") src="images/plus.gif" loaded="no"> 
          <% } %>
          <a target=_blank href="showtopic_tree.jsp?boardcode=<%=myboardcode%>&hit=<%=(hit+1)%>&boardname=<%=StrUtil.UrlEncode(myboardname,"utf-8")%>&rootid=<%=id%>"><%=title%></a>
          <%
		// 计算共有多少页回贴
		int allpages = (int)Math.ceil((double)recount/pagesize);
		if (allpages>1)
		{
		 	out.print("[");
			for (int m=1; m<=allpages; m++)
			{ %>
          <a href="showtopic.jsp?boardcode=<%=myboardcode%>&hit=<%=(hit+1)%>&boardname=<%=urlboardname%>&rootid=<%=id%>&CPages=<%=m%>"><%=m%></a> 
          <% }
		  	out.print("]");
		 }%>
        </td>
      <td align=middle width=91 bgcolor=#ffffff> 
	  <% if (privilege.getUser(request).equals(name)) { %>
          <IMG height=14 src="images/my.gif" width=14>
	  <% } %>
	  <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=user.getNick()%></a> 
      </td>
        <td align=middle width=55 bgcolor=#f8f8f8><font color=red>[<%=recount%>]</font></td>
        <td align=middle width=55 bgcolor=#ffffff><%=hit%></td>
      <td align=left width=80 bgcolor=#f8f8f8> 
        <table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
          <tbody> 
          <tr> 
            <td width="10%">&nbsp;</td>
            <td><%=lydate%></td>
          </tr>
          </tbody> 
        </table>
      </td>
      <td align=middle width=91 bgcolor=#ffffff>&nbsp;<a 
      href="listtopic.jsp?boardcode=<%=lf.getCode()%>"><%=lf.getName()%></a>&nbsp;|&nbsp;<a href="myfavoriate.jsp?op=del&id=<%=id%>"><lt:Label res="res.label.forum.myfavoriate" key="del"/></a></td>
    </tr>
    <tr id=follow<%=id%> style="DISPLAY: none"> 
      <td noWrap align=middle width=30 bgcolor=#f8f8f8>&nbsp;</td>
      <td align=middle width=17 bgcolor=#ffffff>&nbsp;</td>
      <td onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''" align=left bgcolor=#f8f8f8 colspan="6">
	 <div id=followDIV<%=id%> 
      style="WIDTH: 100%;BACKGROUND-COLOR: lightyellow" 
      onClick=loadThreadFollow(<%=id%>,<%=id%>,"&hit=<%=hit+1%>&boardname=<%=urlboardname%>")><lt:Label res="res.label.forum.listtopic" key="wait"/></div>
</td>
    </tr>
    <tr> 
      <td 
    style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" 
    colspan=5> 
      </td>
    </tr>
    </tbody>
  </table>
<%}%>
<script>
</script>
<table width="98%" border="0" class="p9">
  <tr>
    <td align="right"><%
				String querystr = "";
				out.print(paginator.getCurPageBlock(request, "myfavoriate.jsp?"+querystr));
				%>      &nbsp;&nbsp; </td>
  </tr>
</table>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td width="2%" height="23">&nbsp;</td>
      <td width="76%" valign="baseline" height="23"><div align="right">        &nbsp;</div>    </td>
      <td width="22%" height="23">

	  </td>
  </tr>
</table>            
  <TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
  <TBODY>
  <TR>
    <TD><TABLE width="100%" border=0 align="center" 
      cellPadding=0 cellSpacing=4 borderColor=#111111 style="BORDER-COLLAPSE: collapse">
      <TBODY>
        <TR>
          <TD noWrap width=200><IMG height=12 alt="" 
            src="<%=skinPath%>/images/f_new.gif" width=18 border=0>&nbsp;
              <lt:Label res="res.label.forum.listtopic" key="topic_reply"/></TD>
          <TD noWrap width=100><IMG height=12 alt="" 
            src="<%=skinPath%>/images/f_hot.gif" width=18 border=0>&nbsp;
              <lt:Label res="res.label.forum.listtopic" key="topic_hot"/>
          </TD>
          <TD noWrap width=100><IMG height=15 alt="" 
            src="<%=skinPath%>/images/f_locked.gif" width=17 border=0>&nbsp;
              <lt:Label res="res.label.forum.listtopic" key="topic_lock"/></TD>
          <TD noWrap width=150><IMG src="images/topicgood.gif">
              <lt:Label res="res.label.forum.listtopic" key="topic_elite"/></TD>
          <TD noWrap width=150><IMG height=15 alt="" src="images/top_forum.gif" width=15 border=0>&nbsp;
              <lt:Label res="res.label.forum.listtopic" key="topic_all_top"/></TD>
        </TR>
        <TR>
          <TD noWrap width=200><IMG height=12 alt="" 
            src="<%=skinPath%>/images/f_norm.gif" width=18 border=0>&nbsp;
              <lt:Label res="res.label.forum.listtopic" key="topic_no_reply"/></TD>
          <TD noWrap width=100><IMG height=15 alt="" 
            src="<%=skinPath%>/images/f_poll.gif" width=17 border=0>&nbsp;
              <lt:Label res="res.label.forum.listtopic" key="topic_vote"/></TD>
          <TD noWrap width=100><IMG height=15 alt="" 
            src="<%=skinPath%>/images/f_top.gif" width=15 border=0>&nbsp;
              <lt:Label res="res.label.forum.listtopic" key="topic_top"/></TD>
          <TD noWrap width=150><IMG height=14 src="<%=skinPath%>/images/my.gif" 
            width=14>
              <lt:Label res="res.label.forum.listtopic" key="topic_my"/></TD>
          <TD noWrap width=150>&nbsp;</TD>
        </TR>
      </TBODY>
    </TABLE></TD>
    </TR></TBODY></TABLE>
</CENTER>
<%@ include file="inc/footer.jsp"%>
</BODY></HTML>
