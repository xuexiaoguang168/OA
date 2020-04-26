<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.UserBlog"%>
<%@ page import="com.redmoon.blog.UserDirDb"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.person.UserDb"%>
<%@ page import="com.redmoon.forum.MsgDb"%>
<%@ page import="com.redmoon.forum.ThreadBlockIterator "%>
<%@ page import="com.redmoon.forum.ForumDb "%>
<%@ page import="com.redmoon.forum.* "%>
<%@ page import="com.redmoon.forum.plugin.DefaultRender "%>
<%@ page import="cn.js.fan.module.nav.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
// 取得显示的年月 
int leftyear,leftmonth;
try {
	leftyear = ParamUtil.getInt(request, "year");
	leftmonth = ParamUtil.getInt(request, "month");
}
catch (Exception e) {
    Calendar cal = Calendar.getInstance();
    leftyear = cal.get(cal.YEAR);
    leftmonth = cal.get(cal.MONTH) + 1;
}
if (leftmonth>12)
	leftmonth = 12;
if (leftmonth<1)
	leftmonth = 1;
UserDb leftUser = new UserDb();
leftUser = leftUser.getUser(userName);
%>
<style type="text/css">
<!--
.STYLE2 {color: #FFFFFF}
-->
</style>
<table width="100%" border="0" class="blog_left_table">
  <tr>
    <td height="32" align="center">
	<table width="100%" border="0">
      <tr>
        <td height="5"></td>
      </tr>
    </table>
	<a class="blog_link_username" href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(userName)%>"><%=ucd.getPenName()%></a>	</td>
  </tr>
  <tr>
    <td align="center"><font color="#FF0000">
      <%
		int myfacewidth=120,myfaceheight=150;
		String myface = leftUser.getMyface();
		myfacewidth = leftUser.getMyfaceWidth();
		myfaceheight = leftUser.getMyfaceHeight();
		String RealPic = leftUser.getRealPic();  
	  if (myface.equals("")) {%>
      <img src="../forum/images/face/<%=RealPic%>"/>
      <%}else{%>
      <img src="../images/myface/<%=myface%>" name="tus" width="<%=myfacewidth%>" height="<%=myfaceheight%>" id="tus" />
      <%}%>
    </font></td>
  </tr>
  <tr>
    <td align="center" height="10"></td>
  </tr>
  <tr>
    <td align="center">
			<div id=div_cal></div>		
			  <script>
			  var userName = "<%=StrUtil.UrlEncode(userName)%>";
			  </script>	  
			  <script src="inc/calendar.js">
			  </script>
			  <script>
			  newCalendar("div_cal", <%=leftyear%>, <%=leftmonth%>);
			  </script>
			  <%
			  // 取得year-month这个月中的所有日志，遍历后对日历初始化
			  UserBlog bu = new UserBlog(userName);
			  int[] dayCountAry = bu.getBlogDayCount(leftyear, leftmonth);
			  int dayLen = dayCountAry.length;
			  %>
			  <script>
			  <%
			  Calendar cal = Calendar.getInstance();
			  // int dayOfMonth = cal.get(cal.DAY_OF_MONTH);			  
			  for (int n=1; n<dayLen; n++) {
			  		if (dayCountAry[n]>0) {
						String totle_log = SkinUtil.LoadString(request,"res.label.blog.left", "totle_log");
						totle_log = StrUtil.format(totle_log, new Object[] {"" + dayCountAry[n]});
			  %>
						// alert(day<%=n%>.innerHTML);
						day<%=n%>.innerHTML = "<table width=100% cellSpacing=0 cellPadding=1 class=table_day><tr><td align=center><a href='listdayblog.jsp?userName=<%=StrUtil.UrlEncode(userName)%>&y=<%=leftyear%>&m=<%=leftmonth%>&d=<%=n%>' title='<%=totle_log%>'>" + <%=n%> +"</a></td></tr></table>";
			  <%	}
			  }%>
			  </script>	</td>
  </tr>
  
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        
        <tr>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td class="blog_td_spacer_up"></td>
            </tr>
            <tr>
              <td class="blog_td_title"><li class="titleBar">&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.blog.left" key="my_column"/></li></td>
            </tr>
            <tr>
              <td class="blog_td_spacer_down"></td>
            </tr>
          </table>
            <table width="100%"  border="0" align="center" cellpadding="3" cellspacing="0">
              <tr align="center">
                <td>&nbsp;</td>
                <td height="22" align="left"><a href="<%=rootpath%>/blog/myblog.jsp?blogUserDir=<%=UserDirDb.DEFAULT%>&userName=<%=StrUtil.UrlEncode(userName)%>"><%=UserDirDb.getDefaultName()%></a></td>
              </tr>            
            <%
UserDirDb sb1 = new UserDirDb();
Vector leftv = sb1.list(userName);
Iterator leftir = leftv.iterator();
while (leftir.hasNext()) {
	UserDirDb as = (UserDirDb)leftir.next();
%>
              <tr align="center">
                <td width="14%">&nbsp;</td>
                <td width="86%" height="22" align="left"><a href="<%=rootpath%>/blog/myblog.jsp?userName=<%=StrUtil.UrlEncode(userName)%>&blogUserDir=<%=StrUtil.UrlEncode(as.getCode())%>"><%=as.getDirName()%></a></td>
              </tr>
            <%}%>
          </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td class="blog_td_spacer_up"></td>
        </tr>
        <tr>
          <td class="blog_td_title"><li class="titleBar">&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.blog.left" key="new_article"/></li> </td>
        </tr>
        <tr>
          <td class="blog_td_spacer_down"></td>
        </tr>
      </table>
	  <%
		MsgDb leftMsgDb = new MsgDb();
		String leftsql = SQLBuilder.getNewMsgOfBlog(userName);	
        ThreadBlockIterator leftirmsg = leftMsgDb.getThreads(leftsql, leftMsgDb.getVirtualBoardcodeOfBlogUser(userName, ""), 0, 10);
		while (leftirmsg.hasNext()) {
			leftMsgDb = (MsgDb) leftirmsg.next();%>
	<table width="100%" border="0">
      <tr>
        <td width="14%">&nbsp;</td>
        <td><a href="../forum/showblog.jsp?rootid=<%=leftMsgDb.getId()%>" title="<%=leftMsgDb.getTitle()%>"><%=StrUtil.getLeft(leftMsgDb.getTitle(), 26)%></a></td>
      </tr>
    </table>
	<%}
	%>	</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td class="blog_td_spacer_up"></td>
        </tr>
        <tr>
          <td class="blog_td_title"><li class="titleBar">&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.blog.left" key="new_comment"/></li> </td>
        </tr>
        <tr>
          <td class="blog_td_spacer_down"></td>
        </tr>
      </table>
	<%
	leftsql = SQLBuilder.getNewReplySqlOfBlog(userName);  // "select id from sq_message where isBlog=1 and replyRootName=" + StrUtil.sqlstr(userName) + " order by lydate desc";
	ListResult leftlr = leftMsgDb.list(leftsql, 1, 10);
	DefaultRender leftRender = new DefaultRender();
	if (leftlr!=null) {
		leftv = leftlr.getResult();
		leftir = leftv.iterator();
		while (leftir.hasNext()) {
			leftMsgDb = (MsgDb)leftir.next();
			if (leftMsgDb.getMsgDb(leftMsgDb.getRootid()).getCheckStatus()==MsgDb.CHECK_STATUS_PASS) {
			%>
			<table width="100%" border="0">
              <tr>
                <td width="14%">&nbsp;</td>
                <td><a href="../userinfo.jsp?username=<%=leftMsgDb.getName()%>">[<%=um.getUser(leftMsgDb.getName()).getNick()%>]</a>&nbsp;&nbsp;&nbsp;<a href="../forum/showblog.jsp?rootid=<%=leftMsgDb.getRootid()%>&amp;op=allcomm#<%=leftMsgDb.getId()%>"><%=leftMsgDb.getTitle()%></a></td>
              </tr>
            </table>
		<% }
		}
	}
	%>	<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td class="blog_td_spacer_up"></td>
          </tr>
          <tr>
            <td class="blog_td_title"><li class="titleBar">&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.blog.left" key="blog_statistics"/></li></td>
          </tr>
          <tr>
            <td class="blog_td_spacer_down"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0">
              <tr>
                <td width="14%">&nbsp;</td>
                <td><lt:Label res="res.label.blog.left" key="article"/><%=ucd.getMsgCount()%></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><lt:Label res="res.label.blog.left" key="comment"/><%=ucd.getReplyCount()%></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><lt:Label res="res.label.blog.left" key="visit"/><%=ucd.getViewCount()%></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td class="blog_td_spacer_up"></td>
        </tr>
        <tr>
          <td class="blog_td_title"><li class="titleBar">&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.blog.left" key="link"/></li> </td>
        </tr>
        <tr>
          <td class="blog_td_spacer_down"></td>
        </tr>
      </table>
	
	  <%
				LinkDb leftld = new LinkDb();
				String listsql = "select id from " + leftld.getTableName() + " where userName=" + StrUtil.sqlstr(userName) + " and kind=" + StrUtil.sqlstr(leftld.KIND_USER_BLOG) + " order by sort";
				Iterator leftirlink = leftld.list(listsql).iterator();
				while (leftirlink.hasNext())
				{
					leftld = (LinkDb) leftirlink.next();
				%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="p9">
        <tr>
          <td width="14%" height="20">&nbsp;</td>
          <td>&nbsp;<span class="dirItem">
		  <a target="_blank" href="<%=leftld.getUrl()%>" title="<%=leftld.getTitle()%>">
					<%if (leftld.getImage()!=null && !leftld.getImage().equals("")) {%>
						<img src="../<%=leftld.getImage()%>" border=0>
					<%}else{%>
						<%=leftld.getTitle()%>
					<%}%>
		  </a>
		  </span></td>
        </tr>
      </table>
    <%}%></td>
  </tr>
</table>
