<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="com.redmoon.forum.MsgDb"%>
<%@ page import="com.redmoon.forum.person.UserDb"%>
<%@ page import="cn.js.fan.module.photo.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/DirListTag.tld" prefix="left_dirlist" %>
<%@ taglib uri="/WEB-INF/tlds/DocumentTag.tld" prefix="left_doc" %>
<%@ taglib uri="/WEB-INF/tlds/DocListTag.tld" prefix="dl" %>
<%@ taglib uri="/WEB-INF/tlds/DocumentTag.tld" prefix="doc" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="../inc/common.js"></script>
<%
String title = SkinUtil.LoadString(request,"res.label.blog.index", "title");
title = StrUtil.format(title, new Object[] {Global.AppName});
%>
<title><%=title%></title>
<link href="common.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String privurl = StrUtil.getUrl(request);
%>
<%@ include file="blog_header.jsp"%>
<!-- 导航条 -->
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0" class="line4t">
  <tr>
    <td width="325" valign="top" bgcolor="#F7F7F7"><table width="302" border="0" align="center" cellpadding="0" cellspacing="0">
         <tr>
          <td height="10"></td>
        </tr>
		<tr>
          <td height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:16px;padding-top:2px; "><img src="images/ico_015.gif" width="13" height="14" align="absmiddle"><img src="images/no.gif" width="50" height="8"><b><lt:Label res="res.label.blog.index" key="web_announcement"/><img src="images/no.gif" width="100" height="8"></b><img src="images/more.gif" width="32" height="9"></div></td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="146" valign="top" bgcolor="#FFFFFF" class="line4t">
<MARQUEE onmouseover=stop() onmouseout=start() scrollAmount=1 
                  direction=up height=120>
            <TABLE cellSpacing=0 cellPadding=2 width="98%" border=0>
              <TBODY>
                <dl:DocListTag action="list" query="" dirCode="blog_notice" start="0" end="11">
                  <TR>
                    <TD vAlign=top width=7><IMG height=6 hspace=2 
                        src="images/ico5.gif" width=3 align=absMiddle 
                        vspace=3></TD>
                    <TD><dl:DocListItemTag field="title" length="27" mode="detail"> <a href="../doc_show.jsp?id=$id" title="#title">$title</a>$isNew </dl:DocListItemTag>                    </TD>
                  </TR>
                </dl:DocListTag>
              </TBODY>
            </TABLE>
            </MARQUEE>		  
		  </td>
        </tr>
		 <tr>
          <td height="10"></td>
        </tr>
    </table></td>
    <td width="565" bgcolor="#F7F7F7"><table width="98%"  border="0" cellspacing="0" cellpadding="0">
       <tr>
        <td height="10"></td>
        </tr>
	  <tr>
        <td width="554" height="150"><iframe scrolling="no" width="554" height="150" frameborder="0" src="../doc_show_content.jsp?dirCode=blog_ad1"></iframe></td>
        </tr>
      <tr>
        <td height="5"></td>
      </tr>
      <tr>
        <td height="29" bgcolor="#DCDCD4"> 
		
          <table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">  
  <tr><form id="search" name="search" action="listmsg.jsp" method="post">
    <td width="3%" align="center"><img src="images/i_search.gif" width="17" height="16"></td>
    <td width="22%" align="center"><b><lt:Label res="res.label.blog.index" key="blog_search"/>&nbsp;</b></td>
    <td width="22%">
      <select id="searchType" name="searchType">
          <OPTION value="msgTitle" selected><lt:Label res="res.label.blog.index" key="log_title"/></OPTION>
          <OPTION value="msgContent"><lt:Label res="res.label.blog.index" key="log_content"/></OPTION>
      </select>
   </td>
    <td width="34%"><input id="keyword" name="keyword" type="text" size="20" maxLength="40"></td>
    <td width="19%"><input type="submit" name="Submit" value="<lt:Label res="res.label.blog.index" key="search"/>"></td>
  </form> </tr>
</table>

