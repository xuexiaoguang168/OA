<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "cn.js.fan.util.*"%>
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

function setFilePriv(op)
{
	openWin("setfilepriv.jsp?op="+op,400,300);
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
</head>
<body bgcolor="#FFFFFF" text="#000000" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%@ include file="inc/inc.jsp"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int id = ParamUtil.getInt(request, "id");

PlanDb pd = new PlanDb();
pd = pd.getPlanDb(id);

String title="",content="";
Calendar mydate = Calendar.getInstance();

int year=0,month=0,day=0,hour=0,minute=0,sec=0;
String strmonth="01";
title = pd.getTitle();
content = pd.getContent();
mydate.setTime(pd.getMyDate());
year = mydate.get(mydate.YEAR);
month = mydate.get(mydate.MONTH)+1;
if (month<10)
	strmonth = "0"+month;
else
	strmonth = ""+month;
day = mydate.get(mydate.DAY_OF_MONTH);
hour = mydate.get(mydate.HOUR_OF_DAY);
minute = mydate.get(mydate.MINUTE);
sec = mydate.get(mydate.SECOND);
%>
<%@ include file="plan_inc_menu_top.jsp"%>
<br>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <tr bgcolor="#0099FF"> 
    <td height="21" colspan="3" align="left" bgcolor="#0099FF" class="right-title"><b><font color="#FFFFFF">&nbsp;修改日程</font></b></td>
  </tr>
  <form name="form1" action="plan_edit_do.jsp" method="post" onSubmit="">
    <tr> 
      <td height="19" align="center">标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题</td>
      <td height="19">&nbsp;</td>
      <td height="19"><input name="title" class="singleboarder" size=35 value="<%=title%>">
	  <input type=hidden value=<%=id%> name=id>	  </td>
    </tr>
    <tr> 
      <td width="13%" height="19" align="center">待办日期 </td>
      <td width="0%" height="19">&nbsp;</td>
      <td width="87%" height="19">
		<input name=mydate size="10">
        <img style="CURSOR: hand" onClick="SelectDate('mydate','yyyy-mm-dd')" src="images/form/calendar.gif" align="absMiddle" width="26" height="26">
        <input style="WIDTH: 50px" value="12:30:30" name="time" size="20">
      &nbsp;<img style="CURSOR: hand" onClick="SelectDateTime('time')" src="images/form/clock.gif" align="absMiddle" width="18" height="18"> </td>
	  <script language="JavaScript">
	  <!--
	  form1.mydate.value = "<%=DateUtil.format(mydate, "yyyy-MM-dd")%>";
	  form1.time.value = "<%=DateUtil.format(mydate, "HH:mm:ss")%>";
	  //-->
	  </script>
    </tr>
    <tr>
      <td height="17" align="center">是否提醒</td>
      <td height="17">&nbsp;</td>
      <td height="17"><input type="checkbox" name="isRemind" value="1" <%=pd.isRemind()?"checked":""%>>
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
  </select>
  <%
  int m = 10;
  java.util.Date rd = pd.getRemindDate();
  if (rd!=null) {
	  m = DateUtil.datediffMinute(pd.getMyDate(), rd);
  }
  %>
  <script>
  form1.before.value = "<%=m%>";
  </script>
  
        之前 
        <%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
        <input name="isToMobile" value="true" type="checkbox"  <%=pd.isRemindBySMS()?"checked":""%>/>
短讯提醒
<%}%></td>
    </tr>
    <tr> 
      <td width="13%" height="17" align="center">内&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;容</td>
      <td width="0%" height="17">&nbsp;</td>
      <td width="87%" height="17"> <textarea name=content cols="50" class="singleboarder" rows="8"><%=content%></textarea>      </td>
    </tr>
    <tr> 
      <td colspan="3" align="center">&nbsp; </td>
    </tr>
    <tr> 
      <td colspan="3" align="center"> <input name="submit" type=submit class="singleboarder" value=" 发 送 "> 
        &nbsp;&nbsp;&nbsp; <input name="reset" type=reset class="singleboarder" value=" 取 消 ">      </td>
    </tr>
    <tr> 
      <td colspan="3" align="center">&nbsp;</td>
    </tr>
  </form>
</table>
</body>
</html>