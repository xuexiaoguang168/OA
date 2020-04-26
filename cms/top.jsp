<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>标题</TITLE>
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
            target=mainFrame>刷新当前页</A> <IMG height=7 hspace=5 
            src="images/arrow_white.gif" width=6 
            algin="absmiddle"><A 
            href="main.jsp" 
            target=mainFrame>控制面板首页</A> <IMG height=7 hspace=5 
            src="images/arrow_white.gif" width=6 
            algin="absmiddle"><A 
            href="../index.jsp" 
            target=_blank>浏览网站</A> <IMG height=7 hspace=5 
            src="images/arrow_white.gif" width=6 
            algin="absmiddle"><A 
            href="javascript:window.close()" 
            target=_top>退出系统</A> </TD>
        </TR>
        <TR>
          <TD width="309" align=center class=wht>
<jsp:useBean id="cfg" scope="page" class="cn.js.fan.web.Config"/>
<%=cfg.getProperty("Application.name")%>
管理后台		  </TD>
          <TD width="138" align=right class=wht>跳转：
            <select 
            onChange="if (this.options[this.selectedIndex].value!='') window.top.mainFrame.location.href=this.options[this.selectedIndex].value" 
            name=menu>
              <option style="BACKGROUND-COLOR: #eeeeee" 
              selected>&nbsp;&nbsp;快速通道</option>
              <option 
              value=dir_frame.jsp>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;栏目管理</option>
              <option 
              value=dir_frame.jsp?root_code=template>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;模板管理</option>
              <option 
              value=cache.jsp>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;系统环境</option>
            </select></TD>
        </TR></TBODY></TABLE></TD></TR></TBODY></TABLE></BODY></HTML>
