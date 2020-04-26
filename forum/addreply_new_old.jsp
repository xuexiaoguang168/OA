<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String targeturl = StrUtil.getUrl(request);
if (!privilege.isUserLogin(request)) {
	response.sendRedirect("../door.jsp?targeturl="+targeturl);
	return;
}
%>
<%
int i=0;
String strreplyid = request.getParameter("replyid");
if (strreplyid==null || !StrUtil.isNumeric(strreplyid))
{
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, SkinUtil.ERR_ID)));
	return;
}

long replyid = Long.parseLong(strreplyid);

String privurl = request.getParameter("privurl");
String quote = StrUtil.getNullString(request.getParameter("quote"));
String quotecontent = "";
String retopic;

MsgMgr msgMgr = new MsgMgr();
MsgDb msgDb = msgMgr.getMsgDb(replyid);
retopic = msgDb.getTitle();
String qc = SkinUtil.LoadString(request, "res.label.forum.addreply", "quote_content");
qc = qc.replaceFirst("\\$u", msgDb.getName());
qc = qc.replaceFirst("\\$d", com.redmoon.forum.ForumSkin.formatDateTime(request, msgDb.getAddDate()));
quotecontent = qc + "\r\n\r\n" + msgDb.getContent();
quotecontent = "<table align=center style=\"width:80%\" cellpadding=5 cellspacing=1 class=quote><TR><TD>" + quotecontent + "</td></tr></table>";

retopic = SkinUtil.LoadString(request, "res.label.forum.addreply", "reply") + retopic;

String boardcode = msgDb.getboardcode();
Leaf lf = new Leaf();
lf = lf.getLeaf(boardcode);
String boardname = lf.getName();
String hit = request.getParameter("hit");

// 取得皮肤路径
String skincode = lf.getSkin();
if (skincode.equals("") || skincode.equals(UserSet.defaultSkin)) {
	skincode = UserSet.getSkin(request);
	if (skincode==null || skincode.equals(""))
		skincode = UserSet.defaultSkin;
}	
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
String skinPath = skin.getPath();

com.redmoon.forum.Config cfg1 = new com.redmoon.forum.Config();
int msgTitleLengthMin = cfg1.getIntProperty("forum.msgTitleLengthMin");
int msgTitleLengthMax = cfg1.getIntProperty("forum.msgTitleLengthMax");
int msgLengthMin = cfg1.getIntProperty("forum.msgLengthMin");
int msgLengthMax = cfg1.getIntProperty("forum.msgLengthMax");
int maxAttachmentCount = cfg1.getIntProperty("forum.maxAttachmentCount");
int maxAttachmentSize = cfg1.getIntProperty("forum.maxAttachmentSize");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Global.AppName%> - <lt:Label res="res.label.forum.addreply" key="addreply"/></title>
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
<script>
function frmAnnounce_onsubmit()
{
	if (!cws_validateMode())
		return false;

	if (document.frmAnnounce.topic.value.length<<%=msgTitleLengthMin%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_title"/><%=msgTitleLengthMin%>");
		return false;
	}	

	if (document.frmAnnounce.topic.value.length><%=msgTitleLengthMax%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_large_title"/><%=msgTitleLengthMax%>");
		return false;
	}	
	
	var html;
	html=cws_getText();
	html=cws_rCode(html,"<a>　</a>","");
 	document.frmAnnounce.Content.value=html;
	
	if (document.frmAnnounce.Content.value.length<<%=msgLengthMin%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_short_content"/><%=msgLengthMin%>");
		return false;
	}
	if (document.frmAnnounce.Content.value.length><%=msgLengthMax%>)
	{
		alert("<lt:Label res="res.forum.MsgDb" key="err_too_large_content"/><%=msgLengthMax%>");
		return false;
	}
}

