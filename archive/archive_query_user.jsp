<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.pvg.Privilege"%>
<%@ page import="com.redmoon.oa.archive.*"%>
<%@ page import="java.util.*"%>
<HTML><HEAD><TITLE>管理查询操作人</TITLE>
<link rel="stylesheet" href="../common.css">
<script language="JavaScript">
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

var selUserNames = "";
var selUserRealNames = "";
function getSelUserNames() {
	return selUserNames;
}

function getSelUserRealNames() {
	return selUserRealNames;
}

var doWhat = "";

function openWinUsers() {
	doWhat = "users";
	selUserNames = form1.users.value;
	selUserRealNames = form1.userRealNames.value;
	showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:520px;dialogHeight:400px;status:no;help:no;')
}

function setUsers(users, userRealNames) {
	if (doWhat=="users") {
		form1.users.value = users;
		form1.userRealNames.value = userRealNames;
	}
	if (doWhat=="principal") {
		form1.principal.value = users;
		form1.principalRealNames.value = userRealNames;
	}
}

function openWinPrincipal() {
	doWhat = "principal";
	selUserNames = form1.principal.value;
	selUserRealNames = form1.principalRealNames.value;
	showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:520px;dialogHeight:400px;status:no;help:no;')
}
</script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<% 
	String userRealNames = "",users = "";
	int id = ParamUtil.getInt(request, "id");
	String sql = ArchiveSQLBuilder.getUserPrivilege(id);
	ArchivePrivilegeDb apd = new ArchivePrivilegeDb();
	Vector vt = apd.list(sql);
	Iterator ir = null;
	ir = vt.iterator();
	while (ir != null && ir.hasNext()) {
		apd = (ArchivePrivilegeDb) ir.next();
		if (users.equals("")) {
			users = apd.getUserName();
			UserDb ud = new UserDb();
			ud = ud.getUserDb(apd.getUserName());
			userRealNames = ud.getRealName();
		}
		else {
			users += "," + apd.getUserName();
			UserDb ud = new UserDb();
			ud = ud.getUserDb(apd.getUserName());
			userRealNames += "," + ud.getRealName();
		}
	}
  
%>
<table width="426" border="0" align="center" cellpadding="0" cellspacing="1" class="tableframe">
<form action="archive_query_do.jsp?op=modifyUsers" name="form1" method="post">
  <tr>
    <td colspan="3" align="center" class="right-title">管理查询操作人</td>
    </tr>
  <tr>
    <td width="47">&nbsp;</td>
    <td width="317"> <span class="TableData">
      <input name="users" id="users" type="hidden" value="<%=users%>">
      <textarea name="userRealNames" cols="45" rows="3" readOnly wrap="yes" id="userRealNames"><%=userRealNames%></textarea>&nbsp;</span> 
    </td>
    <td width="488" align="left"><span class="TableData">
        <input class="SmallButton" title="添加收件人" onClick="openWinUsers()" type="button" value="添 加" name="button">
        &nbsp;
        <input class="SmallButton" title="清空收件人" onClick="form1.users.value='';form1.userRealNames.value=''" type="button" value="清 空" name="button"></span> </td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td align="center"><input type="submit" value="确 定">
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="hidden" name="id" value="<%=id%>">      &nbsp; </td>
    <td align="center">&nbsp;</td>
  </tr>
  </form>
</table>
</BODY></HTML>
