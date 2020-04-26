<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="java.util.Calendar" %>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
<jsp:useBean id="strutil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<%
String dir_code = ParamUtil.get(request, "dir_code");
String dir_name = ParamUtil.get(request, "dir_name");
int id = 0;
if (!FSecurity.isValidSqlParam(dir_code)) {
	out.print(strutil.makeErrMsg("标识非法！"));
	return;
}
%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:setProperty name="privilege" property="defaulturl" value="../index.jsp"/>
<%
String priv="admin";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String correct_result = "操作成功！";
Document doc = null;
String op = ParamUtil.get(request, "op");
if (op.equals("edit")) {
	try {
		id = ParamUtil.getInt(request, "id");
		doc = docmanager.getDocument(request, id, privilege);
	} catch (ErrMsgException e) {
		out.print(strutil.makeErrMsg(e.getMessage(),"red", "green"));
		return;
	}
}
if (op.equals("editarticle")) {
	op = "edit";
	try {
		doc = docmanager.getDocumentByCode(request, dir_code, privilege);
	} catch (ErrMsgException e) {
		out.print(strutil.makeErrMsg(e.getMessage(),"red", "green"));
		return;
	}
}
%>
<title><%=doc!=null?doc.getTitle():""%></title>
<style type="text/css">
<!--
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px; font-style: normal; line-height: 150%; font-weight: normal}
-->
</style>
<script language="JavaScript">
<!--
<%
if (doc!=null) {
	out.println("var id=" + doc.getID() + ";");
}
%>
	var op = "<%=op%>";

	function SubmitWithFile(){
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();			
			return false;
		}
		if (op=="edit") {
			addform.webedit.Clear();
			addform.webedit.AddField("title",addform.title.value);
			addform.webedit.AddField("id", id);
			addform.webedit.AddField("op", "<%=op%>");
			if (addform.canComment.checked)
				addform.webedit.AddField("canComment", addform.canComment.value);
			if (addform.isHome.checked)
				addform.webedit.AddField("isHome", addform.isHome.value);
			if (addform.isvote.checked)
			{
				addform.webedit.AddField("isvote", addform.isvote.value);
				addform.webedit.AddField("vote", addform.vote.value);
			}
			addform.webedit.AddField("keywords", addform.keywords.value);
			if (addform.isRelateShow.checked)
				addform.webedit.AddField("isRelateShow", addform.isRelateShow.value);
			addform.webedit.AddField("examine", addform.examine.value);
			addform.webedit.SetHtmlCode(document.frames.webEditorFrame.getHTML());
		}
		if (op=="add") {
			addform.webedit.Clear();
			addform.webedit.AddField("title",addform.title.value);
			addform.webedit.AddField("op", "<%=op%>");
			addform.webedit.AddField("dir_code", "<%=dir_code%>");
			if (addform.canComment.checked)
				addform.webedit.AddField("canComment", addform.canComment.value);			
			if (addform.isHome.checked)
				addform.webedit.AddField("isHome", addform.isHome.value);
			if (addform.isvote.checked)
			{
				addform.webedit.AddField("isvote", addform.isvote.value);
				addform.webedit.AddField("vote", addform.vote.value);
			}				
			addform.webedit.AddField("examine", addform.examine.value);
			addform.webedit.AddField("keywords", addform.keywords.value);
			if (addform.isRelateShow.checked)
				addform.webedit.AddField("isRelateShow", addform.isRelateShow.value);
			addform.webedit.SetHtmlCode(document.frames.webEditorFrame.getHTML());
		}
		addform.webedit.UploadArticle();
		if (addform.webedit.ReturnMessage == "<%=correct_result%>")
			doAfter(true);
		else
			doAfter(false);
	}
	
	function SubmitWithoutFile() {
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();	
			return false;
		}
		//addform.content.value = document.frames.webEditorFrame.getHTML();
		//addform.submit();
		addform.webedit.Clear();
		addform.webedit.UploadMode = 0;
		if (op=="edit") {
			addform.webedit.AddField("isuploadfile", "false");
			addform.webedit.AddField("title",addform.title.value);
			addform.webedit.AddField("id", id);
			if (addform.canComment.checked)
				addform.webedit.AddField("canComment", addform.canComment.value);
			if (addform.isHome.checked)
				addform.webedit.AddField("isHome", addform.isHome.value);
			addform.webedit.AddField("op", "<%=op%>");
			if (addform.isvote.checked)
			{
				addform.webedit.AddField("isvote", addform.isvote.value);
				addform.webedit.AddField("vote", addform.vote.value);
			}
			addform.webedit.AddField("examine", addform.examine.value);
			addform.webedit.AddField("keywords", addform.keywords.value);
			if (addform.isRelateShow.checked)
				addform.webedit.AddField("isRelateShow", addform.isRelateShow.value);
			
			addform.webedit.SetHtmlCode(document.frames.webEditorFrame.getHTML());
		}
		if (op=="add") {
			addform.webedit.AddField("isuploadfile", "false");
			addform.webedit.AddField("title",addform.title.value);
			addform.webedit.AddField("dir_code", "<%=dir_code%>");
			addform.webedit.AddField("op", "<%=op%>");
			if (addform.canComment.checked)
				addform.webedit.AddField("canComment", addform.canComment.value);
			if (addform.isHome.checked)
				addform.webedit.AddField("isHome", addform.isHome.value);
			if (addform.isvote.checked)
			{
				addform.webedit.AddField("isvote", addform.isvote.value);
				addform.webedit.AddField("vote", addform.vote.value);
			}
			addform.webedit.AddField("examine", addform.examine.value);
			addform.webedit.AddField("keywords", addform.keywords.value);
			if (addform.isRelateShow.checked)
				addform.webedit.AddField("isRelateShow", addform.isRelateShow.value);
			
			addform.webedit.SetHtmlCode(document.frames.webEditorFrame.getHTML());
		}
		addform.webedit.UploadArticle();
		if (addform.webedit.ReturnMessage == "<%=correct_result%>")
			doAfter(true);
		else
			doAfter(false);		
	}
	
	function clearAll(){
		document.addform.title.value=""
		document.frames.webEditorFrame.setHTML('');			
	}
	
	function doAfter(isSucceed) {
		if (isSucceed) {
			if (confirm("<%=correct_result%> 请点击确定按钮刷新页面。"))
				window.location.reload(true);
		}
		else {
			alert(addform.webedit.ReturnMessage);
		}
	}
	
