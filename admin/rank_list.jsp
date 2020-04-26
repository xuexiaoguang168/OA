<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.SkinUtil"%>
<%@ page import = "com.redmoon.oa.basic.*"%>
<%@ page import = "com.redmoon.oa.pvg.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>职级管理</title>
</head>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	RankMgr rm = new RankMgr();
	boolean re = false;
	try {
		  re = rm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "rank_list.jsp"));

}%>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="98%" border="0" align="center">
<tr align="center">
  <td width="100%"><table width="100%" border="0" align="center" cellspacing="1" class="tableframe">
    <tr align="center">
      <td width="42%" bgcolor="#00CCFF" class="right-title">名称</td>
      <td width="21%" bgcolor="#00CCFF" class="right-title">序号</td>
      <td width="37%" bgcolor="#00CCFF" class="right-title">操作</td>
    </tr>
    <tr align="center">
      <%
	    RankDb rdb = new RankDb();
		Iterator ir = rdb.list().iterator();
	  	String userRealName = "";
		String userName = "";
		while (ir.hasNext()) {
		  rdb = (RankDb)ir.next();
	%>
      <td bgcolor="#FFFFFF"><%=rdb.getName()%></td>
      <td bgcolor="#FFFFFF"><%=rdb.getOrders()%></td>
      <td bgcolor="#FFFFFF"><a href="#" class="STYLE2" onClick="window.open('rank_edit.jsp?code=<%=StrUtil.UrlEncode(rdb.getCode())%>','','height=100, width=320, top=200,left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onClick="if (confirm('您确定要删除<%=rdb.getName()%>吗？')) window.location.href='?op=del&code=<%=StrUtil.UrlEncode(rdb.getCode())%>'">删除</a></td>
    </tr>
    <%}%>
  </table></td>
</tr>
<tr>
  <td align="center">&nbsp;
    <input name="button" type="button" class="button1" onclick="window.location.href='rank_add.jsp'" value="添加职级" /></td></tr>
</table>
</body>
</html>
