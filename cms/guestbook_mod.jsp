<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.module.guestbook.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>留言簿管理</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<LINK href="default.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
<style type="text/css">
<!--
.style1 {
	font-size: 16px;
	font-weight: bold;
}
-->
</style>
</HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=3 marginheight="3" marginwidth="0">
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">管理留言</td>
  </tr>
</table>
<br>
<TABLE class="frame_gray"  
cellSpacing=0 cellPadding=0 width="95%" align=center>
  <TBODY>
    <TR>
      <TD height=200 valign="top" bgcolor="#FFFBFF"><table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top" background="../images/tab-b-back.gif"><jsp:useBean id="privilege" scope="page" class="com.fan.redmoon.Privilege"/>
            
              <%
if (!privilege.isAdmin(request))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String id = request.getParameter("id");
if (id==null || !StrUtil.isNumeric(id))
{
	out.println(StrUtil.makeErrMsg("未选择留言标识！"));
	return;
}
%>
              <jsp:useBean id="msgmgr" scope="page" class="cn.js.fan.module.guestbook.MessageMgr"/>
              
              <%
String dowhat = StrUtil.getNullString(request.getParameter("dowhat"));
if (dowhat.equals("modify"))
{
	String content = StrUtil.getNullString(StrUtil.UnicodeToUTF8(request.getParameter("content")));
	if (content.equals(""))
	{
		out.println(StrUtil.Alert("留言内容不能为空！"));
	}
	else
	{
		String reply = StrUtil.getNullString(StrUtil.UnicodeToUTF8(request.getParameter("reply")));
		boolean re = false;
		try {
			re = msgmgr.update(Integer.parseInt(id), content, reply);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.makeErrMsg(e.getMessage()));
		}
		if (re)
			out.print(StrUtil.Alert("更新留言成功！"));
	}
}
Message msg = msgmgr.get(Integer.parseInt(id));
%>
              <br>
              <table width="89%" border="0" align="center" cellpadding="0" cellspacing="0" class="p9">
                <form name="form1" action="guestbook_mod.jsp" method="post" onSubmit="">
                  <tr>
                    <td width="15%" height="21" align="center" bgcolor="#eeeeee" class="stable">用户名</td>
                    <td width="31%" height="21" bgcolor="#eeeeee" class="stable"><%=StrUtil.toHtml(msg.getUserName())%></td>
                    <td width="54%" height="21" bgcolor="#eeeeee" class="stable">时间 <%=msg.getDate()%>
                        <input type=hidden name="id" value="<%=id%>">
                        <input type=hidden name=dowhat value="modify"></td>
                  </tr>
                  <tr>
                    <td width="15%" height="17" align="center" bgcolor="#eeeeee" class="stable">内&nbsp;&nbsp;容</td>
                    <td height="17" colspan="2" bgcolor="#eeeeee" class="stable"><textarea name=content rows=10 cols="45"><%=StrUtil.toHtml(msg.getContent())%></textarea>
                        <br>
                    </td>
                  </tr>
                  <tr>
                    <td width="15%" height="58" align="center" bgcolor="#eeeeee" class="stable">回&nbsp;&nbsp;复</td>
                    <td height="58" colspan="2" bgcolor="#eeeeee" class="stable"><textarea name=reply rows=10 cols="45"><%=msg.getReply()%></textarea>
                    </td>
                  </tr>
                  <tr>
                    <td height="22" align="center" bgcolor="#eeeeee" class="stable">回复时间</td>
                    <td height="22" colspan="2" align="left" bgcolor="#eeeeee" class="stable"><%
			if (!msg.getReDate().equals("")) {
				out.print(msg.getReDate());
			}%>
&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="3" align="center"><input type=submit value="发送" name="submit">
&nbsp;&nbsp;
              <input type=reset value="取消" name="reset">
                    </td>
                  </tr>
                </form>
            </table></td>
        </tr>
        <tr>
          <td height="9">&nbsp;</td>
        </tr>
      </table></TD>
    </TR>
  </TBODY>
</TABLE>
</BODY></HTML>
