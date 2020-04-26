<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<html>
<head>
<title>编辑通讯录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%@ include file="../inc/inc.jsp"%>
<%
String strtype = ParamUtil.get(request, "type");
int type = AddressDb.TYPE_USER;
if (!strtype.equals(""))
	type = Integer.parseInt(strtype);
%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" class="right-title">　通 讯 录 </td>
  </tr>
  <tr> 
    <td valign="top" background="../images/tab-b-back.gif">
        <%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
int id = ParamUtil.getInt(request, "id");

AddressDb addr = new AddressDb();
addr = addr.getAddressDb(id);

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
	if (business.equals(""))
		business = "&nbsp;";
%>
        <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999">
        <tr> 
          <td height="21" colspan="2" align="left" bgcolor="#C4DAFF"><strong>个人信息</strong></td>
          </tr>
        <form name="form1" action="address_edit_do.jsp?id=<%=id%>" method="post" onSubmit="">
          <tr> 
            <td width="16%" height="19" align="center" bgcolor="#EEEEEE">姓名</td>
            <td width="84%" height="19" bgcolor="#EEEEEE"><%=person%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#EEEEEE">昵&nbsp;&nbsp;称</td>
            <td height="19" bgcolor="#EEEEEE"> <%=addr.getNickname()%></td>
          </tr>
          <tr>
            <td height="19" align="center" bgcolor="#EEEEEE">部门 </td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getDepartment()%></td>
          </tr>
          <tr>
            <td height="19" align="center" bgcolor="#EEEEEE">科室</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getCompany()%></td>
          </tr>
		  <tr bgcolor="#EEEEEE">
            <td height="19" align="center">职&nbsp;&nbsp;务</td>
            <td height="19"><%=addr.getJob()%></td>
          </tr>
          <tr>
            <td height="19" align="center" bgcolor="#EEEEEE">办公室电话</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getOperationPhone()%></td>
          </tr>
		  <tr> 
            <td height="19" align="center" bgcolor="#EEEEEE">手机</td>
            <td height="19" bgcolor="#EEEEEE"><%=mobile%></td>
          </tr>
          <tr>
            <td height="19" align="center" bgcolor="#EEEEEE">小灵通</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getBeepPager()%></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#EEEEEE">Email</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getEmail()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center">住宅所在</td>
            <td height="19"><%=addr.getStreet()%></td>
          </tr>
          <tr>
            <td height="19" align="center" bgcolor="#EEEEEE">住宅电话</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getTel()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE">住宅传真</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getFax()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE">QQ</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getQQ()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE">MSN</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getMSN()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE">网页</td>
            <td height="19" bgcolor="#EEEEEE"><%=addr.getWeb()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center">邮政编码</td>
            <td height="19"><%=addr.getCompanyPostcode()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center">业务传真</td>
            <td height="19"><%=addr.getOperationFax()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center">地&nbsp;&nbsp;址</td>
            <td height="19"><%=addr.getAddress()%></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="17" align="center">附注</td>
            <td height="17"><%=addr.getIntroduction()%> </td>
          </tr>
        </form>
      </table></td>
  </tr>
</table>
</body>
</html>