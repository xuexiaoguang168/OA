<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人事档案管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
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

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);
	GetDate = showModalDialog("../util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}

function setPerson(deptCode, deptName, user, userRealName)
{
	form1.userName.value = user;
	form1.userRealName.value = userRealName;
}
//-->
</script>
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<%
	String userName = ParamUtil.get(request,"userName");
	if (!privilege.isUserPrivValid(request, "archive.family")||!archivePrivilege.canAdminUser(request,userName)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<%@ include file="archive_inc_menu_top.jsp"%>
<%
	String strId = ParamUtil.get(request, "id");
	if (!StrUtil.isNumeric(strId)) {
		out.println(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.module.archive","warn_id_err_archive")));
		return;
	}
	int id = Integer.parseInt(strId);
	
	UserFamilyDb ufd = new UserFamilyDb();
	ufd = ufd.getUserFamilyDb(id);
	
	UserInfoDb uid = new UserInfoDb();
	uid = uid.getUserInfoDb(userName);
	String userRealName = uid.getUserRealName();
	
	BasicDataMgr bdm = new BasicDataMgr("archive");
	String options = "";
%>
<br>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
  <form name="form1" action="archive_family_do.jsp?op=modify" method="post">
    <tbody>
	  <tr>
		<td colspan="3" class="right-title">修改家庭信息</td>
	  </tr>
      <tr>
        <td width="80" noWrap>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</td>
        <td colSpan="2"><input maxLength="100" name="userRealName" size="20" readonly value="<%=userRealName%>"><input name="userName" type="hidden" value="<%=userName%>">
          <input type="hidden" name="id" value="<%=id%>">
        </td>
      </tr>
      <tr>
        <td noWrap>称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;谓：</td>
        <td colSpan="2">		  
		<%options = bdm.getOptionsStr("appellation");%>
		<select name="appellation">
		<%=options%>
        </select>
		<script language="JavaScript">
		<!--
		form1.appellation.value="<%=ufd.getAppellation()%>";
		//-->
		</script>
		</td>
      </tr>
      <tr>
        <td noWrap>成员姓名：</td>
        <td colSpan="2"><input maxLength="100" name="name" size="20" value="<%=ufd.getName()%>"></td>
      </tr>
      <tr>
        <td noWrap>出生日期：</td>
        <td colSpan="2"><input maxLength="100" name="birthday" size="20" value="<%=DateUtil.format(ufd.getBirthday(),"yyyy-MM-dd")%>"><img style="CURSOR: hand" onClick="SelectDate('birthday', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>政治面貌：</td>
        <td colSpan="2">
	    <%options = bdm.getOptionsStr("polity");%>
		<select name="politic">
		<%=options%>
        </select>
		<script language="JavaScript">
		<!--
		form1.politic.value="<%=ufd.getPolitic()%>";
		//-->
		</script>
		</td>
      </tr>
      <tr>
        <td noWrap>工作单位：</td>
        <td colSpan="2"><input maxLength="100" name="unit" size="20" value="<%=ufd.getUnit()%>"></td>  
      </tr>
      <tr>
        <td noWrap>联系地址：</td>
        <td colSpan="2"><input maxLength="100" name="address" size="20" value="<%=ufd.getAddress()%>"></td>
      </tr>
      <tr>
        <td noWrap>联系电话：</td>
        <td colSpan="2"><input maxLength="100" name="phone" size="20" value="<%=ufd.getPhone()%>"></td>
      </tr>
      <tr>
        <td noWrap>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
        <td colSpan="2"><textarea name="remark" cols="45" rows="3" wrap="yes" class="BigINPUT" id="remark"><%=ufd.getRemark()%></textarea></td>
      </tr>
      <tr>
        <td noWrap align="middle" colSpan="3"><input value="保存" type="submit">&nbsp;&nbsp; 
          <input type="reset" value="重填">&nbsp;&nbsp;</td>
      </tr>
    </tbody>
  </FORM>
</table>
</body>
</html>
