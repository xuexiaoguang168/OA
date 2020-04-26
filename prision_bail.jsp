<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link href="forum/<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<title><lt:Label res="res.label.prision" key="vist_prisionor"/> - <%=Global.AppName%></title>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body>
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="fdate" scope="page" class="cn.js.fan.util.DateUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="prision" scope="page" class="com.redmoon.forum.life.prision.Prision"/>
<div id="newdiv" name="newdiv">
<%
String op = StrUtil.getNullString(request.getParameter("op"));
int baildlt = prision.getBailDlt();
if (op.equals("bail")) {
	boolean re = false;
	String username = ParamUtil.get(request, "username");
	try {
		re = prision.bail(request);
	}
	catch (ErrMsgException e) {
		out.println(StrUtil.p_center("<font color=red>"+e.getMessage()+"</font>"));
	}
	if (re)
		out.println(StrUtil.Alert(username+SkinUtil.LoadString(request,"info_operate_success")));
	else
		out.println(StrUtil.Alert(username+SkinUtil.LoadString(request,"info_operate_fail")));
}
%>
<table width="98%" border="0" align="center">
	<form id=formsearch name=formsearch action="?op=search" method=post>
        <tr>
        <td align="center"><lt:Label res="res.label.prision" key="search_user"/> 
          <input name="username" type="text" class="singleboarder">
          &nbsp; 
          <input name="Submit" type="submit" class="singleboarder" value="<%=SkinUtil.LoadString(request,"res.label.prision","user_name_search")%>">
          </td>
        </tr></form>
  </table>
  <div align="center"><br>
    <strong><font color="#6666DF"><lt:Label res="res.label.prision" key="list_prisionor"/></font>    </strong></div>
<%
		String sql = "select name from sq_user where arrestday>0 and releasetime > " + System.currentTimeMillis() + " ORDER BY RegDate";
		if (op.equals("search")) {
			String username = ParamUtil.get(request, "username");
			sql = "select name from sq_user where arrestday>0 and releasetime > " + System.currentTimeMillis() + " and name like "+StrUtil.sqlstr("%"+username+"%")+" ORDER BY RegDate";
		}
				
		int credit = 0;
			
		int pagesize = 10;
		ResultRecord rr = null;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		PageConn pageconn = new PageConn(Global.defaultDB, curpage, pagesize);
		ResultIterator ri = pageconn.getResultIterator(sql);
		paginator.init(pageconn.getTotal(), pagesize);
		//设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
  <table width="98%" border="0" align="center" class="p9">
    <tr>
      <td align="right"><lt:Label res="res.label.prision" key="count"/> <b><%=paginator.getTotal() %></b> <lt:Label res="res.label.prision" key="per_page"/> <b><%=paginator.getPageSize() %></b> 
        <lt:Label res="res.label.prision" key="page"/> <b><%=curpage %>/<%=totalpages %></b></td>
    </tr>
  </table>    
  <TABLE width="98%" 
border=0 align=center cellPadding=0 cellSpacing=1 bgcolor="#edeced">
    <TBODY>
      <TR align=center class="text_title"> 
        <TD width=17% height=23 background="forum/<%=skinPath%>/images/bg1.gif"><lt:Label res="res.label.prision" key="user_name"/></TD>
        <TD width=9% background="forum/<%=skinPath%>/images/bg1.gif"><lt:Label res="res.label.prision" key="arrested_time"/></TD>
        <TD width=30% background="forum/<%=skinPath%>/images/bg1.gif"><lt:Label res="res.label.prision" key="arrested_reason"/></TD>
        <TD width=8% background="forum/<%=skinPath%>/images/bg1.gif"><lt:Label res="res.label.prision" key="arrested_days"/></TD>
      <TD width=9% background="forum/<%=skinPath%>/images/bg1.gif"><lt:Label res="res.label.prision" key="arrester"/></TD>
        <TD width=16% background="forum/<%=skinPath%>/images/bg1.gif"><lt:Label res="res.label.prision" key="bail_money"/></TD>
        <TD width="11%" background="forum/<%=skinPath%>/images/bg1.gif"%><%=SkinUtil.LoadString(request,"op")%></TD>
      </TR>
      <%		
String id="",name="",RegDate="",Gender="",OICQ="",State="",myface="",arrestreason="",arrestpolice="";
Date arresttime = null;
int layer = 1,ispolice=0,arrestday=0;
int i = 0;
String RealPic = "";
UserDb user = new UserDb();

while (ri.hasNext()) {
 	    rr = (ResultRecord)ri.next(); 
		i++;
		name = rr.getString("name");
		user = user.getUser(name);
		
		RegDate = DateUtil.format(user.getRegDate(), "yyyy-MM-dd");
		Gender = StrUtil.getNullString(user.getGender());
		if (Gender.equals("M"))
			Gender = SkinUtil.LoadString(request,"res.label.prision","man");
		else if (Gender.equals("F"))
			Gender = SkinUtil.LoadString(request,"res.label.prision","woman");
		else
			Gender = SkinUtil.LoadString(request,"res.label.prision","not_in_detail");
		
		
		OICQ = StrUtil.getNullString(user.getOicq());
		State = StrUtil.getNullString(user.getState());
		if (State.equals("0"))
			State = SkinUtil.LoadString(request,"res.label.prision","not_in_detail");
		RealPic = StrUtil.getNullString(user.getRealPic());
		myface = StrUtil.getNullString(user.getMyface());
		ispolice = user.getIsPolice();
		arrestday = user.getArrestDay();
		arrestreason = StrUtil.getNullString(user.getArrestReason());
		arresttime = user.getArrestTime();
		arrestpolice = StrUtil.getNullString(user.getArrestPolice());
		credit = user.getCredit();
%>
      <TR align=center bgColor=#f8f8f8> 
        <TD width=17% height=23 align="left"> &nbsp; <%if (myface.equals("")) {%> <img src="forum/images/face/<%=RealPic%>" width=16 height=16> 
          <%}else{%> <img src="forum/images/myface/<%=myface%>" width=16 height=16> 
          <%}%> <a href="userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=user.getNick()%></a>
		  <input type=hidden name=username value="<%=name%>">
		  <input type=hidden name=CPages value="<%=curpage%>">
	    </TD>
        <TD width=9%><%
		String artime = "";
		if (arresttime==null)
			artime = "";
		else
			artime = StrUtil.FormatDate(arresttime,"yyyy-MM-dd");
		%>
        <%=artime%></TD>
        <TD width=30%><%=arrestreason%></TD>
        <TD width=8%><%=arrestday%></TD>
      <TD width=9%><a href="userinfo.jsp?username=<%=arrestpolice%>"><%=user.getUser(arrestpolice).getNick()%></a>        </TD>
        <TD width=16%>
		<%
		int bailfee = baildlt*arrestday;
		%>
		<%=bailfee%>
		</TD>
        <TD>
	  <a href="javascript:window.location.href='prision_bail.jsp?op=bail&username=<%=name%>&CPages=<%=curpage%>'"><lt:Label res="res.label.prision" key="to_libreate"/></a>      </TD>
      </TR>
<%}%>
    </TBODY>
  </TABLE>
	
  <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td width="2%" height="23">&nbsp;</td>
      <td width="76%" valign="baseline" height="23"> <div align="right"> 
          <%
	  String querystr = "";
 	  out.print(paginator.getCurPageBlock("prision_bail.jsp?"+querystr));
	  %>
	</div></td>
      <td width="22%" height="23"> 
	  </td>
    </tr>
  </table>
</div>
</body>
</html>
