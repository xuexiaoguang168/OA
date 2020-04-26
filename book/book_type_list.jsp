<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加图书类别</title>
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
String priv="book.all";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	BookTypeMgr btm = new BookTypeMgr();
	boolean re = false;
	try {
		  re = btm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

if (op.equals("del")) {
	BookTypeMgr btm = new BookTypeMgr();
	boolean re = false;
	try {
		re = btm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<%@ include file="book_inc_menu_top.jsp"%>
<br>
<table width="541" height="89" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
<tr>
  <td height="23" background="../images/top-right.gif" class="right-title"><span> &nbsp;图书类别管理</span></td>
</tr>
 
      <tr>
        <td align="center"><table width="88%" height="81"  border="0" cellpadding="0" cellspacing="0" class=" STYLE3 STYLE3">
          <tr>
            <td class="p14"></td>
          </tr>
          <tr> </tr>
          <tr>
            <td class="p14">&nbsp;</td>
          </tr>
          <tr>
            <td class="p14"><%
			  BookTypeDb btd = new BookTypeDb();
			  String sql = "select id from book_type";
			  Iterator ir = btd.list(sql).iterator();
			  while (ir.hasNext()) {
			  	btd = (BookTypeDb)ir.next();%>
                <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
				    <td width="59%"><%=btd.getName()%></td>
                    <td width="16%"><a href="book_type_edit.jsp?id=<%=btd.getId()%>">编辑</a></td>
                    <td width="11%"><a href="#" onClick="if (confirm('您确定要删除<%=btd.getName()%>吗？')) window.location.href='?op=del&id=<%=btd.getId()%>'">删除</a></td>
                  </tr>
                </table>
              <%}%>            </td>
          </tr>
        </table></td>
      </tr>
  
  <tr> 
  <tr>
    <td></td>
  </tr>
  <form id=form1 name="form1" action="?op=add" method=post>
    <td valign="top">
	  <tr>
	   <td>&nbsp;</td>
	  </tr>
	  <tr>
        <td height="26" align="center"><span class="STYLE6">图书类别名称(<span class="STYLE5">*</span>)</span><span class="STYLE4">：</span>
          <input name="name" width="200">
          &nbsp;&nbsp;&nbsp;&nbsp;
          <input name="submit" type=submit class="button1" value="添  加">
	    &nbsp;</span></td>
      </tr>
  </form>
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

