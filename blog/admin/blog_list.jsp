<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*,
				 java.text.*,
				 com.redmoon.blog.*,
				 cn.js.fan.db.*,
				 cn.js.fan.util.*,
				 com.redmoon.forum.person.UserMgr,
				 com.redmoon.forum.person.UserDb,
				 cn.js.fan.web.*,
				 cn.js.fan.module.pvg.*"
%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<HTML><HEAD><TITLE><lt:Label res="res.label.blog.admin.blog" key="title"/></TITLE>
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

String privurl;
String op = ParamUtil.get(request, "op");
if (op.equals("stop")) {
	privurl = ParamUtil.get(request, "privurl");
	String userName = ParamUtil.get(request, "userName");
	UserConfigDb uc = new UserConfigDb();
	uc = uc.getUserConfigDb(userName);
	int isValid = ParamUtil.getInt(request, "isValid");
	uc.setValid(isValid==1?true:false);
	if (uc.save()) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.common", "info_op_success"), privurl));
	}
	else {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.common", "info_op_fail"), privurl));
	}
}

if (op.equals("del")) {
	String userName = ParamUtil.get(request, "userName");
	UserConfigDb uc = new UserConfigDb();
	uc = uc.getUserConfigDb(userName);
	if (uc.del())
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.common", "info_op_success")));
	else
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.common", "info_op_fail")));
}

privurl = ParamUtil.get(request, "privurl");
%>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD class=head><lt:Label res="res.label.blog.admin.blog" key="blog_management"/></TD>
  </TR></TBODY></TABLE>
<br>
<%
int pagesize = 10;
Paginator paginator = new Paginator(request);

UserConfigDb ucd = new UserConfigDb();
String sql = "select userName from " + ucd.getTableName();
int total = ucd.getObjectCount(sql);
paginator.init(total, pagesize);
int curpage = paginator.getCurPage();
//设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}
%>
<table width="98%" height="227" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr>
    <td height=20 align="center" class="thead style1"><lt:Label res="res.label.blog.admin.blog" key="blog_list"/></td>
  </tr>
  <tr>
    <td valign="top"><br>
        <table width="86%" height="24" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right">
			<%=paginator.getPageStatics(request)%>
			</td>
          </tr>
        </table>
      <table width="86%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#666666"">
          <tr align="center" bgcolor="#F1EDF3">
            <td width="17%" height="22"><lt:Label res="res.label.blog.admin.blog" key="username"/></td>
            <td width="22%" height="22"><lt:Label res="res.label.blog.admin.blog" key="penname"/></td>
            <td width="21%"><lt:Label res="res.label.blog.admin.blog" key="adddate"/></td>
            <td width="26%"><lt:Label res="res.label.blog.admin.blog" key="operate"/></td>
          </tr>
          <%
Vector v = ucd.list(sql, (curpage-1)*pagesize, curpage*pagesize-1);
Iterator ir = v.iterator();
int i = 0;
UserMgr um = new UserMgr();
while (ir.hasNext()) {
	ucd = (UserConfigDb)ir.next();
	i++;
%>
          <form id="form<%=i%>" name="form<%=i%>" action="?op=modify" method="post">
            <tr align="center">
              <td height="22" bgcolor="#FFFFFF"><a target=_blank href="../myblog.jsp?userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>">
			  <%
			  UserDb ud = um.getUser(ucd.getUserName());
			  out.print(ud.getNick());
			  %>
			  </a>              </td>
              <td height="22" bgcolor="#FFFFFF"><%=ucd.getPenName()%></td>
              <td bgcolor="#FFFFFF"><%=DateUtil.format(ucd.getAddDate(), "yy-MM-dd HH:mm:ss")%></td>
              <td height="22" bgcolor="#FFFFFF">
			  <%if (ucd.isValid()) {%>
			  <lt:Label res="res.label.blog.admin.blog" key="used"/>&nbsp;&nbsp;<a title="<lt:Label res="res.label.blog.admin.blog" key="no_use_userblog"/>" href="?op=stop&userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>&privurl=<%=privurl%>&isValid=0"><lt:Label res="res.label.blog.admin.blog" key="no_use"/></a>
			  <%}else{%>
			  <lt:Label res="res.label.blog.admin.blog" key="no_used"/>&nbsp;&nbsp;<a title="<lt:Label res="res.label.blog.admin.blog" key="use_userblog"/>" href="?op=stop&userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>&privurl=<%=privurl%>&isValid=1"><font color=red><lt:Label res="res.label.blog.admin.blog" key="use"/></font></a>
			  <%}%>
			  &nbsp;<a href="?op=del&userName=<%=StrUtil.UrlEncode(ucd.getUserName())%>"><lt:Label res="res.label.blog.admin.blog" key="del"/></a>			  </td>
            </tr>
          </form>
          <%}%>
        </table>
      <table width="86%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
          <tr>
            <td height="23"><div align="right">
                <%
	String querystr = "";
    out.print(paginator.getPageBlock(request,"?"+querystr));
%>
            </div></td>
          </tr>
      </table></td>
  </tr>
</table>
<br>
</BODY></HTML>
