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

function getradio(radionname) {
	var radioboxs = document.all.item(radionname);
	if (radioboxs!=null)
	{
		for (i=0; i<radioboxs.length; i++)
		{
			if (radioboxs[i].type=="radio" && radioboxs[i].checked)
			{ 
				return radioboxs[i].value;
			}
		}
		return radioboxs.value
	}
	return "";
}

function getcheckbox(checkboxname){
	var checkboxboxs = document.all.item(checkboxname);
	var CheckboxValue = '';
	if (checkboxboxs!=null)
	{
		// 如果只有一个元素
		if (checkboxboxs.length==null) {
			if (checkboxboxs.checked) {
				return checkboxboxs.value;
			}
		}
		for (i=0; i<checkboxboxs.length; i++)
		{
			if (checkboxboxs[i].type=="checkbox" && checkboxboxs[i].checked)
			{
				if (CheckboxValue==''){
					CheckboxValue += checkboxboxs[i].value;
				}
				else{
					CheckboxValue += ","+ checkboxboxs[i].value;
				}
			}
		}
		//return checkboxboxs.value
	}
	return CheckboxValue;
}

function getCtlValue(ctlObj, ctlType) {
	var ctlName = ctlObj.name;
	var value = "";
	if (ctlType=="radio")
		value = getradio(ctlName);
	else if (ctlType=="checkbox")
		value = getcheckbox(ctlName);
	else
		value = ctlObj.value;
	return value;
}

function setCtlValue(ctlName, ctlType, ctlValue) {
	try {
		var obj = findObj(ctlName);
		if (ctlType=="checkbox") {
			if (ctlValue=="1")
				obj.checked = true;
			else
				obj.checked = false;
		}
		else
			obj.value = ctlValue;
	}
	catch (e) {
	}	
}

// 禁止控件的同时，在其后插入hidden控件，以使被禁止的控件的值能够上传, ctlValue中为经过toHtml的值，ctlValueRaw中为原始值
function DisableCtl(name, ctlType, ctlValue, ctlValueRaw) {
   for(var i=0;i<flowForm.elements.length;i++) {
		var obj = flowForm.elements[i];
		// alert(obj.type);
		if (obj.name==name) {
			// var value = getCtlValue(obj, ctlType);
			// obj.insertAdjacentHTML("AfterEnd", "<input type=hidden name='" + name + "' value='" + obj.value + "'>");
			// obj.disabled = true;
			if (ctlType=="DATE" || ctlType=="DATE_TIME") {
				try {
					btnImgObj = findObj(name + "_btnImg");
					btnImgObj.outerHTML = "";
				}
				catch (e) {}
				obj.insertAdjacentHTML("AfterEnd", "<input type=hidden name='" + name + "' value='" + ctlValue + "'>");
				obj.outerHTML = ctlValue + "&nbsp;";
			}
			else if (ctlType=="checkbox") {
				var v = obj.checked;
				if (v) {
					obj.insertAdjacentHTML("AfterEnd", "<input type=hidden name='" + name + "' value='1'>");
				 	obj.outerHTML = "(是)";
				}
				else {
					obj.insertAdjacentHTML("AfterEnd", "<input type=hidden name='" + name + "' value='0'>");
					obj.outerHTML = "(否)";
				}
			}
			else {
				obj.insertAdjacentHTML("AfterEnd", "<textarea style='display:none' name='" + name + "'>" + ctlValueRaw + "</textarea>");
				obj.outerHTML = ctlValue;
			}
		}
   }	
}

// 用控件的值来替代控件，用于把表单以报表方式显示时
function ReplaceCtlWithValue(name, ctlType, ctlValue) {
   for(var i=0;i<flowForm.elements.length;i++) {
		var obj = flowForm.elements[i];
		if (obj.name==name) {
			if (ctlType=="checkbox") {
			}
			else {
				if (ctlType=="DATE_TIME") {
					// 去除时间中的时分秒域
					var timeObj = findObj(name + "_time");
					timeObj.outerHTML = "";
				}

				obj.outerHTML = ctlValue;
			}
		}
   }	
}

// 清除其它辅助图片按钮等
function ClearAccessory() {
	while (true) {
		var isFinded = false;
		var len = document.all.tags('IMG').length;
		for(var i=0; i<len; i++) { 
			try {
				var imgObj = document.all.tags('IMG')[i];
				// alert(imgObj.src);
				if (imgObj.src.indexOf("gif")!=-1 && imgObj.src.indexOf("file_flow")) {
					// imgObj.outerHTML = ""; // 会清除所有图片，当流程中表单存档时就会出现问题，目录树的图片也会被清除，另外在表单中特意上传的图片也会被清除
					// isFinded = true;
				}
				if (imgObj.src.indexOf("calendar.gif")!=-1) {
					imgObj.outerHTML = "";
					isFinded = true;
				}
			}
			catch (e) {}
		}
		if (!isFinded)
			break;
	}
}

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);

	GetDate = showModalDialog("util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:195px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}

function SelectDateTime(objName) {
	var dt = showModalDialog("util/calendar/time.htm", "" ,"dialogWidth:266px;dialogHeight:125px;status:no;help:no;");
	if (dt!=null)
		findObj(objName + "_time").value = dt;
}