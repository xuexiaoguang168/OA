<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String targeturl = StrUtil.getUrl(request);
if (!privilege.isUserLogin(request)) {
	response.sendRedirect("../door.jsp?targeturl="+targeturl);
	return;
}
%>
<%
String boardcode = ParamUtil.get(request, "boardcode");
Leaf curleaf = new Leaf();
curleaf = curleaf.getLeaf(boardcode);
if (curleaf==null || !curleaf.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "该版块" + boardcode + "不存在"));
	return;
}

if (!curleaf.isUsePlugin2("alipay")) {
	out.print(SkinUtil.makeErrMsg(request, "该版不能够发起支付宝交易！"));
	return;
}

String boardname = curleaf.getName();
String blogUserDir = ParamUtil.get(request, "blogUserDir");
if (blogUserDir.equals(""))
	blogUserDir = UserDirDb.DEFAULT;
	

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
<title><%=Global.AppName%> - 发新贴</title>
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
	
	var html;
	html=cws_getText();
	html=cws_rCode(html,"<a>　</a>","");
 	document.frmAnnounce.Content.value=html;
		
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

var attachCount = 1;
function AddAttach() {
	if (attachCount>=<%=maxAttachmentCount%>) {
		alert("附件最多只能上传<%=maxAttachmentCount%>个！");
		return;
	}
	updiv.insertAdjacentHTML("BeforeEnd", "<table width=100%><tr><lt:Label res="res.label.forum.addtopic" key="file"/>&nbsp;<input type='file' name='filename" + attachCount + "' size=10><td></td></tr></table>");
	// updiv.innerHTML += "<table width=100%><tr>文件&nbsp;<input type='file' name='filename" + attachCount + "' size=10><td></td></tr></table>";
	attachCount += 1;
}
//-->
</script>
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
<br>
<script src="inc/ubbcode.jsp"></script>
<%
int i=0;
%>
<table width="98%" border="1" align="center" cellpadding="4" cellspacing="0" borderColor="<%=skin.getTableBorderClr()%>">
<form name=frmAnnounce method="post" action="addtopictodb.jsp" enctype="MULTIPART/FORM-DATA" onSubmit="return frmAnnounce_onsubmit()">
    <TBODY>
      <tr> 
        <td height="26" colspan="2" background="<%=skinPath%>/images/bg1.gif" class="td_title">发表新贴至：<a href="listtopic.jsp?boardcode=<%=boardcode%>"><%=boardname%></a></td>
      </tr>
    </TBODY>
    <TBODY>
      <tr>
        <td>发表至论坛版块</td>
        <td>
		<%
		UserConfigDb ucd = new UserConfigDb();
		ucd = ucd.getUserConfigDb(privilege.getUser(request));
		// 如果用户的博客未开通，则不能选择版块
		if (Global.hasBlog && ucd!=null && ucd.isLoaded()) {
		%>
		  <script>
		  var bcode<%=i%> = "<%=boardcode%>";
		  </script>
		  <select name="boardcode" onChange="if(this.options[this.selectedIndex].value=='not'){alert(this.options[this.selectedIndex].text+' 不能被选择！'); this.value=bcode<%=i%>; return false;}">
                <option value="not" selected>请选择版块</option>
                <%
				com.redmoon.forum.Directory directory = new com.redmoon.forum.Directory();
				com.redmoon.forum.Leaf lf = directory.getLeaf("root");
				com.redmoon.forum.DirectoryView dv = new com.redmoon.forum.DirectoryView(lf);
				dv.ShowDirectoryAsOptions(out, lf, lf.getLayer());
				%>
          </select>		
		  <script>
			frmAnnounce.boardcode.value = "<%=boardcode%>";
		  </script>		
		  <%if (boardcode.equals(Leaf.CODE_BLOG)) {%>
			（如果需要发表至论坛中，则选择其它版块，否则将不会显示在论坛中）
		  <%}
		  }else{%>
		  <%=boardname%><input type="hidden" name="boardcode" value="<%=boardcode%>">
		  <%}%>		</td>
      </tr>
	  <%
	  if (Global.hasBlog && ucd.isLoaded()) {
	  %>
      <tr>
        <td>发表至博客目录</td>
        <td>
		<%
		UserDirDb udd = new UserDirDb();
		%>
		<select name=blogUserDir>
          <option value="<%=UserDirDb.DEFAULT%>">默认目录</option>
          <%=udd.toOptions(privilege.getUser(request))%>
        </select>
		<script>
		frmAnnounce.blogUserDir.value = "<%=blogUserDir%>";
		</script>
		<input name=isBlog value=1 type=checkbox <%=boardcode.equals(Leaf.CODE_BLOG)?"checked":""%>>
		发表至博客		</td>
      </tr>
	  <%}%>
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
		IPluginViewAddMsg pv = ipu.getViewAddMsg(boardcode);
		if (pv.IsPluginBoard()) {
			out.print(pu.getName(request) + ":&nbsp;" + pv.render(UIAddMsg.POS_TITLE) + "<BR>");
			out.print(pv.render(UIAddMsg.POS_FORM_ELEMENT) + "<BR>");
		}
	}
}

