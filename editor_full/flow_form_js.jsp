<%@ page contentType="text/html;charset=utf-8"%>
<%
String jsRootPath = request.getContextPath();
%>

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

function showProperty() {
	cws_selectRange();
	if (cws_selection.type == "Control") {
		var oControlRange = cws_selection.createRange();
		var obj = oControlRange.item(0);
		var tagName = obj.tagName;
		// alert(tagName + " name=" + obj.name + " value=" + obj.value + " title=" + obj.title + " kind=" + obj.kind);
		var params = makeParams('edit', obj);
		var kind = obj.kind;
		if (tagName=="INPUT") {
			if (obj.type=="checkbox") {
				showModalDialog('images/flow_checkbox_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
				return;
			}

			if (kind=="DATE")
				showModalDialog('images/flow_calendar_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
			else if (kind=="DATE_TIME")
				showModalDialog('images/flow_calendar_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
			else if (kind=="macro")
				showModalDialog('images/flow_macro_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
			else {
				// 控件没有标题时的情况：日期控件的Time部分
				if (obj.title=="undefined" || obj.title=="")
					;
				else
					showModalDialog('images/flow_text_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
			}
		}
		else if (tagName=="TEXTAREA") {
			showModalDialog('images/flow_text_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
		}
		else if (tagName=="SELECT") { // 单选或多选
			showModalDialog('images/flow_select_prop.htm', params, 'dialogWidth:360px;dialogHeight:380px;status:no;help:no;')
		}
	}
}

/* // 遍历被选中的控件
function traverse() {
  if (cws_selection.type == "Control") {
    var oControlRange = cws_selection.createRange();
    for (i = 0; i < oControlRange.length; i++) {
		var obj = oControlRange.item(i);
		var tagName = obj.tagName;
      	//if (oControlRange.item(i).tagName != "IMG")
      	//  oControlRange.item(i).style.color = event.srcElement.style.backgroundColor;
	  	alert(tagName + " name=" + obj.name + " value=" + obj.value + " title=" + obj.title + " kind=" + obj.kind);
	}
  }
}
*/

function insert(content)
{
	cws_InsertSymbol(content);
}

// mode "create" or "edit" 当为create时，obj为fieldType，当为edit时，obj为正在编辑的控件
function makeParams(mode, obj) {
	return new Array(window.self, mode, obj);
}

function cloud_textfield() {
	var params = makeParams('create', 'text');
	showModalDialog('images/flow_text_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
}

function cloud_macro() {
	var params = makeParams('create', 'macro');
	showModalDialog('images/flow_macro_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
}

function cloud_textarea() {
	var params = makeParams('create', 'textarea');
	showModalDialog('images/flow_text_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
}

function cloud_checkbox() {
	var params = makeParams('create', 'checkbox');
	showModalDialog('images/flow_checkbox_prop.htm', params, 'dialogWidth:320px;dialogHeight:170px;status:no;help:no;')
}

function cloud_calendar() {
	var params = makeParams('create', 'calendar');
	showModalDialog('images/flow_calendar_prop.htm', params, 'dialogWidth:320px;dialogHeight:180px;status:no;help:no;')
}

function cloud_select() {
	var params = makeParams('create', 'select');
	showModalDialog('images/flow_select_prop.htm', params, 'dialogWidth:360px;dialogHeight:380px;status:no;help:no;')
}

function cloud_list() {
	var params = makeParams('create', 'list');
	showModalDialog('images/flow_select_prop.htm', params, 'dialogWidth:360px;dialogHeight:380px;status:no;help:no;')
}

function CreateTxtCtl(ctlType, ctlName, ctlTitle, ctlDefaultValue) {
	var content = "";
	// if (ctlDefaultValue=="") // 使value为空的时候不致于被格式化掉
	//	ctlDefaultValue = "default";
	if (ctlType=="text")
		content = '<input title="' + ctlTitle + '" value="' + ctlDefaultValue + '" name="' + ctlName + '" type=text>';
	else if (ctlType=="textarea") {
		content = '<textarea title="' + ctlTitle + '" name="' + ctlName + '">' + ctlDefaultValue + '</textarea>';
	}
	insert(content);
}

function CreateCheckboxCtl(ctlType, ctlName, ctlTitle, ctlDefaultValue) {
	var content = "";
	content = '<input title="' + ctlTitle + '" type=checkbox ' + ctlDefaultValue + ' value="1" name="' + ctlName + '">';
	insert(content);
}

function CreateCalendarCtl(ctlType, ctlName, ctlTitle, ctlDefaultValue, ctlFormat) {
	var content = "";
	if (ctlFormat=="yyyy-MM-dd") {
		content += "<input readonly title='" + ctlTitle + "' value='" + ctlDefaultValue + "' name='" + ctlName + "' kind=DATE><img name='" + ctlName + "_btnImg' src='<%=jsRootPath%>/images/form/calendar.gif' width='26' height='26' align='absmiddle' style='cursor:hand' onClick='SelectDate(\"" + ctlName + "\",\"yyyy-mm-dd\")'>";
	}else{
		content += "<input readonly title='" + ctlTitle + "' value='" + ctlDefaultValue + "' name='" + ctlName + "' kind=DATE_TIME><img name='" + ctlName + "_btnImg' src='<%=jsRootPath%>/images/form/calendar.gif' width='26' height='26' align='absmiddle' style='cursor:hand' onClick='SelectDate(\"" + ctlName + "\",\"yyyy-mm-dd\")'><input readonly name='" + ctlName + "_time' style='width:50px' value='12:30:30'/>&nbsp;<img name='" + ctlName + "_time_btnImg' src='<%=jsRootPath%>/images/form/clock.gif' align='absmiddle' style='cursor:hand' onClick='SelectDateTime(\"" + ctlName + "\")'>";
	}
	insert(content);
}

function CreateMacroCtl(ctlType, ctlName, ctlTitle, macroDefaultValue, macroType, macroName) {
	// if (macroDefaultValue=="");
	//	macroDefaultValue = "";
	var content = "";
	content += "<input title='" + ctlTitle + "' value='" + macroName + "' name='" + ctlName + "' macroDefaultValue='" + macroDefaultValue + "' macroType=" + macroType + " kind=macro>";
	insert(content);
}

function CreateSelectCtl(ctlType, ctlName, ctlTitle, opts) {
	var content = "";
	if (ctlType=="select") {
		content = '<select title="' + ctlTitle + '" name="' + ctlName + '">' + opts + '</select>';
	}
	else {
		content = '<select title="' + ctlTitle + '" name="' + ctlName + '" size=5 style="width: 60px">' + opts + '</select>';
	}
	insert(content);
}

