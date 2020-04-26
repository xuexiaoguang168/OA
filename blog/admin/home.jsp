<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*,
				 java.text.*,
				 com.redmoon.blog.*,
				 com.redmoon.forum.person.*,
				 cn.js.fan.db.*,
				 cn.js.fan.util.*,
				 cn.js.fan.module.cms.*,
				 cn.js.fan.web.*,
				 cn.js.fan.module.pvg.*"
%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<HTML><HEAD><TITLE><lt:Label res="res.label.blog.admin.home" key="title"/></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="images/default.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.3790.259" name=GENERATOR>
<style type="text/css">
<!--
.style1 {	font-size: 14px;
	font-weight: bold;
}
-->
</style>
</HEAD>
<BODY text=#000000 bgColor=#eeeeee leftMargin=0 topMargin=0>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isMasterLogin(request))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

BlogDb bd = new BlogDb();
bd = bd.getBlogDb();

String op = ParamUtil.get(request, "op");
if (op.equals("star")) {
	String star = ParamUtil.get(request, "star");
	if (star.equals("")) {
	}
	else {
		UserDb ud = new UserDb();
		ud = ud.getUser(star);
		if (ud!=null && ud.isLoaded()) {
			UserConfigDb ucd = new UserConfigDb();
			ucd = ucd.getUserConfigDb(star);
			if (ucd!=null && ucd.isLoaded()) {
				bd.setStar(star);
				bd.save();
			}
			else {
				String str = SkinUtil.LoadString(request,"res.label.blog.admin.home", "user_blog_not_open");
				str = StrUtil.format(str, new Object[] {star});
				out.print(StrUtil.Alert(str));
			}
		}
		else{
		    String str = SkinUtil.LoadString(request,"res.label.blog.admin.home", "user_not_have");
			str = StrUtil.format(str, new Object[] {star});
			out.print(StrUtil.Alert(str));
		}
	}
}

if (op.equals("setHomeClass")) {
	String homeClasses = ParamUtil.get(request, "homeClasses");
	bd.setHomeClasses(homeClasses);
	if (bd.save())
		;
	else
		out.print(SkinUtil.LoadString(request,"res.common", "info_op_fail"));
}

if (op.equals("setRecommandBlogs")) {
	String recommandBlogs = ParamUtil.get(request, "recommandBlogs");
	bd.setRecommandBlogs(recommandBlogs);
	if (bd.save())
		;
	else
		out.print(SkinUtil.LoadString(request,"res.common", "info_op_fail"));
}

if (op.equals("refreshHome")) {
	BlogCache bc = new BlogCache();
	bc.refreshHomePage();
}
%>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD class=head><lt:Label res="res.label.blog.admin.home" key="blog_first_page_manage"/>&nbsp;&nbsp;&nbsp;<a href="?op=refreshHome"><lt:Label res="res.label.blog.admin.home" key="reflash_first_page"/></a></TD>
  </TR></TBODY></TABLE>
