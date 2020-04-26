<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "cn.js.fan.security.*"%>
<%@ page import="com.redmoon.oa.dept.*" %>
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
var oldDeptCode = "";
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

function getDept() {
	return form1.dept.value;
}

function selDeptCode() {
	var code = form1.deptCode.options(form1.deptCode.selectedIndex).value;
	if (form1.deptCode.value=="root") {
		alert("请选择具体部门！");
		form1.deptCode.value = oldDeptCode;
		return false;
	}
	oldDeptCode = code;  
}

function preview(userName)
{
	window.location.href='archive_gwy_print.jsp?userName='+userName;
}
//-->
</script>
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="archivePrivilege" scope="page" class="com.redmoon.oa.archive.ArchivePrivilege"/>
<%
String userName = ParamUtil.get(request,"userName");
if (userName.trim().equals("") || !SecurityUtil.isValidSqlParam(userName) || userName.length() > 20) {
   out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive","warn_username_err_archive")));
   return;
}
%>
<%@ include file="archive_inc_menu_top.jsp"%>
<%
if (!privilege.isUserPrivValid(request, "archive.userinfo")||!archivePrivilege.canAdminUser(request,userName)) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

UserInfoDb uid = new UserInfoDb();
uid = uid.getUserInfoDb(userName);

/*
if(uid == null || !uid.isLoaded()){
	boolean re = false;
	try {
	   re = uid.createNewUser();
	}
	catch (ErrMsgException e) {
	   out.print(StrUtil.Alert_Back(e.getMessage()));
	}
	if (re) {
	   out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.module.archive", "success_add_userinfo"),"archive_user_modify.jsp?userName=" + userName));
	   return;
	}
}
*/

BasicDataMgr bdm = new BasicDataMgr("archive");
String options = "";
%>

