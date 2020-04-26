<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.redmoon.oa.db.PageQuery"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>留言簿管理</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../common.css" type="text/css">
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=3 marginheight="3" marginwidth="0">
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:setProperty name="privilege" property="defaulturl" value="../index.jsp"/>
<!--重定向至 :<jsp:getProperty name="privilege" property="defaulturl"   />-->
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b5-top.gif">　　　　　<span class="right-title">留 
      言 簿 管 理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="../images/tab-b-back.gif">
        <%
String priv="admin";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
        <BR>
        <%
		PageQuery pagebean = new PageQuery("ttoa");
		String sql = "select * from guestbook order by lydate desc";
		int pagesize = 10;
		pagebean.setPageSize(pagesize);
		String Query = fchar.getNullString(request.getParameter("Query"));
		if (!Query.equals(""))
			sql = Query;
			
		ResultSet rs=pagebean.myQuery(sql,request) ; 
		pagebean.PageLegend(response);			
		int curpage,totalpages;
		curpage = pagebean.getCurrentPages();
		totalpages = pagebean.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47"><img src="../images/title1-l.gif" width="47" height="25"></td>
          <td valign="top" background="../images/title1-back.gif"><div align="center" class="title1">找到符合条件的记录 
              <b><%=pagebean.getTotal() %></b> 条　每页显示 <b><%=pagebean.getPageSize() %></b> 
              条　页次 <b><%=curpage %>/<%=totalpages %></b></div></td>
          <td width="47"><img src="../images/title1-r.gif" width="47" height="25"></td>
        </tr>
      </table>
      <br>
      <%
try
{
  int i = 0;
  if (rs!=null )
  {
    if (pagebean.getTotalPages()>0)
	{
		do
		{
		  i++;
		%>
      <table width=90% border=0 align="center" cellpadding="2" cellspacing="0" class="p9">
        <tr> 
          <td width="20%" align="left" bgcolor="#C4DAFF" class="stable"> <%=fchar.toHtml(rs.getString("person"))%> </td>
          <td width="41%" align="left" bgcolor="#C4DAFF" class="stable">留言日期：<%=rs.getDate("lydate")%> 
          </td>
          <td width="20%" align="left" bgcolor="#C4DAFF" class="stable"><a href="guestbook_mod.jsp?id=<%=rs.getString("id")%>" class=mainA>修改/回复</a></td>
          <td width="19%" align="left" bgcolor="#C4DAFF" class="stable"> <a href="guestbook_del.jsp?id=<%=rs.getString("id")%>">删除</a></td>
        </tr>
        <tr> 
          <td colspan="4" class="stable"> <br> <%=fchar.toHtml(rs.getString("content"))%><br> <%
				  String reply = fchar.getNullString(rs.getString("reply"));
				  if (!reply.equals(""))
				  {
				  %> <font color="#F09F6F">回复：</font><%=fchar.toHtml(rs.getString("reply"))%> <br>
            回复日期：<%=rs.getString("redate").substring(0,19)%> <% } %>
          </td>
        </tr>
      </table>
      <br>
      <%
		}
		while(i<pagesize && rs.next());
	}
	else
		out.println(fchar.p_center("暂无留言!"));
  }
  else
	out.println(fchar.p_center("暂无留言!"));
  
}
catch(SQLException e)
{
  out.print("出错: ");
  out.print(e);
  out.print(e.getMessage());
}
if (rs!=null)
{
	rs.close();
	rs = null;
}
pagebean.clear();
%>
      <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td height="23"> <div align="right"> 
              <%
	  String querystr;
      querystr = "";  
	  %>
              <%if(!pagebean.getFirstPage().equals("none")) {%>
              <a href="guestbook_m.jsp?<%=pagebean.getFirstPage()+querystr%>"><img src="../images/first.gif" width="41" height="12" border="0"></a> 
              <% }
			    if(!pagebean.getPrevPage().equals("none")){
			     %>
              &nbsp;<a href="guestbook_m.jsp?<%=pagebean.getPrevPage()+querystr%>"><img src="../images/forward.gif" width="47" height="12" border="0"></a> 
              <% } 
			    
				  if(!pagebean.getNextPage().equals("none")){%>
              &nbsp;<a href="guestbook_m.jsp?<%=pagebean.getNextPage()+querystr%>"><img src="../images/next.gif" width="47" height="12" border="0"></a> 
              <% }
                  if(!pagebean.getLastPage().equals("none")){   %>
              &nbsp;<a href="guestbook_m.jsp?<%=pagebean.getLastPage()+querystr%>"><img src="../images/last.gif" width="41" height="12" border="0"></a> 
              <% }%>
              &nbsp;</div></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
<br>
</BODY></HTML>