String hit = request.getParameter("hit");
String isvote = StrUtil.getNullString(request.getParameter("isvote"));
%>        </td>
      </tr>
<%
if (cfg1.getBooleanProperty("forum.addUseValidateCode")) {
%>
<tr><td width="20%">
请输入验证码：
</td><td><input name="validateCode" type="text" size="1">
  <img src='../validatecode.jsp' border=0 align="absmiddle" style="cursor:hand" onClick="this.src='../validatecode.jsp'" alt="<lt:Label res="res.label.forum.index" key="refresh_validatecode"/>"></td>
</tr>	  <%}%>      
      <tr>
        <td>支付宝账号</td>
        <td><input class="input" maxlength="200" size="35" name="alipay_seller">
		<input name="plugin2Code" value="alipay" type="hidden">		</td>
      </tr>
      <tr>
        <td>商品名称</td>
        <td><input class="input" maxlength="200" size="25" name="alipay_subject">
          &nbsp;&nbsp;  
      价格
      <input class="input" maxlength="20" size="5" name="alipay_price">
元</td>
      </tr>
      <tr>
        <td>邮费承担方</td>
        <td><input id="alipay_transport" onClick="checkTransport();" type="radio" value="3" name="alipay_transport">
          虚拟物品不需邮递
          <input id="alipay_transport" onClick="checkTransport();" type="radio" checked value="2" name="alipay_transport">
          卖家承担运费
          <input id="alipay_transport" onClick="checkTransport();" type="radio" value="1" name="alipay_transport">
          买家承担运费
          <br>
平邮
<input class="input" disabled maxlength="20" size="5" name="alipay_ordinary">
元&nbsp;&nbsp; 快递
<input class="input" disabled maxlength="20" size="5" name="alipay_express">
元 (不填为平邮)</td>
      </tr>
      <tr>
        <td>演示网址</td>
        <td><input class="input" maxlength="200" size="35" name="alipay_demo">
        商品说明请填写于信息内容中</td>
      </tr>
      <tr>
        <td>联系方式</td>
        <td>淘宝旺旺
          <input class="input" maxlength="20" size="10" name="alipay_ww">
腾讯QQ
<input class="input" maxlength="20" size="10" name="alipay_qq">
让买家在线联系您</td>
      </tr>
      
      <tr> 
        <td width="20%">主题标题：</td>
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
          </SELECT> <input name="topic" type="text" id="topic" size="60" maxlength="80">
          <input type="hidden" name="boardname" value="<%=boardname%>">
          <input type="hidden" name="hit" value="<%=hit%>">
          <input type="hidden" name="privurl" value="<%=privurl%>"></td>
      </tr>
      <tr>
        <td valign="top">当前心情：<br>
          将放在帖子的前面</td>
        <td><iframe src="iframe_emote.jsp" height="25"  width="500px" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
        <input type="hidden" name="expression" value="25"></td>
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
		<input type="checkbox" name="isvote" value="1" onClick="showvote()" <%=ischecked%>>投票选项		</td>
        <td width="80%"><textarea style="display:<%=display%>" cols="55" name="vote" rows="8" wrap="VIRTUAL" title="输入投票选项"></textarea>
          每行代表一个选项</td>
      </tr>
      <tr> 
        <td rowspan="3" valign="bottom"><input type="checkbox" name="email_notify" value="1">
          有回复通知我 </td><td><table width="100%" border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td class=tablebody1 valign=top height=30>文件&nbsp;<input type="file" name="filename" size=10>
                限制：<%=maxAttachmentCount%>个，限制大小<%=maxAttachmentSize%>K
                <input type=button onClick="AddAttach()" value="增加附件"></td>
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
          <input type=submit value=" 发 出 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=reset value=" 重 写 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if (!boardcode.equals(Leaf.CODE_BLOG)) {%>
<input type="button" onClick="window.location.href='addtopic.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>&privurl=<%=privurl%>'" value="UBB发贴">
<%}%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if (privilege.canWebEditRedMoon(request, boardcode)) {%>
<input type="button" onClick="window.location.href='addtopic_we.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>&blogUserDir=<%=blogUserDir%>&privurl=<%=privurl%>'" value="高级发贴">
<%}%></td>
      </tr>
    </TBODY></form>
</table>
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
