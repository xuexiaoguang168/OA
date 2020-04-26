<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.treasure.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.blog.*"%>
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
<html><head>
<meta http-equiv="pragma" content="no-cache">
<link href="forum/<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><lt:Label res="res.label.usercenter" key="user_center"/> - <%=Global.AppName%></title>
<style type="text/css">
<!--
.style1 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
<body topmargin='0' leftmargin='0'>
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isUserLogin(request)) {
	response.sendRedirect("info.jsp?op=login&info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "err_not_login")));
	return;
}

String userName = privilege.getUser(request);
UserDb user = new UserDb();
user = user.getUser(userName);

String op = ParamUtil.get(request, "op");

int myfacewidth=120,myfaceheight=150;
String name="",lydate="",content="",topic="";
String RegDate="",Gender="",RealPic="",email="",sign="",myface="";
int experience=0;
int credit=0;
int addcount=0;

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
sign = user.getSign();
myface = StrUtil.getNullStr(user.getMyface());
myfacewidth = user.getMyfaceWidth();
myfaceheight = user.getMyfaceHeight();
%>
<br>
<%
int pagesize = 10;
Paginator paginator = new Paginator(request);

TreasureUserDb tu = new TreasureUserDb();
String sql = "select userName,treasureCode from " + tu.getTableName() + " where userName=" + StrUtil.sqlstr(userName);
int total = tu.getObjectCount(sql);
int curpage = paginator.getCurPage();
paginator.init(total, pagesize);
//设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}
%>
<table width='780' border="0" align="center" cellpadding='0' cellspacing='1' >
  <tr>
    <td colspan="2" height="25" align="center" background="forum/<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.usercenter" key="user_center"/></td>
  </tr>
  <tr>
    <td width="18%" align="center" valign="top" bgcolor="#F5F5F5" class="head">&nbsp;&nbsp;
        <table cellspacing=0 cellpadding=0 width="90%" align=center 
border=0>
          <tbody>
            <tr>
              <td align=left><table style="FILTER: glow(color=a4b6d7)">
                  <caption>
                  <b><font style="FONT-SIZE: 10pt" 
                    color=#ffffff><%=user.getNick()%></font></b>
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
              <td align=left height=42><%if (myface.equals("")) {%>
                  <img src="forum/images/face/<%=RealPic%>">
                  <%}else{%>
                  <img src="images/myface/<%=myface%>" width=<%=myfacewidth%> height=<%=myfaceheight%>>
                  <%}%>
              </td>
            </tr>
            <tr>
              <td align=left height=17><img src="forum/images/<%=user.getLevelPic()%>"> <%=Gender%></td>
            </tr>
            <tr>
              <td align=left height=54><lt:Label res="res.label.forum.showtopic" key="rank"/><%=user.getLevelDesc()%><br>
<lt:Label res="res.label.forum.showtopic" key="experience"/><%=experience%><br>
<lt:Label res="res.label.forum.showtopic" key="credit"/><%=credit%><br>
<%
						ScoreMgr sm = new ScoreMgr();
						ScoreUnit su = sm.getScoreUnit("gold");
						out.print(StrUtil.toHtml(su.getName(request)));
						%>
：<%=user.getGold()%><br>
<lt:Label res="res.label.forum.showtopic" key="topic_count"/><%=addcount%> <br>
<lt:Label res="res.label.forum.showtopic" key="topic_elite"/><%=user.getEliteCount()%><br>
<lt:Label res="res.label.forum.showtopic" key="reg_date"/><%=RegDate%> <br>
<lt:Label res="res.label.forum.showtopic" key="online_status"/><%
						OnlineUserDb ou = new OnlineUserDb();
						ou = ou.getOnlineUserDb(user.getName());
						if (ou.isLoaded())
							out.print(SkinUtil.LoadString(request, "res.label.forum.showtopic", "online_status_yes")); // "在线");
						else
							out.print(SkinUtil.LoadString(request, "res.label.forum.showtopic", "online_status_no")); // "离线");
						%>
<%
						com.redmoon.forum.Config cfg1 = new com.redmoon.forum.Config();
						if (cfg1.getBooleanProperty("forum.showFlowerEgg")) {
							UserPropDb up = new UserPropDb();
							up = up.getUserPropDb(user.getName());
						%>
<BR>
<img src="images/flower.gif">&nbsp;(<%=up.getInt("flower_count")%>)&nbsp;&nbsp;&nbsp; <img src="images/egg.gif">&nbsp;(<%=up.getInt("egg_count")%>)
<%}
						%></td>
            </tr>
          </tbody>
        </table>
          
    </td>
    <td width="82%" align="center" valign="top" bgcolor="#F7F7F7" class="head"><table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
      <tr>
        <td align="left" valign="top" bgcolor="#F7F7F7" class="head"><a href="myinfo.jsp"><lt:Label res="res.label.usercenter" key="modify_myinfo"/></a>&nbsp;</td>
        <td width="55%" align="left" valign="top" bgcolor="#F7F7F7" class="head"><a href="javascript:hopenWin('../message/message.jsp',320,260)"></a><a href="forum/myfriend.jsp"><lt:Label res="res.label.usercenter" key="list_myfriend"/></a></td>
      </tr>
      <tr>
        <td align="left" valign="top" bgcolor="#F7F7F7" class="head"><a href="forum/mytopic.jsp?action=mytopic"><lt:Label res="res.label.usercenter" key="mytopic"/></a></td>
        <td align="left" valign="top" bgcolor="#F7F7F7" class="head"><a href="javascript:hopenWin('message/send.jsp',320,260)"><lt:Label res="res.label.usercenter" key="send_bbs_message"/></a></td>
      </tr>
      <tr>
        <td align="left" valign="top" bgcolor="#F7F7F7" class="head"><a href="forum/myfavoriate.jsp"><lt:Label res="res.label.usercenter" key="myfavoriate"/></a>&nbsp;</td>
        <td align="left" valign="top" bgcolor="#F7F7F7" class="head"><%
if (Global.hasBlog) {
	UserConfigDb ucd = new UserConfigDb();
	ucd = ucd.getUserConfigDb(userName);
	if (ucd.isLoaded()) {
	%>
          <a href="blog/user/frame.jsp?userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.usercenter" key="blog_mgr"/></a>
          <%}else{%>
          <a href="blog/user/userconfig_add.jsp"><lt:Label res="res.label.usercenter" key="userconfig_add"/></a>
          <%}
}%></td>
      </tr>
      <tr>
        <td colspan="2" align="left" valign="top" bgcolor="#F7F7F7" class="head"><a title="<lt:Label res="res.label.usercenter" key="ad_msg"/>" href="#"><lt:Label res="res.label.usercenter" key="ad_link"/></a> ： <%=Global.getRootPath()%>/ad_user_link.jsp?userId=<%=user.getId()%></td>
        </tr>
      <tr>
        <td colspan="2" align="center" valign="top" bgcolor="#F7F7F7" class="head"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="15%"><lt:Label res="res.label.usercenter" key="disk_space"/></td>
              <td width="53%" height="22"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height=16 bgcolor="#CCCCCC"><%
	int wpercent = (int)Math.round((double)user.getDiskSpaceUsed()/user.getDiskSpaceAllowed()*100);
	%>
                        <img src=forum/images/vote/bar1.gif width="<%=wpercent%>%" height=16></td>
                  </tr>
              </table></td>
              <td width="32%">&nbsp;<lt:Label res="res.label.usercenter" key="disk_space_used"/><%=wpercent%>%&nbsp;(<%=user.getDiskSpaceUsed()%>)<lt:Label res="res.label.usercenter" key="disk_space_allowed"/><%=NumberUtil.round((double)user.getDiskSpaceAllowed()/1024000, 1)%>M</td>
              </tr>
                </table></td>
        </tr>
      
    </table>
        <table width="100%" border="0" cellspacing="1" bgcolor="#FFFFFF">
          <tr>
            <td height="24" colspan="6" bgcolor="#F7F7F7">&nbsp;<strong><lt:Label res="res.label.usercenter" key="user_priv"/></strong></td>
          </tr>
          <tr>
            <td width="18%" height="24" align="center" bgcolor="#F7F7F7">
              <lt:Label res="res.forum.person.UserPrivDb" key="add_topic"/>            </td>
            <td width="17%" align="center" bgcolor="#F7F7F7">              <lt:Label res="res.forum.person.UserPrivDb" key="reply_topic"/>            </td>
            <td width="17%" align="center" bgcolor="#F7F7F7">              <lt:Label res="res.forum.person.UserPrivDb" key="attach_upload"/>            </td>
            <td width="15%" align="center" bgcolor="#F7F7F7">              <lt:Label res="res.forum.person.UserPrivDb" key="attach_download"/>            </td>
            <td width="16%" align="center" bgcolor="#F7F7F7">              <lt:Label res="res.forum.person.UserPrivDb" key="vote"/>            </td>
            <td width="17%" align="center" bgcolor="#F7F7F7">              <lt:Label res="res.forum.person.UserPrivDb" key="search"/>            </td>
          </tr>
          <tr>
            <td height="24" align="center" bgcolor="#F7F7F7">
			<%
			UserPrivDb upd = new UserPrivDb();
			upd = upd.getUserPrivDb(user.getName());
			if (upd.getBoolean("add_topic"))
				out.print("√");
			else
				out.print("×");
			%>			</td>
            <td align="center" bgcolor="#F7F7F7"><%
			if (upd.getBoolean("reply_topic"))
				out.print("√");
			else
				out.print("×");
			%></td>
            <td align="center" bgcolor="#F7F7F7"><%
			if (upd.getBoolean("attach_upload"))
				out.print("√");
			else
				out.print("×");
			%></td>
            <td align="center" bgcolor="#F7F7F7"><%
			if (upd.getBoolean("attach_download"))
				out.print("√");
			else
				out.print("×");
			%></td>
            <td align="center" bgcolor="#F7F7F7"><%
			if (upd.getBoolean("vote"))
				out.print("√");
			else
				out.print("×");
			%></td>
            <td align="center" bgcolor="#F7F7F7"><%
			if (upd.getBoolean("search"))
				out.print("√");
			else
				out.print("×");
			%></td>
          </tr>
          <tr>
            <td height="24" align="center" bgcolor="#F7F7F7">              <lt:Label res="res.forum.person.UserPrivDb" key="attach_day_count"/>            </td>
            <td align="center" bgcolor="#F7F7F7">              <lt:Label res="res.forum.person.UserPrivDb" key="attach_size"/>            </td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
          </tr>
          <tr>
            <td height="24" align="center" bgcolor="#F7F7F7"><%=upd.getInt("attach_day_count")%></td>
            <td align="center" bgcolor="#F7F7F7"><%=upd.getInt("attach_size")%>(K)</td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
            <td align="center" bgcolor="#F7F7F7">&nbsp;</td>
          </tr>
        </table>
        <br>
        <table width="98%" height="153" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
          <tr>
            <td height=20 align="center" class="thead style1"><lt:Label res="res.label.usercenter" key="show_baby"/></td>
          </tr>
          <tr>
            <td height="133" valign="top"><br>
                <table width="86%" height="24" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td align="right"><div><lt:Label res="res.label.usercenter" key="right_records"/> <b><%=paginator.getTotal() %></b> <lt:Label res="res.label.usercenter" key="per_page"/> <b><%=paginator.getPageSize() %></b> <lt:Label res="res.label.usercenter" key="page"/> <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></div></td>
                  </tr>
                </table>
              <table width="86%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#666666"">
                  <tr align="center" bgcolor="#F1EDF3">
                    <td width="41%" height="22"><lt:Label res="res.label.usercenter" key="baby_name"/></td>
                    <td width="26%" height="22"><lt:Label res="res.label.usercenter" key="buy_date"/></td>
                    <td width="18%"><lt:Label res="res.label.usercenter" key="count"/></td>
                    <td width="15%"><%=SkinUtil.LoadString(request,"op")%></td>
                  </tr>
                  <%
Vector v = tu.list(sql, (curpage-1)*pagesize, curpage*pagesize-1);
TreasureMgr tmg = new TreasureMgr();
Iterator ir = v.iterator();
int i = 0;
while (ir.hasNext()) {
	tu = (TreasureUserDb)ir.next();
	i++;
%>
                  <form id="form<%=i%>" name="form<%=i%>" action="?op=modify" method="post">
                    <tr align="center">
                      <td height="22" bgcolor="#FFFFFF"><%
			String treasureCode = tu.getTreasureCode();
			TreasureUnit tun = tmg.getTreasureUnit(treasureCode);
			out.print(tun.getName());
			%>
                      </td>
                      <td height="22" bgcolor="#FFFFFF"><%=DateUtil.format(tu.getBuyDate(), "yy-MM-dd")%> </td>
                      <td bgcolor="#FFFFFF"><%=tu.getAmount()%></td>
                      <td height="22" bgcolor="#FFFFFF"><a href="forum/treasure_show.jsp?code=<%=StrUtil.UrlEncode(tu.getTreasureCode())%>"><lt:Label res="res.label.usercenter" key="view"/></a></td>
                    </tr>
                  </form>
                <%}%>
              </table>
              <table width="86%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
                  <tr>
                    <td height="23"><div align="right">
                        <%
	String querystr = "userName=" + StrUtil.UrlEncode(userName);
    out.print(paginator.getCurPageBlock("?"+querystr));
%>
                    </div></td>
                  </tr>
              </table></td>
          </tr>
    </table></td>
  </tr>
</table>
<%@ include file="forum/inc/footer.jsp"%>
</td> </tr>             
      </table>                                        
       </td>                                        
     </tr>                                        
 </table>                                                                      
</body>                                        
</html>                            
  