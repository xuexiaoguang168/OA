<%@ page language="java"  contentType="text/html;charset=gb2312" %>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.sql.ResultSet"%>
<%@ page import = "java.sql.SQLException"%>
<%@ page import = "java.util.Properties"%>
<HTML><HEAD><TITLE>查看通知</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../common.css" type="text/css">
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY text=#000000 bgColor=#ffffff >
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b-top.gif">　　　　　<span class="right-title">查 
      看 通 知</span></td>
  </tr>
  <tr> 
    <td height="255" align="center" valign="top" background="../images/tab-b-back.gif"> 
      <jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
        <jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
        <jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
        <%
		String priv="admin";
		String priv1="notice_public";
		if (!privilege.isUserPrivValid(request,priv) && !privilege.isUserDepartmentPrivValid(request,priv1))
		{
			out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}

String id = fchar.getNullString(request.getParameter("id"));
if (id.equals(""))
{
	out.print(fchar.makeErrMsg("缺少需求信息标识符！"));
	return;
}
%>
        <jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/>
        <jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/>
        <%
String title="",content="",mydate="",filename="",extname="",author="";
int isdel = 0;
String sql = "select title,content,mydate,filename,extname,author from notice where id="+id;
ResultSet rs = null;
try {
	rs = conn.executeQuery(sql);
	if (rs!=null && rs.next())
	{
		title = rs.getString("title");
		content = rs.getString("content");
		mydate = rs.getString("mydate").substring(0,10);
		filename = fchar.getNullStr(rs.getString("filename"));
		extname = rs.getString("extname");
		author = rs.getString("author");
	}
}
catch (SQLException e) {
	out.println(e.getMessage());
}
finally {
	if (rs!=null) {
		rs.close();
		rs = null;
	}
	if (conn!=null) {
		conn.close();
		conn = null;
	}
}
%>
        <br>
      <table width="90%" border="0" align="center" cellpadding="2" cellspacing="0">
        <tr bgcolor="#C4DAFF"> 
          <td width="19%" class="stable">发送者：</td>
          <td width="81%" class="stable"><%=author%> </td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td bgcolor="#eeeeee" class="stable">日&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
          <td class="stable"><%=mydate%></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td valign="top" bgcolor="#eeeeee" class="stable">附&nbsp;&nbsp;&nbsp;&nbsp;件：</td>
          <td class="stable"> 
            <%
	if (!filename.equals(""))
	{
	%> <a href="../getnoticefile.jsp?id=<%=id%>&filename=<%=filename%>&extname=<%=extname%>">附件（.<%=extname%>）</a> <%
	}
	else
		out.print("&nbsp;");
	%> </td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td valign="top" bgcolor="#eeeeee" class="stable">内 &nbsp;&nbsp;&nbsp;容：</td>
          <td class="stable"><%=content%> </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</BODY>
</HTML>
