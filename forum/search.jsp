<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.security.*"%>
<%@ page import="cn.js.fan.web.Global"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><lt:Label res="res.label.forum.search" key="search"/> - <%=Global.AppName%></title>
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
body {
	margin-top: 0px;
}
</STYLE>
<script language="javascript">
<!--
function form1_onsubmit()
{
	if (form1.selboard.value=="")
	{
		alert("<lt:Label res="res.label.forum.search" key="alert_board"/>");
		return false;
	}
}
//-->
</script>
</head>
<body>
<%@ include file="inc/header.jsp"%>
<br>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
if (!privilege.canUserDo(request, "", "search")) {
	response.sendRedirect("../info.jsp?info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "pvg_invalid")));
}

// 检查是否处于可发贴时间段
TimeConfig tcsearch = new TimeConfig();
if (tcsearch.isSearchForbidden(request)) {
    out.print(SkinUtil.makeErrMsg(request, StrUtil.format(SkinUtil.LoadString(request, "res.label.forum.search", "time_forbid_search"), 
           new Object[] {tc.getProperty("forbidSearchTime")})));
	return;
}
			
String boardcode = ParamUtil.get(request, "boardcode");
String boardname = ParamUtil.get(request, "boardname");
%>
<TABLE width="98%" height=207 align="center" cellPadding=0 cellSpacing=0 
borderColor=#666666 id=AutoNumber1 
style="PADDING-RIGHT: 0px; BORDER-TOP: 1px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; BORDER-LEFT: 1px; PADDING-TOP: 0px; BORDER-BOTTOM: 1px; BORDER-COLLAPSE: collapse; BORDER-RIGHT-WIDTH: 1px">
  <FORM name=form1 action=search_do.jsp method=post onSubmit="return form1_onsubmit()">
    <TBODY>
      <TR> 
        <TD height=22 
    colSpan=2 background="<%=skinPath%>/images/bg1.gif" 
    > <P align=center><SPAN class="text_title"><lt:Label res="res.label.forum.search" key="input_keywards"/></SPAN> </P></TD>
      </TR>
      <TR bgColor=#f5f5f5> 
        <TD height=24 align="right" 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid"><lt:Label res="res.label.forum.search" key="search_content"/>&nbsp;&nbsp;</TD>
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    vAlign=top height=24>&nbsp; 
          <input size=40 name=searchwhat>
		  <input name=boardcode value="<%=boardcode%>" type=hidden>
		  <input name=boardname value="<%=boardname%>" type=hidden>
	    </TD>
      </TR>
      <TR bgColor=#f5f5f5> 
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    width=210 height=24> <P align=right><FONT style="FONT-SIZE: 9pt"><lt:Label res="res.label.forum.search" key="search_author"/></FONT> 
            <INPUT type=radio value=byauthor name=searchtype>
            &nbsp; </P></TD>
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    vAlign=top height=24>&nbsp; <SELECT size=1 name=selauthor>
            <OPTION value=topicname selected><lt:Label res="res.label.forum.search" key="topic_author"/></OPTION>
            <OPTION value=replyname><lt:Label res="res.label.forum.search" key="reply_author"/></OPTION>
          </SELECT> </TD>
      </TR>
      <TR bgColor=#f5f5f5> 
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    width=210 height=22> <P align=right><SPAN style="FONT-SIZE: 9pt">&nbsp;&nbsp;&nbsp;&nbsp; 
            <lt:Label res="res.label.forum.search" key="search_keywords"/></SPAN> 
            <INPUT type=radio CHECKED value=bykey name=searchtype>
            &nbsp; </P></TD>
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    vAlign=top height=22>&nbsp; <SELECT size=1 name=searchxm2>
            <OPTION value=topic selected><lt:Label res="res.label.forum.search" key="search_topic_keywards"/></OPTION>
          </SELECT> </TD>
      </TR>
      <TR bgColor=#f5f5f5> 
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    width=210 height=23> <P align=right><FONT style="FONT-SIZE: 9pt" 
      color=#000000><lt:Label res="res.label.forum.search" key="scope_date"/>&nbsp;</FONT>&nbsp; </P></TD>
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    vAlign=top height=23>&nbsp; <SELECT size=1 name=timelimit>
            <OPTION 
        value="all"><lt:Label res="res.label.forum.search" key="all_date"/></OPTION>
            <OPTION value=1><lt:Label res="res.label.forum.search" key="after_yestoday"/></OPTION>
            <OPTION value=5 selected><lt:Label res="res.label.forum.search" key="after_five_today"/></OPTION>
            <OPTION value=10><lt:Label res="res.label.forum.search" key="after_ten_today"/></OPTION>
            <OPTION value=30><lt:Label res="res.label.forum.search" key="after_30_today"/></OPTION>
          </SELECT> </TD>
      </TR>
      <TR bgColor=#f5f5f5> 
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    align=right width=210 bgColor=#f5f5f5 height=26><FONT 
      style="FONT-SIZE: 9pt" color=#000000><lt:Label res="res.label.forum.search" key="sel_board"/>&nbsp;&nbsp;</FONT></TD>
        <TD 
    style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    vAlign=center height=26>&nbsp; 
	<select name="selboard">
            <option value="allboard" selected><lt:Label res="res.label.forum.search" key="all_board"/></option>
<%
LeafChildrenCacheMgr dlcm = new LeafChildrenCacheMgr("root");
java.util.Vector vt = dlcm.getChildren();
Iterator ir = vt.iterator();
while (ir.hasNext()) {
	Leaf leaf = (Leaf) ir.next();
	String parentCode = leaf.getCode();
%>
    <option style="BACKGROUND-COLOR: #f8f8f8" value="">╋ <%=leaf.getName()%></option>
<%
	LeafChildrenCacheMgr dl = new LeafChildrenCacheMgr(parentCode);
	java.util.Vector v = dl.getChildren();
	Iterator ir1 = v.iterator();
	while (ir1.hasNext()) {
		Leaf lf = (Leaf) ir1.next();
%>
            <option value="<%=lf.getCode()%>">　├『<%=lf.getName()%>』</option>
  <%}
}%>
          </select> 
		  
		  <script language=javascript>
		<!--
		var v = "<%=boardcode%>";
		if (v!="")
			form1.selboard.value = v;
		//-->
		</script> &nbsp; <INPUT type=submit value=<lt:Label res="res.label.forum.search" key="begin_search"/> name=submit1> 
        </TD>
      </TR>
      <TR bgColor=#f5f5f5> 
        <TD style="BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 1px; PADDING-BOTTOM: 1px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: #666666 1px solid" 
    colSpan=2 height=22></TD>
      </TR>
  </FORM></TBODY>
</TABLE>

<%@ include file="inc/footer.jsp"%>
</body>
</html>