<br>
<table width="46%" border='0' align="center" cellpadding='5' cellspacing='0' class="tableframe_gray">
  <tr>
    <td height=20 align="center" class="thead style1"><lt:Label res="res.label.blog.admin.home" key="blog_star"/></td>
  </tr>
  <tr>
    <td valign="top">
	<%
	String star = StrUtil.getNullString(bd.getStar());
	if (!star.equals("")) {
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><font color="#FF0000">
        <%
		UserConfigDb ucd = new UserConfigDb();
		ucd = ucd.getUserConfigDb(star);
		UserDb user = new UserDb();
		user = user.getUser(star);
		int myfacewidth=120,myfaceheight=150;
		String myface = user.getMyface();
		myfacewidth = user.getMyfaceWidth();
		myfaceheight = user.getMyfaceHeight();
		String RealPic = user.getRealPic();  
	  if (myface.equals("")) {%>
          <img src="../../forum/images/face/<%=RealPic%>"/>
          <%}else{%>
          <img src="../../images/myface/<%=myface%>" name="tus" width="<%=myfacewidth%>" height="<%=myfaceheight%>" id="tus" />
          <%}%>
        </font></td>
        </tr>
      <tr>
        <td><a href="../myblog.jsp?userName=<%=StrUtil.UrlEncode(star)%>" target="_blank"><%=ucd.getTitle()%></a></td>
      </tr>
      <tr>
        <td><%=ucd.getSubtitle()%></td>
      </tr>
    </table>
	
	<%
	}
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<form action="?op=star" method="post">
      <tr>
        <td><input type="text" name="star" value="<%=star%>"><input type="submit" value="<lt:Label res="res.label.blog.admin.home" key="set_blog_star"/>"></td>
      </tr>
	 </form>
    </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="46%" height="175" border='0' align="center" cellpadding='5' cellspacing='0' class="tableframe_gray">
  <tr>
    <td height=20 align="center" class="thead style1"><lt:Label res="res.label.blog.admin.home" key="set_first_page_class"/></td>
  </tr>
  <tr>
    <td height="145" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <form action="?op=setHomeClass" method="post">
        <tr>
          <td><input name="homeClasses" type="text" value="<%=StrUtil.getNullString(bd.getHomeClasses())%>" size="50">
              <input name="submit" type="submit" value="<lt:Label res="res.label.blog.admin.home" key="set_class"/>">
              <br>
            <lt:Label res="res.label.blog.admin.home" key="class_description"/></td>
        </tr>
        <tr>
          <td>
		  <%
			Vector v = bd.getAllHomeClasses();
			int nsize = v.size();
			if (nsize==0)
				out.print(SkinUtil.LoadString(request,"res.label.blog.admin.home", "not_class"));
			else {
				Iterator ir = v.iterator();
				while (ir.hasNext()) {
					com.redmoon.blog.Leaf lf = (com.redmoon.blog.Leaf)ir.next();
			%>
					<table width="100%">
					<tr>
					<td><li><%=lf.getName()%></li></td>
					<td>
					<%
					if (ir.hasNext()) {
						lf = (com.redmoon.blog.Leaf)ir.next();
					%>
						<li><%=lf.getName()%></li>
					<%}%>
					</td>
					</tr></table>
			<%
				}
			}
		  %>
		  </td>
        </tr>
      </form>
    </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="46%" height="135" border='0' align="center" cellpadding='5' cellspacing='0' class="tableframe_gray">
  <tr>
    <td height=20 align="center" class="thead style1"><lt:Label res="res.label.blog.admin.home" key="commend_blog"/></td>
  </tr>
  <tr>
    <td height="105" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <form action="?op=setRecommandBlogs" method="post">
        <tr>
          <td><input name="recommandBlogs" type="text" value="<%=StrUtil.getNullString(bd.getRecommandBlogs())%>" size="50">
                <input name="submit2" type="submit" value="<lt:Label res="res.label.blog.admin.home" key="commend"/>">
                <br>
            <lt:Label res="res.label.blog.admin.home" key="comment_description"/></td>
        </tr>
        <tr>
          <td><%
			v = bd.getAllRecommandBlogs();
			nsize = v.size();
			if (nsize==0)
				out.print(SkinUtil.LoadString(request,"res.label.blog.admin.home", "not_commend_blog"));
			else {
				Iterator ir = v.iterator();
				while (ir.hasNext()) {
					UserConfigDb ucd = (UserConfigDb)ir.next();
			%>
                <table width="100%">
                  <tr>
                    <td><li><a href="../myblog.jsp?userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>" target="_blank"><%=ucd.getUserName()%></a></li></td>
                  </tr>
                </table>
            <%
				}
			}
		  %>
          </td>
        </tr>
      </form>
    </table></td>
  </tr>
</table>
<br>
</BODY></HTML>
