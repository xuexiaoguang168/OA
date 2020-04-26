<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<html>
<head>
<title>增加日程</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="common.css" type="text/css">
<script language=javascript>
<!--
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

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
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
		findObj(objName).value = dt;
}
//-->
</script>
<style type="text/css">
<!--
.STYLE1 {	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%@ include file="inc/inc.jsp"%>
<%@ include file="plan_inc_menu_top.jsp"%>
<br>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" valign="middle" class="right-title">&nbsp;增 
      加 日 程</td>
  </tr>
  <tr> 
    <td height="293" valign="top" bgcolor="#FFFFFF">
<table width="90%" border="0" align="center">
        <tr> 
          <td height="5"></td>
        </tr>
      </table> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="stable">
        <tr class="stable"> 
          <td width="16%" height="21" align="center" bgcolor="#C4DAFF" class="stable">&nbsp;</td>
          <td width="84%" height="21" bgcolor="#C4DAFF" class="stable">增加日程</td>
        </tr>
        <form name="form1" action="plan_add_do.jsp" method="post" onSubmit="">
          <tr> 
            <td width="16%" height="19" align="center" bgcolor="#eeeeee" class="stable">标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题</td>
            <td height="19"><input name="title" class="singleboarder" size=35></td>
          </tr>
          <tr> 
            <td width="16%" height="19" align="center" bgcolor="#eeeeee" class="stable">待办日期            </td>
            <td width="84%" height="19"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        
        <tr>
          <td><input name=mydate size="10" readonly="">
            <img style="CURSOR: hand" onClick="SelectDate('mydate','yyyy-mm-dd')" src="images/form/calendar.gif" align="absMiddle" width="26" height="26">
			<input style="WIDTH: 50px" value="12:00:00" name="time" size="20">&nbsp;<img style="CURSOR: hand" onClick="SelectDateTime('time')" src="images/form/clock.gif" align="absMiddle" width="18" height="18">			</td>
          </tr>
      </table></td>
          </tr>
          <tr>
            <td height="17" align="center" bgcolor="#eeeeee" class="stable">是否提醒</td>
            <td height="17"><input type="checkbox" name="isRemind" value="1" checked>
            &nbsp;&nbsp;
			<select name="before">
			<option value="10">十分钟</option>
			<option value="20">二十分钟</option>
			<option value="30">三十分钟</option>
			<option value="45">四十五分钟</option>
			<option value="60">一小时</option>
			<option value="120">二小时</option>
			<option value="180">三小时</option>
			<option value="360">六小时</option>
			<option value="720">十二小时</option>
			</select>之前			
			<%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
            <input name="isToMobile" value="true" type="checkbox" checked />
短讯提醒
<%}%></td>
          </tr>
          <tr> 
            <td width="16%" height="17" align="center" bgcolor="#eeeeee" class="stable">内&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;容</td>
            <td width="84%" height="17"> <textarea name=content cols="50" class="singleboarder" rows="12"></textarea>            </td>
          </tr>
          <tr> 
            <td colspan="2" align="center">&nbsp; </td>
          </tr>
          <tr> 
            <td colspan="2" align="center"> <input name="submit" type=submit class="singleboarder" value=" 发 送 "> 
              &nbsp;&nbsp;&nbsp; <input name="reset" type=reset class="singleboarder" value=" 取 消 ">            </td>
          </tr>
        </form>
      </table>    </td>
  </tr>
</table>
</body>
</html>