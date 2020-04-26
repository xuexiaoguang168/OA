<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<HTML>
<HEAD>
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<Link rel="stylesheet" type="text/css" href="edit.css">
</style>
<Script Language=JavaScript>
var URLParams = new Object() ;
var aParams = document.location.search.substr(1).split('&') ;
for (i=0 ; i < aParams.length ; i++) {
	var aParam = aParams[i].split('=') ;
	URLParams[aParam[0]] = aParam[1] ;
}
var sAction = URLParams['action'];
var sTitle = "<lt:Label res="res.label.editor.link" key="insert"/>";

var objWindow;

var oRange;
var sType;
var oSel;

var sUrl = "http://";
var sProtocol = "http://";
var sTarget = "";

switch (sAction){
case "other":
	sUrl = dialogArguments.objLink.Href;
	sTarget = dialogArguments.objLink.Target;
	sProtocol = getProtocol(sUrl);
	objWindow = dialogArguments.opener;
	break;
default:
	oRange = dialogArguments.IframeID.document.selection.createRange();
	sType = dialogArguments.IframeID.document.selection.type;

	if (sType == "Control") {
		oSel = oRange(0).parentNode;
	}else{
		oSel = oRange.parentElement();
	}

	if (oSel.tagName.toUpperCase() == "A"){
		sTarget = oSel.target;
		sUrl = oSel.getAttribute("href",2);
		sProtocol = getProtocol(sUrl);
	}
	objWindow = dialogArguments;
	break;
}

// 从地址取协议
function getProtocol(url){
	var re=/(.+:\/*)(.*)/gi;
	return url.replace(re,"$1");
}

// 改变协议
function changeProtocol(index){
	sProtocol=d_protocol.options[index].value;
	sUrl = d_url.value;
	var re = /(.+:\/*)/gi;
	sUrl = sUrl.replace(re, "");
	d_url.value = sProtocol + sUrl;
}


// 初始值
function InitDocument(){
	SearchSelectValue(d_protocol, sProtocol.toLowerCase());
	SearchSelectValue(d_target, sTarget.toLowerCase());
	getAnchors();
	d_url.value = sUrl;
}

// 取所有的锚
function getAnchors() {
	d_anchor.options.length = 1;
	var allLinks = objWindow.IframeID.document.body.getElementsByTagName("A");
	for (i=0; i < allLinks.length; i++) {
		if (allLinks[i].href.toUpperCase() == "") {
			d_anchor.options[d_anchor.options.length] = new Option(allLinks[i].name,"#"+allLinks[i].name);
		}
	}
}

// 搜索下拉框值与指定值匹配，并选择匹配项
function SearchSelectValue(o_Select, s_Value){
	for (var i=0;i<o_Select.length;i++){
		if (o_Select.options[i].value == s_Value){
			o_Select.selectedIndex = i;
			return true;
		}
	}
	return false;
}
</Script>



<title><lt:Label res="res.label.editor.link" key="link_prop"/></title>

<SCRIPT event=onclick for=Ok language=JavaScript>
	sUrl = d_url.value;
	sProtocol = d_protocol.options[d_protocol.selectedIndex].value;
	sTarget = d_target.options[d_target.selectedIndex].value;

	if (sUrl != ""){
		switch (sAction){
		case "other":
			var arr = new Array();
			arr[0] = sUrl;
			arr[1] = sTarget;
			window.returnValue = arr;
			break;
		default:
			oRange.execCommand("CreateLink",false,sUrl);

			oRange = dialogArguments.IframeID.document.selection.createRange();
			sType = dialogArguments.IframeID.document.selection.type;

			if (sType == "Control") {
				oSel = oRange(0).parentNode;
			}else{
				oSel = oRange.parentElement();
			}

			if (sTarget != ""){
				oSel.target = sTarget;
			}else{
				oSel.removeAttribute("target");
			}
			window.returnValue = null;
			break;
		}
	} else {
		alert("<lt:Label res="res.label.editor.link" key="url_none"/>");
		d_url.focus();
		return;
	}
	window.close();
</SCRIPT>

</HEAD>

<body bgcolor=menu onLoad="InitDocument()">
<br>
<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr>
	<td>
	<fieldset>
	<legend><lt:Label res="res.label.editor.link" key="link_info"/></legend>
	<table border=0 cellpadding=0 cellspacing=0>
	<tr><td colspan=9 height=5></td></tr>
	<tr>
		<td width=7></td>
		<td noWrap><lt:Label res="res.label.editor.link" key="link_type"/></td>
		<td width=5></td>
		<td><select id=d_protocol style="width:72px" onChange="changeProtocol(this.selectedIndex)">
				<option value=''>其它</option>
				<option value='file://'>file:</option>
				<option value='ftp://'>ftp:</option>
				<option value='gopher://'>gopher:</option>
				<option value='http://'>http:</option>
				<option value='https://'>https:</option>
				<option value='mailto:'>mailto:</option>
				<option value='news:'>news:</option>
				<option value='telnet:'>telnet:</option>
				<option value='wais:'>wais:</option>
				</select></td>
		<td width=40></td>
		<td noWrap><lt:Label res="res.label.editor.link" key="target"/></td>
		<td width=5></td>
		<td><select id=d_target style="width:72px"><option value=''><lt:Label res="res.label.editor.link" key="default"/></option><option value='_self'><lt:Label res="res.label.editor.link" key="self"/></option><option value='_top'><lt:Label res="res.label.editor.link" key="top"/></option><option value='_blank'><lt:Label res="res.label.editor.link" key="blank"/></option><option value='_parent'><lt:Label res="res.label.editor.link" key="parent"/></option></select></td>
		<td width=7></td>
	</tr>
	<tr><td colspan=9 height=5></td></tr>
	<tr>
		<td width=7></td>
		<td><lt:Label res="res.label.editor.link" key="url"/></td>
		<td width=5></td>
		<td colspan=5><input type=text id=d_url size=38 value="" style="width:243px"></td>
		<td width=7></td>
	</tr>
	<tr><td colspan=9 height=5></td></tr>
	<tr>
		<td width=7></td>
		<td><lt:Label res="res.label.editor.link" key="anchor"/></td>
		<td width=5></td>
		<td colspan=5><select id=d_anchor onChange="d_url.value=this.options[this.selectedIndex].value"><option value=''><lt:Label res="res.label.editor.link" key="default"/></option></select></td>
		<td width=7></td>
	</tr>
	<tr><td colspan=9 height=5></td></tr>
	</table>
	</fieldset>
	</td>
</tr>
<tr><td height=5></td></tr>
<tr><td align=right><input type=submit value='<lt:Label res="res.common" key="ok"/>' id=Ok>
      &nbsp;&nbsp;
      <input type=button value='<lt:Label res="res.common" key="cancel"/>' onClick="window.close();"></td></tr>
</table>

</BODY>
</HTML>