var attachCount = 1;
function AddAttach() {
	if (attachCount>=<%=maxAttachmentCount%>) {
		alert("<lt:Label res="res.label.forum.addtopic" key="topic_max_attach"/><%=maxAttachmentCount%>");
		return;
	}
	updiv.insertAdjacentHTML("BeforeEnd", "<table width=100%><tr><lt:Label res="res.label.forum.addtopic" key="file"/>&nbsp;<input type='file' name='filename" + attachCount + "' size=10><td></td></tr></table>");
	
	// updiv.innerHTML += "<table width=100%><tr><lt:Label res="res.label.forum.addtopic" key="file"/>&nbsp;<input type='file' name='filename" + attachCount + "' size=10><td></td></tr></table>";
	attachCount += 1;
}
</script>
</head>
<body>
<%@ include file="inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice" />
<%@ include file="inc/position.jsp"%>
<br>
<script src="inc/ubbcode.jsp"></script>
<table width="98%" border="1" align="center" cellpadding="4" cellspacing="0" borderColor="<%=skin.getTableBorderClr()%>">
<form name=frmAnnounce method="post" action="addreplytodb.jsp" enctype="MULTIPART/FORM-DATA" onSubmit="return frmAnnounce_onsubmit()">
    <TBODY>
      <tr> 
      <td colspan="2" background="<%=skinPath%>/images/bg1.gif" class="td_title"> <lt:Label res="res.label.forum.addreply" key="reply_topic"/>&nbsp;<a href="showtopictree.jsp?rootid=<%=msgDb.getRootid()%>&showid=<%=msgDb.getId()%>"><%=msgDb.getTitle()%></a>&nbsp;&nbsp;&nbsp;&nbsp;
	  <lt:Label res="res.label.forum.addreply" key="author"/><%=msgDb.getName()%>&nbsp;&nbsp;&nbsp;&nbsp;
	  <lt:Label res="res.label.forum.addreply" key="board"/>&nbsp;<a class=left href="listtopic.jsp?boardcode=<%=boardcode%>"><%=boardname%></a></td>
      </tr>
    </TBODY>
    <TBODY>
      <tr>
        <td colspan="2">
          <%
String pluginCode = msgDb.getRootMsgPluginCode();
		  
PluginMgr pm = new PluginMgr();
Vector vplugin = pm.getAllPluginUnitOfBoard(boardcode);
if (vplugin.size()>0) {
	Iterator irplugin = vplugin.iterator();
	long msgRootId = msgDb.getRootid();
	while (irplugin.hasNext()) {
		PluginUnit pu = (PluginUnit)irplugin.next();
		IPluginUI ipu = pu.getUI(request);
		IPluginViewAddReply pv = ipu.getViewAddReply(boardcode, msgRootId);
		if (pv.IsPluginBoard()) {
			boolean showPlugin = false;
			if (pu.getType().equals(pu.TYPE_BOARD))
				showPlugin = true;
			else if (pu.getType().equals(pu.TYPE_TOPIC)) {
				if (pluginCode.equals(pu.getCode()))
					showPlugin = true;
			}
			if (showPlugin) {						
				if (!pu.getAddReplyPage().equals("")) {
	%>
					<jsp:include page="<%=pu.getAddReplyPage()%>" flush="true">
					<jsp:param name="msgRootId" value="<%=replyid%>" /> 
					</jsp:include>
	<%			}
				else {
					out.print(pu.getName(request) + ":&nbsp;" + pv.render(UIAddReply.POS_FORM_NOTE) + "<BR>");
					out.print(pv.render(UIAddReply.POS_FORM_ELEMENT));
				}	
			}		
		}
	}
}
%>        </td>
      </tr>
