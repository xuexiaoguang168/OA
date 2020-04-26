<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<%@ page import = "cn.js.fan.security.*"%>
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
	String deptCode = ParamUtil.get(request,"deptCode");
	if (!privilege.isUserPrivValid(request, "archive.userinfo")||!archivePrivilege.canAdminDept(request,deptCode)) {
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	
	if (deptCode.trim().equals("") || !SecurityUtil.isValidSqlParam(deptCode) || deptCode.length() > 50) {
	   out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive","warn_deptcode_err_archive")));
	   return;
	}
	
	
	BasicDataMgr bdm = new BasicDataMgr("archive");
	String options = "";
%>
<form name="form1" action="archive_user_do.jsp?op=add&deptCode=<%=deptCode%>" method="post" encType="multipart/form-data">
  <table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
    <tbody>
	  <tr>
		<td colspan="3" class="right-title">添加用户信息</td>
	  </tr>
      <tr>
        <td noWrap width="80">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
        <td><input maxLength="100" name="userRealName" size="20"><input name="userName" type="hidden" value="<%=cn.js.fan.util.RandomSecquenceCreator.getId(20)%>">
		<input type="hidden" name="deptCode" value="<%=deptCode%>"></td>
        <td width="250" rowSpan="9"><center>暂无照片</center></td>
      </tr>
      <tr>
        <td noWrap>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
        <td><select name="sex">
            <option value="女">女</option>
            <option value="男" selected>男</option>
          </select></td>
      </tr>
      <tr>
        <td noWrap>出生日期：</td>
        <td><input maxLength="100" name="birthday" size="20"><img style="CURSOR: hand" onClick="SelectDate('birthday', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：</td>
        <td><%options = bdm.getOptionsStr("people");%>
		  <select name="people">
		  <%=options%>
          </select></td>
      </tr>
      <tr>
        <td noWrap>籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯：</td>
        <td><input maxLength="100" size="12" name="nation"></td>
      </tr>
      <tr>
        <td noWrap>出&nbsp;&nbsp;生&nbsp;&nbsp;地：</td>
        <td><input maxLength="100" size="12" name="born"></td>
      </tr>
      <tr>
        <td noWrap>入党时间：</td>
        <td><input maxLength="100" name="joinPartyDate" size="20">
        <img style="CURSOR: hand" onClick="SelectDate('joinPartyDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>参加工作时间：</td>
        <td colSpan="2"><input maxLength="100" name="joinWorkDate" size="20">
        <img style="CURSOR: hand" onClick="SelectDate('joinWorkDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如  1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>加入本单位时间：</td>
        <td colSpan="2"><input maxLength="100" name="joinDepartmentDate" size="20">
        <img style="CURSOR: hand" onClick="SelectDate('joinDepartmentDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如  1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>在职情况：</td>
        <td colSpan="2">		
		<%options = bdm.getOptionsStr("inActiveService");%>
		  <select name="inActiveService">
		  <%=options%>
          </select>  </td>
      </tr>
      <tr>
        <td noWrap>健康状况：</td>
        <td colSpan="2">
		<%options = bdm.getOptionsStr("healthState");%>
		  <select name="healthState">
		  <%=options%>
          </select>		</td>
      </tr>
      <tr>
        <td noWrap>最高学历：</td>
        <td colSpan="2">		  
		  <%options = bdm.getOptionsStr("grade");%>
		  <select name="mostGrade">
		  <%=options%>
          </select></td>
      </tr>
      <tr>
        <td noWrap>文化程度：</td>
        <td colSpan="2">
		  <%options = bdm.getOptionsStr("culture");%>
		  <select name="culture">
		  <%=options%>
          </select></td>
      </tr>
      <tr>
        <td noWrap>后备干部级别：</td>
        <td colSpan="2">
		  <%options = bdm.getOptionsStr("insupportCadreLevel");%>
		  <select name="insupportCadreLevel">
		  <%=options%>
          </select></td>
      </tr>
      <tr>
        <td noWrap>定为后备干部的时间：</td>
        <td colSpan="2"><input maxLength="100" name="insupportCadreDate" size="20">
        <img style="CURSOR: hand" onClick="SelectDate('insupportCadreDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>政治面貌：</td>
        <td colSpan="2">
		<%options = bdm.getOptionsStr("polity");%>
		  <select name="polity">
		  <%=options%>
          </select></td>  
      </tr>
      <tr>
        <td noWrap>其它党派加入时间：</td>
        <td colSpan="2"><input maxLength="100" name="joinClanDate" size="20">
        <img style="CURSOR: hand" onClick="SelectDate('joinClanDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>编制情况：</td>
        <td colSpan="2">
		<%options = bdm.getOptionsStr("typeofwork");%>
		  <select name="typeOfWork">
		  <%=options%>
          </select></td>
      </tr>
	  <tr>
        <td noWrap>干部来源</td>
        <td colSpan="3"><%options = bdm.getOptionsStr("cadresSource");%>
		  <select name="cadresSource">
		  <%=options%>
          </select></td>
      </tr>
      <tr>
        <td noWrap>过渡时间</td>
        <td colSpan="3"><input maxLength="100" name="transitionDate" size="20"><img style="CURSOR: hand" onClick="SelectDate('transitionDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>照片</td>
        <td colSpan="2"><input title="选择附件文件" type="file" size="30" name="image"></td>
      </tr>
      <tr>
        <td noWrap>备注：</td>
        <td colSpan="2"><textarea name="remark" cols="45" rows="3" wrap="yes" class="BigINPUT" id="remark"></textarea></td>
      </tr>
      <tr>
        <td noWrap align="middle" colSpan="3"><input value="保存" type="submit">&nbsp;&nbsp; 
          <input type="reset" value="重填">&nbsp;&nbsp;</td>
      </tr>
    </tbody>
  </table>
</FORM>
</body>
</html>
