<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加分组类别</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
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
int type = ParamUtil.getInt(request, "type");
String op = ParamUtil.get(request, "op");

if (type==AddressDb.TYPE_PUBLIC) {
	if (!privilege.isUserPrivValid(request, "admin.address.public")) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}

if (op.equals("add")) {
	AddressTypeMgr atm = new AddressTypeMgr();
	boolean re = false;
	try {
		  re = atm.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

if (op.equals("del")) {
	AddressTypeMgr atm = new AddressTypeMgr();
	boolean re = false;
	try {
		re = atm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<table width="541" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
<tr>
  <td height="23" background="../images/top-right.gif" class="right-title">&nbsp;分组类别管理</td>
</tr>
 
      <tr>
        <td align="center"><table width="88%"  border="0" cellpadding="0" cellspacing="0" class=" STYLE3 STYLE3">
          <tr>
            <td class="p14"></td>
          </tr>
          <tr> </tr>
          
          <tr>
            <td class="p14"><%
			  AddressTypeDb atd = new AddressTypeDb();
			  String userName = privilege.getUser(request);
			  if (type==AddressDb.TYPE_PUBLIC)
			  	userName = AddressTypeDb.PUBLIC;
			  String sql = "select id from address_type where USER_NAME=" + StrUtil.sqlstr(userName);
			  
			  Iterator ir = atd.list(sql).iterator();
			  while (ir.hasNext()) {
			  	atd = (AddressTypeDb)ir.next();%> 
                <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
				    <td width="59%"><%=atd.getName()%></td>
                    <td width="16%"><a href="address_type_edit.jsp?id=<%=atd.getId()%>">编辑</a></td>
                    <td width="11%"><a href="#" onClick="if (confirm('您确定要删除<%=atd.getName()%>吗？')) window.location.href='?op=del&id=<%=atd.getId()%>&type=<%=type%>'">删除</a></td>
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
        <td height="26" align="center"><span class="STYLE6">分组类别名称(<span class="STYLE5">*</span>)</span><span class="STYLE4">：</span>
          <input name="name" width="200"><input name="type" value="<%=type%>" type="hidden">
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

