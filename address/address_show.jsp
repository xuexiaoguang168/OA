<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<html>
<head>
<title>通讯录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%@ include file="../inc/inc.jsp"%>
<%
int id = ParamUtil.getInt(request, "id");

AddressDb addr = new AddressDb();
addr = addr.getAddressDb(id);
int type = addr.getType();	
String mode = ParamUtil.get(request, "mode");
if (mode.equals("show")) {	
}%>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" class="right-title">　　　　　通 讯 录  </td>
  </tr>
  <tr> 
    <td height="298" valign="top" background="../images/tab-b-back.gif"> 
      <jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
        <%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String person="",job="",tel="",mobile="",email="",address="",postalcode="",introduction="",business="";
	person = addr.getPerson();
	job = addr.getJob();
	tel = addr.getTel();
	mobile = addr.getMobile();
	email = addr.getEmail();
	address = addr.getAddress();
	postalcode = StrUtil.getNullString(addr.getPostalcode());
	if (postalcode.equals(""))
		postalcode = "&nbsp;";
	introduction = addr.getIntroduction();
	business = fchar.getNullStr(addr.getBusiness());
	if (business.equals(""))
		business = "&nbsp;";
%>
      <table width="90%" border="0" align="center">
        <tr> 
          <td height="5"></td>
        </tr>
      </table> 
      <table width="95%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr> 
          <td width="16%" height="21" align="center" bgcolor="#C4DAFF" class="stable">&nbsp;</td>
          <td width="84%" height="21" bgcolor="#C4DAFF" class="stable">通讯录</td>
        </tr>
        <form name="form1" action="address_edit_do.jsp?id=<%=id%>" method="post" onSubmit="">
          <tr> 
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">姓名</td>
            <td height="19" class="stable"><%=person%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">职务</td>
            <td height="19" class="stable"><%=job%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">电话</td>
            <td height="19" class="stable"><%=tel%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">手机</td>
            <td height="19" class="stable"><%=mobile%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">Email</td>
            <td height="19" class="stable"><%=email%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">地址</td>
            <td height="19" class="stable"><%=address%></td>
          </tr>
          <tr>
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">单位</td>
            <td height="19" class="stable"><%=business%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#eeeeee" class="stable">邮编</td>
            <td height="19" class="stable"><%=postalcode%></td>
          </tr>
          <tr> 
            <td width="16%" height="17" align="center" bgcolor="#eeeeee" class="stable">简介</td>
            <td width="84%" height="17" class="stable"><%=introduction%> </td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>