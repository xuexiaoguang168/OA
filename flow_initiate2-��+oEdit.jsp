<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.db.Paginator"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="common.css" rel="stylesheet" type="text/css">
<link href="cms/default.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<jsp:useBean id="strutil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="docmanager" scope="page" class="com.redmoon.oa.flow.DocumentMgr"/>
<jsp:useBean id="dir" scope="page" class="com.redmoon.oa.flow.Directory"/>
<%
String dir_code = "";
String dir_name = "";

String flowTitle = ParamUtil.get(request, "flowTitle");

int id = 0;

Privilege privilege = new Privilege();

String correct_result = "操作成功！";
int flowId = ParamUtil.getInt(request, "flowId");
WorkflowDb wfd = new WorkflowDb();
wfd = wfd.getWorkflowDb(flowId);
id = wfd.getDocId();

Document doc = new Document();
doc = doc.getDocument(id);
dir_code = doc.getDirCode();

Document template = null;
Leaf leaf = dir.getLeaf(dir_code);
dir_name = leaf.getName();

String strtemplateId = ParamUtil.get(request, "templateId");
int templateId = Document.NOTEMPLATE;
if (!strtemplateId.trim().equals("")) {
	if (StrUtil.isNumeric(strtemplateId))
		templateId = Integer.parseInt(strtemplateId);
}
if (templateId==Document.NOTEMPLATE) {
	if (leaf!=null)
		templateId = leaf.getTemplateId();
}
if (templateId!=Document.NOTEMPLATE) {
	template = docmanager.getDocument(templateId);
}
String op = ParamUtil.get(request, "op");
String work = ParamUtil.get(request, "work"); // init modify

if (op.equals("add")) {
	String action = ParamUtil.get(request, "action");
	if (action.equals("selTemplate")){
		int tid = ParamUtil.getInt(request, "templateId");
		template = docmanager.getDocument(tid);
	}
}
if (op.equals("edit")) {
	String action = ParamUtil.get(request, "action");
	try {
		id = ParamUtil.getInt(request, "id");
		doc = docmanager.getDocument(id);
		dir_code = doc.getDirCode();

		if (action.equals("selTemplate")) {
			int tid = ParamUtil.getInt(request, "templateId");
			doc.setTemplateId(tid);
			doc.updateTemplateId();
		}
		
		if (doc!=null) {
			template = doc.getTemplate();
		}
	} catch (ErrMsgException e) {
		out.print(strutil.makeErrMsg(e.getMessage(), "red", "green"));
		return;
	}
	
	if (action.equals("changeAttachOrders")) {
		int attachId = ParamUtil.getInt(request, "attachId");
		String direction = ParamUtil.get(request, "direction");
		// 取得第一页的内容
		DocContent dc = new DocContent();
		dc = dc.getDocContent(id, 1);
		dc.moveAttachment(attachId, direction);		
	}
}
if (op.equals("editarticle")) {
	op = "edit";
	try {
		doc = docmanager.getDocumentByCode(request, dir_code, privilege);
		dir_code = doc.getDirCode();
		
	} catch (ErrMsgException e) {
		out.print(strutil.makeErrMsg(e.getMessage(),"red", "green"));
		return;
	}
}