<br>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
  <form name="form1" action="archive_user_do.jsp?op=modify&userName=<%=uid.getUserName()%>" method="post" encType="multipart/form-data">
    <tbody>
	  <tr>
		<td colspan="3" class="right-title">修改用户信息</td>
	  </tr>
      
      <tr>
        <td width="165" noWrap>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
        <td><input maxlength="100" name="userRealName" size="20" value="<%=uid.getUserRealName()%>" readonly>
          <input name="userName" type="hidden" value="<%=uid.getUserName()%>">
          <input type="hidden" name="oldImage" value="<%=uid.getImage()%>"></td>
        <td width="246" rowspan="8"><%if(uid.getImage().equals("")){%>
          <center>
            暂无照片
          </center>
          <%}else{%>
          <img src="../<%=uid.getImage()%>" width="100" height="140">
        <%}%></td>
      </tr>
      <tr>
        <td noWrap><p>所在部门：</p>
        </td>
        <td><select name="deptCode" onChange="return selDeptCode()">
			<%
			    DeptMgr dir = new DeptMgr();
				DeptDb leaf = dir.getDeptDb(uid.getDeptCode());
				DeptDb rootlf = leaf.getDeptDb(DeptDb.ROOTCODE);
				DeptView dv = new DeptView(rootlf);
				dv.ShowDeptAsOptions(out, rootlf, rootlf.getLayer());
			%>
		</select>
	    <script language="JavaScript">
		<!--
		form1.deptCode.value="<%=uid.getDeptCode()%>";
		//-->
		</script>
		</td>
      </tr>
      <tr>
        <td noWrap>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
        <td width="452"><select name="sex">
            <option value="女">女</option>
            <option value="男" selected>男</option>
          </select>
		<script language="JavaScript">
		<!--
		form1.sex.value="<%=uid.getSex()%>";
		//-->
		</script>		</td>
      </tr>
      <tr>
        <td noWrap>出生日期：</td>
        <td><input maxLength="100" name="birthday" size="20" value="<%=DateUtil.format(uid.getBirthday(),"yyyy-MM-dd")%>"><img style="CURSOR: hand" onClick="SelectDate('birthday', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
	  <tr>
        <td noWrap>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：</td>
        <td><%options = bdm.getOptionsStr("people");%>
		  <select name="people">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.people.value="<%=uid.getPeople()%>";
		//-->
		</script>
		  </td>
      </tr>

      <tr>
        <td noWrap>籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯：</td>
        <td><input maxLength="100" size="12" name="nation" value="<%=uid.getNation()%>"></td>
      </tr>
      <tr>
        <td noWrap>出&nbsp;&nbsp;生&nbsp;&nbsp;地：</td>
        <td><input maxLength="100" size="12" name="born" value="<%=uid.getBorn()%>"></td>
      </tr>
      <tr>
        <td noWrap>入党时间：</td>
        <td><input maxLength="100" name="joinPartyDate" size="20" value="<%=DateUtil.format(uid.getJoinPartyDate(),"yyyy-MM")%>"><img style="CURSOR: hand" onClick="SelectDate('joinPartyDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>参加工作时间：</td>
        <td colSpan="3"><input maxLength="100" name="joinWorkDate" size="20" value="<%=DateUtil.format(uid.getJoinWorkDate(),"yyyy-MM")%>"><img style="CURSOR: hand" onClick="SelectDate('joinWorkDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
	        <tr>
        <td noWrap>加入本单位时间：</td>
        <td colSpan="2"><input maxLength="100" name="joinDepartmentDate" size="20" value="<%=DateUtil.format(uid.getJoinDepartmentDate(),"yyyy-MM")%>"><img style="CURSOR: hand" onClick="SelectDate('joinDepartmentDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>在职情况：</td>
        <td colSpan="2">		
		<%options = bdm.getOptionsStr("inactiveservice");%>
		  <select name="inActiveService">
		  <%=options%>
          </select> 
		<script language="JavaScript">
		<!--
		form1.inActiveService.value="<%=uid.getInActiveService()%>";
		//-->
		</script> </td>
      </tr>
      <tr>
        <td noWrap>健康状况：</td>
        <td colSpan="3">
		<%options = bdm.getOptionsStr("healthstate");%>
		  <select name="healthState">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.healthState.value="<%=uid.getHealthState()%>";
		//-->
		</script>		</td>
      </tr>
	  <tr>
        <td noWrap>最高学历：</td>
        <td colSpan="2">		  
		  <%options = bdm.getOptionsStr("grade");%>
		  <select name="mostGrade">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.mostGrade.value="<%=uid.getMostGrade()%>";
		//-->
		</script>
		</td>
      </tr>
      <tr>
        <td noWrap>文化程度：</td>
        <td colSpan="3">
		<%options = bdm.getOptionsStr("culture");%>
		  <select name="culture">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.culture.value="<%=uid.getCulture()%>";
		//-->
		</script>		  </td>
      </tr>
      <tr>
        <td noWrap>后备干部级别：</td>
        <td colSpan="3">
		<%options = bdm.getOptionsStr("insupportcadrelevel");%>
		  <select name="insupportCadreLevel">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.insupportCadreLevel.value="<%=uid.getInsupportCadreLevel()%>";
		//-->
		</script>		  </td>
      </tr>
      <tr>
        <td noWrap>定为后备干部的时间：</td>
        <td colSpan="3"><input maxLength="100" name="insupportCadreDate" size="20" value="<%=DateUtil.format(uid.getInsupportCadreDate(),"yyyy-MM")%>"><img style="CURSOR: hand" onClick="SelectDate('insupportCadreDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>政治面貌：</td>
        <td colSpan="3">
		<%options = bdm.getOptionsStr("polity");%>
		  <select name="polity">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.polity.value="<%=uid.getPolity()%>";
		//-->
		</script>		  </td>  
      </tr>
      <tr>
        <td noWrap>其它党派加入时间：</td>
        <td colSpan="3"><input maxLength="100" name="joinClanDate" size="20" value="<%=DateUtil.format(uid.getJoinClanDate(),"yyyy-MM")%>"><img style="CURSOR: hand" onClick="SelectDate('joinClanDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>编制情况：</td>
        <td colSpan="3">
		<%options = bdm.getOptionsStr("typeofwork");%>
		  <select name="typeOfWork">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.typeOfWork.value="<%=uid.getTypeOfWork()%>";
		//-->
		</script>		  </td>
      </tr>
	  <tr>
        <td noWrap>干部来源</td>
        <td colSpan="3"><%options = bdm.getOptionsStr("cadressource");%>
		  <select name="cadresSource">
		  <%=options%>
          </select>
		<script language="JavaScript">
		<!--
		form1.cadresSource.value="<%=uid.getCadresSource()%>";
		//-->
		</script></td>
      <tr>
        <td noWrap>过渡时间</td>
        <td colSpan="3"><input maxLength="100" name="transitionDate" size="20" value="<%=DateUtil.format(uid.getTransitionDate(),"yyyy-MM")%>"><img style="CURSOR: hand" onClick="SelectDate('transitionDate', 'yyyy-MM')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">  
          日期格式形如 1999-1-2</td>
      </tr>
      <tr>
        <td noWrap>照片</td>
        <td colSpan="3"><input title="选择附件文件" type="file" size="30" name="image"></td>
      </tr>
      <tr>
        <td noWrap>备注：</td>
        <td colSpan="3"><textarea name="remark" cols="45" rows="3" wrap="yes" class="BigINPUT" id="remark"><%=uid.getRemark()%></textarea></td>
      </tr>
      <tr>
        <td noWrap align="middle" colSpan="4"><input value="保存" type="submit">&nbsp;&nbsp; 
          <input type="reset" value="重填">&nbsp;&nbsp;
          <!--<input type="button" value="打印公务员登记表" onClick="UseWord.Open('<%=Global.getRootPath()%>/archive/doc_templ/111.doc')">-->
		  </td>
      </tr>
    </tbody>
  </FORM>
