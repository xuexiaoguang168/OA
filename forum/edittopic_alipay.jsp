<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.blog.*" %>
<%@ page import="com.redmoon.forum.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin2.alipay.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ page import="com.redmoon.forum.person.UserSet"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
long editid = -1;
try {
	editid = ParamUtil.getInt(request, "editid");
}
catch (ErrMsgException e) {
	out.print(SkinUtil.makeErrMsg(request, "标识错误！"));
	return;
}
String privurl = request.getParameter("privurl"); 

if (!privilege.isUserLogin(request))
{
	out.print(StrUtil.makeErrMsg("您尚未登录！"));
	return;
}

MsgMgr mm = new MsgMgr();
MsgDb Topic = mm.getMsgDb(editid);
int i=0;

String name = privilege.getUser(request);
try {
	if (!privilege.canEdit(request, Topic))
	{
		out.print(StrUtil.makeErrMsg("您无权编辑！"));
		return;
	}
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert_Back(e.getMessage()));
	return;
}

String topic="",content="";
int expression=1;

String show_ubbcode = "" + Topic.getShowUbbcode();
String show_smile = "" + Topic.getShowSmile();
String email_notify = "" + Topic.getEmailNotify();
long rootid = Topic.getRootid();
topic = Topic.getTitle();
content = Topic.getContent();
expression = Topic.getExpression();

String boardname;
String hit = request.getParameter("hit");
String boardcode = Topic.getboardcode();

Leaf curleaf = new Leaf();
curleaf = curleaf.getLeaf(boardcode);
boardname = curleaf.getName();
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

Vector attachments = Topic.getAttachments();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Global.AppName%> - 编辑贴子</title>
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
</STYLE>
<script>
function delAttach(attach_id, msgId) {
	if (!window.confirm("您确定要删除吗？")) {
		return;
	}
	document.frames.hideframe.location.href = "edittopicdo.jsp?op=delAttach&msgId=" + msgId + "&attach_id=" + attach_id
}

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

function frmAnnounce_onsubmit() {
	if (!cws_validateMode())
		return false;

	var html;
	html=cws_getText();
	html=cws_rCode(html,"<a>　</a>","");
 	document.frmAnnounce.Content.value=html;
	
	if (frmAnnounce.topic.value.length<<%=msgTitleLengthMin%>)
	{
		alert("您输入的主题太短了，注意最短不能少于<%=msgTitleLengthMin%>字！");
		return false;
	}
	if (frmAnnounce.topic.value.length><%=msgTitleLengthMax%>)
	{
		alert("您输入的主题太长了，注意最长不能超过<%=msgTitleLengthMax%>字！");
		return false;
	}
	if (frmAnnounce.Content.value.length<<%=msgLengthMin%>)
	{
		alert("您输入的内容太短了，注意最短不能少于<%=msgLengthMin%>字！");
		return false;
	}
	if (frmAnnounce.Content.value.length><%=msgLengthMax%>)
	{
		alert("您输入的内容太长了，注意最长不能超过<%=msgLengthMax%>字！");
		return false;
	}
}

function changeAttachName(attach_id, msgId, nm) {
	var obj = findObj(nm);
	// document.frames.hideframe.location.href = "fwebedit_do.jsp?op=changeattachname&page_num=1&doc_id=" + doc_id + "&attach_id=" + attach_id + "&newname=" + obj.value
	form3.action = "edittopicdo.jsp?op=changeattachname&msgId=" + msgId + "&attach_id=" + attach_id;
	form3.newname.value = obj.value;
	form3.submit();
}

