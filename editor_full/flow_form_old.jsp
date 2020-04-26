<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="cn.js.fan.util.ParamUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>智能表单设计器</title>
<link rel="STYLESHEET" type="text/css" href="edit.css">
<%
String editorRootPath = request.getContextPath();
String op = ParamUtil.get(request, "op");
%>
<script>
var editorRootPath = "<%=editorRootPath%>";
var op = "<%=op%>";

function getContent() {
	return window.opener.getFormContent();
}

function saveexit() {
	var html;
	html = cws_getText();
	html = cws_rCode(html,"<a>　</a>","");
	// alert(html);
 	window.opener.setFormContent(html);
	window.opener.focus();
	
	window.close();
}

function window_onload() {
	if (op=="edit") {
		setHTML(getContent());
	}
	cws_Size(360);
}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body onLoad="window_onload()"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#DEDFDE">
  <tr>
    <td width="81%" valign="top">
<Script src="DhtmlEdit.js"></Script>
<Script src="editor.js"></Script>
<Script src="flow_form_js.jsp"></Script>

<input type="hidden" id="edit" name="edit" value="" />
<div id="cws_edit">
	<ul id="ExtToolbar0">
	<li >
	<select id="cws_formatSelect"  onchange="cws_doSelectClick('FormatBlock',this)">
	<option>段落格式</option>
	<option value="&lt;P&gt;">普通格式 
	<option value="&lt;H1&gt;">标题 1 
	<option value="&lt;H2&gt;">标题 2 
	<option value="&lt;H3&gt;">标题 3 
	<option value="&lt;H4&gt;">标题 4 
	<option value="&lt;H5&gt;">标题 5 
	<option value="&lt;H6&gt;">标题 6 
	<option value="&lt;H7&gt;">标题 7 
	<option value="&lt;PRE&gt;">已编排格式 
	<option value="&lt;ADDRESS&gt;">地址 
	</select>
	<select language="javascript" class="cws_TBGen" id="FontName" onChange="FormatText ('fontname',this[this.selectedIndex].value);">
	<option class="heading" selected>字体 
	<option value="宋体">宋体 
	<option value="黑体">黑体 
	<option value="楷体_GB2312">楷体 
	<option value="仿宋_GB2312">仿宋 
	<option value="隶书">隶书 
	<option value="幼圆">幼圆 
	<option value="新宋体">新宋体 
	<option value="细明体">细明体 
	<option value="Arial">Arial 
	<option value="Arial Black">Arial Black 
	<option value="Arial Narrow">Arial Narrow 
	<option value="Bradley Hand ITC">Bradley Hand ITC 
	<option value="Brush Script	MT">Brush Script MT 
	<option value="Century Gothic">Century Gothic 
	<option value="Comic Sans MS">Comic Sans MS 
	<option value="Courier">Courier 
	<option value="Courier New">Courier New 
	<option value="MS Sans Serif">MS Sans Serif 
	<option value="Script">Script 
	<option value="System">System 
	<option value="Times New Roman">Times New Roman 
	<option value="Viner Hand ITC">Viner Hand ITC 
	<option value="Verdana">Verdana 
	<option value="Wide Latin">Wide Latin 
	<option value="Wingdings">Wingdings</option>
	</select>
	<select language="javascript" class="cws_TBGen" id="FontSize" onChange="FormatText('fontsize',this[this.selectedIndex].value);">                                   
	<option class="heading" selected>字号 
	<option value="1">1 
	<option value="2">2 
	<option value="3">3 
	<option value="4">4 
	<option value="5">5 
	<option value="6">6 
	<option value="7">7</option>
	</select>
	</li>
	<li class="cws_Btn" title="字体颜色" language="javascript" onClick="cws_foreColor();" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/fgcolor.gif" />	</li>
	<li class="cws_Btn" title="字体背景颜色" language="javascript" onClick="cws_backColor();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';> 
	<img class="cws_Ico" src="images/fbcolor.gif" />	</li>
	<li class="cws_Btn" title="插入特殊符号" language="javascript" onClick="insertSpecialChar();" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';> 
	<img class="cws_Ico" src="images/specialchar.gif" /></li>
	<li class="cws_Btn" title="替换" language="javascript" onClick="cws_replace();" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';><img class="cws_Ico" src="images/replace.gif" /></li>
	<li class="cws_Btn" title="清理代码" language="javascript" onClick="cws_CleanCode();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';> 
	<img class="cws_Ico" src="images/cleancode.gif" /></li>
	<li> 
	<select ID="Zoom" class="cws_TBGen" onChange="doZoom(this)" >
	<option value="100">100% 
	<option value="50">50% 
	<option value="75">75% 
	<option value="100">100% 
	<option value="125">125% 
	<option value="150">150% 
	<option value="175">175% 
	<option value="200">200%</option>
	</select>
	</li>
     <li class="cws_Btn" title="帮助" language="javascript" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';> <a href="#"><img src="images/help.gif" class="cws_Ico" border="0"></a>	</li>        
	</ul>
	<ul id="ExtToolbar1"> 
	<li class="cws_Btn" title="全选" language="javascript" onClick="FormatText('selectAll');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn' > 
	<img class="cws_Ico" src="images/selectAll.gif" />	</li>
	<li class="cws_Btn" title="剪切" language="javascript" onClick="FormatText('cut');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/cut.gif" />	</li>
	<li class="cws_Btn" title="复制" language="javascript" onClick="FormatText('copy');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/copy.gif" />	</li>
	<li class="cws_Btn" title="粘贴" language="javascript" onClick="FormatText('paste');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/paste.gif" />	</li>
	<li class="cws_Btn" title="撤消" language="javascript" onClick="FormatText('undo');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/undo.gif" />	</li>
	<li class="cws_Btn" title="恢复" language="javascript" onClick="FormatText('redo');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/redo.gif" />	</li>
	<li class="cws_Btn" title="插入超级链接" language="javascript" onClick="cws_forlink();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/wlink.gif" >	</li>
	<li class="cws_Btn" title="去掉超级链接" language="javascript" onClick="FormatText('Unlink');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/unlink.gif" />	</li>
	<li class="cws_Btn" title="插入图片" language="javascript" onClick="cws_forimg();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/img.gif" />	</li>
	<li class="cws_Btn" title="插入水平线" language="javascript" onClick="FormatText('InsertHorizontalRule', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/hr.gif" />	</li>
	<li class="cws_Btn" title="插入表格" language="javascript" onClick="cws_fortable();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/table.gif" />	</li>
	<li class="cws_Btn" title="插入行" language="javascript" onClick="cws_InsertRow();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/insertrow.gif" />	</li>
	<li class="cws_Btn" title="删除行" language="javascript" onClick="cws_DeleteRow();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/deleterow.gif" />	</li>
	<li class="cws_Btn" title="插入列" language="javascript" onClick="cws_InsertColumn();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/insertcolumn.gif" />	</li>
	<li class="cws_Btn" title="删除列" language="javascript" onClick="cws_DeleteColumn();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/deletecolumn.gif" />	</li>
	<li class="cws_Btn" title="插入Flash" language="javascript" onClick="cws_forswf();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/swf.gif" />	</li>
	<li class="cws_Btn" title="插入Windows Media" language="javascript" onClick="cws_forwmv();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/wmv.gif" />	</li>
	<li class="cws_Btn" title="插入Real Media" language="javascript" onClick="cws_forrm();ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/rm.gif" />	</li>
	</ul>
	<ul id="ExtToolbar2"> 
	<li class="cws_Btn" title="加粗" language="javascript" onClick="FormatText('bold', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/bold.gif" />	</li>
	<li class="cws_Btn" title="斜体" language="javascript" onClick="FormatText('italic', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/italic.gif" />	</li>
	<li class="cws_Btn" title="下划线" language="javascript" onClick="FormatText('underline', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/underline.gif" />	</li>
	<li class="cws_Btn" title="上标" language="javascript" onClick="FormatText('superscript', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/superscript.gif" />	</li>
	<li class="cws_Btn" title="下标" language="javascript" onClick="FormatText('subscript', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/subscript.gif" />	</li>
	<li class="cws_Btn" title="删除线" language="javascript" onClick="FormatText('strikethrough', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/strikethrough.gif" />	</li>
	<li class="cws_Btn" title="取消格式" language="javascript" onClick="FormatText('RemoveFormat', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/removeformat.gif" />	</li>
	<li class="cws_Btn" title="左对齐" NAME="Justify" language="javascript" onClick="FormatText('justifyleft', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/aleft.gif" />	</li>
	<li class="cws_Btn" title="居中" NAME="Justify" language="javascript" onClick="FormatText('justifycenter', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/center.gif" />	</li>
	<li class="cws_Btn" title="右对齐" NAME="Justify" language="javascript" onClick="FormatText('justifyright', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/aright.gif" />	</li>
	<li class="cws_Btn" title="编号" language="javascript" onClick="FormatText('insertorderedlist', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/numlist.gif" />	</li>
	<li class="cws_Btn" title="项目符号" language="javascript" onClick="FormatText('insertunorderedlist', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/bullist.gif" />	</li>
	<li class="cws_Btn" title="减少缩进量" language="javascript" onClick="FormatText('outdent', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/outdent.gif" />	</li>
	<li class="cws_Btn" title="增加缩进量" language="javascript" onClick="FormatText('indent', '');ondrag='return false;'" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/indent.gif" />	</li>
	<li class="cws_Btn" title="插入表情" language="javascript" onClick="cws_foremot()" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn'; > 
	<img class="cws_Ico" src="images/smiley.gif" / >	</li>
	<!--
	<li class="cws_Btn" title="上传文件" language="javascript" onclick="cws_forfile()" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';>
	<img class="cws_Ico" src="images/file.gif" />
	</li>
	-->
	<li class="cws_Btn" title="插入代码" language="javascript" onClick="cws_code()" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';>
	<img class="cws_Ico" src="images/code.gif" />	</li>
	<li class="cws_Btn" title="插入引用" language="javascript" onClick="cws_quote()" onmouseover=this.className='cws_BtnMouseOverUp'; onmouseout=this.className='cws_Btn';>
	<img class="cws_Ico" src="images/quote.gif" />	</li>
	</ul>
	<ul style="height:100%" id="PostiFrame">
	  <iframe class="cws_Composition" id="cws_Composition" marginheight="5" marginwidth="5" width="100%" height="100%"></iframe>
	</ul>
	<ul>
	<li style="width:10px"></li>
	<li class="cws_TabOn" id="cws_TabDesign" onClick="if (cws_bTextMode!=1) {cws_setMode(1);}"> 
	<img src="images/mode.design.gif" ALIGN="absmiddle" width="20" height="20">&nbsp;设计</li>
	<li style="width:10px"></li>
	<li class="cws_TabOff" id="cws_TabView" onClick="cws_View();" > 
	<img unselectable="on" src="images/mode.view.gif" ALIGN="absmiddle" width="20" height="20" />&nbsp;预览	</li>
	<li style="width:10px"></li>
	<li class="cws_TabOff" id="cws_TabHtml" onClick="if (cws_bTextMode!=2) {cws_setMode(2);}" style="cursor: pointer;"><img unselectable="on" src="images/mode.html.gif" ALIGN="absmiddle" width=21 height=20 />&nbsp;源码</li>
	<li style="width:300;text-align:right;">
	<a href="javascript:cws_Size(360)"></a> 
	<a href="javascript:cws_Size(420)"></a></li>
	<li style="width:10px"></li>
	</ul>
