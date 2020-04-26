<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>通讯录</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<%
String strtype = ParamUtil.get(request, "type");
int type = AddressDb.TYPE_USER;
if (!strtype.equals(""))
	type = Integer.parseInt(strtype);
if (type==AddressDb.TYPE_PUBLIC) {
	if (!privilege.isUserPrivValid(request, "admin.address.public")) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
%>
<%
        String op = ParamUtil.get(request, "op");
		AddressMgr am = new AddressMgr();
		boolean re = false;
		if (op.equals("add")) {
			try {
				re = am.create(request);
			}
			catch (ErrMsgException e) {
				out.print(StrUtil.Alert(e.getMessage()));
			}
			if (re) {
				out.print(StrUtil.Alert("添加成功，请继续添加！"));
			}
		}
%>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="100%" height="23" valign="middle" class="right-title">　<span>通 
      讯 录 </span></td>
  </tr>
  <tr> 
    <td valign="top">
	 <form name="form1" action="?op=add" method="post" onSubmit="return form1_onsubmit()">
	   <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
         <tr bgcolor="#C4DAFF">
           <td height="21" colspan="4" align="left" bgcolor="#C4DAFF" class="stable"><strong>类别</strong></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">类&nbsp;&nbsp;别</td>
           <td height="19" colspan="3" class="stable"><%
			  AddressTypeDb atd = new AddressTypeDb();
			  String opts = "";
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
                 <option selected>-----请选择-----</option>
                 <%=opts%>
             </select></td>
         </tr>
         <tr bgcolor="#C4DAFF">
           <td height="21" colspan="4" align="left" bgcolor="#C4DAFF" class="stable"><strong>个人信息</strong></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td  height="19" align="center" class="stable">姓&nbsp;&nbsp;名</td>
           <td  height="19" class="stable"><input name="person" class="singleboarder" size=25>
               <input type=hidden name="type" value="<%=type%>"></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">昵&nbsp;&nbsp;称</td>
           <td height="19" colspan="3" class="stable"><input name="nickname" class="singleboarder" size=25></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">部门 </td>
           <td height="19" colspan="3" class="stable"><input name="department" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">科室</td>
           <td height="19" colspan="3" class="stable"><input name="company" class="singleboarder" size=35></td>
         </tr>
        <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">职&nbsp;&nbsp;务</td>
           <td height="19" colspan="3" class="stable"><input name="job" class="singleboarder" size=35></td>
         </tr>
		 <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">办公室电话</td>
           <td height="19" colspan="3" class="stable"><input name="operationPhone" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">手机</td>
           <td height="19" colspan="3" class="stable"><input name="mobile" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">小灵通</td>
           <td height="19" colspan="3" class="stable"><input name="beepPager" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">Email</td>
           <td height="19" colspan="3" class="stable"><input name="email" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">住宅地址</td>
           <td height="19" colspan="3" class="stable"><input name="street" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">住宅电话</td>
           <td height="19" colspan="3" class="stable"><input name="tel" class="singleboarder" size=25></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">住宅传真</td>
           <td height="19" colspan="3" class="stable"><input name="fax" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">QQ</td>
           <td height="19" colspan="3" class="stable"><input name="QQ" class="singleboarder" size=25></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">MSN</td>
           <td height="19" colspan="3" class="stable"><input name="MSN" class="singleboarder" size=25></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">网页</td>
           <td height="19" colspan="3" class="stable"><input name="web" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">邮政编码</td>
           <td height="19" colspan="3" class="stable"><input name="companyPostcode" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">业务传真</td>
           <td height="19" colspan="3" class="stable"><input name="operationFax" class="singleboarder" size=35></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="19" align="center" class="stable">地&nbsp;&nbsp;址</td>
           <td height="19" colspan="3" class="stable"><input name="address" class="singleboarder" size=45></td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td height="17" align="center" class="stable">附注</td>
           <td height="17" colspan="3" bgcolor="#EEEEEE" class="stable"><textarea name="introduction" cols="50" class="singleboarder" rows="8"></textarea> </td>
         </tr>
         <tr bgcolor="#EEEEEE">
           <td colspan="4" align="center" class="stable"><input name="submit" type=submit class="singleboarder" value="发送">
             &nbsp;&nbsp;&nbsp;
             <input name="reset" type=reset class="singleboarder" value="取消">           </td>
         </tr>
       </table>
	 </form>    </td>
  </tr>
</table>
</body>
<script>
function form1_onsubmit() {
	if (form1.typeId.value=="") {
		alert("类别不能为空！");
		return false;
	}
}
</script>
</html>