var attachCount = <%=attachments.size()%> + 1; // 把默认输入框计算在内
function AddAttach() {
	if (attachCount>=<%=maxAttachmentCount%>) {
		alert("附件最多只能上传<%=maxAttachmentCount%>个！");
		return;
	}
	updiv.insertAdjacentHTML("BeforeEnd", "<table width=100%><tr><lt:Label res="res.label.forum.addtopic" key="file"/>&nbsp;<input type='file' name='filename" + attachCount + "' size=10><td></td></tr></table>");
	
	// updiv.innerHTML += "<table width=100%><tr>文件&nbsp;<input type='file' name='filename" + attachCount + "' size=10><td></td></tr></table>";
	attachCount += 1;
}
</script>
<script src="inc/ubbcode.jsp"></script>
</head>
<body topmargin="2">
<%if (!boardcode.equals(Leaf.CODE_BLOG)) {%>
<%@ include file="inc/header.jsp"%>
<%}%>
<jsp:include page="inc/position.jsp" flush="true">
<jsp:param name="boardcode" value="<%=StrUtil.UrlEncode(boardcode)%>" />
</jsp:include>
  <table width="98%" border="1" align="center" cellpadding="4" cellspacing="0" borderColor="<%=skin.getTableBorderClr()%>">
<form name=frmAnnounce method="post" action="edittopicdo.jsp" enctype="MULTIPART/FORM-DATA" onSubmit="return frmAnnounce_onsubmit()">
    <TBODY>
      <tr> 
      <td colspan="2" class="td_title"> 编辑贴子&nbsp;<a href="showtopictree.jsp?rootid=<%=Topic.getRootid()%>"><%=Topic.getTitle()%></a></td>
      </tr>
    </TBODY>
    <TBODY>
      <tr>
        <td colspan="2">
<%
PluginMgr pm = new PluginMgr();
Vector vplugin = pm.getAllPluginUnitOfBoard(boardcode);
if (vplugin.size()>0) {
	Iterator irplugin = vplugin.iterator();
	while (irplugin.hasNext()) {
		PluginUnit pu = (PluginUnit)irplugin.next();
		IPluginUI ipu = pu.getUI(request);
		IPluginViewEditMsg pv = ipu.getViewEditMsg(boardcode, Topic.getId());
		if (pv.IsPluginBoard()) {
			out.print(pu.getName(request) + ":&nbsp;" + pv.render(UIEditMsg.POS_FORM_NOTE) + "<BR>");
			out.print(pv.render(UIEditMsg.POS_FORM_ELEMENT));
		}
	}
}
%></td>
      </tr>
	  <%
	  // 判别该用户的博客是否已被激活及该贴是否为根贴，只有两项全符合，才会出现编辑博客的选项
	  if (Topic.getReplyid()==-1) {
		  UserConfigDb ucd = new UserConfigDb();
		  ucd = ucd.getUserConfigDb(Topic.getName());
		  if (ucd!=null && ucd.isLoaded()) {
		  %>
			  <tr>
				<td>发表至博客目录</td>
				<td>
				<%
				UserDirDb udd = new UserDirDb();
				String checked = "";
				if (Topic.isBlog())
					checked = "checked";
				%>
				  <select name=blogUserDir>
					<option value="<%=UserDirDb.DEFAULT%>">默认目录</option>
					<%=udd.toOptions(privilege.getUser(request))%>
				  </select>
				  <script>
					frmAnnounce.blogUserDir.value = "<%=Topic.getBlogUserDir()%>";
				  </script>
				  <input name=isBlog value=1 type=checkbox <%=checked%>> 
				  发表至博客</td>
			  </tr>
		  <%}
	  }%>
			  <tr>
                <td>支付宝账号</td>
			    <td>
				<%
				AlipayDb ad = new AlipayDb();
				ad = ad.getAlipaydDb(Topic.getId());
				%>
				<input class="input" maxlength="200" size="35" name="alipay_seller" value="<%=ad.getSeller()%>">
                    <input name="plugin2Code" value="alipay" type="hidden">                </td>
      </tr>
			  <tr>
                <td>商品名称</td>
			    <td><input class="input" maxlength="200" size="25" name="alipay_subject" value="<%=ad.getSubject()%>">
			      &nbsp;&nbsp;  
			      价格
			      <input class="input" maxlength="20" size="5" name="alipay_price" value="<%=ad.getPrice()%>">
			      元</td>
      </tr>
			  <tr>
                <td>邮费承担方</td>
			    <td><input id="alipay_transport" onClick="checkTransport();" type="radio" value="3" name="alipay_transport" <%=ad.getTransport()==3?"checked":""%>>
