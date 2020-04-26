<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cn.js.fan.util.*"%>
<LINK href="images/default.css" type=text/css rel=stylesheet>
<STYLE type=text/css>.ttl {
	CURSOR: hand; COLOR: #ffffff; PADDING-TOP: 4px
}
</STYLE>
<BR>
<%
String rootpath = request.getContextPath();
%>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
  <TR>
    <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
    <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif">CMS 快速通道</TD>
    <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD></TR>
  <TR>
    <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3>
      <TABLE width="100%">
        <TBODY>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../cms/dir_frame.jsp" 
            target=mainFrame>栏目管理</a></TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../cms/document_list_m.jsp" 
            target=mainFrame>审核文章</a></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a href="../../cms/nav_m.jsp" target=mainFrame>导航条</a></TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../cms/dir_frame.jsp?root_code=template" 
            target=mainFrame>模板管理</a></TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../email_m.jsp" 
            target=mainFrame>群发Email</a></TD>
        </TR>
        </TBODY></TABLE></TD></TR></TR>
  <TR>
    <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD></TR></TBODY></TABLE>
<%
Directory dir = new Directory();
Menu menu = dir.getMenu("root");
Iterator ir = menu.Iterator();
while (ir.hasNext()) {
	MenuItem mi = (MenuItem)ir.next();
%>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
  <TR>
    <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
    <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif">
CMS
<%
	Leaf headLeaf = mi.getHeadLeaf();
	out.print(headLeaf.getName());
%>	
</TD>
    <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD></TR>
  <TR style="DISPLAY: none">
    <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3>
      <TABLE width="100%">
        <TBODY>
<%		
	Iterator childir = mi.getChildLeaves();
	while (childir.hasNext()) {
		Leaf childLeaf = (Leaf) childir.next();
%>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> 
            <A 
            href="../../cms/dir_frame.jsp?root_code=<%=StrUtil.UrlEncode(childLeaf.getCode())%>" 
            target=mainFrame><%=childLeaf.getName()%></A></TD></TR>
<%		
	}		
%>	
        </TBODY></TABLE>
	  </TD></TR></TR>
  <TR>
    <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD></TR></TBODY></TABLE>
<%	
}
%>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
  <TR>
    <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
    <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif">CMS会员及会员组</TD>
    <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD></TR>
  <TR style="DISPLAY: none">
    <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3>
      <TABLE width="100%">
        <TBODY>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="../../cms/user_m.jsp"
            target=mainFrame>用户管理</A></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="../../cms/user_group_m.jsp"
            target=mainFrame>用户组管理</A></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> 
            <A 
            href="user_m.jsp" 
            target=mainFrame>会员帐号管理</A></TD></TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> 
            <A 
            href="priv_m.jsp" 
            target=mainFrame>权限管理</A></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> 
            <A 
            href="../log/redmoon.log" 
            target=mainFrame>查看管理员日志</A></TD></TR></TBODY></TABLE></TD></TR></TR>
  <TR>
    <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD></TR></TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
  <TR>
    <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
    <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif">CMS附件</TD>
    <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD></TR>
  <TR style="DISPLAY: none">
    <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3>
      <TABLE width="100%">
        <TBODY>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> 
            <A href="counter/showcount.jsp" 
            target=mainFrame>访问统计</A></TD></TR>
        </TBODY></TABLE></TD></TR></TR>
  <TR>
    <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD></TR></TBODY></TABLE>

