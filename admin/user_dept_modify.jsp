<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>管理用户所属部门</title>
<link href="default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style4 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
<script>
function getDepts() {
	return form1.depts.value;
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="admin";
if (!privilege.isUserPrivValid(request,priv)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String userName = ParamUtil.get(request, "userName");

UserDb ud = new UserDb();
ud = ud.getUserDb(userName);

String depts = "";

DeptUserDb du = new DeptUserDb();
String op = ParamUtil.get(request, "op");
if (op.equals("setDept")) {
	depts = ParamUtil.get(request, "depts");
	String[] ary = StrUtil.split(depts, ",");
	// 删除原来所属的部门
	du.delUser(userName);
	if (ary!=null) {
		int len = ary.length;
		for (int i=0; i<len; i++) {
    		du.create(ary[i], userName, "");	
		}
	}
	out.print(StrUtil.Alert("操作完毕！"));
}

java.util.Iterator ir = du.getDeptsOfUser(userName).iterator();

String deptNames = "";
depts = "";
while (ir.hasNext()) {
	DeptDb dd = (DeptDb)ir.next();
	
	if (depts.equals("")) {
		depts = dd.getCode();
		deptNames = dd.getName();
	}
	else {
		depts += "," + dd.getCode();
		deptNames += "," + dd.getName();
	}
}

%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理<%=ud.getRealName()%>所属部门</td>
    </tr>
  </tbody>
</table>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">
	  所属部门</TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><table width="71%" border="0" cellpadding="0" cellspacing="0">
        <form name="form1" method="post" action="?op=setDept">
          <tr>
            <td height="31" align="center">
              <input type="hidden" name="depts" value="<%=depts%>">
              <textarea name="deptNames" cols="45" rows="5" readOnly wrap="yes" id="deptNames"><%=deptNames%></textarea>
              <input name="userName" value="<%=userName%>" type="hidden">
			  </td>
            </tr>
          <tr>
            <td align="center"></td>
          </tr>
          <tr>
            <td height="43" align="center"><input title="添加部门" onClick="openWinDepts()" type="button" value="选择部门">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input name="Submit" type="submit" value="确定">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input name="Submit2" type="button" value="取消" onClick="window.close()"></td>
          </tr>
        </form>
      </table></TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
<br>
<br>
</body>
<script language="javascript">
<!--
function openWinDepts() {
	var ret = showModalDialog('../dept_multi_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:360px;status:no;help:no;')
	if (ret==null)
		return;
	form1.deptNames.value = "";
	form1.depts.value = "";
	for (var i=0; i<ret.length; i++) {
		if (form1.deptNames.value=="") {
			form1.depts.value += ret[i][0];
			form1.deptNames.value += ret[i][1];
		}
		else {
			form1.depts.value += "," + ret[i][0];
			form1.deptNames.value += "," + ret[i][1];
		}
	}
}
//-->
</script>
</html>