var eSentenceAry, cSentenceAry;

function parseContent(contentObj, isEnglish) {
	var content = contentObj.value;
	RegExp.multiline = true;
	var eText = "";
	// To match any character including the '\n', use a pattern such as '[\s\S]. ...
	var re;
	if (isEnglish)
		re = /(\[e\])([\s\S]*)(\[\/e\])/ig; // 匹配英文部分
	else
		re = /(\[c\])([\s\S]*)(\[\/c\])/ig; // 匹配英文部分
	if (re.test(content))
		eText = RegExp.$2;
	// ? 当该字符紧跟在任何一个其他限制符 (*, +, ?, {n}, {n,}, 
	// {n,m}) 后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的 
	// 匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜 
	// 索的字符串。例如，对于字符串 "oooo"，’o+?’ 将匹配单个 
	// "o"，而 ’o+’ 将匹配所有 ’o’。 
	re = /(\[p\])([\S\s]*?)(\[\/p\])/ig; // 匹配英文部分的段落，使用非贪婪模式 ?
	var sentenceAry = new Array(); // 注意是一维数组，因为维数不确定，其各个无素为长度不一的数组
	var pIndex = 0; // 段落索引
	var sIndex = 0; // 句子索引
	var k = 0;
	while (re.test(eText)) {
		var pText = RegExp.$2;
		// alert(pText);
		var sre = /(\[s\])([\S\s]*?)(\[\/s\])/ig; // 匹配段落中的句子
		sIndex = 0;
		sentenceAry[pIndex] = new Array();
		while (sre.test(pText)) {
			// alert(RegExp.$2);
			if (isEnglish) {
				sentenceAry[pIndex][sIndex] = RegExp.$2;
				sentenceAry[pIndex][sIndex] = "<span id=en_" + k + "><img src=images/ico.gif align=absolutemiddle style='cursor:hand' onClick=\"selPlPlay(" + k + ")\">&nbsp;" + sentenceAry[pIndex][sIndex] + "</span>";
			}
			else {
				sentenceAry[pIndex][sIndex] = RegExp.$2;
				sentenceAry[pIndex][sIndex] = "<span id=cn_" + k + ">" + sentenceAry[pIndex][sIndex] + "</span>";
			}
			sIndex++;
			k++;
		}
		pIndex++;
	}
/*	
	var m = sentenceAry.length;
	for (var i=0; i<m; i++)
	{
		var n = sentenceAry[i].length;
		for (var j=0; j<n; j++)
			alert(sentenceAry[i][j]);
	}
*/	
	return sentenceAry;
}

function show(mode) {
	if (mode=="yw")
		showYuanWen();
	else if (mode=="yiw")
		showYiWen();
	else if (mode=="zydb")
		showZydb();
	else if (mode=="dldb")
		showDldb();
	else if (mode=="jzdb")
		showJzdb();
	else
		showYuanWen();
}

// 原文
function showYuanWen() {
	var str = "";
	var m = eSentenceAry.length;
	for (var i=0; i<m; i++)
	{
		str += "<p>";
		var n = eSentenceAry[i].length;
		for (var j=0; j<n; j++) {
			str += eSentenceAry[i][j];
		}
		str += "</p>"
	}
	
	contentView.innerHTML = str;
}

// 译文
function showYiWen() {
	var str = "";
	var m = cSentenceAry.length;
	for (var i=0; i<m; i++)
	{
		str += "<p>";
		var n = cSentenceAry[i].length;
		for (var j=0; j<n; j++) {
			str += cSentenceAry[i][j];
		}
		str += "</p>"
	}
	
	contentView.innerHTML = str;
}

// 左右对比
function showZydb() {
	var str = "<table width=98%>";
	var m = eSentenceAry.length;
	for (var i=0; i<m; i++)	{
		str += "<tr><td width=50%>";
		var n = eSentenceAry[i].length;
		for (var j=0; j<n; j++) {
			str += eSentenceAry[i][j];
		}
		str += "</td><td width=50%>"
		if (cSentenceAry[i]!=null) {
			n = cSentenceAry[i].length;
			for (j=0; j<n; j++) {
				str += cSentenceAry[i][j];
			}
		}
		str += "</td></tr>";
	}
	str += "</table>";
	
	contentView.innerHTML = str;
}

// 段落对比
function showDldb() {
	var str = "<p>";
	var m = eSentenceAry.length;
	for (var i=0; i<m; i++)	{
		var n = eSentenceAry[i].length;
		for (var j=0; j<n; j++) {
			str += eSentenceAry[i][j];
		}
		if (cSentenceAry[i]!=null) {
			str += "<p>";
			n = cSentenceAry[i].length;
			for (j=0; j<n; j++) {
				str += cSentenceAry[i][j];
			}
			str += "</p>";
		}
	}
	str += "</p>";
	contentView.innerHTML = str;
}

// 句子对比
function showJzdb() {
	var str = "";
	var m = eSentenceAry.length;
	for (var i=0; i<m; i++)	{
		str += "<p>";
		var n = eSentenceAry[i].length;
		for (var j=0; j<n; j++) {
			str += eSentenceAry[i][j];
			if (cSentenceAry[i]!=null) {
				if (cSentenceAry[i][j]!=null)
					str += cSentenceAry[i][j];
			}
		}
		str += "</p>";
	}
	contentView.innerHTML = str;
}