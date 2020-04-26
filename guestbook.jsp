<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.redmoon.oa.db.PageQuery"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>镇江GIS黄页系统</title>
<link href="common.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="5">
<%@ include file="inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/>
<jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="images/tab-b-top.gif">　　　　　<span class="right-title">留 
      言 簿</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
        <%
String sql = "";
String content = fchar.UnicodeToGB(request.getParameter("content"));
if ((content!=null) && (!content.equals("")))
{
	String ip = request.getRemoteAddr();
	sql = "insert into guestbook (person,ip,content) values ("+fchar.sqlstr(privilege.getUser(request))+","+fchar.sqlstr(ip)+","+fchar.sqlstr(content)+")";
	if (conn.executeUpdate(sql)==0)
	{
		conn.close();
		conn = null;
		out.println(fchar.makeErrMsg("留言失败，请检查留言内容是否超出了有效长度！"));
		return;
	}
}
if (conn!=null)
{
	conn.close();
	conn = null;
}
%>
        <%
		sql = "select * from guestbook order by lydate desc";
		int pagesize = 5;
		PageQuery pagebean = new PageQuery("ttoa");
		pagebean.setPageSize(pagesize);
		String Query = fchar.getNullString(request.getParameter("Query"));
		if (!Query.equals(""))
			sql = Query;
			
		ResultSet rs = pagebean.myQuery(sql,request) ; 
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
      <table width="90%" border="0">
        <tr> 
          <td height="5"></td>
        </tr>
      </table> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47"><img src="images/title1-l.gif" width="47" height="25"></td>
          <td valign="top" background="images/title1-back.gif"><div align="center" class="title1">找到符合条件的记录 
              <b><%=pagebean.getTotal() %></b> 条　每页显示 <b><%=pagebean.getPageSize() %></b> 
              条　页次 <b><%=curpage %>/<%=totalpages %></b></div></td>
          <td width="47"><img src="images/title1-r.gif" width="47" height="25"></td>
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
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr> 
          <td width="27%" height="17" valign="bottom" bgcolor="#C4DAFF" class="stable">　用户：<%=fchar.toHtml(rs.getString("person"))%>　</td>
          <td width="73%" valign="bottom" bgcolor="#C4DAFF" class="stable">留言日期：<%=rs.getDate("lydate")%></td>
        </tr>
        <tr> 
          <td colspan="2" bgcolor="#EEEEEE" class="stable"> <%=fchar.toHtml(rs.getString("content"))%><br> <%
				  String reply = fchar.getNullString(rs.getString("reply"));
				  if (!reply.equals(""))
				  {
				  %> <font color="#F09F6F">回复：</font><%=fchar.toHtml(rs.getString("reply"))%> <br>
            回复日期：<%=rs.getDate("redate")%> <% } %> </td>
        </tr>
      </table><br>

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
      <table width="87%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td height="23"> <div align="right"> 
              <%
	  String querystr = "";
	  %>
              <%if(!pagebean.getFirstPage().equals("none")) {%>
              <a href="guestbook.jsp?<%=pagebean.getFirstPage()+querystr%>"><img src="images/first.gif" width="41" height="12" border="0"></a> 
              <% }
			    if(!pagebean.getPrevPage().equals("none")){
			     %>
              &nbsp;<a href="guestbook.jsp?<%=pagebean.getPrevPage()+querystr%>"><img src="images/forward.gif" width="47" height="12" border="0"></a> 
              <% } 
				  if(!pagebean.getNextPage().equals("none")){%>
              &nbsp;<a href="guestbook.jsp?<%=pagebean.getNextPage()+querystr%>"><img src="images/next.gif" width="47" height="12" border="0"></a> 
              <% }
                  if(!pagebean.getLastPage().equals("none")){   %>
              &nbsp;<a href="guestbook.jsp?<%=pagebean.getLastPage()+querystr%>"><img src="images/last.gif" width="41" height="12" border="0"></a> 
              <% }%>
              &nbsp;</div></td>
        </tr>
      </table>
      <br> <table width="409" height="192" border="0" align="center" background="">
        <form name="form1" action="guestbook.jsp" method="post" onSubmit="return form1_onsubmit()">
          <tr> 
            <td width="403" valign="top"> <table width="98%" height="150" border="0" cellpadding="1" cellspacing="0">
                <tr> 
                  <td width="20%" height="25">&nbsp;</td>
                  <td height="25" colspan="2">&nbsp;</td>
                </tr>
                <tr> 
                  <td>留言<br>
                    内容</td>
                  <td colspan="2"><textarea name="content" cols="50" rows="8"></textarea> 
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td width="30%"> <div align="left"> </div></td>
                  <td width="50%"><input name="submit" type="submit" class="stable" value="发送留言"></td>
                </tr>
              </table></td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
<SCRIPT language=javascript id=clientEventHandlersJS>
<!--
function form1_onsubmit()
{
	if (form1.content.value=="")
	{
		alert("留言内容不能为空！");
		return false;
	}
}
//-->
</SCRIPT>
</html>
