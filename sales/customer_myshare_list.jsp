<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.visual.module.sales.*"%>
<%@ page import = "com.redmoon.oa.visual.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<%@ include file="customer_inc_menu_top.jsp"%>
<br>
<table width="98%" height="89" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
<tr>
  <td height="23" background="../images/top-right.gif" class="right-title"><span> &nbsp;我的共享客户</span></td>
</tr>
 
      <tr>
        <td align="center"><%
			CustomerShareDb csd = new CustomerShareDb();
			FormMgr fm = new FormMgr();
			String formCode = "sales_customer";
			FormDb fd = fm.getFormDb(formCode);
%>
            <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
              <tr align="center" bgcolor="#C4DAFF">
                <td width="23%" bgcolor="#C4DAFF">客户名称</td>
                <td width="21%" bgcolor="#C4DAFF">销售人员</td>
                <td width="20%" bgcolor="#C4DAFF">电话</td>
                <td width="18%" bgcolor="#C4DAFF">传真</td>
                <td width="18%" bgcolor="#C4DAFF">网址</td>
              </tr>
              <%
			  com.redmoon.oa.visual.FormDAOMgr fdm = new com.redmoon.oa.visual.FormDAOMgr(fd);
			  String sql = "select id from customer_share where sharePerson=" + StrUtil.sqlstr(privilege.getUser(request));
			  Iterator ir = csd.list(sql).iterator();
			  while (ir.hasNext()) {
			  	csd = (CustomerShareDb)ir.next();
				int id = csd.getCustomerId();
				com.redmoon.oa.visual.FormDAO fdao = fdm.getFormDAO(id);
				id = fdao.getId();
		%>
              <tr align="center" bgcolor="#EEEEEE">
                <td width="23%" bgcolor="#EEEEEE"><a href="customer_show.jsp?id=<%=id%>&formCode=<%=formCode%>"><%=fdao.getFieldValue("customer")%></a></td>
                <td width="21%" bgcolor="#EEEEEE"><%=fdao.getFieldValue("sales_person")%></td>
                <td width="20%" bgcolor="#EEEEEE"><a href=../visual_show.jsp?id=<%=id%>&formCode=<%=formCode%>><%=fdao.getFieldValue("tel")%></a></td>
                <td width="18%" bgcolor="#EEEEEE"><a href=../visual_show.jsp?id=<%=id%>&formCode=<%=formCode%>><%=fdao.getFieldValue("fax")%></a></td>
                <td width="18%" bgcolor="#EEEEEE"><a href=../visual_show.jsp?id=<%=id%>&formCode=<%=formCode%>><%=fdao.getFieldValue("web")%></a></td>
              </tr>
              <%}%>
            </table>
        </td>
      </tr> 
  <tr> 
  <tr>
    <td></td>
  </tr>
</table>
</td>
  </tr>
  <tr> 
    <td height="9">&nbsp;</td>
  </tr>
<br>
<br>
</body>
</html>

