<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin2.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String targeturl = StrUtil.getUrl(request);
if (!privilege.isUserLogin(request)) {
	response.sendRedirect("../door.jsp?targeturl="+targeturl);
	return;
}

String boardcode = ParamUtil.get(request, "boardcode");
Leaf curleaf = new Leaf();
curleaf = curleaf.getLeaf(boardcode);

if (curleaf==null || !curleaf.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "res.label.forum.addtopic", "board_none"))); // "版块不存在"));
	return;
}

String boardname = curleaf.getName();
String blogUserDir = ParamUtil.get(request, "blogUserDir");
	
// 取得皮肤路径
String skincode = curleaf.getSkin();
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
<title><%=Global.AppName%> - <lt:Label res="res.label.forum.addtopic" key="addtopic"/></title>
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<STYLE>TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
}
</STYLE>
<script language="javascript">
<!--
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}

function showvote(isshow)
{
	if (frmAnnounce.isvote.checked)
	{
		frmAnnounce.vote.style.display = "";
	}
	else
	{
		frmAnnounce.vote.style.display = "none";		
	}
}

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
//-->
</script>
<script src="inc/ubbcode.jsp"></script>
</head>
<body>
<%if (!boardcode.equals(Leaf.CODE_BLOG)) {%>
<%@ include file="inc/header.jsp"%>
<%@ include file="inc/position.jsp"%>
<%}%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice"/>
<%
String privurl = ParamUtil.get(request, "privurl");
String notwe = request.getParameter("notwe");
if (notwe==null) {
	//if (privilege.canWebEdit(request)) {
	//	response.sendRedirect("addtopic_we.jsp?privurl="+StrUtil.UrlEncode(privurl, "utf-8")+"&boardcode="+boardcode+"&boardname="+StrUtil.UrlEncode(boardname, "utf-8"));
	//	return;
	//}
}
%>
<%
int i=0;
String addFlag = ParamUtil.get(request, "addFlag");
%>
<table width="98%" border="1" align="center" cellpadding="4" cellspacing="0" borderColor="<%=skin.getTableBorderClr()%>">
<form name=frmAnnounce method="post" action="addtopictodb.jsp?addFlag=<%=StrUtil.UrlEncode(addFlag)%>" enctype="MULTIPART/FORM-DATA" onSubmit="return frmAnnounce_onsubmit()">
    <TBODY>
      <tr> 
        <td height="26" colspan="2" background="<%=skinPath%>/images/bg1.gif" class="td_title"><lt:Label res="res.label.forum.addtopic" key="topic_add_to"/><a href="listtopic.jsp?boardcode=<%=boardcode%>"><%=boardname%></a></td>
      </tr>
    </TBODY>
    <TBODY>
      <tr>
        <td><lt:Label res="res.label.forum.addtopic" key="topic_add_to_board"/></td>
        <td>
		<%
		if (blogUserDir.equals(""))
			blogUserDir = UserDirDb.DEFAULT;
		
		UserConfigDb ucd = new UserConfigDb();
		ucd = ucd.getUserConfigDb(privilege.getUser(request));
		// 如果用户的博客未开通，则不能选择版块
		if (Global.hasBlog && ucd!=null && ucd.isLoaded()) {
		%>
		  <script>
		  var bcode<%=i%> = "<%=boardcode%>";
		  </script>
		  <select name="boardcode" onChange="if(this.options[this.selectedIndex].value=='not'){alert(this.options[this.selectedIndex].text+' <lt:Label res="res.label.forum.addtopic" key="can_not_sel"/>'); this.value=bcode<%=i%>; return false;}">
                <option value="not" selected><lt:Label res="res.label.forum.addtopic" key="sel_board"/></option>
                <%
				com.redmoon.forum.Directory directory = new com.redmoon.forum.Directory();
				com.redmoon.forum.Leaf lf = directory.getLeaf("root");
				com.redmoon.forum.DirectoryView dv = new com.redmoon.forum.DirectoryView(lf);
				dv.ShowDirectoryAsOptions(out, lf, lf.getLayer());
				%>
				<option value="<%=Leaf.CODE_BLOG%>">&nbsp;&nbsp;&nbsp;&nbsp;<lt:Label res="res.label.forum.addtopic" key="blog"/></option>
          </select>
		  <script>
			frmAnnounce.boardcode.value = "<%=boardcode%>";
		  </script>		
		  <%if (boardcode.equals(Leaf.CODE_BLOG)) {%>
			<lt:Label res="res.label.forum.addtopic" key="info_board_blog"/>
		  <%}
		  }else{%>
			  <%=boardname%><input type="hidden" name="boardcode" value="<%=boardcode%>">
		  <%}%>		</td>
      </tr>
	  <%
	  if (Global.hasBlog && ucd.isLoaded()) {
	  %>
      <tr>
        <td><lt:Label res="res.label.forum.addtopic" key="add_to_blog"/></td>
        <td>
		<%
		UserDirDb udd = new UserDirDb();
		%>
		<select name=blogUserDir>
          <option value="<%=UserDirDb.DEFAULT%>"><lt:Label res="res.label.forum.addtopic" key="default_dir"/></option>
          <%=udd.toOptions(privilege.getUser(request))%>
        </select>
		<script>
		frmAnnounce.blogUserDir.value = "<%=blogUserDir%>";
		</script>
		<input name=isBlog value=1 type=checkbox <%=boardcode.equals(Leaf.CODE_BLOG)?"checked":""%>>
		<lt:Label res="res.label.forum.addtopic" key="add_to_blog"/>		</td>
      </tr>
	  <%}%>
      <tr>
        <td colspan="2">
          <%
