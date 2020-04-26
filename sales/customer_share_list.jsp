<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.visual.module.sales.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>共享人员列表</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=150,left=220,width="+width+",height="+height);
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #FFFFFF}
.STYLE4 {
	color: #000000;
	font-weight: bold;
}
.STYLE5 {color: #FF0000}
.STYLE6 {color: #000000}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	CustomerShareMgr csm = new CustomerShareMgr();
	boolean re = false;
	try {
		  re = csm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

if (op.equals("del")) {
	CustomerShareMgr csm = new CustomerShareMgr();
	boolean re = false;
	try {
		re = csm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

CustomerShareDb csd = new CustomerShareDb();
int id = ParamUtil.getInt(request,"id");
%>
<script language="javascript">
function setPerson(deptCode, deptName, user, userRealName)
{
	form1.sharePerson.value = user;
	form1.sharePersonRealName.value = userRealName;
}
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableframe" height="100%">
  <tr>
    <td class="right-title">&nbsp;共享人员列表</td>
  </tr>
  <form id=form1 name="form1" action="?op=add&id=<%=id%>" method=post onSubmit="return form1_onsubmit()">
  <tr>
    <td align="center"><span class="STYLE6">共享给</span>:
      <input name="sharePerson" id="sharePerson" type=hidden>
      <input name="sharePersonRealName" id="sharePersonRealName" style="width:50px">
      <input name="customerId" id="customerId" type="hidden" value="<%=id%>" />
      <a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择用户</a></span>
      <input name="submit" type=submit class="button1" value="添  加"></td>
  </tr>
  <tr>
    <td valign="top"><%
			  String sql = "select id from customer_share where customerId=" + id;
			  Iterator ir = csd.list(sql).iterator();
			  UserDb ud = new UserDb();
			  while (ir.hasNext()) {
			  	csd = (CustomerShareDb)ir.next();%>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="59%"><%
					ud = ud.getUserDb(csd.getSharePerson());
					%>
              <%=ud.getRealName()%> </td>
          <td width="11%"><a href="#" onClick="if (confirm('您确定要删除<%=csd.getSharePerson()%>吗？')) window.location.href='?op=del&id=<%=id%>&delId=<%=csd.getId()%>'">删除</a></td>
        </tr>
      </table>
    <%}%></td>
  </tr>
  </form>
</table>
</body>
<script>
function form1_onsubmit() {
	if (form1.sharePerson.value=="") {
		alert("请输入用户名");
		return false;
	}
}
</script>
</html>