</td>
      </tr> <tr>
        <td height="1" bgcolor="#555555"></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6" bgcolor="#555555"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="10"></td>
        </tr>
		<tr>
          <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.index" key="new_update"/></div></td>
          <td width="300" background="images/button-bg-01.gif" class="line3t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.index" key="hot_log"/></div></td>
        </tr>
        <tr>
          <td height="10"></td>
          <td></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top">
		  <div class="test">
			<%
			BlogDb bd = new BlogDb();
			bd = bd.getBlogDb();
			long[] newMsgs = bd.getNewBlogMsgs(9);
			int newMsgsLen = newMsgs.length;
			MsgDb md = new MsgDb();
			for (int i=0; i<newMsgsLen; i++) {
				md = md.getMsgDb(newMsgs[i]);
			%>
			<li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 30)%></a></li>
			<%}%>	  	  
		  </div>
		  </td>
          <td bgcolor="#FFFFFF" class="line3t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top">
          <div class="test">
			<%
			long[] hotMsgs = bd.getHotBlogMsgs(9);
			int hotMsgsLen = hotMsgs.length;
			for (int i=0; i<hotMsgsLen; i++) {
				md = md.getMsgDb(hotMsgs[i]);
			%>
			<li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 30)%></a></li>
			<%}%>  
		  </div></td>
        </tr>
		 <tr>
          <td height="10"></td>
        </tr>
    </table></td>
    <td width="2"></td>
    <td width="260" valign="top" bgcolor="#F7F7F7" class="line4t">
	<table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.frame" key="user_login"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
	  <%if (!privilege.isUserLogin(request)) {%>
      <tr>
        <td height="13" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;">
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <form action="../login.jsp" method="post" name="form1" id="form1">
		  <tr>
            <td><lt:Label res="res.label.blog.frame" key="name"/></td>
            <td><input name="name" id="name" size="14" />          </tr>
          <tr>
            <td><lt:Label res="res.label.blog.frame" key="pwd"/></td>
            <td><input name="pwd" type="password" id="pwd" size="14" /><input type="hidden" name="privurl" value="<%=privurl%>"></td>
          </tr>
          <tr>
            <td><lt:Label res="res.label.blog.frame" key="test_code"/></td>
            <td><input name="validateCode" type="text" id="validateCode" size="4" style="width:50" />
                    <a href="#" onClick="$('imgValidateCode').src='../validatecode.jsp?' + 'xxx=' + new Date().getTime();"><img id="imgValidateCode" src="../validatecode.jsp" width="58" height="20" align="absmiddle" border=0/></a></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
             <td height="28"><input type="button" name="register" value="<lt:Label res="res.label.blog.frame" key="register"/>" onclick="window.location.href='../regist.jsp'"/>
				      &nbsp;&nbsp;
                      <input name="login" type="submit" value="<lt:Label res="res.label.blog.frame" key="login"/>"/>               &nbsp;</td>
          </tr>
		  </form>
        </table>
		</td>
      </tr>
	  <%}else{%>
	  <tr>
        <td height="13" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;">
		<%
		  String userName = privilege.getUser(request);
		  UserDb me = new UserDb();
		  me = me.getUser(userName);
		  String myface = me.getMyface();
		  %>
		  <jsp:useBean id="Msg" scope="page" class="com.redmoon.forum.message.MessageMgr"/>
		  <%
		  int msgcount = 0;
		  msgcount = Msg.getNewMsgCount(request);
		  String welcome_you = SkinUtil.LoadString(request,"res.label.blog.frame", "welcome_you");
		  welcome_you = StrUtil.format(welcome_you, new Object[] {Global.AppName});
		  %>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="22"><%=welcome_you%></td>
            </tr>
            <tr>
              <td height="22"> <lt:Label res="res.label.blog.frame" key="user"/><%=me.getNick()%></td>
            </tr>
            <tr>
              <td height="22"><lt:Label res="res.label.blog.frame" key="before_login"/><%=DateUtil.format(me.getLastTime(), "yyyy-MM-dd")%></td>
            </tr>
            <tr>
              <td height="22"><a href="../usercenter.jsp"><lt:Label res="res.label.blog.frame" key="user_center"/></a> <a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.frame" key="my_blog"/></a></td>
            </tr>
            <tr>
              <td height="22"><a href="../message/message.jsp"><lt:Label res="res.label.blog.frame" key="message"/></a>(<font class="redfont"><%=msgcount%></font>)&nbsp;<a href="../exit.jsp?privurl=<%=privurl%>"><u><lt:Label res="res.label.blog.frame" key="exit_blog"/></u></a></td>
            </tr>
          </table>
		  </td>
	    </tr></table></td>
  </tr>
	  <%}%>
      <tr>
        <td height="10"></td>
      </tr>
