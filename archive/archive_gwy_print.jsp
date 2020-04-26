<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.security.*"%>
<%@ page import = "java.util.*"%>
<HTML>
<HEAD>
<TITLE>ATL 3.0 test page for object UseWord</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY>
<P>
<OBJECT id=UseWord classid=CLSID:D01B1EDF-E803-46FB-B4DC-90F585BC7EEE 
VIEWASTEXT><PARAM NAME="BackColor" VALUE="0000ff00">
<PARAM NAME="Server" VALUE="localhost">
<PARAM NAME="Port" VALUE="8080">
<PARAM NAME="isAutoUpload" VALUE="0" />
<PARAM NAME="isConfirmUpload" VALUE="1" />
<PARAM NAME="PostScript" VALUE="">
<PARAM NAME="WordUrl" VALUE="">
</OBJECT></P>
<p><a href="javascript:UseWord.Open('<%=Global.getRootPath()%>/archive/doc_templ/111.doc')">打开WORD </a>&nbsp;&nbsp;</p>
<%
String userName = ParamUtil.get(request,"userName");
String sql = "";
if (userName.trim().equals("") || !SecurityUtil.isValidSqlParam(userName) || userName.length() > 20) {
   out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.module.archive","warn_username_err_archive")));
   return;
}
UserInfoDb uid = new UserInfoDb();
uid = uid.getUserInfoDb(userName);
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
   resume += urd.getCompany() + urd.getJob() + DateUtil.format(urd.getBeginDate(),"yyyy-MM-dd") + DateUtil.format(urd.getEndDate(),"yyyy-MM-dd") + "<br>";
} // end 工作简历	

// 何时受过何种奖惩 rewards
UserRewardsDb urwd = new UserRewardsDb();
Iterator ir2 = urwd.list(sql).iterator();
String rewards = "";
while (ir2.hasNext()) {
  urwd = (UserRewardsDb)ir2.next();
  rewards += DateUtil.format(urwd.getMyDate(),"yyyy-MM-dd") + urwd.getPlace() + urwd.getRewards() + urwd.getReason() + "<br>";
} // end 何时受过何种奖惩
%>
</BODY>
<script language=javascript>
function doalert()
{
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
</HTML>