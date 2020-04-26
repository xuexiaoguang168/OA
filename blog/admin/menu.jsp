<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Vector"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<HTML><HEAD><TITLE>menu</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="images/default.css" type=text/css rel=stylesheet>
<STYLE type=text/css>.ttl {
	CURSOR: hand; COLOR: #ffffff; PADDING-TOP: 4px
}
</STYLE>
<SCRIPT language=javascript>
  function showHide(obj){
    var oStyle = obj.parentElement.parentElement.parentElement.rows[1].style;
    oStyle.display == "none" ? oStyle.display = "block" : oStyle.display = "none";
  }
</SCRIPT>
<META content="MSHTML 6.00.3790.259" name=GENERATOR></HEAD>
<BODY bgColor=#9aadcd leftMargin=0 topMargin=0>
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
    background="images/box_topbg.gif"><lt:Label res="res.label.blog.admin.index" key="quick_channel"/></TD>
    <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD></TR>
  <TR>
    <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3>
      <TABLE width="100%">
        <TBODY>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> 
            <A href="<%=rootpath%>/blog/index.jsp" 
target=_blank><lt:Label res="res.label.blog.admin.index" key="browse_web"/></A></TD></TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="dir_frame.jsp" 
            target=mainFrame><lt:Label res="res.label.blog.admin.index" key="list_management"/></a></TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../cms/frame.jsp" 
            target=_top><lt:Label res="res.label.blog.admin.index" key="CMS_management"/></a></TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../forum/admin/frame.jsp" 
            target=_top><lt:Label res="res.label.blog.admin.index" key="forum_management"/></a></TD>
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
            href="dir_frame.jsp?root_code=<%=StrUtil.UrlEncode(childLeaf.getCode())%>" 
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
    background="images/box_topbg.gif"><lt:Label res="res.label.blog.admin.index" key="blog_management"/></TD>
      <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD>
    </TR>
    <TR style="DISPLAY: none">
      <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3><TABLE width="100%">
        <TBODY>
          <TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="blog_list.jsp" 
            target=mainFrame><lt:Label res="res.label.blog.admin.index" key="blog_list"/></A></TD>
          </TR>
          <TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="home.jsp" 
            target=mainFrame><lt:Label res="res.label.blog.admin.index" key="blog_index"/></A></TD>
          </TR>
        </TBODY>
      </TABLE></TD>
    </TR>
    </TR>
    
    <TR>
      <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD>
    </TR>
  </TBODY>
</TABLE>
</BODY></HTML>
