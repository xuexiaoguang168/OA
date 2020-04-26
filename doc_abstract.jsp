<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="com.redmoon.oa.pvg.Privilege"%>
<%@ page import="java.util.Calendar" %>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="common.css" rel="stylesheet" type="text/css">
<link href="admin/default.css" rel="stylesheet" type="text/css">
<%
String correct_result = "操作成功！";
%>
<script>
	function addform_submit() {
		addform.content.value = oEdit1.getHTMLBody();
	}
	
	function ClearAll(){
		oEdit1.RENDER(" ");
	}
	
	function SubmitWithFile(){
		var htmlcode = oEdit1.getHTMLBody();
		if (htmlcode=="")
			htmlcode = " ";
		addform.webedit.Clear();
		addform.webedit.AddField("id", addform.id.value);
		addform.webedit.SetHtmlCode(htmlcode);
		addform.webedit.UploadArticle();
		if (addform.webedit.ReturnMessage == "<%=correct_result%>")
			doAfter(true);
		else
			doAfter(false);
	}	
	
	function SubmitWithoutFile(){
		var htmlcode = oEdit1.getHTMLBody();
		if (htmlcode=="")
			htmlcode = " ";
		addform.webedit.Clear();
		addform.webedit.AddField("isuploadfile", "false");
		addform.webedit.AddField("id", addform.id.value);
		addform.webedit.SetHtmlCode(htmlcode);
		addform.webedit.UploadArticle();
		if (addform.webedit.ReturnMessage == "<%=correct_result%>")
			doAfter(true);
		else
			doAfter(false);
	}	
	
	function doAfter(isSucceed) {
		if (isSucceed) {
			alert("<%=correct_result%>");
    		window.location.reload(true); 
		}
		else {
			alert(addform.webedit.ReturnMessage);
		}
	}	
</script>
<jsp:useBean id="strutil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<%
int id = 0;
Document doc = null;
String op = ParamUtil.get(request, "op");
id = ParamUtil.getInt(request, "id");
Privilege privilege = new Privilege();
doc = docmanager.getDocument(request, id, privilege);

LeafPriv lp = new LeafPriv(doc.getDirCode());
if (!lp.canUserModify(privilege.getUser(request))) {
	out.print(StrUtil.makeErrMsg(privilege.MSG_INVALID));
	return;
}
%>
<title><%=doc.getTitle()%></title>
<style type="text/css">
<!--
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px; font-style: normal; line-height: 150%; font-weight: normal}
-->
</style>
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
    <TD height="430" colspan="2" style="background-attachment: fixed; background-image: url(images/bg_bottom.jpg); background-repeat: no-repeat">
	<form name="addform" action="/doc_abstract_do.jsp" method="post" onSubmit="return addform_submit()">
          <TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
              <TR>
                <TD class=head>
				提取摘要&nbsp;&nbsp;&nbsp;&nbsp;<a href="fwebedit.jsp?op=edit&id=<%=doc.getID()%>&dir_code=<%=StrUtil.UrlEncode(doc.getDirCode())%>">返回</a></TD>
              </TR>
            </TBODY>
          </TABLE>
          <table border="0" cellspacing="1" width="100%" cellpadding="0" align="center">
            <tr align="center" bgcolor="#F2F2F2">
              <td height="20" colspan=3 align=center><b><%=doc.getTitle()%></b>&nbsp;
			  <input type="hidden" name=id value="<%=doc.getID()%>">
			  </td>
            </tr>
            <tr align="center">
              <td colspan="3" valign="top" bgcolor="#F2F2F2" class="unnamed2">
			  <textarea id="content" name="content" style="display:none">
			  </textarea>
<pre id="idTemporary" name="idTemporary" style="display:none">
<%=strutil.HTMLEncode(strutil.getNullString(doc.getSummary()))%>
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

	oEdit1.RENDER(document.getElementById("idTemporary").innerHTML);

</script>

              </td>
            </tr>
            <tr>
              <td width="13%" align="right" bgcolor="#FFFFFF">提示：</td>
              <td width="87%" colspan="2" bgcolor="#FFFFFF">
			  回车可用Shift+Enter			  </td>
            </tr>
            <tr>
              <td height="25" colspan=3 align="center" bgcolor="#FFFFFF"><table  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                <tr>
                  <td bgcolor="#FFFFFF"><%
Calendar cal = Calendar.getInstance();
String year = "" + (cal.get(cal.YEAR));
String month = "" + (cal.get(cal.MONTH) + 1);
String filepath = "upfile/webeditimg/" + year + "/" + month;
%>
                      <object classid="CLSID:DE757F80-F499-48D5-BF39-90BC8BA54D8C" codebase="<%=request.getContextPath()%>/activex/webedit.cab#version=4,0,1,1" width=400 height=153 align="middle" id="webedit">
                        <param name="Encode" value="utf-8">
                        <param name="MaxSize" value="<%=Global.MaxSize%>">
                        <!--上传字节-->
                        <param name="ForeColor" value="(0,255,0)">
                        <param name="BgColor" value="(0,0,0)">
                        <param name="ForeColorBar" value="(255,255,255)">
                        <param name="BgColorBar" value="(0,0,255)">
                        <param name="ForeColorBarPre" value="(0,0,0)">
                        <param name="BgColorBarPre" value="(200,200,200)">
                        <param name="FilePath" value="<%=filepath%>">
                        <!--上传后的文件需放在服务器上的路径-->
                        <param name="Server" value="<%=request.getServerName()%>">
                        <param name="Port" value="<%=request.getServerPort()%>">
                        <param name="VirtualPath" value="<%=Global.virtualPath%>">
                        <param name="PostScript" value="<%=Global.virtualPath%>/doc_abstract_do.jsp">
                    </object></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td height="20" colspan=3 align=center bgcolor="#FFFFFF">
&nbsp;
&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input name="Submit" type="button" class="singleboarder" value=" 提 交 " onClick="return SubmitWithFile()">      &nbsp;&nbsp;&nbsp;
      <input name="Submit" type="button" class="singleboarder" value=" 提 交(不上传文件) " onClick="return SubmitWithoutFile()">      &nbsp;&nbsp;&nbsp;&nbsp;
      <input name="cmdcancel" type="button" class="singleboarder" onClick="ClearAll()" value=" 清 空 ">
      &nbsp;（摘要不支持附件上传）</td>
            </tr>
          </table>
    </form>
	<br></TD>
  </TR>
</TABLE>
</body>

</html>