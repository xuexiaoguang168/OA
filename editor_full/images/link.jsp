<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><lt:Label res="res.label.editor_full.link" key="page_title"/></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="link_files/pop.css" type=text/css rel=stylesheet></STYLE>
<SCRIPT language=JavaScript>
var URLParams = new Object() ;
var aParams = document.location.search.substr(1).split('&') ;
for (i=0 ; i < aParams.length ; i++) {
	var aParam = aParams[i].split('=') ;
	URLParams[aParam[0]] = aParam[1] ;
}
var sAction = URLParams['action'];
var sTitle = "<lt:Label res="res.label.editor_full.link" key="insert"/>";

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
</SCRIPT>

<SCRIPT language=JavaScript event=onclick for=Ok>
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
		alert("链接地址不能为空");
		d_url.focus();
		return;
	}
	window.close();
</SCRIPT>

<META content="MSHTML 6.00.3790.373" name=GENERATOR></HEAD>
<BODY bgColor=menu onload=InitDocument()><BR>
<TABLE cellSpacing=0 cellPadding=0 align=center border=0>
  <TBODY>
  <TR>
    <TD>
      <FIELDSET><LEGEND><lt:Label res="res.label.editor_full.link" key="link_info"/></LEGEND>
      <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD noWrap><lt:Label res="res.label.editor_full.link" key="link_type"/></TD>
          <TD width=5></TD>
          <TD><SELECT id=d_protocol style="WIDTH: 72px" 
            onchange=changeProtocol(this.selectedIndex)> <OPTION value="" 
              selected><lt:Label res="res.label.editor_full.link" key="other"/></OPTION> <OPTION value=file://>file:</OPTION> <OPTION 
              value=ftp://>ftp:</OPTION> <OPTION 
              value=gopher://>gopher:</OPTION> <OPTION 
              value=http://>http:</OPTION> <OPTION 
              value=https://>https:</OPTION> <OPTION 
              value=mailto:>mailto:</OPTION> <OPTION value=news:>news:</OPTION> 
              <OPTION value=telnet:>telnet:</OPTION> <OPTION 
              value=wais:>wais:</OPTION></SELECT></TD>
          <TD width=40></TD>
          <TD noWrap><lt:Label res="res.label.editor_full.link" key="target"/></TD>
          <TD width=5></TD>
          <TD><SELECT id=d_target style="WIDTH: 72px"><OPTION value="" 
              selected><lt:Label res="res.label.editor_full.link" key="default"/></OPTION><OPTION value=_self><lt:Label res="res.label.editor_full.link" key="self"/></OPTION><OPTION 
              value=_top><lt:Label res="res.label.editor_full.link" key="top"/></OPTION><OPTION value=_blank><lt:Label res="res.label.editor_full.link" key="blank"/></OPTION><OPTION 
              value=_parent><lt:Label res="res.label.editor_full.link" key="parent"/></OPTION></SELECT></TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD><lt:Label res="res.label.editor_full.link" key="url"/></TD>
          <TD width=5></TD>
          <TD colSpan=5><INPUT id=d_url style="WIDTH: 243px" size=38></TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD><lt:Label res="res.label.editor_full.link" key="anchor"/></TD>
          <TD width=5></TD>
          <TD colSpan=5><SELECT id=d_anchor 
            onchange=d_url.value=this.options[this.selectedIndex].value><OPTION 
              value="" selected><lt:Label res="res.label.editor_full.link" key="default"/></OPTION></SELECT></TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR></TBODY></TABLE></FIELDSET> </TD></TR>
  <TR>
    <TD height=5></TD></TR>
  <TR>
    <TD align=right><INPUT id=Ok type=submit value=<lt:Label res="res.common" key="ok"/>> &nbsp;&nbsp; <INPUT onclick=window.close(); type=button value=<lt:Label res="res.common" key="cancel"/>></TD></TR></TBODY></TABLE></BODY></HTML>
