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