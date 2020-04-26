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
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td width="100%" height="23" class="right-title">　通 讯 录 编 
      辑 </td>
  </tr>
  <tr> 
    <td valign="top">
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
%>      <form name="form1" action="address_edit_do.jsp?id=<%=id%>" method="post" onSubmit="">
        <table width="95%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr>
          <td height="21" colspan="4" align="left" bgcolor="#C4DAFF" class="stable"><strong>分组</strong></td>
        </tr>
        <tr>
          <td height="19" align="center" bgcolor="#EEEEEE" class="stable">类别</td>
          <td height="19" colspan="3" bgcolor="#EEEEEE"><%
				  String opts = "";
				  AddressTypeDb atd = new AddressTypeDb();
				  String who = privilege.getUser(request);
				  if (type==AddressDb.TYPE_PUBLIC)
					who = AddressTypeDb.PUBLIC;	
				  String sql = "select id from address_type where USER_NAME=" + StrUtil.sqlstr(who);
				  Iterator ir = atd.list(sql).iterator();
				  while (ir.hasNext()) {
					 atd = (AddressTypeDb)ir.next();
					 opts += "<option value='" + atd.getId() + "'>" + atd.getName() + "</option>";
				  }
		   %>
            <select name="typeId" id="typeId" >
              <%=opts%>
              </select>
			  <script>
			  form1.typeId.value = "<%=addr.getTypeId()%>";
              </script>			</td>
        </tr>
		
        <tr> 
          <td height="21" colspan="4" align="left" bgcolor="#C4DAFF" class="stable"><strong>个人信息</strong></td>
          </tr>
          <tr> 
            <td width="8%" height="19" align="center" bgcolor="#EEEEEE" class="stable">姓名</td>
            <td width="46%" height="19" bgcolor="#EEEEEE"><input name="person" class="singleboarder" size=25 value="<%=person%>"> 
			<input name="type" type="hidden" value="<%=addr.getType()%>">
            <input name="id" type="hidden" value="<%=addr.getId()%>"></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">昵&nbsp;&nbsp;称</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE"><input name="nickname" class="singleboarder" size=35  value="<%=addr.getNickname()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">部门 </td>
            <td height="19" colspan="3" class="stable"><input name="department" class="singleboarder" size=35 value="<%=addr.getDepartment()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">科室</td>
            <td height="19" colspan="3" class="stable"><input name="company" class="singleboarder" size=35 value="<%=addr.getCompany()%>"></td>
          </tr>
		  <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">职&nbsp;&nbsp;务</td>
            <td height="19" colspan="3" class="stable"><input name="job" class="singleboarder" size=35 value="<%=addr.getJob()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">办公室电话</td>
            <td height="19" colspan="3" class="stable"><input name="operationPhone" class="singleboarder" size=35 value="<%=addr.getOperationPhone()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">手机</td>
            <td height="19" colspan="3" class="stable"><input name="mobile" class="singleboarder" size=35 value="<%=mobile%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">小灵通</td>
            <td height="19" colspan="3" class="stable"><input name="beepPager" class="singleboarder" size=35 value="<%=addr.getBeepPager()%>"></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">Email</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE"><input name="email" class="singleboarder" size=35  value="<%=addr.getEmail()%>"></td>
          </tr>
          <tr> 
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">手机</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE"><input name="mobile" class="singleboarder" size=25 value="<%=mobile%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">住宅所在</td>
            <td height="19" colspan="3" class="stable"><input name="street" class="singleboarder" size=35 value="<%=addr.getStreet()%>"></td>
          </tr>
          <tr>
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">住宅电话</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE"><input name="tel" class="singleboarder" size=25 value="<%=addr.getTel()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">住宅传真</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE" class="stable"><input name="fax" class="singleboarder" size=35 value="<%=addr.getFax()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">QQ</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE" class="stable"><input name="QQ" class="singleboarder" size=35 value="<%=addr.getQQ()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">MSN</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE" class="stable"><input name="MSN" class="singleboarder" size=35 value="<%=addr.getMSN()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">网页</td>
            <td height="19" colspan="3" bgcolor="#EEEEEE" class="stable"><input name="web" class="singleboarder" size=35 value="<%=addr.getWeb()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">邮政编码</td>
            <td height="19" colspan="3" class="stable"><input name="companyPostcode" class="singleboarder" size=35 value="<%=addr.getCompanyPostcode()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">业务传真</td>
            <td height="19" colspan="3" class="stable"><input name="operationFax" class="singleboarder" size=35 value="<%=addr.getOperationFax()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="19" align="center" class="stable">地&nbsp;&nbsp;址</td>
            <td height="19" colspan="3" class="stable"><input name="address" class="singleboarder" size=45 value="<%=addr.getAddress()%>"></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="17" align="center" class="stable">附注</td>
            <td height="17" colspan="3" class="stable"><textarea name=introduction cols="50" class="singleboarder" rows="8"><%=addr.getIntroduction()%> </textarea></td>
          </tr>
          <tr> 
            <td colspan="4" align="center" class="stable"> <input name="submit" type=submit class="singleboarder" value="确 定"> 
              &nbsp;&nbsp;&nbsp; <input name="reset" type=reset class="singleboarder" value="取 消">            </td>
          </tr>
    </table>
        </form></td>
  </tr>
</table>
</body>
</html>