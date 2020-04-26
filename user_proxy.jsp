<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="cn.js.fan.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>日程安排</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link rel="stylesheet" href="common.css" type="text/css">
<%@ include file="inc/nocache.jsp" %>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
<script>
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

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);

	GetDate = showModalDialog("util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
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

function setPerson(deptCode, deptName, userName, userRealName)
{
	form1.proxy.value = userName;
	form1.proxyUserRealName.value = userRealName;
}
</script>
</HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=3 marginheight="3" marginwidth="0">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	String priv="read";
	if (!privilege.isUserPrivValid(request, priv)) {
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	String userName = ParamUtil.get(request, "userName");
	if (userName.equals(""))
		userName = privilege.getUser(request);
	
	String op = ParamUtil.get(request, "op");
	UserMgr um = new UserMgr();
	
	if (op.equals("setProxy")) {
		boolean re = false;
		try {
			re = um.setProxy(request, userName);
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.p_center(e.getMessage()));
		}
		if (re)
			out.print(StrUtil.Alert("设置代理成功！"));
	}
	
	UserDb ud = um.getUserDb(userName);
	String proxy = ud.getProxy();
	String proxyUserRealName = "";
	if (!proxy.equals("")) {
		proxyUserRealName = ud.getUserDb(proxy).getRealName();
	}
%>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" class="right-title">&nbsp;设置 <%=ud.getRealName()%> 代理职位</td>
  </tr>
  <tr> 
    <td height="225" align="center" valign="top">
      <table width="83%" border="0" cellspacing="0" cellpadding="5">
	   <form id=form1 name=form1 action="?op=setProxy" method="post">
        <tr>
          <td>代&nbsp;&nbsp;理&nbsp;&nbsp;人&nbsp;
            <input name=proxyUserRealName value="<%=proxyUserRealName%>" readonly>
          <a href="#" onClick="javascript:showModalDialog('user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择用户</a>&nbsp;&nbsp;
          <input name=proxy type=hidden value="<%=ud.getProxy()%>">
          <input name="userName" type="hidden" value="<%=userName%>">
		<input type="button" onClick="form1.proxy.value='';form1.proxyUserRealName.value=''" value="清除">		  
		  </td>
        </tr>
        <tr>
          <td>开始时间
          <input name=proxyBeginDate size=10 readonly value="<%=DateUtil.format(ud.getProxyBeginDate(), "yyyy-MM-dd")%>">
          <img src="images/form/calendar.gif" width="26" height="26" align=absMiddle style="cursor:hand" onClick="SelectDate('proxyBeginDate','yyyy-mm-dd')">
          <input style="WIDTH: 50px" value="<%=DateUtil.format(ud.getProxyBeginDate(), "HH:mm:ss")%>" name="proxyBeginTime" size="20">
&nbsp;<img style="CURSOR: hand" onClick="SelectDateTime('proxyBeginTime')" src="images/form/clock.gif" align="absMiddle" width="18" height="18"></td>
        </tr>
        <tr>
          <td align="left">结束时间
            <input name=proxyEndDate size=10 readonly value="<%=DateUtil.format(ud.getProxyEndDate(), "yyyy-MM-dd")%>">
            <img src="images/form/calendar.gif" width="26" height="26" align=absMiddle style="cursor:hand" onClick="SelectDate('proxyEndDate','yyyy-mm-dd')">
            <input style="WIDTH: 50px" value="<%=DateUtil.format(ud.getProxyEndDate(), "HH:mm:ss")%>" name="proxyEndTime" size="20">
&nbsp;<img style="CURSOR: hand" onClick="SelectDateTime('proxyEndTime')" src="images/form/clock.gif" align="absMiddle" width="18" height="18"></td>
        </tr>
        <tr>
          <td align="center"><label>
            <input name="isUseMsg" type="checkbox" value="true" checked>短消息通知&nbsp;&nbsp;
            <input type="submit" name="Submit" value="设   置">
          &nbsp;&nbsp;&nbsp;</label></td>
        </tr>
        <tr>
          <td align="center">注意：将代理人设置为空将清除代理</td>
        </tr>
		</form>
      </table>
      <p><br>
      </p></td>
  </tr>
</table>
<div align="center"></div>
</BODY>
</HTML>
