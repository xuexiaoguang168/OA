<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
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
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<title><lt:Label res="res.label.forum.myfriend" key="myfriend"/> - <%=Global.AppName%></title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style></head>
<body>
<%@ include file="inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<div id="newdiv" name="newdiv">
<%
//安全验证
String querystring = StrUtil.getNullString(request.getQueryString());
String privurl=request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");
if (!privilege.isUserLogin(request))
{
	response.sendRedirect("../index.jsp");
	return;
}
%>
<%
UserFriendDb ufd = new UserFriendDb();

String op = StrUtil.getNullString(request.getParameter("op"));
if (op.equals("del"))
{
	int delid = ParamUtil.getInt(request, "delid");
	ufd = ufd.getUserFriendDb(delid);
	boolean re = ufd.del();
	if (re)
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	else
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_fail")));
}

String sql = "select id from sq_friend where name="+StrUtil.sqlstr(privilege.getUser(request));
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
					
		ListResult lr = ufd.listResult(sql, curpage, pagesize);
		int total = lr.getTotal();
		Vector v = lr.getResult();
	    Iterator ir = null;
		if (v!=null)
			ir = v.iterator();
		paginator.init(total, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
  <div align="center"><font color="#706AD9"><br>
    <strong><lt:Label res="res.label.forum.myfriend" key="myfriend"/></strong></font><strong><br>
    <br>
    </strong></div> 
    
  <TABLE width="98%" 
border=0 align=center cellPadding=0 cellSpacing=1 bgcolor="#edeced">
    <TBODY>
      <TR class="td_title"> 
        <TD width=131 height=23 align="center"><lt:Label res="res.label.forum.myfriend" key="user_name"/></TD>
        <TD width=122 height=23 align="center">OICQ</TD>
        <TD width=130 height=23 align="center"><lt:Label res="res.label.forum.myfriend" key="birthday"/></TD>
        <TD width=161 align="center"><lt:Label res="res.label.forum.myfriend" key="address"/></TD>
        <TD width=109 height=23 align="center"><lt:Label res="res.label.forum.myfriend" key="tel"/></TD>
        <TD width=78 align="center"><lt:Label key="op"/></TD>
      </TR>
      <%		
String name="",OICQ="",birthday="",address="",phone="";
String RealPic = "";
int i = 1;
UserDb ud = new UserDb();
while (ir.hasNext())
{
	i++;
	ufd = (UserFriendDb)ir.next();
	ud = ud.getUser(ufd.getFriend());
	name = ud.getName();
	OICQ = ud.getOicq();
	if (OICQ==null)
		OICQ = "";
	birthday = DateUtil.format(ud.getBirthday(), "yyyy-MM-dd");
	address = ud.getAddress();
	phone = ud.getPhone();
	RealPic = StrUtil.getNullString(ud.getRealPic());
%>
      <TR bgColor=#f8f8f8> 
        <TD width=131 height=23> &nbsp;<img height=16 src="images/face/<%=RealPic%>" width=16> 
          <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=ud.getNick()%></a> </TD>
        <TD width=122 height=23 align="center"><%=OICQ%></TD>
        <TD width=130 height=23 align="center"><%=birthday%></TD>
        <TD width=161 align="center"><%=address%></TD>
        <TD width=109 height=23 align="center"><%=phone%></TD>
        <TD width=78 height=23 align="center"><a href="myfriend.jsp?op=del&delid=<%=ufd.getId()%>"><lt:Label key="op_del"/></a></TD>
      </TR>
<%
}
%>
    </TBODY>
  </TABLE>
 </div>
<%@ include file="inc/footer.jsp"%>
</body>
</html>
