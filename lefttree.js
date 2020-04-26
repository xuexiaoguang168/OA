<!--
	function swapimg(myimgNum,secNum,folderimg){
	    if (secNum.className=="off")
		{
			secNum.className="on";
	     	myimgNum.src="images/left/tplus.gif";
	     	folderimg.src="images/left/icon_folder.gif"
		}
	    else
		{
			secNum.className="off";
	     	myimgNum.src="images/left/tminus.gif";
	     	folderimg.src="images/left/icon_folderopen.gif"
		}
	  }
	function statu()
	{
		window.defaultStatus=' ';
	}
	//window.setInterval("statu()",10)
	
	function AllClose(){
		tempColl = document.all.tags("div");
	
		for (i=0; i<tempColl.length; i++) {
			if (tempColl(i).className == "off") {
			tempColl(i).className = "on"
			}
		}
		imgColl = document.all.tags("img");
		
		for (i=0; i<imgColl.length; i++) {
			if (imgColl(i).id != "") {
				if(imgColl(i).className == "havechild") {
					imgColl(i).src = "images/left/icon_folder.gif"
				}
				else{
					imgColl(i).src = "images/left/tplus.gif"
				}
			}
		}
	}
	
	function AllOpen(){
		tempColl = document.all.tags("div");
		for (i=0; i<tempColl.length; i++) {
			if (tempColl(i).className == "on") {
			tempColl(i).className = "off"
			}
		}
		imgColl = document.all.tags("IMG");	
		for (i=0; i<imgColl.length; i++) {
			if (imgColl(i).id != "") {
				if(imgColl(i).className == "havechild") {
					imgColl(i).src = "images/left/icon_folderopen.gif"
				}
				else{
					imgColl(i).src = "images/left/tminus.gif"
				}
			}
		}
	}

var Xpos = 1;
var Ypos = 1;
function doDown() {
Xpos = document.body.scrollLeft+event.x;
Ypos = document.body.scrollTop+event.y;
}

function showmenu(){
menutool.style.left=Xpos;
menutool.style.top=Ypos;
menutool.style.display="block"
}

function hidemenu(){
menutool.style.display="none"
}
document.onclick = hidemenu;
document.onmousedown = doDown;
-->