PluginMgr pm = new PluginMgr();
Vector vplugin = pm.getAllPluginUnitOfBoard(boardcode);
String pluginCode = ParamUtil.get(request, "pluginCode");
if (vplugin.size()>0) {
	Iterator irplugin = vplugin.iterator();
	while (irplugin.hasNext()) {
		PluginUnit pu = (PluginUnit)irplugin.next();
		IPluginUI ipu = pu.getUI(request, response, out);
		IPluginViewAddMsg pv = ipu.getViewAddMsg(boardcode);
		if (pv.IsPluginBoard()) {
			boolean showPlugin = false;
			if (pu.getType().equals(pu.TYPE_BOARD))
				showPlugin = true;
			else if (pu.getType().equals(pu.TYPE_TOPIC)) {
				if (pluginCode.equals(pu.getCode()))
					showPlugin = true;
			}
			if (showPlugin) {
				if (!pu.getAddTopicPage().equals("")) {
%>
					<jsp:include page="<%=pu.getAddTopicPage()%>" flush="true">
					<jsp:param name="boardcode" value="<%=StrUtil.UrlEncode(boardcode)%>" /> 
					</jsp:include>
<%				}
				else {
					out.print(pu.getName(request) + ":&nbsp;" + pv.render(UIAddMsg.POS_TITLE) + "<BR>");
					out.print(pv.render(UIAddMsg.POS_FORM_ELEMENT) + "<BR>");
				}
			}
		}
	}
}

String hit = request.getParameter("hit");
String isvote = StrUtil.getNullString(request.getParameter("isvote"));
String plugin2Code = ParamUtil.get(request, "plugin2Code");
if (!plugin2Code.equals("")) {
	Plugin2Mgr p2m = new Plugin2Mgr();
	Plugin2Unit p2u = p2m.getPlugin2Unit(plugin2Code);
%>
				<jsp:include page="<%=p2u.getAddTopicPage()%>" flush="true">
				<jsp:param name="boardcode" value="<%=StrUtil.UrlEncode(boardcode)%>" /> 
				</jsp:include>
	
<%}%>
        </td>
      </tr>
