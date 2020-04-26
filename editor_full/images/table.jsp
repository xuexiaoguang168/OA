<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META http-equiv=Expires content=0><LINK href="table_files/pop.css" 
type=text/css rel=stylesheet>
<SCRIPT language=JavaScript>
var sAction = "INSERT";
var sTitle = "<lt:Label res="res.label.editor_full.table" key="insert"/>";
var oControl;
var oSeletion;
var sRangeType;
var sRow = "1";
var sCol = "1";
var sAlign = "";
var sBorder = "1";
var sCellPadding = "3";
var sCellSpacing = "2";
var sWidth = "";
var sBorderColor = "#CCCCCC";
var sBgColor = "#FFFFFF";
var sWidthUnit = "%"
var bCheck = true;
var bWidthDisable = false;
var sWidthValue = "100"

oSelection = dialogArguments.cws_Composition.document.selection.createRange();
sRangeType = dialogArguments.cws_Composition.document.selection.type;
if (sRangeType == "Control") {
	if (oSelection.item(0).tagName == "TABLE"){
		sAction = "MODI";
		sTitle = "<lt:Label res="res.label.editor_full.table" key="modify"/>";
		oControl = oSelection.item(0);
		sRow = oControl.rows.length;
		sCol = getColCount(oControl);
		sAlign = oControl.align;
		sBorder = oControl.border;
		sCellPadding = oControl.cellPadding;
		sCellSpacing = oControl.cellSpacing;
		sWidth = oControl.width;
		sBorderColor = oControl.borderColor;
		sBgColor = oControl.bgColor;
	}
}
document.write("<TITLE><lt:Label res="res.label.editor_full.table" key="page_title"/>[" + sTitle + "]</TITLE>");
// 初始值
function InitDocument(){
	SearchSelectValue(d_align, sAlign.toLowerCase());

	// 修改状态时取值
	if (sAction == "MODI"){
		if (sWidth == ""){
			bCheck = false;
			bWidthDisable = true;
			sWidthValue = "100";
			sWidthUnit = "%";
		}else{
			bCheck = true;
			bWidthDisable = false;
			if (sWidth.substr(sWidth.length-1) == "%"){
				sWidthValue = sWidth.substring(0, sWidth.length-1);
				sWidthUnit = "%";
			}else{
				sWidthUnit = "";
				sWidthValue = parseInt(sWidth);
				if (isNaN(sWidthValue)) sWidthValue = "";
			}
		}
	}

	switch(sWidthUnit){
	case "%":
		d_widthunit.selectedIndex = 1;
		break;
	default:
		sWidthUnit = "";
		d_widthunit.selectedIndex = 0;
		break;
	}

	d_row.value = sRow;
	d_col.value = sCol;
	d_border.value = sBorder;
	d_cellspacing.value = sCellSpacing;
	d_cellpadding.value = sCellPadding;
	d_widthvalue.value = sWidthValue;
	d_widthvalue.disabled = bWidthDisable;
	d_widthunit.disabled = bWidthDisable;
	d_bordercolor.value = sBorderColor;
	s_bordercolor.style.backgroundColor = sBorderColor;
	d_bgcolor.value = sBgColor;
	s_bgcolor.style.backgroundColor = sBgColor;
	d_check.checked = bCheck;


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

// 选颜色
function SelectColor(what){
	var dEL = document.all("d_"+what);
	var sEL = document.all("s_"+what);
	//var url = "selcolor.htm?color="+encodeURIComponent(dEL.value);
	//var arr = showModalDialog(url,window,"dialogWidth:280px;dialogHeight:250px;help:no;scroll:no;status:no");
	var arr = showModalDialog("selcolor.html", "", "dialogWidth:18.5em; dialogHeight:17.5em; status:0; help:0");
	if (arr) {
		dEL.value=arr;
		sEL.style.backgroundColor=arr;
	}
}
// 是否有效颜色值
function IsColor(color){
	var temp=color;
	if (temp=="") return true;
	if (temp.length!=7) return false;
	return (temp.search(/\#[a-fA-F0-9]{6}/) != -1);
}
// 只允许输入数字
function IsDigit(){
  return ((event.keyCode >= 48) && (event.keyCode <= 57));
}
// 判断值是否大于0
function MoreThanOne(obj, sErr){
	var b=false;
	if (obj.value!=""){
		obj.value=parseFloat(obj.value);
		if (obj.value!="0"){
			b=true;
		}
	}
	if (b==false){
		BaseAlert(obj,sErr);
		return false;
	}
	return true;
}

// 得到表格列数
function getColCount(oTable) {
	var intCount = 0;
	if (oTable != null) {
		for(var i = 0; i < oTable.rows.length; i++){
			if (oTable.rows[i].cells.length > intCount) intCount = oTable.rows[i].cells.length;
		}
	}
	return intCount;
}

// 增加行
function InsertRows( oTable ) {
	if ( oTable ) {
		var elRow=oTable.insertRow();
		for(var i=0; i<oTable.rows[0].cells.length; i++){
			var elCell = elRow.insertCell();
			elCell.innerHTML = "&nbsp;";
		}
	}
}

// 增加列
function InsertCols( oTable ) {
	if ( oTable ) {
		for(var i=0; i<oTable.rows.length; i++){
			var elCell = oTable.rows[i].insertCell();
			elCell.innerHTML = "&nbsp;"
		}
	}
}

// 删除行
function DeleteRows( oTable ) {
	if ( oTable ) {
		oTable.deleteRow();
	}
}

// 删除列
function DeleteCols( oTable ) {
	if ( oTable ) {
		for(var i=0;i<oTable.rows.length;i++){
			oTable.rows[i].deleteCell();
		}
	}
}

</SCRIPT>

<SCRIPT language=JavaScript event=onclick for=Ok>
	// 边框颜色的有效性
	sBorderColor = d_bordercolor.value;
	if (!IsColor(sBorderColor)){
		BaseAlert(d_bordercolor,'<lt:Label res="res.label.editor_full.table" key="invalid_border_color"/>');
		return;
	}
	// 背景颜色的有效性
	sBgColor = d_bgcolor.value;
	if (!IsColor(sBgColor)){
		BaseAlert(d_bgcolor,'<lt:Label res="res.label.editor_full.table" key="invalid_bg_color"/>');
		return;
	}
	// 行数的有效性
	if (!MoreThanOne(d_row,'<lt:Label res="res.label.editor_full.table" key="invalid_row_count"/>')) return;
	// 列数的有效性
	if (!MoreThanOne(d_col,'<lt:Label res="res.label.editor_full.table" key="invalid_col_count"/>')) return;
	// 边线粗细的有效性
	if (d_border.value == "") d_border.value = "0";
	if (d_cellpadding.value == "") d_cellpadding.value = "0";
	if (d_cellspacing.value == "") d_cellspacing.value = "0";
	// 去前导0
	d_border.value = parseFloat(d_border.value);
	d_cellpadding.value = parseFloat(d_cellpadding.value);
	d_cellspacing.value = parseFloat(d_cellspacing.value);
	// 宽度有效值性
	var sWidth = "";
	if (d_check.checked){
		if (!MoreThanOne(d_widthvalue,'<lt:Label res="res.label.editor_full.table" key="invalid_width"/>')) return;
		sWidth = d_widthvalue.value + d_widthunit.value;
	}

	sRow = d_row.value;
	sCol = d_col.value;
	sAlign = d_align.options[d_align.selectedIndex].value;
	sBorder = d_border.value;
	sCellPadding = d_cellpadding.value;
	sCellSpacing = d_cellspacing.value;

	if (sAction == "MODI") {
		// 修改行数
		var xCount = sRow - oControl.rows.length;
  		if (xCount > 0)
	  		for (var i = 0; i < xCount; i++) InsertRows(oControl);
  		else
	  		for (var i = 0; i > xCount; i--) DeleteRows(oControl);
		// 修改列数
  		var xCount = sCol - getColCount(oControl);
  		if (xCount > 0)
  			for (var i = 0; i < xCount; i++) InsertCols(oControl);
  		else
  			for (var i = 0; i > xCount; i--) DeleteCols(oControl);

		try {
			oControl.width = sWidth;
		}
		catch(e) {
			//alert("对不起，请您输入有效的宽度值！\n（如：90%  200  300px  10cm）");
		}

		oControl.align			= sAlign;
  		oControl.border			= sBorder;
  		oControl.cellSpacing	= sCellSpacing;
  		oControl.cellPadding	= sCellPadding;
  		oControl.borderColor	= sBorderColor;
  		oControl.bgColor		= sBgColor;

	}else{
		var sTable = "<table align='"+sAlign+"' border='"+sBorder+"' cellpadding='"+sCellPadding+"' cellspacing='"+sCellSpacing+"' width='"+sWidth+"' bordercolor='"+sBorderColor+"' bgcolor='"+sBgColor+"'>";
		for (var i=1;i<=sRow;i++){
			sTable = sTable + "<tr>";
			for (var j=1;j<=sCol;j++){
				sTable = sTable + "<td>&nbsp;</td>";
			}
		}
		sTable = sTable + "</table>";
	}
	window.returnValue = sTable;
	window.close();
</SCRIPT>

<META content="MSHTML 6.00.3790.373" name=GENERATOR></HEAD>
<BODY bgColor=menu onload=InitDocument()>
<TABLE cellSpacing=0 cellPadding=0 align=center border=0>
  <TBODY>
  <TR>
    <TD>
      <FIELDSET><LEGEND><lt:Label res="res.label.editor_full.table" key="table_size"/></LEGEND>
      <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="rows"/></TD>
          <TD width=5></TD>
          <TD><INPUT onkeypress=event.returnValue=IsDigit(); id=d_row 
            maxLength=3 size=10></TD>
          <TD width=40></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="cols"/></TD>
          <TD width=5></TD>
          <TD><INPUT onkeypress=event.returnValue=IsDigit(); id=d_col 
            maxLength=3 size=10></TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR></TBODY></TABLE></FIELDSET> </TD></TR>
  <TR>
    <TD height=5></TD></TR>
  <TR>
    <TD>
      <FIELDSET><LEGEND><lt:Label res="res.label.editor_full.table" key="range"/></LEGEND>
      <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="align"/></TD>
          <TD width=5></TD>
          <TD><SELECT id=d_align style="WIDTH: 72px"> <OPTION value="" 
              selected><lt:Label res="res.label.editor_full.table" key="default"/></OPTION> <OPTION value=left><lt:Label res="res.label.editor_full.table" key="align_left"/></OPTION> <OPTION 
              value=center><lt:Label res="res.label.editor_full.table" key="align_center"/></OPTION> <OPTION value=right><lt:Label res="res.label.editor_full.table" key="align_right"/></OPTION></SELECT> 
          </TD>
          <TD width=40></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="border"/></TD>
          <TD width=5></TD>
          <TD><INPUT onkeypress=event.returnValue=IsDigit(); id=d_border 
            size=10></TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="cell_space"/></TD>
          <TD width=5></TD>
          <TD><INPUT onkeypress=event.returnValue=IsDigit(); id=d_cellspacing 
            maxLength=3 size=10></TD>
          <TD width=40></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="cell_margin"/></TD>
          <TD width=5></TD>
          <TD><INPUT onkeypress=event.returnValue=IsDigit(); id=d_cellpadding 
            maxLength=3 size=10></TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR></TBODY></TABLE></FIELDSET> </TD></TR>
  <TR>
    <TD height=5></TD></TR>
  <TR>
    <TD>
      <FIELDSET><LEGEND><lt:Label res="res.label.editor_full.table" key="width"/></LEGEND>
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD onclick=d_check.click() vAlign=center noWrap><INPUT id=d_check 
            onclick=d_widthvalue.disabled=(!this.checked);d_widthunit.disabled=(!this.checked); 
            type=checkbox value=1> <lt:Label res="res.label.editor_full.table" key="assign_width"/></TD>
          <TD align=right width="60%"><INPUT 
            onkeypress=event.returnValue=IsDigit(); maxLength=4 size=5 
            name=d_widthvalue> <SELECT name=d_widthunit> <OPTION value=px 
              selected><lt:Label res="res.label.editor_full.table" key="pixel"/></OPTION><OPTION value=%><lt:Label res="res.label.editor_full.table" key="percent"/></OPTION></SELECT> </TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR></TBODY></TABLE></FIELDSET> </TD></TR>
  <TR>
    <TD height=5></TD></TR>
  <TR>
    <TD>
      <FIELDSET><LEGEND><lt:Label res="res.label.editor_full.table" key="table_color"/></LEGEND>
      <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD colSpan=9 height=5></TD></TR>
        <TR>
          <TD width=7></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="border_color"/></TD>
          <TD width=5></TD>
          <TD><INPUT id=d_bordercolor size=7></TD>
          <TD><IMG id=s_bordercolor style="CURSOR: hand" 
            onclick="SelectColor('bordercolor')" src="table_files/rect.gif" 
            width=18 border=0></TD>
          <TD width=40></TD>
          <TD><lt:Label res="res.label.editor_full.table" key="bg_color"/></TD>
          <TD width=5></TD>
          <TD><INPUT id=d_bgcolor size=7></TD>
          <TD><IMG id=s_bgcolor style="CURSOR: hand" 
            onclick="SelectColor('bgcolor')" src="table_files/rect.gif" width=18 
            border=0></TD>
          <TD width=7></TD></TR>
        <TR>
          <TD colSpan=9 height=5></TD></TR></TBODY></TABLE></FIELDSET> </TD></TR>
  <TR>
    <TD height=5></TD></TR>
  <TR>
    <TD align=right><BUTTON id=Ok type=submit><lt:Label res="res.common" key="ok"/></BUTTON>&nbsp;&nbsp;<BUTTON 
      onclick=window.close();><lt:Label res="res.common" key="close"/></BUTTON> </TD></TR></TBODY></TABLE></BODY></HTML>
