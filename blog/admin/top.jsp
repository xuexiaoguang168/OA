<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>title</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="images/default.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.3790.259" name=GENERATOR>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style2 {font-family: "宋体"}
-->
</style>
</HEAD>
<BODY leftMargin=0 topMargin=0>

<TABLE cellSpacing=0 cellPadding=0 width="100%" 
background="images/top_bg.png" border=0>
  <TBODY>
  <TR>
    <TD><IMG height=49 src="images/us_logo.gif" 
    width=182></TD>
    <TD style="PADDING-RIGHT: 20px">
      <TABLE width="459" align=right class=wht>
        <TBODY>
        <TR>
          <TD colspan="2" align="right"><span class="style1"><span class="style2">&nbsp;</span>&nbsp;&nbsp;&nbsp;</span><IMG height=7 hspace=5 
            src="images/arrow_white.gif" width=6 
            algin="absmiddle"><A href="javascript:location.reload();" 
            target=mainFrame><lt:Label res="res.label.blog.admin.top" key="current_page"/></A> <IMG height=7 hspace=5 
            src="images/arrow_white.gif" width=6 
            algin="absmiddle"><A 
            href="main.jsp" 
            target=mainFrame><lt:Label res="res.label.blog.admin.top" key="control_panel_page"/></A> <IMG height=7 hspace=5 
            src="images/arrow_white.gif" width=6 
            algin="absmiddle"><A 
            href="../index.jsp" 
            target=_blank><lt:Label res="res.label.blog.admin.top" key="browse_web"/></A> <IMG height=7 hspace=5 
            src="images/arrow_white.gif" width=6 
            algin="absmiddle"><A 
            href="javascript:window.close()" 
            target=_top><lt:Label res="res.label.blog.admin.top" key="quit_system"/></A> </TD>
        </TR>
        <TR>
          <TD width="309" align=center class=wht>
<jsp:useBean id="cfg" scope="page" class="cn.js.fan.web.Config"/>
<%=cfg.getProperty("Application.name")%>
<lt:Label res="res.label.blog.admin.top" key="manage_system"/>		  </TD>
          <TD width="138" align=right class=wht><lt:Label res="res.label.blog.admin.top" key="jump"/>
            <select 
            onChange="if (this.options[this.selectedIndex].value!='') window.top.mainFrame.location.href=this.options[this.selectedIndex].value" 
            name=menu>
              <option style="BACKGROUND-COLOR: #eeeeee" 
              selected>&nbsp;&nbsp;<lt:Label res="res.label.blog.admin.top" key="quick_channel"/></option>
              <option 
              value=dir_frame.jsp>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.blog.admin.top" key="list_management"/></option>
              <option 
              value=cache.jsp>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.blog.admin.top" key="system_condition"/></option>
            </select></TD>
        </TR></TBODY></TABLE></TD></TR></TBODY></TABLE></BODY></HTML>