function showvote(isshow)
{
	if (addform.isvote.checked)
	{
		addform.vote.style.display = "";
	}
	else
	{
		addform.vote.style.display = "none";		
	}
}	
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" onLoad="window_onload()">
<TABLE BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR valign="top" bgcolor="#FFFFFF">
    <TD width="590" height="430" colspan="2" style="background-attachment: fixed; background-image: url(images/bg_bottom.jpg); background-repeat: no-repeat">
	<form name="addform" action="fwebedit_do.jsp" method="post">
          <TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
              <TR>
                <TD class=head>
				<%
				if (op.equals("add")) {%>
					添加内容至--<a href="document_list_m.jsp?dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>"><%=dir_name%></a>
				<%}else{%>
					修改--
					<%if (doc.getType()==2) {%>
						<a href="document_list_m.jsp?dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>"><%=dir_name%></a>
					<%}else{%>
						<%=dir_name%>
					<%}%>
					(<%=doc.getDirCode()%>)
				<%}%>
				</TD>
              </TR>
            </TBODY>
          </TABLE>
          <table border="0" cellspacing="1" width="100%" cellpadding="0" align="center">
            <tr align="center" bgcolor="#F2F2F2">
              <td height="20" colspan=2 align=center><b><%=doc!=null?doc.getTitle():""%></b>&nbsp;<input type="hidden" name=isuploadfile value="false">
			  <input type="hidden" name=id value="<%=doc!=null?doc.getID():""%>">
<%=doc!=null?"(id:"+doc.getID()+")":""%>			  </td>
            </tr>
            <tr>
              <td align="right" class="unnamed2" valign="middle" bgcolor="#FFFFFF">标&nbsp;&nbsp;&nbsp;&nbsp;题：</td>
              <td width="89%" bgcolor="#FFFFFF">
                  <input name="title" id=me type="TEXT" size=50 maxlength=100 style="background-color:ffffff;color:000000;border: 1 double" value="<%=doc!=null?doc.getTitle():""%>">                  <span class="unnamed2"><font color="#FF0000">＊</font></span>			</td>
            </tr>
            <tr>
              <td align="right" class="unnamed2" valign="middle" bgcolor="#FFFFFF">关键字：</td>
              <td bgcolor="#FFFFFF"><input name="keywords" id=keywords type="TEXT" size=30 maxlength=100 style="background-color:ffffff;color:000000;border: 1 double" value="<%=StrUtil.getNullStr(doc==null?dir_code:doc.getKeywords())%>">
              ( 请用&quot;，&quot;号分隔)
                <span class="unnamed2">
                <%
			String strRelateChecked = "";
			if (doc!=null && doc.getIsRelateShow())
				strRelateChecked = "checked";
			%>