<%
if (cfg1.getBooleanProperty("forum.addUseValidateCode")) {
%>
<tr><td width="20%">
<lt:Label res="res.label.forum.addtopic" key="input_validatecode"/>
</td><td><input name="validateCode" type="text" size="1">
  <img src='../validatecode.jsp' border=0 align="absmiddle" style="cursor:hand" onClick="this.src='../validatecode.jsp'" alt="<lt:Label res="res.label.forum.index" key="refresh_validatecode"/>"></td>
</tr>	  <%}%>
      <tr> 
        <td width="20%"><lt:Label res="res.label.forum.addtopic" key="topic_title"/></td>
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
          </SELECT> <input name="topic" type="text" id="topic" size="60"  title="不得超过 50 个汉字或100个英文字符" maxlength="80">
          <input type="hidden" name="boardname" value="<%=boardname%>">
          <input type="hidden" name="hit" value="<%=hit%>">
          <input type="hidden" name="privurl" value="<%=privurl%>"></td>
      </tr>
      <tr>
        <td valign="top"><lt:Label res="res.label.forum.addtopic" key="emote_icon"/>
        </td>
        <td><iframe src="iframe_emote.jsp" height="25"  width="500px" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
		<input type="hidden" name="expression" value="25">		</td>
      </tr>
      <tr> 
        <td valign="top" width="20%">
		<%
		String display="none",ischecked="false";
		if (isvote.equals("1")) {
		display = "";
		ischecked = "checked";
		}
		%>
		<input type="checkbox" name="isvote" value="1" onClick="showvote()" <%=ischecked%>><lt:Label res="res.label.forum.addtopic" key="vote_option"/>		</td>
        <td width="80%"><textarea style="display:<%=display%>" cols="55" name="vote" rows="8" wrap="VIRTUAL"></textarea>
          <lt:Label res="res.label.forum.addtopic" key="vote_option_one_line"/></td>
      </tr>
      <tr> 
        <td rowspan="3" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="5">          
          <tr>
            <td><a href="javascript:payme()"><lt:Label res="res.label.forum.addtopic" key="fee_to_me"/></a></td>
          </tr>
        </table>
        <input type="checkbox" name="email_notify" value="1">
          <lt:Label res="res.label.forum.addtopic" key="email_notify"/> </td><td><table width="100%" border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td class=tablebody1 valign=top height=30><lt:Label res="res.label.forum.addtopic" key="file"/>&nbsp;<input type="file" name="filename" size=10>
                <lt:Label res="res.label.forum.addtopic" key="file_limit_count"/><%=maxAttachmentCount%>&nbsp;<lt:Label res="res.label.forum.addtopic" key="file_limit_all_size"/><%=maxAttachmentSize%>K
                <input type=button onClick="AddAttach()" value="<lt:Label res="res.label.forum.addtopic" key="add_attach"/>">
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
                </select></td>
            </tr>
          </table>
		  <div id=updiv name=updiv></div></td>
      </tr>
      <tr> 
        <td>
          <%@ include file="../editor_full/editor.jsp"%>        </td>
      </tr>
      <tr> 
        <td><input type=hidden name="Content">
          <input type=hidden name="isWebedit" value="<%=MsgDb.WEBEDIT_NORMAL%>">
          <br>
<input type=submit value="<lt:Label res="res.label.forum.addtopic" key="commit"/>">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=reset value="<lt:Label res="res.label.forum.addtopic" key="rewrite"/>">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onClick="window.location.href='addtopic.jsp?addFlag=<%=addFlag%>&pluginCode=<%=StrUtil.UrlEncode(pluginCode)%>&plugin2Code=<%=StrUtil.UrlEncode(plugin2Code)%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&privurl=<%=privurl%>'
" value="<lt:Label res="res.label.forum.addtopic" key="add_ubb"/>"> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if (privilege.canWebEditRedMoon(request, boardcode)) {%>
<input type="button" onClick="window.location.href='addtopic_we.jsp?addFlag=<%=addFlag%>&pluginCode=<%=StrUtil.UrlEncode(pluginCode)%>&plugin2Code=<%=StrUtil.UrlEncode(plugin2Code)%>&boardcode=<%=StrUtil.UrlEncode(boardcode)%>&blogUserDir=<%=blogUserDir%>&privurl=<%=privurl%>'" value="<lt:Label res="res.label.forum.addtopic" key="add_we"/>">
<%}%></td>
      </tr>
    </TBODY></form>
</table>
<%if (!boardcode.equals(Leaf.CODE_BLOG)) {%>
<%@ include file="inc/footer.jsp"%>
<%}%>
</body>
</html>
