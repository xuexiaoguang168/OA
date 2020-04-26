<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.forum.*"%>
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
<title><%=Global.AppName%> - <lt:Label res="res.label.forum.showonline" key="view_online"/></title>
<style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
-->
</style></head>
<body>
<%@ include file="inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<div id="newdiv" name="newdiv">
<%
String querystring = StrUtil.getNullString(request.getQueryString());
String privurl=request.getRequestURL()+"?"+java.net.URLEncoder.encode(querystring,"utf-8");
// 安全验证
//if (!privilege.isUserLogin(request))
//{
//	response.sendRedirect("../door.jsp");
//	return;
//}
%>
  <div align="center"><br>
    <strong><font color="#6666DF"><lt:Label res="res.label.forum.showonline" key="view_online"/></font><br>
    <br>
    </strong></div>
<%
		int pagesize = 10;
		String sql = "select t1.*,t2.RealPic,t2.myface,t2.nick from sq_online t1 left join sq_user t2 on t1.name=t2.name ORDER BY logtime";
		
		ResultRecord rr = null;
			
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		PageConn pageconn = new PageConn(Global.defaultDB, curpage, pagesize);
		ResultIterator ri = pageconn.getResultIterator(sql);
		paginator.init(pageconn.getTotal(), pagesize);
		
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
<TABLE class="list" border=1 align=center cellPadding=1 cellSpacing=0 bordercolor="<%=skin.getTableBorderClr()%>">
    <TBODY>
      <TR align=center bgColor=#f8f8f8 class="td_title"> 
        <TD width=192 height=23><lt:Label res="res.label.forum.showonline" key="user_name"/></TD>
        <TD width=197 height=23><lt:Label res="res.label.forum.showonline" key="cur_pos"/></TD>
        <TD width=160 height=23>IP</TD>
        <TD width=201 height=23><lt:Label res="res.label.forum.showonline" key="login_date"/></TD>
      </TR>
   <%		
String id="",name="",ip="",logtime="",doing="",boardname="",myface="";
int layer = 1;
int i = 1;
int p = 0;
int covered = 0;
String RealPic = "";
Leaf leaf = new Leaf();
while (ri.hasNext()) {
 	    rr = (ResultRecord)ri.next(); 
	    i++;
	    name = rr.getString("name");
		logtime = com.redmoon.forum.ForumSkin.formatDateTime(request, DateUtil.parse(rr.getString("logtime")));
		doing = rr.getString("doing");
		ip = rr.getString("ip");
		if (!privilege.isMasterLogin(request))
		{
			p = ip.indexOf(".");
			p = ip.indexOf(".",p+1);
			ip = ip.substring(0,p)+".*.*";
		}
		
		String boardcode = StrUtil.getNullString(rr.getString("boardcode"));
		boardname = "";
		if (!boardcode.equals("")) {
			leaf = leaf.getLeaf(boardcode);
			boardname = leaf.getName();
		}
		covered = rr.getInt("covered");
		RealPic = StrUtil.getNullString(rr.getString("RealPic"));
		myface = StrUtil.getNullString(rr.getString("myface"));
%>
      <TR align=center bgColor=#f8f8f8> 
	       <TD width=192 height=23 align="left">&nbsp; 
		  <%
		  if (covered==0) {
			  if (myface.equals("")) {%>
				  <img src="images/face/<%=RealPic%>" width=16 height=16> 
			  <%}else{%>
				  <img src="../images/myface/<%=myface%>" width=16 height=16>
			  <%}
		  }%>		
          <% if (covered==1) {
		  		if (privilege.isMasterLogin(request)) { %>
		          <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=rr.getString("nick")%></a>(<lt:Label res="res.label.forum.showonline" key="login_hide"/>) 
          <% 	}
		  		else {%>
				  <lt:Label res="res.label.forum.showonline" key="login_hide"/>
			<%	}
			}
			else{
				if (rr.getInt("isguest")==0) {
			%>
		          <a href="../userinfo.jsp?username=<%=StrUtil.UrlEncode(name)%>"><%=rr.getString("nick")%></a> 
		  		<%} else {%>
					<lt:Label res="res.label.forum.showonline" key="guest"/>
			<%	}
			}%>
        </TD>
        <TD width=197 height=23>&nbsp;<a href="listtopic.jsp?boardcode=<%=StrUtil.UrlEncode(leaf.getCode())%>"><%=boardname%></a></TD>
        <TD width=160 height=23><%=ip%></TD>
        <TD width=201 height=23><%=logtime%></TD>
      </TR>
<%}%>
    </TBODY>
  </TABLE>
	
  <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td width="2%" height="23">&nbsp;</td>
      <td height="23" valign="baseline"> <div align="right"> 
    <%
	  String querystr = "";
 	  out.print(paginator.getCurPageBlock(request, "showonline.jsp?"+querystr));
	%>
	</div>	  </td>
    </tr>
  </table>
</div>
<%@ include file="inc/footer.jsp"%>
</body>
</html>
