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
  var allUserOfDept="";
  var allUserRealNameOfDept = "";
  
  function setUsers() {
	// window.returnValue = users.innerText;
	window.opener.setUsers(users.innerText, userRealNames.innerText);
  	window.close();
  }

  function initUsers() {
  	users.innerText = window.opener.getSelUserNames();
  	userRealNames.innerText = window.opener.getSelUserRealNames();
	
   // 初始化可以选择的用户角色
   try {
	   var depts = window.opener.getValidUserRole();
	   if (depts!="") {
		   var ary = depts.split(",");
		   var isFinded = true;
	   	   isFinded = false;
		   var len = document.all.tags('A').length;
		   for(var i=0; i<len; i++) {
		   		try {
					var aObj = document.all.tags('A')[i];
					var canSel = false;
					for (var j=0; j<ary.length; j++) {
						if (aObj.outerHTML.indexOf(ary[j])!=-1) {
							canSel = true;
							// alert(canSel);
							break;
						}
					}
					if (!canSel && aObj.menu=="true") {
						aObj.outerHTML = "<font color='#888888'>" + aObj.innerText + "</font>";
						// aObj.outerHTML = aObj.outerHTML.replace(/onClick/gi, "''");
					}
						
					isFinded = true;
				}
				catch (e) {}
		   }
	   }
   }
   catch (e) {}		
  }

  function selPerson(deptCode, deptName, userName, userRealName) {
	// 检查用户是否已被选择
	if (users.innerText.indexOf(userName)!=-1) {
		alert("用户" + userRealName + "已被选择！");
		return;
	}
	if (users.innerText=="") {
		users.innerText += userName
		userRealNames.innerText += userRealName;
	}
	else {
		users.innerText += "," + userName;
		userRealNames.innerText += "," + userRealName;
	}

  }
  
  function cancelSelPerson(deptCode, deptName, userName) {
	// 检查用户是否已被选择
	var strUsers = users.innerText;
	if (strUsers=="")
		return;
	if (strUsers.indexOf(userName)==-1) {
		return;
	}
	
	var strUserRealNames = userRealNames.innerText;
  	var ary = strUsers.split(",");
	var aryRealName = strUserRealNames.split(",");
	var len = ary.length;
	var ary1 = new Array();
	var aryRealName1 = new Array();
	var k = 0;
	for (i=0; i<len; i++) {
		if (ary[i]!=userName) {
			ary1[k] = ary[i];
			aryRealName1[k] = aryRealName[i];
			k++;
		}
	}
	var str = "";
	var str1 = "";
	for (i=0; i<k; i++) {
		if (str=="") {
			str = ary1[i];
			str1 = aryRealName1[i];
		}
		else {
			str += "," + ary1[i];
			str1 += "," + aryRealName1[i];
		}
	}
	users.innerText = str;
	userRealNames.innerText = str1;
  }
  
  function selAllUserOfDept() {
  	if (allUserOfDept=="")
		return;
	var allusers = users.innerText;
	var allUserRealNames = userRealNames.innerText;
	if (allusers=="") {
		allusers += allUserOfDept;
		allUserRealNames += allUserRealNameOfDept;
	}
	else {
		allusers += "," + allUserOfDept;
		allUserRealNames += "," + allUserRealNameOfDept;
	}
	// alert(allUserRealNames);
	var r = clearRepleatUser(allusers, allUserRealNames);
  	users.innerText = r[0];
	userRealNames.innerText = r[1];
  }
   
  function clearRepleatUser(strUsers, strUserRealNames) {
  	var ary = strUsers.split(",");
	var aryRealName = strUserRealNames.split(",");
	
	var len = ary.length;
	// 创建二维数组
	var ary1 = new Array();
	for (i=0; i<len; i++) {
		ary1[i] = new Array(2);
		ary1[i][0] = ary[i];
		ary1[i][1] = 0; // 1 表示重复
	}
	
	// 标记重复的用户
	for (i=0; i<len; i++) {
		var user = ary[i];
		for (j=i+1; j<len; j++) {
			if (ary1[j][1]==1)
				continue;
			if (ary[j]==user)
				ary1[j][1] = 1;
		}
	}

	// 重组为字符串
	var str = "";
	var str1 = "";
	for (i=0; i<len; i++) {
		if (ary1[i][1]==0) {
			u = ary1[i][0];
			if (str=="") {
				str = u;
				str1 = aryRealName[i];
			}
			else {
				str += "," + u;
				str1 += "," + aryRealName[i];
			}
		}
	}
	var retary = new Array();
	retary[0] = str;
	retary[1] = str1;
	return retary;
	
  }