if (doc!=null) {
	id = doc.getID();
	Leaf lfn = new Leaf();
	lfn = lfn.getLeaf(doc.getDirCode());
	dir_name = lfn.getName();
}
%>
<title><%=doc!=null?doc.getTitle():""%></title>
<style type="text/css">
<!--
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px; font-style: normal; line-height: 150%; font-weight: normal}
.style2 {color: #FF3300}
-->
</style>
<script language=JavaScript src='scripts/formpost.js'></script>
<script language="JavaScript">
<!--
<%
if (doc!=null) {
	out.println("var id=" + doc.getID() + ";");
}
%>
	var op = "<%=op%>";
	var work = "<%=work%>";

	function SubmitWithFileDdxc() {
		addform.webedit.isDdxc = 1;
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();			
			return false;
		}
		loadDataToWebeditCtrl(addform, addform.webedit);
		addform.webedit.MTUpload();
		// 因为Upload()中启用了线程的，所以函数在执行后，会立即反回，使得下句中得不到ReturnMessage的值
		// 原因是此时服务器的返回信息还没收到
		// alert("ReturnMessage=" + addform.webedit.ReturnMessage);
	}

	function SubmitWithFileThread() {
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();			
			return false;
		}
		loadDataToWebeditCtrl(addform, addform.webedit);
		addform.webedit.Upload();
		// 因为Upload()中启用了线程的，所以函数在执行后，会立即反回，使得下句中得不到ReturnMessage的值
		// 原因是此时服务器的返回信息还没收到
		// alert("ReturnMessage=" + addform.webedit.ReturnMessage);
	}

	function SubmitWithFile(){
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();			
			return false;
		}
		loadDataToWebeditCtrl(addform, addform.webedit);
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

		addform.isuploadfile.value = "false";
		loadDataToWebeditCtrl(addform, addform.webedit);
		addform.webedit.UploadMode = 0;
		addform.webedit.UploadArticle();
		addform.isuploadfile.value = "true";
		if (addform.webedit.ReturnMessage == "<%=correct_result%>")
			doAfter(true);
		else
			doAfter(false);		
	}

	function ClearAll() {
		document.addform.title.value=""
		oEdit1.putHTML(" ");
	}
	
	function doAfter(isSucceed) {
		if (isSucceed) {
			if (op=="edit")
			{
				if (work=="modify")
					location.href = "flow_modify3.jsp?flowId=<%=flowId%>";
				else
					location.href = "flow_initiate3.jsp?flowId=<%=flowId%>";
			}
			else {
				location.href = "flow_initiate3.jsp?flowId=<%=flowId%>";
		    }
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

function selTemplate(id)
{
	if (addform.templateId.value!=id) {
		addform.templateId.value = id;
		// 此处注意当模式对话框的路径在admin下时，退出后本页路径好象被改为admin了
<%if (doc!=null) {%>
		window.location.href="<%=Global.getRootPath()%>/flow_initiate2.jsp?op=edit&work=init&flowId=<%=flowId%>&action=selTemplate&id=<%=id%>&dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>&templateId=" + id;
<%}else{%>
		if (id!=-1)
			window.location.href="<%=Global.getRootPath()%>/flow_initiate2.jsp?op=add&work=init&flowId=<%=flowId%>&action=selTemplate&dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>&templateId=" + id;		
<%}%>
	}
}
//-->
</script>
<script language=JavaScript src='scripts/language/schi/editor_lang.js'></script>
<%
if (request.getHeader("User-Agent").indexOf("MSIE")!=-1){
	out.println("<script language=JavaScript src='scripts/editor.js'></script>");
}
else{
	out.println("<script language=JavaScript src='scripts/moz/editor.js'></script>");
}
%>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<TABLE width="98%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR valign="top" bgcolor="#FFFFFF">
    <TD width="" height="430" colspan="2" style="background-attachment: fixed; background-image: url(images/bg_bottom.jpg); background-repeat: no-repeat">
          <TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
              <TR>
                <TD class=head>
				<%
				if (op.equals("add")) {%>
					添加流程
				<%}else{%>
					修改--
					<%
					Leaf dlf = new Leaf();
					if (doc!=null) {
						dlf = dlf.getLeaf(doc.getDirCode());
					}
					if (doc!=null && dlf.getType()==2) {%>
						<a href="cms/document_list_m.jsp?dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>"><%=dlf.getName()%></a>
					<%}else{%>
						<%=dir_name%>
					<%}%>
				<%}%>
				</TD>
              </TR>
            </TBODY>
          </TABLE>
	<form name="addform" action="/admin/fwebedit_do.jsp" method="post">
          <table border="0" cellspacing="1" width="100%" cellpadding="2" align="center">
            <tr align="center" bgcolor="#F2F2F2">
              <td height="20" colspan=2 align=center><b><%=doc!=null?doc.getTitle():""%></b>&nbsp;<input type="hidden" name=isuploadfile value="true">
			  <input type="hidden" name=id value="<%=doc!=null?""+doc.getID():""%>">	</td>
            </tr>
            
            <tr>
              <td align="left" valign="middle" bgcolor="#F2F2F2" class="unnamed2"><span class="p14">流程类型</span>：</td>
              <td bgcolor="#F2F2F2"><span class="p14">
                <%=dir_name%>
              </span></td>
            </tr>
            <tr>
              <td align="left" class="unnamed2" valign="middle">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
              <td width="90%" bgcolor="#FFFFFF">
                  <%=wfd.getTitle()%>
                  <input type="hidden" name="op" value="<%=op%>">
              <input type="hidden" name="title" value="<%=wfd.getTitle()%>">
              <input type="hidden" name="dir_code" value="<%=dir_code%>">
			  <input type="hidden" name="flowId" value="<%=flowId%>">
			  <input type="hidden" name="examine" value="<%=Document.EXAMINE_PASS%>"></td>
            </tr>
            <tr align="center">
              <td colspan="2" valign="top" bgcolor="#F2F2F2" class="unnamed2">

<pre id="idTemporary" name="idTemporary" style="display:none">
<%
if (!op.equals("add")) {
	if (doc!=null) {
		if (doc.getContent(1).trim().equals("")) {
			FormDb rd = new FormDb();
			rd = rd.getFormDb(leaf.getFormCode());
			out.print(rd.getContent());
		}
		else {
%>
			<%=strutil.HTMLEncode(strutil.getNullString(doc.getContent(1)))%>
<%		}
	}
}%>
</pre>

<pre id="divTemplate" name="divTemplate" style="display:none">
<%if (template!=null) {%>
	<%=template.getContent(1)%>
<%}%>
</pre>

 <script>
		var oEdit1 = new InnovaEditor("oEdit1");
		oEdit1.width="100%";
		oEdit1.height="500";

		oEdit1.features=["FullScreen","Preview","Print","Search","SpellCheck",
					"Cut","Copy","Paste","PasteWord","PasteText","|","Undo","Redo","|",
					"ForeColor","BackColor","|","Bookmark","Hyperlink",
					"HTMLFullSource","HTMLSource","XHTMLFullSource",
					"XHTMLSource","BRK","Numbering","Bullets","|","Indent","Outdent","LTR","RTL","|","Image","Flash","Media","|","InternalLink","CustomObject","|",
					"Table","Guidelines","Absolute","|","Characters","Line",
					"Form","Clean","ClearAll","BRK",
					"StyleAndFormatting","TextFormatting","ListFormatting","BoxFormatting",
					"ParagraphFormatting","CssText","Styles","|",
					"Paragraph","FontName","FontSize","|",
					"Bold","Italic",
					"Underline","Strikethrough","|","Superscript","Subscript","|",
					"JustifyLeft","JustifyCenter","JustifyRight","JustifyFull"]; 
<%if (templateId!=-1) {%>	
	oEdit1.RENDER(document.getElementById("divTemplate").innerHTML);
<%}else{%>
	oEdit1.RENDER(document.getElementById("idTemporary").innerHTML);
<%}%>
</script>            </td>
            </tr>
            <tr>
              <td width="10%" align="right" bgcolor="#FFFFFF">提示：</td>
              <td bgcolor="#FFFFFF">
			  回车可用Shift+Enter			  </td>
            </tr>
            <tr>
              <td height="25" colspan=2 align="center" bgcolor="#FFFFFF">
			  <%
			  if (doc!=null) {
				  Vector attachments = doc.getAttachments(1);
				  Iterator ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	Attachment am = (Attachment) ir.next(); %>
					<table width="98%"  border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="7%" align="center"><img src=images/attach.gif width="17" height="17"></td>
                        <td width="93%">&nbsp;
                          <input name="attach_name<%=am.getId()%>" value="<%=am.getName()%>" size="30">
&nbsp;<a href="javascript:changeAttachName('<%=am.getId()%>', '<%=doc.getID()%>', '<%="attach_name"+am.getId()%>')">更改</a>                        &nbsp;<a href="javascript:delAttach('<%=am.getId()%>', '<%=doc.getID()%>')">删除</a>&nbsp;&nbsp;<a target=_blank href="<%=am.getVisualPath() + "/" + am.getDiskName()%>">查看</a>&nbsp;<a href="?op=edit&id=<%=doc.getID()%>&action=changeAttachOrders&direction=up&attachId=<%=am.getId()%>"><img src="images/arrow_up.gif" alt="往上" width="16" height="20" border="0" align="absmiddle"></a>&nbsp;<a href="?op=edit&id=<%=doc.getID()%>&action=changeAttachOrders&direction=down&attachId=<%=am.getId()%>"><img src="images/arrow_down.gif" alt="往下" width="16" height="20" border="0" align="absmiddle"></a></td>
                      </tr>
                    </table>
				<%}
			  }
			  %>			  </td>
            </tr>
            <tr>
              <td height="153" colspan=2 align=center bgcolor="#FFFFFF">
			  <table  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                <tr>
                  <td bgcolor="#FFFFFF"><%
Calendar cal = Calendar.getInstance();
String year = "" + (cal.get(cal.YEAR));
String month = "" + (cal.get(cal.MONTH) + 1);
String filepath = "upfile/document/" + year + "/" + month;
%><object classid="CLSID:DE757F80-F499-48D5-BF39-90BC8BA54D8C" codebase="<%=request.getContextPath()%>/activex/webedit.cab#version=4,0,1,1" width=400 height=280 align="middle" id="webedit">
                      <param name="Encode" value="utf-8">
					  <param name="MaxSize" value="<%=Global.MaxSize%>"> <!--上传字节-->
                      <param name="ForeColor" value="(0,255,0)">
                      <param name="BgColor" value="(0,0,0)">
                      <param name="ForeColorBar" value="(255,255,255)">
                      <param name="BgColorBar" value="(0,0,255)">
                      <param name="ForeColorBarPre" value="(0,0,0)">
                      <param name="BgColorBarPre" value="(200,200,200)">
                      <param name="FilePath" value="<%=filepath%>">
                      <param name="Relative" value="1">
                      <!--上传后的文件需放在服务器上的路径-->
                      <param name="Server" value="<%=request.getServerName()%>">
                      <param name="Port" value="<%=request.getServerPort()%>">
                      <param name="VirtualPath" value="<%=Global.virtualPath%>">
                      <param name="PostScript" value="<%=Global.virtualPath%>/flow_initiate2_do.jsp">
                      <param name="PostScriptDdxc" value="<%=Global.virtualPath%>/ddxc.jsp">
                      <param name="SegmentLen" value="204800">
                    </object></td>
                </tr>
              </table>              </td>
            </tr>
            <tr>
              <td height="30" colspan=2 align=center bgcolor="#FFFFFF">
			  <input type=button class="singleboarder" value="上一步" onClick="window.location.href='flow_modify1.jsp?flowId=<%=flowId%>'">
			  <%
			  String action = "";
			  if (op.equals("add"))
			  	action = "添 加";
			  else
			  	action = "下一步";
			  %>
			  <%if (templateId==-1) {%>
              <!--<input name="cmdok3" type="button" class="singleboarder" value="<%=action%>(单线程)" onClick="return SubmitWithFileThread()">-->
              <%}
			  if (templateId==-1) {%>
			  <input name="cmdok" type="button" class="singleboarder" value=" <%=action%> " onClick="return SubmitWithFile()">
			  <%}%>
&nbsp;
<input name="notuploadfile" type="button" class="singleboarder" value="<%=action%>(不上传图片)" onClick="return SubmitWithoutFile()">
&nbsp;
      <input name="cmdcancel" type="button" class="singleboarder" onClick="ClearAll()" value=" 清 空 ">
&nbsp;
&nbsp;
<input name="remsg" type="button" class="singleboarder" onClick='alert(webedit.ReturnMessage)' value="返回信息">
&nbsp;</td>
            </tr>
        </table>
    </form>
		<table width="100%"  border="0">
          
          <tr>
            <form name="form3" action="?" method="post"><td align="center">
			<input name="newname" type="hidden">
			</td></form>
          </tr>
        </table>
	</TD>
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

function changeAttachName(attach_id, doc_id, nm) {
	var obj = findObj(nm);
	// document.frames.hideframe.location.href = "fwebedit_do.jsp?op=changeattachname&page_num=1&doc_id=" + doc_id + "&attach_id=" + attach_id + "&newname=" + obj.value
	form3.action = "fwebedit_do.jsp?op=changeattachname&page_num=1&doc_id=" + doc_id + "&attach_id=" + attach_id;
	form3.newname.value = obj.value;
	form3.submit();
}

function delAttach(attach_id, doc_id) {
	if (!window.confirm("您确定要删除吗？")) {
		return;
	}
	document.frames.hideframe.location.href = "fwebedit_do.jsp?op=delAttach&page_num=1&doc_id=" + doc_id + "&attach_id=" + attach_id
}
</script>
</html>