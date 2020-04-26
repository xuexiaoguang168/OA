<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.base.*"%>
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
<link href="forum/<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<title><lt:Label res="res.label.listmember" key="list_member"/> - <%=Global.AppName%></title>
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
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<div id="newdiv" name="newdiv">
<%
//安全验证
String targeturl = StrUtil.getUrl(request);
//if (!privilege.isUserLogin(request)) {
	//response.sendRedirect("door.jsp?targeturl="+targeturl);
	//return;
//}
%>
  <div align="center"><br>
    <strong><font color="#6666DF"><lt:Label res="res.label.listmember" key="list_member"/></font><br>
    <br>
    </strong></div>
<%
		String sql = "select name from sq_user where isValid=1 ORDER BY RegDate desc";
		int pagesize = 10;
		ResultRecord rr = null;
		Paginator paginator = new Paginator(request);
		
		UserDb user = new UserDb();
		
		long total = user.getObjectCount(sql);
		paginator.init(total, pagesize);
		
		//设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		
		int curpage = paginator.getCurPage();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}			
		ObjectBlockIterator oir = user.getObjects(sql, (curpage-1)*pagesize, curpage*pagesize);

%>
  <table width="100%" border="0" class="p9">
    <tr>
      <td align="right"><lt:Label res="res.label.listmember" key="count"/><b><%=paginator.getTotal() %></b> <lt:Label res="res.label.listmember" key="per_page"/><b><%=paginator.getPageSize() %></b> 
        <lt:Label res="res.label.listmember" key="page"/> <b><%=curpage %>/<%=totalpages %></b></td>
    </tr>
  </table>    
  <TABLE width="98%" 
border=0 align=center cellPadding=0 cellSpacing=1 bgcolor="#edeced">
    <TBODY>
      <TR align=center bgColor=#f8f8f8 class="td_title"> 
        <TD width=26% height=23><strong><lt:Label res="res.label.listmember" key="user_name"/></strong></TD>
        <TD width=29% height=23><strong><lt:Label res="res.label.listmember" key="sex"/></strong></TD>
        <TD width=15% height=23><strong><lt:Label res="res.label.listmember" key="job"/>
        </strong></TD>
        <TD width=13%><strong><lt:Label res="res.label.listmember" key="provice"/></strong></TD>
        <TD width=17% height=23><strong><lt:Label res="res.label.listmember" key="regist_date"/></strong></TD>
      </TR>
      <%		
String id="",name="",RegDate="",Gender="",OICQ="",State="",myface="";
int layer = 1;
int i = 0;
String RealPic = "";
while (oir.hasNext()) {
 	    user = (UserDb)oir.next(); 
	    i++;
		name = user.getName();
		RegDate = DateUtil.format(user.getRegDate(), "yyyy-MM-dd HH:mm");
		Gender = StrUtil.getNullString(user.getGender());
		if (Gender.equals("M"))
			Gender = SkinUtil.LoadString(request,"res.label.listmember","man");
		else if (Gender.equals("F"))
			Gender = SkinUtil.LoadString(request,"res.label.listmember","woman");
		else
			Gender = SkinUtil.LoadString(request,"res.label.listmember","bu_xian");
		
		OICQ = StrUtil.getNullString(user.getOicq());
		State = StrUtil.getNullString(user.getState());
		if (State.equals("0"))
			State = SkinUtil.LoadString(request,"res.label.listmember","bu_xian");
		RealPic = StrUtil.getNullString(user.getRealPic());
		myface = StrUtil.getNullString(user.getMyface());
%>
      <TR align=center bgColor=#f8f8f8> 
        <TD height=23 align="left"> &nbsp;
			  <%if (myface.equals("")) {%>
			  <img src="forum/images/face/<%=RealPic%>" width=16 height=16> 
			  <%}else{%>
			  <img src="images/myface/<%=myface%>" width=16 height=16>
			  <%}%>		
          <a href="userinfo.jsp?username=<%=StrUtil.UrlEncode(StrUtil.toHtml(name),"utf-8")%>"><%=user.getNick()%></a> 
        </TD>
        <TD width=29% height=23><%=Gender%></TD>
        <TD width=15% height=23><%=user.getCareer()%></TD>
        <TD width=13%><%=State%></TD>
        <TD width=17% height=23><%=RegDate%></TD>
      </TR>
<%}%>
    </TBODY>
  </TABLE>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td width="2%" height="23">&nbsp;</td>
      <td width="76%" valign="baseline" height="23"> <div align="right"> 
    <%
	  String querystr = "";
 	  out.print(paginator.getCurPageBlock("listmember.jsp?"+querystr));
	%>
	</div></td>
      <td width="22%" height="23"> 
		</td>
    </tr>
  </table>
</div>

<%@ include file="forum/inc/footer.jsp"%>
</body>
</html>
