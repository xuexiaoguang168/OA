<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>留言簿</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<LINK href="default.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
.style1 {font-size: 16px}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
}
.style4 {color: #000000}
-->
</style>
</head>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="msgmgr" scope="page" class="cn.js.fan.module.guestbook.MessageMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN))
{
	out.println(StrUtil.makeErrMsg(privilege.MSG_INVALID,"red","green"));
	return;
}
%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">留言簿管理</td>
  </tr>
</table>
<br>
<TABLE class="frame_gray"  
cellSpacing=0 cellPadding=0 width="95%" align=center>
  <TBODY>
    <TR>
      <TD height=200 valign="top" bgcolor="#FFFBFF"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="100%" height="94%" valign="top"><table width="90%" border="0">
              <tr>
                <td height="5"></td>
              </tr>
            </table>
              <%
String strcurpage = StrUtil.getNullString(request.getParameter("CPages"));
if (strcurpage.equals(""))
	strcurpage = "1";
if (!StrUtil.isNumeric(strcurpage)) {
	out.print(StrUtil.makeErrMsg("标识非法！"));
	return;
}
int pagesize = 20;
int curpage = Integer.parseInt(strcurpage);

String sql = "select id,username,content,lydate,reply,redate from guestbook order by lydate desc";

ResultIterator ri = msgmgr.list(sql, curpage, pagesize );
ResultRecord rr = null;
Paginator paginator = new Paginator(request, ri.getTotal(), pagesize);
%>
              <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="47">&nbsp;</td>
                  <td valign="top"><div align="center" class="title1">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></div></td>
                  <td width="47">&nbsp;</td>
                </tr>
              </table>
              <%
while (ri.hasNext()) {
 	rr = (ResultRecord)ri.next(); %>
              <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="#E7E7E7" class="tableframe">
                <tr>
                  <td width="24%" height="22" valign="bottom" class="stable style4">用户：<%=StrUtil.toHtml((String)rr.get("username"))%>　</td>
                  <td width="43%" height="22" valign="bottom" class="stable style4">留言日期：<%=rr.get("lydate").toString().substring(0,16)%></td>
                  <td width="16%" valign="bottom" class="stable style4"><span class="stable"><a href="guestbook_mod.jsp?id=<%=rr.get("id")%>">修改/回复</a></span></td>
                  <td width="17%" valign="bottom" class="stable style4"><span class="stable"><a href="guestbook_del.jsp?id=<%=rr.get("id")%>">删除</a></span></td>
                </tr>
                <tr valign="top">
                  <td height="83" colspan="4" class="stable"><%=StrUtil.toHtml((String)rr.get("content"))%><br>
                      <%
				  String reply = StrUtil.getNullString((String)rr.get("reply"));
				  if (!reply.equals(""))
				  {
				  %>
                      <font color="#F09F6F"><br>
            回复：</font><%=StrUtil.toHtml((String)rr.get("reply"))%> <br>
            回复日期：<%=((java.util.Date)rr.get("redate")).toString().substring(0,16)%>
            <% } %>
                  </td>
                </tr>
              </table>
              <br>
              <%}
%>
              <br>
              <table width="87%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
                <tr>
                  <td height="23"><div align="right">
                      <%
	String querystr = "";
    out.print(paginator.getCurPageBlock("guestbook.jsp?"+querystr));
%>
                  </div></td>
                </tr>
              </table>
              <br>
          </td>
        </tr>
        <tr>
          <td height="6%">&nbsp;</td>
        </tr>
      </table></TD>
    </TR>
  </TBODY>
</TABLE>

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