虚拟物品不需邮递
  <input id="alipay_transport" onClick="checkTransport();" type="radio" checked value="2" name="alipay_transport" <%=ad.getTransport()==2?"checked":""%>>
卖家承担运费
<input id="alipay_transport" onClick="checkTransport();" type="radio" value="1" name="alipay_transport" <%=ad.getTransport()==1?"checked":""%>>
买家承担运费 
<br>
			      平邮
			      <input class="input" disabled maxlength="20" size="5" name="alipay_ordinary" value="<%=ad.getOrdinary()%>">
			      元&nbsp;&nbsp; 快递
			      <input class="input" disabled maxlength="20" size="5" name="alipay_express" value="<%=ad.getExpress()%>">
		        元 (不填为平邮)</td>
      </tr>
			  <tr>
                <td>演示网址</td>
			    <td><input class="input" maxlength="200" size="35" name="alipay_demo" value="<%=ad.getDemo()%>">
			      商品说明请填写于信息内容中</td>
      </tr>
			  <tr>
                <td>联系方式</td>
			    <td>淘宝旺旺
			      <input class="input" maxlength="20" size="10" name="alipay_ww" value="<%=ad.getWw()%>">
			      腾讯QQ
			      <input class="input" maxlength="20" size="10" name="alipay_qq" value="<%=ad.getQq()%>">
			      让买家在线联系您 </td>
      </tr>
      <tr> 
      <td width="20%">回复标题：</td>
        <td width="80%"> <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
            <OPTION selected value="">选择话题</OPTION>
            <OPTION value=[原创]>[原创]</OPTION>
            <OPTION value=[转帖]>[转帖]</OPTION>
            <OPTION value=[灌水]>[灌水]</OPTION>
            <OPTION value=[讨论]>[讨论]</OPTION>
            <OPTION value=[求助]>[求助]</OPTION>
            <OPTION value=[推荐]>[推荐]</OPTION>
            <OPTION value=[公告]>[公告]</OPTION>
            <OPTION value=[注意]>[注意]</OPTION>
            <OPTION value=[贴图]>[贴图]</OPTION>
            <OPTION value=[建议]>[建议]</OPTION>
            <OPTION value=[下载]>[下载]</OPTION>
            <OPTION value=[分享]>[分享]</OPTION>
          </SELECT> 
		  <input name="topic" type="text" id="topic" size="60" maxlength="80" value="<%=topic%>">
          <input type=hidden name="editid" value="<%=editid%>">
          <input type="hidden" name="boardcode" value="<%=boardcode%>">
          <input type="hidden" name="boardname" value="<%=boardname%>">
          <input type="hidden" name="hit" value="<%=hit%>">
          <input type="hidden" name="privurl" value="<%=privurl%>">        </td>
      </tr>
      <tr> 
        <td valign="top" width="20%">当前心情：<br>
          将放在帖子的前面</td>
        <td><iframe src="iframe_emote.jsp?expression=<%=Topic.getExpression()%>" height="25"  width="500px" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
        <input type="hidden" name="expression" value="<%=Topic.getExpression()%>"></td>
      </tr>
      <tr> 
        <td rowspan="2" valign="bottom"><%if (privilege.isManager(request, boardcode)) {%>
          <table width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr>
              <td><a href="javascript:replyCanSee()">回复可见</a></td>
            </tr>
            <tr>
              <td><a href="javascript:experienceCanSee()">经验可见</a></td>
            </tr>
          </table>
          <%}%>
          <br>
		  <input type="checkbox" id="email_notify" name="email_notify" value="1" <%=Topic.getEmailNotify()==1?"checked":""%>>
		  有回复通知我
		<script language="JavaScript">
		<!--
		<% if (rootid==-1) {
			if (email_notify.equals("1")){ %>
			frmAnnounce.email_notify.checked = true;
			<% }
		 } %>
		<% if (show_ubbcode.equals("0")) { %>
			frmAnnounce.show_ubbcode.checked = true;
		<% } %>
		<% if (show_smile.equals("0")) { %>
			frmAnnounce.show_smile.checked = true;
		<% } %>
		//-->
		</script>	    </td>
        <td><%if (attachments.size()<maxAttachmentCount) {%>
		<table width="100%" border=0 cellspacing=0 cellpadding=0>
<tr><td class=tablebody1 valign=top height=30>
文件&nbsp;<input type="file" name="filename" size=10>
              可以上传： 
              <select name="filetype" size=1>
<option value="">文件类型</option>
<option value=rar>rar</option><option value=gif>gif</option><option value=jpg>jpg</option><option value=bmp>bmp</option><option value=zip>zip</option><option value=png>png</option><option value=swf>swf</option><option value=doc>doc</option>
</select>
              限制：<%=maxAttachmentCount%>个，限制大小<%=maxAttachmentSize%>K
              <input name="button" type=button onClick="AddAttach()" value="增加附件">
			  </td>
            </tr>
		</table>
		<%}%>
		<div id=updiv name=updiv></div></td>
      </tr>
      
      <tr> 
        <td><%@ include file="../editor_full/editor.jsp"%>
