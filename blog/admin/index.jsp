<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><%=cn.js.fan.web.Global.AppName%> - <lt:Label res="res.label.blog.admin.index" key="title"/></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="images/admin.css" type=text/css rel=stylesheet>
<STYLE>BODY {
	BACKGROUND-COLOR: #ffffff
}
TR {
	BACKGROUND-COLOR: #ffffff
}
.tr_val {
	BACKGROUND-COLOR: #fdfdfd
}
.input_login {
	BORDER-RIGHT: #ffffff 0px solid; BORDER-TOP: #ffffff 0px solid; FONT-SIZE: 9pt; BORDER-LEFT: #ffffff 0px solid; BORDER-BOTTOM: #ffffff 0px solid; HEIGHT: 16px
}
.input_val {
	BORDER-RIGHT: #ffffff 0px solid; BORDER-TOP: #ffffff 0px solid; FONT-SIZE: 9pt; BORDER-LEFT: #ffffff 0px solid; BORDER-BOTTOM: #c0c0c0 1px solid; HEIGHT: 16px; BACKGROUND-COLOR: #fdfdfd
}
</STYLE>

<SCRIPT language=javascript src="images/admin.js"></SCRIPT>

<SCRIPT language=javascript src="images/joekoe_select.js"></SCRIPT>

<META content="MSHTML 6.00.3790.259" name=GENERATOR></HEAD>
<BODY leftMargin=0 topMargin=0>
<jsp:useBean id="login" scope="page" class="cn.js.fan.security.Login"/>
<%
login.initlogin(request,"redmoon");
%>
<CENTER>
<TABLE height="96%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=middle width="100%" height="100%">
      <TABLE height="96%" width=350 border=0>
        <TBODY>
        <TR>
          <TD align=middle>
            <TABLE cellSpacing=0 cellPadding=0 width=526 border=0>
              <FORM name=admin_frm action=login.jsp method=post><INPUT type=hidden 
              value=ok name=admin_log> 
              <TBODY>
              <TR>
                <TD colSpan=2><IMG src="images/al_top.gif" 
                  border=0></TD></TR>
              <TR>
                <TD colSpan=2>
                  <TABLE cellSpacing=0 cellPadding=0 width=526 border=0>
                    <TBODY>
                    <TR>
                      <TD width=155><IMG 
                        src="images/al_username.gif" border=0></TD>
                      <TD width=105 
                      background="images/al_body_bg.gif"><INPUT 
                        class=input_login maxLength=20 size=15 onmouseover=this.focus() 
                        name=username value=""></TD>
                      <TD width=93><IMG 
                        src="images/al_password.gif" border=0></TD>
                      <TD width=105 
                      background="images/al_body_bg.gif"><INPUT 
                        class=input_login type=password 
                        maxLength=20 size=15 name=pwd value=""></TD>
                      <TD width=68><IMG 
                        src="images/al_body_right.gif" 
                    border=0></TD></TR></TBODY></TABLE></TD></TR>
              <TR>
                <TD colSpan=2>
                  <TABLE cellSpacing=0 cellPadding=0 width=526 border=0>
                    <TBODY>
                    <TR>
                      <TD width=77><IMG 
                        src="images/al_end_left.gif" border=0></TD>
                      <TD width=339>
                        <TABLE cellSpacing=0 cellPadding=0 width=339 border=0>
                          <TBODY>
                          <TR>
                            <TD align=middle 
                            background="images/al_end_bg.gif" height=49>&nbsp;                              </TD>
                          </TR>
                          <TR>
                            <TD><IMG src="images/al_end_end.gif" 
                              border=0></TD></TR></TBODY></TABLE></TD>
                      <TD width=110><input type="image" style="CURSOR: hand" 
                        onclick="javascript:admin_login_chk()"  
                        src="images/al_end_right.gif" 
                    border=0></TD></TR></TBODY></TABLE></TD></TR></FORM></TABLE>
            <SCRIPT language=javascript>
<!--
function admin_login_chk()
{
  var username=document.admin_frm.username.value;
  var password=document.admin_frm.pwd.value;
  if (username=="" || username==null)
  {
    alert("<lt:Label res="res.label.blog.admin.index" key="input_name"/>");
    document.admin_frm.username.focus();
    return;
  }
  if (password=="" || password==null)
  {
    alert("<lt:Label res="res.label.blog.admin.index" key="input_password"/>");
    document.admin_frm.password.focus();
    return;
  }
  document.admin_frm.submit();
}

document.admin_frm.username.focus();
-->
</SCRIPT>
          </TD></TR></TABLE></TD></TR></TBODY></TABLE></CENTER></BODY></HTML>
