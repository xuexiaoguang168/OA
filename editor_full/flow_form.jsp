<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.ParamUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>智能表单设计器</title>
<link rel="STYLESHEET" type="text/css" href="edit.css">
<%
String op = ParamUtil.get(request, "op");
%>
<script>
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
<%@ include file="editor.jsp"%>             
<Script src="flow_form_js.jsp"></Script>
<input type="hidden" id="edit" name="edit" value="" />
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
</html>