</script>
</HEAD>
<BODY bgColor=#FBFAF0 leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="initUsers()">
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
    <td height="24" colspan="4" align="center" class="right-title"><span>用户角色</span></td>
  </tr>
  <tr> 
    <td width="13" height="87">&nbsp;</td>
    <td colspan="2" valign="top">
<%
String showCode = ParamUtil.get(request, "showCode");
String code;
String desc;
RoleDb urole = new RoleDb();
Iterator userir = null;
if (!showCode.equals("")) {
	urole = urole.getRoleDb(showCode);
	userir = urole.getAllUserOfRole().iterator();
}
else
	userir = (new Vector()).iterator();
Vector result = urole.list();
Iterator ir = result.iterator();
%>
      <br>
      <table width="95%" align="center">
        <tbody>
<%
while (ir.hasNext()) {
 	RoleDb ug = (RoleDb)ir.next();
	code = ug.getCode();
	desc = ug.getDesc();
%>
          <tr class="row" style="BACKGROUND-COLOR: #ffffff">
            <td width="31%">
			  <a href="?showCode=<%=StrUtil.UrlEncode(code)%>" menu="true"><%=desc%></a>
			</td>
          </tr>
<%}%>
        </tbody>
      </table>	</td>
    <td width="287" align="center" valign="top" bgcolor="#F3F3F3">
	<div id="resultTable">
	  <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <thead>
        <tr>
          <th width="98" align="left" bgcolor="#B4D3F1">职级</th>
          <th width="91" align="left" bgcolor="#B4D3F1">职员</th>
          <th width="74" align="left" bgcolor="#B4D3F1">&nbsp;</th>
        </tr>
      </thead>
      <tbody id="postsbody">
	  <%
	  while (userir.hasNext()) {
	  	UserDb ud = (UserDb)userir.next();
	  %>
	  <script>
	  if (allUserOfDept=="") {
	  	allUserOfDept = "<%=ud.getName()%>";
		allUserRealNameOfDept = "<%=ud.getRealName()%>";
	  }
	  else {
	  	allUserOfDept += "," + "<%=ud.getName()%>";
		allUserRealNameOfDept += "," + "<%=ud.getRealName()%>";
	  }
	  </script>
	  <tr>
	    <td><%=com.redmoon.oa.basic.RankDb.getRankName(ud.getRankCode())%></td>
	    <td><a onClick="selPerson('', '', '<%=ud.getName()%>', '<%=ud.getRealName()%>')" href="#"><%=ud.getRealName()%></a></td>
	    <td>[<a onClick="cancelSelPerson('', '', '<%=ud.getName()%>')" href="#">取消选择</a>]</td>
	  </tr>
	  <%}%>
      </tbody>
    </table>
	</div><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" align="center"><input name="button" type="button" onClick="selAllUserOfDept()" value="选择该角色所有用户"></td>
  </tr>
</table>
	</td>
  </tr>
  <tr align="center">
    <td height="63" colspan="2">已选职员</td>
    <td height="63" colspan="2" align="left">
	  <div id="users" name="users" style="display:none"></div>
	  <div id="userRealNames" name="userRealNames"></div>
	</td>
  </tr>
  <tr align="center">
    <td height="28" colspan="4">
<input type="button" name="okbtn" value="确定" onClick="setUsers()">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <input type="button" name="cancelbtn" value="取消" onClick="window.close()">    </td>
  </tr>
</table>
</BODY></HTML>