</div>
</ul>
		
	　　</td>
    <td width="19%" valign="top">
	
      <table class="small" cellSpacing="1" cellPadding="3" width="120" align="center" border="0">
  <tbody>
    <tr class="TableHeader">
      <td align="middle">表单控件</td>
    </tr>
    <tr class="TableHeader">
      <td align="middle"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: left" 
onclick=cloud_textfield()>
        <img src="../images/form/textfield.gif" align="absMiddle" width="26" height="26">单行输入框</BUTTON>      </td>
    </tr>
    <tr class="TableHeader">
      <td align="middle"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: left" 
onclick=cloud_textarea()>
        <img src="../images/form/textarea.gif" align="absMiddle" width="26" height="26">多行输入框</BUTTON>      </td>
    </tr>
    <tr class="TableHeader">
      <td align="middle"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: left" 
onclick=cloud_select()>
        <img src="../images/form/listmenu.gif" align="absMiddle" width="26" height="26">下拉菜单</BUTTON>      </td>
    </tr>
    <tr class="TableHeader">
      <td align="middle"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: left" 
onclick=cloud_checkbox()>
        <img src="../images/form/checkbox.gif" align="absMiddle" width="26" height="26">选择框</BUTTON>      </td>
    </tr>
    <tr class="TableHeader">
      <td align="middle"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: left" 
