<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.redmoon.oa.pvg.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="java.util.*" %>
<HTML><HEAD><TITLE>选择用户</TITLE>
<link rel="stylesheet" href="common.css">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style1 {
	font-size: 12pt;
	font-weight: bold;
}
-->
</style>
  <script>
  function setUserGroups() {
	window.returnValue = getTargets();
  	window.close();
  }

  function initUserGroups() {
  	setTargets();
  }

function setTargets() {
   var depts = dialogArguments.getUserGroups();
   var ary = depts.split(",");
   for(var i=0; i<form1.elements.length; i++) {
   		if (form1.elements[i].type=="checkbox"){
			for (var j=0; j<ary.length; j++) {
				if (form1.elements[i].name==ary[j]) {
					form1.elements[i].checked = true;
					break;
				}
			}
   		}
   }
	
}

function getTargets(){
   var ary = new Array();
   var j = 0;
   for(var i=0; i<form1.elements.length; i++) {
   		if (form1.elements[i].type=="checkbox"){
			if (form1.elements[i].checked) {
				ary[j] = new Array();
				ary[j][0] = form1.elements[i].name;
				ary[j][1] = form1.elements[i].value;
				j ++;
			}
   		}
   }
   return ary;
}
</script>
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="initUserGroups()">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="24" colspan="3" align="center" class="right-title"><span>用户组</span></td>
  </tr>
  <tr> 
    <td width="13" height="87">&nbsp;</td>
    <td colspan="2" valign="top">
<%
UserGroupDb ugroup = new UserGroupDb();
Vector result = ugroup.list();
Iterator ir = result.iterator();
%>
      <br>
      <table width="95%" align="center">
	  <form name="form1">
        <tbody>
<%
while (ir.hasNext()) {
 	UserGroupDb ug = (UserGroupDb)ir.next();
%>
          <tr class="row" style="BACKGROUND-COLOR: #ffffff">
            <td width="31%">
			  <input type="checkbox" name="<%=ug.getCode()%>" value="<%=ug.getDesc()%>">&nbsp;<%=ug.getDesc()%>			</td>
          </tr>
<%}%>
        </tbody>
		</form>
      </table>	</td>
  </tr>
  <tr align="center">
    <td height="28" colspan="3">
<input type="button" name="okbtn" value="确定" onClick="setUserGroups()">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <input type="button" name="cancelbtn" value="取消" onClick="window.close()">    </td>
  </tr>
</table>
</BODY></HTML>