</table>
<table style="display:none" width="100%"><tr><td>
<%
String sql = "";
//UserInfoDb uid = new UserInfoDb();
//uid = uid.getUserInfoDb(userName);
if(userName.equals("")){
	sql = ArchiveSQLBuilder.getUserStudy();
  }else{
	sql = ArchiveSQLBuilder.getUserStudy(userName);
}
UserStudyDb usd = new UserStudyDb();		
Iterator ir = usd.list(sql).iterator();
String college = ""; // 全日制教育
String collegeSpecialty = ""; // 全日制教育 毕业院校系及专业
String job = ""; // 在职教育
String zcollegeSpecialty = ""; // 在职教育 毕业院校系及专业
while (ir.hasNext()) {
  usd = (UserStudyDb)ir.next();
  if ((usd.getIsMostGrade()).equals("1")) {
      if (usd.getIsJob().equals("是")) {
		  zcollegeSpecialty = usd.getCollege() + usd.getSpecialty();
		  job = usd.getGrade();		  
	  } else {
		  collegeSpecialty = usd.getCollege() + usd.getSpecialty();
		  college = usd.getGrade();
	  }
  } // if end!
} // end 学历学位

// 工作简历
UserResumeDb urd = new UserResumeDb();	
Iterator ir1 = urd.list(sql).iterator();
String resume = "";
while (ir1.hasNext()) {
   urd = (UserResumeDb)ir1.next();
   resume += urd.getCompany() + urd.getJob() + DateUtil.format(urd.getBeginDate(),"yyyy-MM-dd") + DateUtil.format(urd.getEndDate(),"yyyy-MM-dd");
} // end 工作简历	

// 何时受过何种奖惩 rewards
UserRewardsDb urwd = new UserRewardsDb();
Iterator ir2 = urwd.list(sql).iterator();
String rewards = "";
while (ir2.hasNext()) {
  urwd = (UserRewardsDb)ir2.next();
  rewards += DateUtil.format(urwd.getMyDate(),"yyyy-MM-dd") + urwd.getPlace() + urwd.getRewards() + urwd.getReason();
} // end 何时受过何种奖惩
%>
<OBJECT id=UseWord classid=CLSID:D01B1EDF-E803-46FB-B4DC-90F585BC7EEE 
VIEWASTEXT><PARAM NAME="BackColor" VALUE="0000ff00">
<PARAM NAME="Server" VALUE="localhost">
<PARAM NAME="Port" VALUE="8080">
<PARAM NAME="isAutoUpload" VALUE="0" />
<PARAM NAME="isConfirmUpload" VALUE="1" />
<PARAM NAME="PostScript" VALUE="">
<PARAM NAME="WordUrl" VALUE="">
</OBJECT>
</td></tr></table>
</body>
<script language=javascript>
function doalert() {
	//UseWord.Alert("ff");
}

function OnDocOpen() {
	UseWord.SetWordBookmarkText("realName", "<%=uid.getUserRealName()%>");
	UseWord.SetWordBookmarkText("sex", "<%=uid.getSex()%>");
	UseWord.SetWordBookmarkText("birthday", "<%=uid.getBirthday()%>");
	UseWord.SetWordBookmarkText("nation", "<%=uid.getNation()%>");
	UseWord.SetWordBookmarkText("people", "<%=uid.getPeople()%>");
	UseWord.SetWordbookmarkText("polity", "<%=uid.getPolity()%>");
	UseWord.SetWordbookmarkText("healthState", "<%=uid.getHealthState()%>");
	UseWord.SetWordbookmarkText("joinDepartmentDate", "<%=uid.getJoinDepartmentDate()%>");
	UseWord.SetWordbookmarkText("inactiveService", "<%=uid.getInActiveService()%>");
	UseWord.SetWordbookmarkText("resume", "<%=resume%>");
	UseWord.SetWordbookmarkText("rewards", "<%=rewards%>");
}

function getBookMark() {
	//var str = UseWord.GetWordBookmarkText("realName");
	//alert(str);
}
</script>
</html>