</table> 
</tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<%
UserConfigDb ucd = new UserConfigDb();
Vector vcl = bd.getAllHomeClasses();
Iterator ircl = vcl.iterator();
long[] msgIds = null;
int msgIdsLen = 0;
%>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0"><tr>
        <td width="300" valign="top">
<%
if (ircl.hasNext()) {	
	Leaf lf = (Leaf)ircl.next();
%>

		 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> <a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table>
	<%}%>	</td>
        <td valign="top">	
	<%
	 if (ircl.hasNext()) {	
	    Leaf lf = (Leaf)ircl.next();
	%>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line3t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"><a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table><%}%></td>
	  </tr>
	   <tr>
          <td height="10"></td>
        </tr>
    </table>
	</td>
    <td width="2"></td>
    <td width="260" valign="top" bgcolor="#F7F7F7" class="line4t"><table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.frame" key="blog_star"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="186" valign="top" bgcolor="#FFFFFF" class="line4t">
          <%
	String star = StrUtil.getNullString(bd.getStar());
	
	if (!star.equals("")) {
	%>
          <table width="80%"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" bgcolor="#F7F7F7">
                <%
		ucd = ucd.getUserConfigDb(star);
		UserDb user = new UserDb();
		user = user.getUser(star);
		int myfacewidth=120,myfaceheight=150;
		String myface = user.getMyface();
		myfacewidth = user.getMyfaceWidth();
		myfaceheight = user.getMyfaceHeight();
		String RealPic = user.getRealPic();  
	    if (myface.equals("")) {%>
                <img src="../forum/images/face/<%=RealPic%>"/>
                <%}else{%>
                <img src="../images/myface/<%=myface%>" name="tus" width="<%=myfacewidth%>" height="<%=myfaceheight%>" id="tus" />
                <%}%>              </td>
            </tr>
            <tr>
              <td height="5" bgcolor="#F7F7F7"></td>
            </tr>
            <tr>
              <td bgcolor="#F7F7F7" >&nbsp;<lt:Label res="res.label.blog.frame" key="blog_left"/><a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(star)%>" target="_blank"><%=ucd.getTitle()%></a></td>
            </tr>
            <tr>
              <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="introduction"/><%=ucd.getSubtitle()%></td>
            </tr>
            <tr>
              <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="article"/><%=ucd.getMsgCount()%></td>
            </tr>
            <tr>
              <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="comment"/><%=ucd.getReplyCount()%></td>
            </tr>
            <tr>
              <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="visit"/><%=ucd.getViewCount()%></td>
            </tr>
          </table>
          <%
	}
	%>
        </td>
      </tr>
      <tr>
        <td height="8"></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="5" cellspacing="0" class="line4t">
  <tr>
    <td align="center" valign="top" bgcolor="#F7F7F7" width="879" height="104"><iframe width="100%" height="104" scrolling="no" frameborder="0" src="../doc_show_content.jsp?dirCode=blog_ad2"></iframe></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0"><tr>
        <td width="300" valign="top">
<%
if (ircl.hasNext()) {	
	Leaf lf = (Leaf)ircl.next();
%>

		 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> <a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table>
	<%}%>	</td>
        <td valign="top">	
	<%
	 if (ircl.hasNext()) {	
	    Leaf lf = (Leaf)ircl.next();
	%>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line3t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"><a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table><%}%></td>
	  </tr>
	   <tr>
          <td height="10"></td>
        </tr>
    </table></td>
    <td width="2"></td>
    <td width="260" valign="top" bgcolor="#F7F7F7" class="line4t"><table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.index" key="blog_rank"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="27" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;"><div class="test">
            <%
	String[] postBlogs = bd.getPostRank(9);
	int postBlogsLen = postBlogs.length;
	for (int i=0; i<postBlogsLen; i++) {
		ucd = ucd.getUserConfigDb(postBlogs[i]);
%>
            <li><a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>" title="<%=ucd.getTitle()%>(<%=ucd.getUserName()%>)"><%=StrUtil.getLeft(ucd.getTitle(), 20)%></a></li>
            <%}%>
        </div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.index" key="blog_album"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="186" bgcolor="#FFFFFF" class="line4t"><table width="96%"  border="0" align="center" cellpadding="0" cellspacing="10">
          <tr>
		    <%
			int[] newPhotos = bd.getNewPhotos(6);
			if (newPhotos!=null) {
				int newPhotosLen = newPhotos.length;
				PhotoDb pd = new PhotoDb();
				for (int i=0; i<newPhotosLen; i++) {
					pd = pd.getPhotoDb(newPhotos[i]);
				%>
				<td>
				<a href="showphoto.jsp?userName=<%=StrUtil.UrlEncode(pd.getUserName())%>&id=<%=pd.getId()%>">
				<img src="<%=request.getContextPath()+"/"+pd.getImage()%>" alt="<%=pd.getTitle()%>" width=94 height=120 border=0>
				</a>
				</td>
				<%}
			}%>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
    </table></td>
    <td width="2"></td>
    <td width="260" valign="top" bgcolor="#F7F7F7" class="line4t"><table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.frame" key="new_add"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="27" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
            <%
			String[] newBlogs = bd.getNewBlogs(9);
			int newBlogsLen = newBlogs.length;
			for (int i=0; i<newBlogsLen; i++) {
				ucd = ucd.getUserConfigDb(newBlogs[i]);
			%>
            <li><a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>" title="<%=ucd.getTitle()%>(<%=ucd.getUserName()%>)"><%=StrUtil.getLeft(ucd.getTitle(), 20)%></a></li>
            <%}%>
        </div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0"><tr>
        <td width="300" valign="top">
<%
if (ircl.hasNext()) {	
	Leaf lf = (Leaf)ircl.next();
%>

		 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> <a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table>
	<%}%>	</td>
        <td valign="top">	
	<%
	 if (ircl.hasNext()) {	
	    Leaf lf = (Leaf)ircl.next();
	%>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line3t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"><a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table><%}%></td>
	  </tr>
	   <tr>
          <td height="10"></td>
        </tr>
    </table></td>
    <td width="2"></td>
    <td width="260" valign="top" bgcolor="#F7F7F7" class="line4t"><table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.index" key="commend_blog"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="27" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;"><div class="test">
            <%
			Vector vrcmd = bd.getAllRecommandBlogs();
			Iterator irrcmd = vrcmd.iterator();
			while (irrcmd.hasNext()) {
				ucd = (UserConfigDb)irrcmd.next();
			%>
            <li><a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>" title="<%=ucd.getTitle()%>(<%=ucd.getUserName()%>)"><%=StrUtil.getLeft(ucd.getTitle(), 20)%></a></li>
            <%}%>
        </div></td>
      </tr>
      <tr>
        <td height="8"></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0"><tr>
        <td width="300" valign="top">
<%
if (ircl.hasNext()) {	
	Leaf lf = (Leaf)ircl.next();
%>

		 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> <a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb((int)msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table>
	<%}%>	</td>
        <td valign="top">	
	<%
	 if (ircl.hasNext()) {	
	    Leaf lf = (Leaf)ircl.next();
	%>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line3t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"><a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table><%}%></td>
	  </tr>
	   <tr>
          <td height="10"></td>
        </tr>
    </table></td>
    <td width="2"></td>
    <td width="260" valign="top" bgcolor="#F7F7F7" class="line4t"><table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.frame" key="web_statistics"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="170" bgcolor="#FFFFFF" class="line4t">
          <table width="80%"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle">&nbsp;<lt:Label res="res.label.blog.frame" key="blog_left"/><%=bd.getBlogCount()%> </td>
            </tr>
            <tr>
              <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle">&nbsp;<lt:Label res="res.label.blog.frame" key="log_left"/><%=bd.getTopicCount()%> </td>
            </tr>
            <tr>
              <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle">&nbsp;<lt:Label res="res.label.blog.frame" key="web_statistics_comment"/><%=bd.getPostCount()-bd.getTopicCount()%> </td>
            </tr>
            <%String newUserName = StrUtil.getNullString(bd.getNewBlogUserName());%>
            <tr>
              <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle">&nbsp;<lt:Label res="res.label.blog.frame" key="add"/><a href="<%=StrUtil.UrlEncode(newUserName)%>"><%=newUserName%></a> </td>
            </tr>
            <tr>
              <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle">&nbsp;<lt:Label res="res.label.blog.frame" key="yesterday"/><%=bd.getYestodayCount()%> </td>
            </tr>
            <tr>
              <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle">&nbsp;<lt:Label res="res.label.blog.frame" key="today"/><%=bd.getTodayCount()%></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="5" cellspacing="0" class="line4t">
  <tr>
    <td align="center" valign="top" bgcolor="#F7F7F7" width="879" height="104"><iframe width="100%" height="104" scrolling="no" frameborder="0" src="../doc_show_content.jsp?dirCode=blog_ad3"></iframe></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="892" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0"><tr>
        <td width="300" valign="top">
<%
if (ircl.hasNext()) {	
	Leaf lf = (Leaf)ircl.next();
%>

		 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> <a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb((int)msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table>
	<%}%>	</td>
        <td valign="top">	
	<%
	 if (ircl.hasNext()) {	
	    Leaf lf = (Leaf)ircl.next();
	%>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"><a href="listblog.jsp?kind=<%=lf.getCode()%>"><%=lf.getName()%></a></div></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;" valign="top"><div class="test">
			<%
							msgIds = bd.getBlogMsgsOfKind(9, lf.getCode());
							msgIdsLen = msgIds.length;
							for (int i=0; i<msgIdsLen; i++) {
								md = md.getMsgDb(msgIds[i]);
			%>
            <li><a href="../forum/showblog.jsp?rootid=<%=md.getId()%>" title="<%=md.getTitle()%>(<%=md.getName()%>)"><%=StrUtil.getLeft(md.getTitle(), 20)%></a></li>
            <%}%>
			</div></td>
          </tr>
        </table><%}%></td>
	  </tr>
	   <tr>
          <td height="10"></td>
        </tr>
    </table></td>
    <td width="2"></td>
    <td width="260" rowspan="3" valign="top" bgcolor="#F7F7F7" class="line4t"><table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<lt:Label res="res.label.blog.index" key="link"/></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="27" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;"><div class="test">
	<doc:DocumentTag dirCode="blog_ad4">$content</doc:DocumentTag>
        </div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="6" valign="top"></td>
    <td></td>
  </tr>
  <tr>
    <td bgcolor="#F7F7F7" class="line4t" valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td width="300" height="25" background="images/button-bg-01.gif" class="line4t"><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle"> &nbsp;<SPAN class=b3>日 志 分 类</SPAN></div></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td height="170" bgcolor="#FFFFFF" class="line4t"><table width="95%"  border="0" align="center" cellpadding="0" cellspacing="8" bgcolor="FBFBF3" class="line4-x-b">
            <tr>
              <td align="center" class="color1">
                <%
	int i = 0;
	com.redmoon.blog.LeafChildrenCacheMgr dlcm = new com.redmoon.blog.LeafChildrenCacheMgr("root");
	java.util.Vector vt = dlcm.getDirList();
	Iterator irv = vt.iterator();
	while (irv.hasNext()) {
		Leaf leaf = (Leaf) irv.next();
		String parentCode = leaf.getCode();
		i = i + 1;
	%>
                <a href="listblog.jsp?kind=<%=leaf.getCode()%>"><%=leaf.getName()%></a>&nbsp;
                <%if(i%6 == 0){%>
                <br>
                <%}else{ 
	   if(irv.hasNext()){
	%>
            -&nbsp
            <% }
	  }%>
            <%}%>
              </td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
    </table></td>
    <td></td>
  </tr>
</table>
<table width="1" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<%@ include file="footer.jsp"%>
</body>
</html>
