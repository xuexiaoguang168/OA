<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.UserBlog"%>
<%@ page import="com.redmoon.blog.UserDirDb"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.UserDb"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="leftprivilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String leftprivurl = StrUtil.getUrl(request);
UserConfigDb leftucd = new UserConfigDb();
%>
<table width="100%" border="0" class="blog_left_table">
  <tr>
    <td align="center" valign="top">
      <table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle" /> &nbsp;<lt:Label res="res.label.blog.frame" key="user_login"/></div></td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <%if (!leftprivilege.isUserLogin(request)) {%>
        <tr>
          <td height="13" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <form action="../login.jsp" method="post" name="form1" id="form1">
                <tr>
                  <td><lt:Label res="res.label.blog.frame" key="name"/></td>
                  <td><input name="name" id="name" size="14" />                  </td>
                </tr>
                <tr>
                  <td><lt:Label res="res.label.blog.frame" key="pwd"/></td>
                  <td><input name="pwd" type="password" id="pwd" size="14" />
                      <input type="hidden" name="privurl" value="<%=leftprivurl%>" /></td>
                </tr>
                <tr>
                  <td><lt:Label res="res.label.blog.frame" key="test_code"/></td>
                  <td><input name="validateCode" type="text" id="validateCode" size="4" style="width:50" />
                      <img src="../validatecode.jsp" width="58" height="20" align="absmiddle" /></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td height="28"><input type="button" name="register" value="<lt:Label res="res.label.blog.frame" key="register"/>" onclick="window.location.href='../regist.jsp'"/>
				      &nbsp;&nbsp;
                      <input name="login" type="submit" value="<lt:Label res="res.label.blog.frame" key="login"/>"/>
                  &nbsp;</td>
                </tr>
              </form>
          </table></td>
        </tr>
        <%}else{%>
        <tr>
          <td height="13" bgcolor="#FFFFFF" class="line4t" style="padding-top:6px; padding-left:15px; padding-right:15px;"><%
			String userName = leftprivilege.getUser(request);
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
                  <td height="22"><lt:Label res="res.label.blog.frame" key="user"/><%=userName%></td>
                </tr>
                <tr>
                  <td height="22"><lt:Label res="res.label.blog.frame" key="before_login"/><%=DateUtil.format(me.getLastTime(), "yyyy-MM-dd")%></td>
                </tr>
                <tr>
                  <td height="22"><a href="../usercenter.jsp"><lt:Label res="res.label.blog.frame" key="user_center"/></a> <a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.frame" key="my_blog"/></a></td>
                </tr>
                <tr>
                  <td height="22"><a href="../message/message.jsp"><lt:Label res="res.label.blog.frame" key="message"/></a>(<font class="redfont"><%=msgcount%></font>)&nbsp;<a href="../exit.jsp?privurl=<%=leftprivurl%>"><u><lt:Label res="res.label.blog.frame" key="exit_blog"/></u></a></td>
                </tr>
            </table></td>
        </tr>
    </table>
	  <%}%>
	  <table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle" /> &nbsp;<lt:Label res="res.label.blog.frame" key="blog_star"/></div></td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="186" valign="top" bgcolor="#FFFFFF" class="line4t"><%
	BlogDb bd = new BlogDb();
	bd = bd.getBlogDb();
	String star = StrUtil.getNullString(bd.getStar());
	if (!star.equals("")) {
	%>
              <table width="80%"  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="center">&nbsp;</td>
                </tr>
                <tr>
                  <td align="center" bgcolor="#F7F7F7"><%
 	    UserConfigDb leftleftucd = new UserConfigDb();
		leftleftucd = leftleftucd.getUserConfigDb(star);
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
                      <%}%>
                  </td>
                </tr>
                <tr>
                  <td height="5" bgcolor="#F7F7F7"></td>
                </tr>
                <tr>
                  <td bgcolor="#F7F7F7" >&nbsp;<lt:Label res="res.label.blog.frame" key="blog_left"/><a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(star)%>" target="_blank"><%=leftleftucd.getTitle()%></a></td>
                </tr>
                <tr>
                  <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="introduction"/><%=leftleftucd.getSubtitle()%></td>
                </tr>
                <tr>
                  <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="article"/><%=leftleftucd.getMsgCount()%></td>
                </tr>
                <tr>
                  <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="comment"/><%=leftleftucd.getReplyCount()%></td>
                </tr>
                <tr>
                  <td bgcolor="#F7F7F7">&nbsp;<lt:Label res="res.label.blog.frame" key="visit"/><%=leftleftucd.getViewCount()%></td>
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
      </table>
      <table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle" /> &nbsp;<lt:Label res="res.label.blog.frame" key="new_add"/></div></td>
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
				leftucd = leftucd.getUserConfigDb(newBlogs[i]);
			%>
              <li><a href="myblog.jsp?userName=<%=StrUtil.UrlEncode(leftucd.getUserName())%>" title="<%=leftucd.getTitle()%>(<%=leftucd.getUserName()%>)"><%=StrUtil.getLeft(leftucd.getTitle(), 20)%></a></li>
            <%}%>
          </div></td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
      </table>
      <table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="25" background="images/button-bg-01.gif" class="line4t" ><div style="PADDING-left:18px;padding-top:3px; "><img src="images/subj.gif" width="16" height="15" align="absmiddle" /> &nbsp;<lt:Label res="res.label.blog.frame" key="web_statistics"/></div></td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="170" bgcolor="#FFFFFF" class="line4t"><table width="80%"  border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle" />&nbsp;<lt:Label res="res.label.blog.frame" key="blog_left"/><%=bd.getBlogCount()%> </td>
              </tr>
              <tr>
                <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle" />&nbsp;<lt:Label res="res.label.blog.frame" key="log_left"/><%=bd.getTopicCount()%> </td>
              </tr>
              <tr>
                <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle" />&nbsp;<lt:Label res="res.label.blog.frame" key="web_statistics_comment"/><%=bd.getPostCount()-bd.getTopicCount()%> </td>
              </tr>
              <%String newUserName = StrUtil.getNullString(bd.getNewBlogUserName());%>
              <tr>
                <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle" />&nbsp;<lt:Label res="res.label.blog.frame" key="add"/><a href="<%=StrUtil.UrlEncode(newUserName)%>"><%=newUserName%></a> </td>
              </tr>
              <tr>
                <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle" />&nbsp;<lt:Label res="res.label.blog.frame" key="yesterday"/><%=bd.getYestodayCount()%> </td>
              </tr>
              <tr>
                <td height="25"><img src="images/tu_newgroup.gif" width="15" height="12" align="absmiddle" />&nbsp;<lt:Label res="res.label.blog.frame" key="today"/><%=bd.getTodayCount()%></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
      </table></td>
  </tr>
</table>