onclick=cloud_list()>
        <img src="../images/form/listview.gif" align="absMiddle" width="26" height="26">列表控件</BUTTON>      </td>
    </tr>
    <tr class="TableHeader">
      <td align="middle"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: left" 
onclick=cloud_macro()>
        <img src="../images/form/auto.gif" align="absMiddle" width="26" height="26">宏控件</BUTTON>      </td>
    </tr>
    <tr class="TableHeader">
      <td align="middle"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: left" 
onclick=cloud_calendar()>
        <img src="../images/form/calendar.gif" align="absMiddle" width="26" height="26">日历控件</BUTTON>      </td>
    </tr>
  </tbody>
</table>
<br>
<table class="small" cellSpacing="1" cellPadding="3" width="120" align="center" border="0">
  <tbody>
    <tr class="TableHeader">
      <td align="center"><BUTTON style="WIDTH: 120px; TEXT-ALIGN: center; height: 30px" 
onclick="showProperty()"> <strong>控件属性</strong></BUTTON></td>
    </tr>
    <form name="form1" action="../general/system/workflow/flow_form/cloud_form/submit.php" method="post">
      <tr class="TableHeader">
        <td align="middle"><BUTTON style="WIDTH: 120px; HEIGHT: 30px; TEXT-ALIGN: center" 
