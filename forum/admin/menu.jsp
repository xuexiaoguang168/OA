<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.miniplugin.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.sweet.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<HTML><HEAD><TITLE>Menu</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="images/default.css" type=text/css rel=stylesheet>
<STYLE type=text/css>.ttl {
	CURSOR: hand; COLOR: #ffffff; PADDING-TOP: 4px
}
</STYLE>
<SCRIPT language=javascript>
  function showHide(obj) {
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
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="quick_channel"/></TD>
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
            <A href="<%=rootpath%>/forum/index.jsp" 
target=_blank><lt:Label res="res.label.forum.admin.menu" key="browse_website"/></A></TD></TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="dir_frame.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="board_mgr"/></a></TD>
        </TR>
        
        
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../chat/manage/manage.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="chatroom_mgr"/></a></TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="link.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="link"/></a></TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../cms/frame.jsp" 
            target=_top><lt:Label res="res.label.forum.admin.menu" key="cms_mgr"/></a> </TD>
        </TR>
        <TR>
          <TD><img height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <a 
            href="../../blog/admin/frame.jsp" 
            target=_top><lt:Label res="res.label.forum.admin.menu" key="blog_mgr"/></a></TD>
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
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="user_mgr"/></TD>
    <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD></TR>
  <TR style="DISPLAY: none">
    <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3>
      <TABLE width="100%">
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="user_m.jsp"
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="mgr_user"/></A></TD>
        </TR>
        <TBODY>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="user_group_m.jsp"
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="mgr_user_group"/></A></TD>
        </TR>
        </TBODY></TABLE></TD></TR></TR>
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
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="data_mgr"/></TD>
      <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD>
    </TR>
    <TR style="DISPLAY: none">
      <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3><TABLE width="100%">
       	<TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<a 
            href="forum_notice.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="bbs_notice"/></a></TD>
         </TR>
		<TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="move_board.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="board_move"/></A></TD>
        </TR>

        <TBODY>
          <TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="bak_m.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="bak_data"/></A></TD>
          </TR>
          <TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="../topic_m.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="toplic_mgr"/></A></TD>
          </TR>
          <TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="../topic_check.jsp" 
            target=mainFrame>
              <lt:Label res="res.label.forum.admin.menu" key="check_msg"/>
            </A></TD>
          </TR>
          <TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="../dustbin.jsp" 
            target=mainFrame>
            <lt:Label res="res.label.forum.admin.menu" key="dustbin"/>
            </A></TD>
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
<table cellspacing=0 cellpadding=0 width=159 align=center border=0>
  <tbody>
    <tr>
      <td width=23><img height=25 
      src="images/box_topleft.gif" width=23></td>
      <td class=ttl onClick=showHide(this) width=129 
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="safe_mgr"/></td>
      <td width=7><img height=25 
      src="images/box_topright.gif" width=7></td>
    </tr>
    <tr style="DISPLAY: none">
      <td 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colspan=3><TABLE width="100%">
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="forbidip.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="IP_address_limit"/></A></TD>
        </TR>
		<TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<a 
            href="forum_m.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="bbs_filter"/></a></TD>
        </TR>
        <TBODY>
            <TR>
              <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<A 
            href="config_reg.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="config_reg"/>
              </A></TD>
            </TR>
            <TR>
              <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<A 
            href="config_time.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="time_config"/> </A></TD>
            </TR>		  
        </TBODY>
      </TABLE></td>
    </tr>
    <tr>
      <td colspan=3><img height=10 
      src="images/box_bottom.gif" 
width=159></td>
    </tr>
  </tbody>
</table>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
    <TR>
      <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
      <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="ui_mgr"/></TD>
      <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD>
    </TR>
    <TR style="DISPLAY: none">
      <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3><TABLE width="100%">
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="forum_face.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="reg_face"/></A></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<a href="theme_config.jsp" target="mainFrame"><lt:Label res="res.label.forum.admin.menu" key="theme"/></a></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A href="ad_list.jsp" 
            target=mainFrame> <lt:Label res="res.label.forum.admin.menu" key="ad_mgr"/> </A></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<a href="water_mark.jsp" target="mainFrame"><lt:Label res="res.label.forum.admin.menu" key="water_mark_pic"/></a></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<a href="check_referer.jsp" target="mainFrame"><lt:Label res="res.label.forum.admin.menu" key="check_referer"/></a></TD>
        </TR>
       <TBODY>
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
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
    <TR>
      <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
      <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="plugin_mgr"/></TD>
      <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD>
    </TR>
    <TR style="DISPLAY: none">
      <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3>
<%
PluginMgr pm = new PluginMgr();
Vector v = pm.getAllPlugin();
ir = v.iterator();
while (ir.hasNext()) {
	PluginUnit pu = (PluginUnit)ir.next();
	if (pu!=null && !pu.getAdminEntrance().trim().equals("")) {
%>	
	<TABLE width="100%">
          <TBODY>
            <TR>
              <TD><IMG height=7 hspace=5 src="images/arrow.gif" width=5 align=absMiddle>
				<A href="<%=pu.getAdminEntrance()%>" target=mainFrame><%=pu.LoadString(request, "adminMenuItem")%></A>
			  </TD>
            </TR>
          </TBODY>
      </TABLE>
<%	}
}%>
<TABLE width="100%">
  <TBODY>
    <TR>
      <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="render.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="control_display_toplic_plugin"/></a></TD>
    </TR>
    <TR>
      <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="entrance.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="enter_plugin_mode"/></a></TD>
    </TR>
    <TR>
      <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="score.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="score_plugin"/></a></TD>
    </TR>
  </TBODY>
</TABLE>
</TD>
    </TR>
    <TR>
      <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD>
    </TR>
  </TBODY>
</TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
    <TR>
      <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
      <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="mini_plugin_mgr"/></TD>
      <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD>
    </TR>
    <TR style="DISPLAY: none">
      <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3><%
MiniPluginMgr mpm = new MiniPluginMgr();
Vector mv = mpm.getAllPlugin();
if (mv!=null)
	ir = mv.iterator();
while (ir.hasNext()) {
	MiniPluginUnit pu = (MiniPluginUnit)ir.next();
	String entrance = StrUtil.getNullStr(pu.getAdminEntrance()).trim();
	if (pu!=null && pu.isPlugin() && !entrance.equals("")) {
%>
          <TABLE width="100%">
            <TBODY>
              <TR>
                <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="<%=pu.getAdminEntrance()%>" 
            target=mainFrame><%=pu.LoadString(request, "adminMenuItem")%></A></TD>
              </TR>
            </TBODY>
          </TABLE>
        <%}
		}%></TD>
    </TR>
    <TR>
      <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD>
    </TR>
  </TBODY>
</TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
    <TR>
      <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
      <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="other"/></TD>
      <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD>
    </TR>
    <TR style="DISPLAY: none">
      <TD style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" background="images/box_bg.gif" colSpan=3><TABLE width="100%">
        <TBODY>
          <TR>
            <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="config_seo.jsp" 
            target=mainFrame>
              <lt:Label res="res.label.forum.admin.menu" key="config_seo"/>
            </A></TD>
          </TR>
		  <TR>
                <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="dir_check_pvg.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="file_dir_chk"/></A></TD>
              </TR>
        </TBODY>
      </TABLE></TD>
    </TR>
    <TR>
      <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD>
    </TR>
  </TBODY>
</TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=159 align=center border=0>
  <TBODY>
    <TR>
      <TD width=23><IMG height=25 
      src="images/box_topleft.gif" width=23></TD>
      <TD class=ttl onclick=showHide(this) width=129 
    background="images/box_topbg.gif"><lt:Label res="res.label.forum.admin.menu" key="sys_config"/></TD>
      <TD width=7><IMG height=25 
      src="images/box_topright.gif" width=7></TD>
    </TR>
    <TR style="DISPLAY: none">
      <TD 
    style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px" 
    background="images/box_bg.gif" colSpan=3><TABLE width="100%">
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="../../log/community.log" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="sys_log"/></A></TD>
        </TR>
        <TR>
          <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="forum_statistic.jsp" 
            target=mainFrame>
            <lt:Label res="res.label.forum.admin.menu" key="forum_statistic"/>
          </A></TD>
        </TR>
          <TBODY>
            <TR>
              <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="setup_user_level.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="rank_mgr"/></A></TD>
            </TR>
            <TR>
              <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="config_score.jsp" 
            target=mainFrame>
                <lt:Label res="res.label.forum.admin.config_score" key="score_mgr"/>            
              </A></TD>
            </TR>
            <TR>
              <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle>&nbsp;<A 
            href="forum_status.jsp" 
            target=mainFrame><lt:Label res="res.label.forum.admin.menu" key="forum_state"/></A></TD>
            </TR>
            <TR>
              <TD><IMG height=7 hspace=5 
            src="images/arrow.gif" width=5 align=absMiddle> <A 
            href="config_m.jsp" 
            target=mainFrame>
                <lt:Label res="res.label.forum.admin.menu" key="bbs_config"/>
              </A></TD>
            </TR>
          </TBODY>
      </TABLE></TD>
    </TR>
    <TR>
      <TD colSpan=3><IMG height=10 
      src="images/box_bottom.gif" 
width=159></TD>
    </TR>
  </TBODY>
</TABLE>
</BODY></HTML>