&nbsp;&nbsp;相关文章：
<input type="checkbox" name="isRelateShow" value="1" <%=strRelateChecked%>>
显示</span></td>
            </tr>
            <tr align="left" bgcolor="#F2F2F2">
              <td colspan="2" valign="middle" class="unnamed2">&nbsp;<%
			String strChecked = "";
			if (doc!=null) {
				if (doc.getCanComment())
					strChecked = "checked";
			}
			else
				strChecked = "checked";
			%>
评论：
  <input type="checkbox" name="canComment" value="1" <%=strChecked%>>
允许
<%if (doc!=null) {%>
[<a href="comment_m.jsp?doc_id=<%=doc.getID()%>">管理评论</a>]
<%}%>
&nbsp;
<%if (doc!=null) {%>
<input type="checkbox" name="isHome" value="<%=doc.getIsHome()?"false":"true"%>" <%=doc.getIsHome()?"checked":""%>>
<%}else{%>
<input type="checkbox" name="isHome" value="true" checked>
<%}%>
置于首页&nbsp;&nbsp;&nbsp;&nbsp;审核
<select name="examine">
<option value="0">未审核</option>
<option value="1">未通过</option>
<option value="2">已通过</option>
</select>
<%if (doc!=null) {%>
<script>
addform.examine.value = "<%=doc.getExamine()%>";
</script>
<%}%>
</td>
            </tr>
            <tr bgcolor="#F2F2F2">
              <td align="right" class="unnamed2" valign="middle">
			  <script>
			  var vp = "";
			  </script>
		<%
		String display="none",ischecked="false", isreadonly = "";
		if (doc!=null) {
			if (doc.getType()==1) {
				display = "";
				ischecked = "checked disabled";
				isreadonly = "readonly";
				%>
				<script>
				var voteoption = "<%=doc.getVoteOption()%>";
				var votes = voteoption.split("|");
				var len = votes.length;
				for (var i=0; i<len; i++) {
					if (vp=="")
						vp = votes[i];
					else
						vp += "\r\n" + votes[i];
				}
				</script>
			<%}
		}%>
					  <input type="checkbox" name="isvote" value="1" onClick="showvote()" <%=ischecked%>>
              投票</td>
              <td valign="middle"><textarea <%=isreadonly%> style="display:<%=display%>" cols="60" name="vote" rows="8" wrap="VIRTUAL" title="输入投票选项">
			  </textarea>
			  <script>
  				addform.vote.value = vp;
			  </script>
每行代表一个选项</td>
            </tr>
            <tr align="center">
              <td colspan="2" valign="top" bgcolor="#F2F2F2" class="unnamed2">
			  <textarea id="content" name="content" style="display:none"><%=doc!=null?doc.getContent().replaceAll("\"","'"):""%></textarea>
                  <iframe style=border:none frameborder=0 allowtransparency=true name=webEditorFrame src=Editor.htm width=98% height=350></iframe>
              </td>
            </tr>
            <tr>
              <td width="11%" align="right" bgcolor="#FFFFFF">提示：</td>
              <td bgcolor="#FFFFFF">
			  回车可用Shift+Enter			  </td>
            </tr>
            <tr>
              <td height="25" colspan=2 align="center" bgcolor="#FFFFFF"><font color="#FF0000">注：当可视化编辑器出现图标显示不全的问题，请重新进入，否则保存后内容会消失。</font></td>
            </tr>
            <tr>
              <td height="25" colspan=2 align="center" bgcolor="#FFFFFF">
			  <%
			  if (doc!=null) {
				  Vector attachments = doc.getAttachments();
				  Iterator ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	Attachment am = (Attachment) ir.next(); %>
					<table width="98%"  border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="7%" align="center"><img src=../images/attach.gif></td>
                        <td width="93%">&nbsp;
                          <input name="attach_name<%=am.getId()%>" value="<%=am.getName()%>" size="30">
&nbsp;<a href="javascript:changeAttachName('<%=am.getId()%>', '<%=doc.getID()%>', '<%="attach_name"+am.getId()%>')">更改</a>                        &nbsp;<a href="javascript:delAttach('<%=am.getId()%>', '<%=doc.getID()%>')">删除</a>&nbsp;&nbsp;<a target=_blank href="../<%=am.getVisualPath() + "/" + am.getDiskName()%>">查看</a></td>
                      </tr>
                    </table>
				<%}
			  }
			  %>
			  </td>
            </tr>
            <tr>
              <td height="153" colspan=2 align=center bgcolor="#FFFFFF">
			  <table  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                <tr>
                  <td bgcolor="#FFFFFF"><%
