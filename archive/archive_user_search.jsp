<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>搜索档案</title>
<link rel="stylesheet" type="text/css" href="../common.css">
</head>
<body class="bodycolor">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	String userName = privilege.getUser(request);
	String deptCode = "";
	UserDb ud = new UserDb();
	ud = ud.getUserDb(userName);
	String[] deptCodeArr = ud.getAdminDepts();
	DeptDb dd = new DeptDb();
	int len = 0;
	if (deptCodeArr!=null)
		len = deptCodeArr.length;    
	for (int i=0; i<len; i++) {
		deptCode += "'" + deptCodeArr[i] + "'";
		if(i < len -1){
			deptCode += ",";
		}
	}


	BasicDataMgr bdm = new BasicDataMgr("archive");
	String options = "";
%>
<br>
<table width="80%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#FFFFFF" class="tableframe">
<form action="archive_user_list.jsp?op=search" method="post">
  <tr>
    <td height="24" colspan="2" class="right-title">&nbsp;&nbsp;查询档案</td>
    </tr>
  <tr>
    <td height="24">&nbsp;姓名</td>
    <td width="85%"><input type="text" name="realName" size="20" maxlength="25" class="BigInput"></td>
  </tr>
  <tr>
    <td height="24">&nbsp;性别</td>
    <td>
	    <select name="sex">
		  <option value="" selected></option>
          <option value="女">女</option>
          <option value="男">男</option>
        </select>	</td>
  </tr>
  <tr>
    <td height="24">&nbsp;出生日期</td>
    <td><input maxLength="10" size="20" name="fromBirthday"> 
        <img style="CURSOR: hand" onClick="SelectDate('fromBirthday', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">&nbsp;至 
        <input maxLength="10" size="20" name="toBirthday"><img style="CURSOR: hand" onClick="SelectDate('toBirthday', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 日期格式形如 1999-1-2	</td>
  </tr>
  <tr>
    <td height="24">&nbsp;加入本单位时间</td>
    <td><input maxLength="10" size="20" name="fromJoinDepartmentDate"> 
        <img style="CURSOR: hand" onClick="SelectDate('fromJoinDepartmentDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">&nbsp;至 
        <input maxLength="10" size="20" name="toJoinDepartmentDate"><img style="CURSOR: hand" onClick="SelectDate('toJoinDepartmentDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 日期格式形如 1999-1-2	</td>
  </tr>
  <tr>
    <td height="24">&nbsp;在职情况</td>
    <td><%options = bdm.getOptionsStr("inActiveService");%>
		<select name="inActiveService">
		<%=options%>
        </select>	</td>
  </tr>
  <tr>
    <td height="24">&nbsp;健康状况</td>
    <td><%options = bdm.getOptionsStr("healthState");%>
		<select name="healthState">
		<%=options%>
        </select>	</td>
  </tr>
  <tr>
    <td height="24">&nbsp;最高学历</td>
    <td><%options = bdm.getOptionsStr("grade");%>
		<select name="mostGrade">
		<%=options%>
        </select>	</td>
  </tr>
  <tr>
    <td height="24">&nbsp;文化程度</td>
    <td><%options = bdm.getOptionsStr("culture");%>
		<select name="culture">
		<%=options%>
        </select></td>
  </tr>
  <tr>
    <td height="24">&nbsp;</td>
    <td height="30"><input type="submit" name="Submit" value=" 查 询 ">
      <input type="hidden" name="deptCode" value="<%=deptCode%>"></td>
  </tr>
</form>
</table>
</body>
</html>
