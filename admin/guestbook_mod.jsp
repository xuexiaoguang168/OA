<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
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
    <td height="23" valign="bottom" background="../images/tab-b5-top.gif">　　　　　<span class="right-title">回 
      复 留 言</span></td>
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
        <%
String id = request.getParameter("id");
if (id!=null && fchar.isNumeric(id))
	;
else
{
	out.println(fchar.makeErrMsg("未选择留言标识！"));
	return;
}
%>
        <jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/>
        <jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/>
        <%
String person="",lydate="",ip="",content="",reply="";
String dowhat = fchar.getNullString(request.getParameter("dowhat"));
String redate = "";
String sql = "";
if (dowhat.equals("modify"))
{
	content = fchar.getNullString(fchar.UnicodeToGB(request.getParameter("content")));
	if (content.equals(""))
	{
		conn.close();
		out.println(fchar.makeErrMsg("留言内容不能为空！"));
		return;
	}
	reply = fchar.getNullString(fchar.UnicodeToGB(request.getParameter("reply")));
	redate = (new java.util.Date()).toString();
	sql = "update guestbook set content="+fchar.sqlstr(content)+",reply="+fchar.sqlstr(reply)+",redate=getDate() where id="+id;
	conn.executeUpdate(sql);
}

sql = "select * from guestbook where id="+id;
ResultSet rs = conn.executeQuery(sql);
if (rs!=null && rs.next())
{
	id = rs.getString("id");
	person = rs.getString("person");
	lydate = rs.getString("lydate");
	ip = rs.getString("ip");
	content = rs.getString("content");
	reply = fchar.getNullString(rs.getString("reply"));
	redate = fchar.getNullString(rs.getString("redate"));
}
if (rs!=null)
	rs.close();
conn.close();
%>
        <br>
      <table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="p9">
        <form name="form1" action="guestbook_mod.jsp" method="post" onSubmit="">
          <tr> 
            <td width="15%" height="21" align="center" bgcolor="#eeeeee" class="stable">标&nbsp;&nbsp;识</td>
            <td height="21" colspan="2" class="stable"> <%=id%> <input type=hidden name="id" value="<%=id%>"> <input type=hidden name=dowhat value="modify"> 
            </td>
          </tr>
          <tr> 
            <td width="15%" height="21" align="center" bgcolor="#eeeeee" class="stable">用户名</td>
            <td width="31%" height="21" class="stable"><%=fchar.toHtml(person)%></td>
            <td width="54%" height="21" class="stable">时间 <%=lydate.substring(0,19)%></td>
          </tr>
          <tr> 
            <td width="15%" height="17" align="center" bgcolor="#eeeeee" class="stable">内&nbsp;&nbsp;容</td>
            <td height="17" colspan="2" class="stable"> 
              <textarea name=content rows=10 cols="50"><%=content%></textarea> 
              <br> </td>
          </tr>
          <tr> 
            <td width="15%" height="58" align="center" bgcolor="#eeeeee" class="stable">回&nbsp;&nbsp;复</td>
            <td height="58" colspan="2" class="stable"> 
              <textarea name=reply rows=10 cols="50"><%=reply%></textarea> 
            </td>
          </tr>
          <tr> 
            <td height="22" align="center" bgcolor="#eeeeee" class="stable">回复时间</td>
            <td height="22" colspan="2" align="left" class="stable">
			<%
			if (!redate.equals("")) {
				out.print(redate.substring(0,19));
			}%>
			&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3" align="center"> <input type=submit value="发送" name="submit">
              &nbsp;&nbsp; 
              <input type=reset value="取消" name="reset"> </td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</BODY></HTML>