<input type=hidden name="Content">
          <input type=hidden name="isWebedit" value="<%=MsgDb.WEBEDIT_NORMAL%>">
          <br>
		  <textarea name="tmpContent" style="display:none"><%=content%></textarea>
		  <script>
		  IframeID.document.body.innerHTML=frmAnnounce.tmpContent.value;
		  </script>
		  <%
			  if (Topic!=null) {
				  Iterator ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	Attachment am = (Attachment) ir.next(); %>
          <table width="98%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="4%" align="center"><img src=../images/attach.gif width="17" height="17"></td>
              <td width="96%">&nbsp;
                  <input name="attach_name<%=am.getId()%>" value="<%=am.getName()%>" size="30">
                &nbsp;
                <a href="javascript:changeAttachName('<%=am.getId()%>', '<%=Topic.getId()%>', '<%="attach_name"+am.getId()%>')">改名</a>
                &nbsp;<a href="javascript:delAttach('<%=am.getId()%>', '<%=Topic.getId()%>')">删除</a>&nbsp;&nbsp;<a target=_blank href="<%=am.getVisualPath()%>">查看</a>&nbsp;&nbsp;</td>
            </tr>
          </table>
          <%}
			  }
			  %>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type=submit value=" 发 出 ">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type=reset value=" 重 写 ">      </td>
      </tr>
    </TBODY>
</form>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <form name="form3" action="?" method="post">
        <td align="center"><input name="newname" type="hidden">
        </td>
      </form>
    </tr>
  </table>
  <iframe id="hideframe" name="hideframe" src="edittopicdo_we.jsp" width=0 height=0></iframe>
<%if (!boardcode.equals(Leaf.CODE_BLOG)) {%>
<%@ include file="inc/footer.jsp"%>
<%}%>
</body>
<script>
function getRadioValue(myitem)
{
     var radioboxs = document.all.item(myitem);
     if (radioboxs!=null)
     {
	   //如果只有一个radio
	   if (radioboxs.length==null) {
		if (radioboxs.type=="radio" && radioboxs.checked)
			return radioboxs.value;
		else
			return "";
	   }
	   for (i=0; i<radioboxs.length; i++)
       {
            if (radioboxs[i].type=="radio" && radioboxs[i].checked)
            {
                 return radioboxs[i].value;
            }
       }
     }
	 return "";
}

function checkTransport() {
     if (getRadioValue("alipay_transport")=="1") {
         frmAnnounce.alipay_ordinary.disabled = false;
         frmAnnounce.alipay_express.disabled = false;
     } else {
         frmAnnounce.alipay_ordinary.disabled = true;
         frmAnnounce.alipay_express.disabled = true;
     }	
}
</script>
</html>
