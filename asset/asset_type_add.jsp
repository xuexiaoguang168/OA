<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.asset.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加资产类别</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--

//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE5 {color: #FF0000}
.STYLE6 {color: #000000}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="oa.asset";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	AssetTypeMgr am = new AssetTypeMgr();
	boolean re = false;
	try {
		  re = am.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		{//out.print(StrUtil.Alert_Redirect("操作成功！", "officeequip_type_list.jsp"));
%>
    <script>
		window.opener.location.reload();
		window.close();
	</script>
<%}}%>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" valign="bottom" background="../images/top-right.gif" class="right-title">&nbsp;&nbsp;<span>添加资产类别</span></td>
  </tr>
  <tr> 
    <td valign="top"><table width="100%" bgcolor="#FFFFFF">
      <form action="?op=add" method="post" name="form1" id="form1" onSubmit="">
        <tbody>
          <tr>
            <td align="right" width="20%">类别名称：</td>
            <td width="30%"><input maxlength="100" name="name" /></td>
            <td align="right" width="20%"></td>
            <td width="30%"></td>
          </tr>
          <tr>
            <td align="right">月折旧率：</td>
            <td><input maxlength="10" value="0" name="depreciationRate" /></td>
            <td align="right">资产折旧年限：</td>
            <td><input maxlength="9" value="0" name="depreciationYears" /></td>
          </tr>
          <tr>
            <td> </td>
            <td colspan="3">资产月折旧率是按资产购置时间的下个月开始计算折旧</td>
          </tr>
          <tr>
            <td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 注：</td>
            <td colspan="3"><textarea name="abstracts"></textarea></td>
          </tr>
          <tr>
            <td colspan="4" align="center"><input name="button2" type="submit" class="button1" value="确  定">
               &nbsp;&nbsp;&nbsp;&nbsp; 
                <INPUT name="button" type="button" class="button1" onClick="window.close()" value="取  消">
                              </td>
            </tr>
        </tbody>
      </form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