onclick="saveexit()">
          <b>保存并退出</b></BUTTON>        </td>
      </tr>
      <tr class="TableHeader">
        <td align="middle"><BUTTON style="WIDTH: 120px; HEIGHT: 30px; TEXT-ALIGN: center" 
onclick="window.close()">
          <b>关闭设计器</b></BUTTON>        </td>
      </tr>
      <input type="hidden" name="CONTENT"><input type="hidden" name="CLOSE_FLAG"><input type="hidden" value="3" name="FORM_ID">
    </form>
  </tbody>
</table>	
    </td>
  </tr>
</table>
  
</body>
<Script language="JavaScript">
var cws_bIsIE5=document.all;
var canusehtml='1';
var PostType=1;
if (cws_bIsIE5){
	var IframeID=frames["cws_Composition"];
}
else{
	var IframeID=document.getElementById("cws_Composition").contentWindow;
	var cws_bIsNC=true;
}

if (cws_bLoad==false)
{
	cws_InitDocument("Body","GB2312");
}

function initx(){
//IframeID.document.body.innerHTML=document.oblogform.edit.value;
}
function initt(){
//IframeID.document.body.innerHTML="<a>　</a>"+document.oblogform.edit.value;
}
if (0==1) {
	initt();
}
else{
	initx();
}

function pastestr()
{
	var tmpstr=window.clipboardData.getData("Text");
	if (tmpstr!=null)
	{
		if (IframeID.document.body.innerHTML!="") {
			if (confirm("您的编辑区有内容，是否覆盖？") == false)
			return false;
		}
	IframeID.document.body.innerHTML=window.clipboardData.getData("Text");
	}
}
</Script>
</html>

