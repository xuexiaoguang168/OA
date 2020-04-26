function setSpeedCount(speedCount) {
	addform.speedCount.value = speedCount;
}﻿

function setPptPath(pptPath) {
	addform.pptPath.value = pptPath;
}

function setUseCard(useCard) {
	var obj = document.all.item("isUseCard");	
	if (useCard=="true")
		obj.checked = true;
	else
		obj.checked = false;
}

function setParagraph() {
	var oEditor=eval("idContent"+"oEdit1");
	var oRng=oEditor.document.selection.createRange();

	var isFocus = oEdit1.checkFocus();
	if (!isFocus)
		return;
		
	oRng.text = "[p]" + oRng.htmlText + "[/p]";
}

function setSentence() {
	var oEditor=eval("idContent"+"oEdit1");
	var oRng=oEditor.document.selection.createRange();

	var isFocus = oEdit1.checkFocus();
	if (!isFocus)
		return;
		
	oRng.text = "[s]" + oRng.htmlText + "[/s]";
}