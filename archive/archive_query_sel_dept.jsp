<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户档案查询</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
	if (!privilege.isUserPrivValid(request, "archive.query")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
%>
<br>
<form name="form1" method="post" action="archive_query_confine.jsp">
  <table width="95%" border="0">
    <tr>
      <td><table class="tableframe" cellSpacing="1" cellPadding="2" width="95%" align="center" border="0" bgcolor="#FFFFFF">
        <tbody>
          <tr>
            <td colspan="2" noWrap class="right-title">选择查询部门</td>
          </tr>
<%
	String userName = privilege.getUser(request);
	UserDb ud = new UserDb();
	ud = ud.getUserDb(userName);
	String[] deptCodeArr = ud.getAdminDepts();
	DeptDb dd = new DeptDb();
	int len = 0;
	if (deptCodeArr!=null)
		len = deptCodeArr.length;    
	for (int i=0; i<len; i++) {
%>		  	  
          <tr>
            <td width="6%" noWrap><%=dd.getDeptDb(deptCodeArr[i]).getName()%></td>
            <td><input type="checkbox" name="deptCode" value="<%=deptCodeArr[i]%>" checked>选择该部门
			</td>
          </tr>	
<%
	}
%>	  
        </tbody>
      </table></td>
    </tr>  
    <tr>
      <td align="center"><input value="下一步 &#8594; 选择查询范围" type="submit">&nbsp;&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>