<%
if (cfg1.getBooleanProperty("forum.addUseValidateCode")) {
%>
<tr><td width="20%"><lt:Label res="res.label.forum.addtopic" key="input_validatecode"/></td><td><input name="validateCode" type="text" size="1">
  <img src='../validatecode.jsp' border=0 align="absmiddle" style="cursor:hand" onClick="this.src='../validatecode.jsp'" alt="<lt:Label res="res.label.forum.index" key="refresh_validatecode"/>"></td>
</tr>	  <%}%>	  
      <tr> 
      <td width="20%"><lt:Label res="res.label.forum.addreply" key="topic_reply"/></td>
        <td width="80%"> <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
            <OPTION selected value=""><lt:Label res="res.label.forum.addtopic" key="sel_topic"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_origi"/>><lt:Label res="res.label.forum.addtopic" key="pre_origi"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_from"/>><lt:Label res="res.label.forum.addtopic" key="pre_from"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_water"/>><lt:Label res="res.label.forum.addtopic" key="pre_water"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_discuss"/>><lt:Label res="res.label.forum.addtopic" key="pre_discuss"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_help"/>><lt:Label res="res.label.forum.addtopic" key="pre_help"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_recommend"/>><lt:Label res="res.label.forum.addtopic" key="pre_recommend"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_notice"/>><lt:Label res="res.label.forum.addtopic" key="pre_notice"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_note"/>><lt:Label res="res.label.forum.addtopic" key="pre_note"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_image"/>><lt:Label res="res.label.forum.addtopic" key="pre_image"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_advise"/>><lt:Label res="res.label.forum.addtopic" key="pre_advise"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_download"/>><lt:Label res="res.label.forum.addtopic" key="pre_download"/></OPTION>
            <OPTION value=<lt:Label res="res.label.forum.addtopic" key="pre_share"/>><lt:Label res="res.label.forum.addtopic" key="pre_share"/></OPTION>
          </SELECT> 
		  <input name="topic" type="text" id="topic" size="60" maxlength="80" value="<%=StrUtil.toHtml(retopic)%>">
		  <input type=hidden name=replyid value="<%=replyid%>">
          <input type="hidden" name="boardcode" value="<%=boardcode%>">
          <input type="hidden" name="boardname" value="<%=boardname%>">
          <input type="hidden" name="hit" value="<%=hit%>">
          <input type="hidden" name="privurl" value="<%=privurl%>"></td>
      </tr>
      <tr> 
        <td width="20%"><lt:Label res="res.label.forum.addtopic" key="emote_icon"/></td>
        <td><iframe src="iframe_emote.jsp" height="25"  width="500" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
        <input type="hidden" name="expression" value="25"></td>
      </tr>
      <tr> 
        <td rowspan="2" valign="bottom"><input type="checkbox" name="show_ubbcode" value="0">
          <lt:Label res="res.label.forum.showtopic" key="forbid_ubb"/><br> <input type="checkbox" name="show_smile" value="0">
          <lt:Label res="res.label.forum.showtopic" key="forbid_emote"/><br>        </td>
        <td><table width="100%" border=0 cellspacing=0 cellpadding=0>
<tr>
  <td class=tablebody1 valign=top height=30><lt:Label res="res.label.forum.addtopic" key="file"/>&nbsp;<input type="file" name="filename" size=10>
<lt:Label res="res.label.forum.addtopic" key="file_limit_count"/><%=maxAttachmentCount%>&nbsp;<lt:Label res="res.label.forum.addtopic" key="file_limit_all_size"/><%=maxAttachmentSize%>K
<input name="button" type=button onClick="AddAttach()" value="<lt:Label res="res.label.forum.addtopic" key="add_attach"/>">
<select name="select">
  <option>
  <lt:Label res="res.label.forum.addtopic" key="upload_file_ext"/>
  </option>
  <%
				String[] ext = StrUtil.split(cfg1.getProperty("forum.ext"), ",");
				if (ext!=null) {
					int extlen = ext.length;
					for (int p=0; p<extlen; p++) {
						out.print("<option>" + ext[p] + "</option>");
					}
				}
				%>
</select></td></tr>
</table><div id=updiv name=updiv></div></td>
      </tr>
      <tr> 
        <td><%@ include file="../editor_full/editor.jsp"%>
          <input type=hidden name="Content">
          <input type=hidden name="isWebedit" value="<%=MsgDb.WEBEDIT_NORMAL%>">
<%if (quote!=null && quote.equals("1")) {%>
		  <textarea name="tmpContent" style="display:none"><%=quotecontent%></textarea>
		  <script>
		  IframeID.document.body.innerHTML=frmAnnounce.tmpContent.value;
		  </script>
<%}%>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type=submit value="<lt:Label res="res.label.forum.addtopic" key="commit"/>">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type=reset value="<lt:Label res="res.label.forum.addtopic" key="rewrite"/>">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" onClick="window.location.href='addreply.jsp?replyid=<%=replyid%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&rootid=<%=msgDb.getRootid()%>&privurl=<%=privurl%>'" value="<lt:Label res="res.label.forum.addtopic" key="add_ubb"/>">
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <%if (privilege.canWebEditRedMoon(request, boardcode)) {%>
          <input type="button" onClick="window.location.href='addreply_we.jsp?replyid=<%=replyid%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&rootid=<%=msgDb.getRootid()%>&privurl=<%=privurl%>'" value="<lt:Label res="res.label.forum.addtopic" key="add_we"/>">
          <%}%></td>
      </tr>
      <tr> 
        <td colspan="2">&nbsp;</td>
      </tr>
    </TBODY></form>
</table>
<%@ include file="inc/footer.jsp"%>
</body>
</html>