Calendar cal = Calendar.getInstance();
String year = "" + (cal.get(cal.YEAR));
String month = "" + (cal.get(cal.MONTH) + 1);
String filepath = "upfile/webeditimg/" + year + "/" + month;
%><object classid="CLSID:DE757F80-F499-48D5-BF39-90BC8BA54D8C" codebase="<%=request.getContextPath()%>/activex/webedit.cab#version=4,0,1,1" width=400 height=153 align="middle" id="webedit">
                      <param name="Encode" value="utf-8">
					  <param name="MaxSize" value="<%=Global.MaxSize%>"> <!--上传字节-->
                      <param name="ForeColor" value="(0,255,0)">
                      <param name="BgColor" value="(0,0,0)">
                      <param name="ForeColorBar" value="(255,255,255)">
                      <param name="BgColorBar" value="(0,0,255)">
                      <param name="ForeColorBarPre" value="(0,0,0)">
                      <param name="BgColorBarPre" value="(200,200,200)">
                      <param name="FilePath" value="<%=filepath%>">
                      <!--上传后的文件需放在服务器上的路径-->
                      <param name="Server" value="<%=Global.server%>">
                      <param name="Port" value="<%=Global.port%>">
                      <param name="VirtualPath" value="<%=Global.virtualPath%>">
                      <param name="PostScript" value="<%=Global.virtualPath%>/admin/fwebedit_do.jsp">
                    </object></td>
                </tr>
              </table>
              </td>
            </tr>
            <tr>
              <td height="30" colspan=2 align=center bgcolor="#FFFFFF">
			  <%
			  String action = "";
			  if (op.equals("add"))
			  	action = "添 加";
			  else
			  	action = "修 改";
			  %>
			  <input name="cmdok" type="button" class="singleboarder" value=" <%=action%> " onClick="return SubmitWithFile()">
&nbsp;
<input name="notuploadfile" type="button" class="singleboarder" value="<%=action%>(不上传图片)" onClick="return SubmitWithoutFile()">
&nbsp;
      <input name="cmdcancel" type="button" class="singleboarder" onClick="clearAll()" value=" 清 空 ">
&nbsp;
      <%if (op.equals("edit")) {%>
	  <input name="editbtn" type="button" class="singleboarder" onClick="location.href='doc_abstract.jsp?id=<%=doc.getID()%>'" value=" 摘要 ">
	  <%}%>
&nbsp;
<input name="remsg" type="button" class="singleboarder" onClick='alert(webedit.ReturnMessage)' value="返回信息">
&nbsp;
<input name="remsg" type="button" class="singleboarder" onClick='window.open("../doc_show.jsp?id=<%=id%>")' value="预览"> </td>
            </tr>
          </table>
    </form>
		<br></TD>
  </TR>
</TABLE>
<iframe id="hideframe" name="hideframe" src="fwebedit_do.jsp" width=0 height=0></iframe>
</body>
<script>
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

function window_onload() {
	document.frames.webEditorFrame.setHTML(addform.content.value);			
}

function changeAttachName(attach_id, doc_id, nm) {
	var obj = findObj(nm);
	document.frames.hideframe.location.href = "fwebedit_do.jsp?op=changeattachname&doc_id=" + doc_id + "&attach_id=" + attach_id + "&newname=" + obj.value
}

function delAttach(attach_id, doc_id) {
	if (!window.confirm("您确定要删除吗？")) {
		return;
	}
	document.frames.hideframe.location.href = "fwebedit_do.jsp?op=delAttach&doc_id=" + doc_id + "&attach_id=" + attach_id
}
</script>
</html>