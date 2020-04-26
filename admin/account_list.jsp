<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.SkinUtil"%>
<%@ page import = "com.redmoon.oa.account.*"%>
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
<title>帐号管理</title>
</head>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
com.redmoon.oa.pvg.Privilege privilege = new com.redmoon.oa.pvg.Privilege();
if (!privilege.isUserPrivValid(request, "admin.account")) {
    out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	AccountMgr am = new AccountMgr();
	boolean re = false;
	try {
		  re = am.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "account_list.jsp"));

}%>
<body>
<table width="545" border="0" align="center">
<tr>
  <td width="539" align="right">
  <table width="397" border="0" align="center">
  <form action="?op=search" name=form1 method=post>
  <tr>
    <td align="center">按&nbsp;
      <select name=by>
      <option value='userName'>姓名</option>
      <option value='account'>工号</option>
    </select>      &nbsp;
    <input name=what value="" size="20">
    &nbsp;
    <input name="submit" type="submit" value="搜索" />
    &nbsp;
    <input name="button" type="button" onclick="window.location.href='account_add.jsp'" value="添加工号" /></td>
    </tr>
	</form>
</table>

  <%
		String sql;
		// sql = "select a.name from account a, users u where a.name=u.name order by a.name asc" ;
		sql = "select name from account order by name asc" ;
		
		String by = ParamUtil.get(request, "by");
		String what = ParamUtil.get(request, "what");
		if (op.equals("search")) {
			if (by.equals("userName")) {
				sql = "select a.name from account a, users u where a.userName=u.name and u.realName like " + StrUtil.sqlstr("%" + what + "%") + " order by a.name asc" ;
			}
			else if (by.equals("account")) {
				sql = "select name from account where name like " + StrUtil.sqlstr("%" + what + "%") + " order by name asc" ;			
			}
		}
		
		String querystr = "op=" + op + "&by=" + by + "&what=" + StrUtil.UrlEncode(what);
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		AccountDb adb = new AccountDb();
		ListResult lr = adb.listResult(sql, curpage, pagesize);
		int total1 = lr.getTotal();
		Vector v = lr.getResult();
	    Iterator ir1 = null;
		if (v!=null)
			ir1 = v.iterator();
		paginator.init(total1, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}

%>    &nbsp;找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></b></td>
</tr>
<tr align="center">
  <td><table width="539" border="0" align="center" cellspacing="0" class="tableframe">
    <tr align="center">
      <td width="180" class="right-title">工号</td>
      <td width="215" class="right-title">姓名</td>
      <td width="337" class="right-title">操作</td>
    </tr>
    <tr align="center">
      <%
	  	String userRealName = "";
		String userName = "";
		while (ir1!=null && ir1.hasNext()) {
		  adb = (AccountDb)ir1.next();
		  UserDb user = new UserDb();
		  userName = StrUtil.getNullString(adb.getUserName());
		  userRealName = "";
		  if (!userName.equals("")) {
			  user = user.getUserDb(adb.getUserName());
			  if (user!=null && user.isLoaded()) {
				userRealName = user.getRealName();
			  }
		  }
	%>
      <td bgcolor="#FFFFFF"><%=adb.getName()%></td>
      <td bgcolor="#FFFFFF"><%=userRealName%></td>

      <td bgcolor="#FFFFFF"><a href="#" class="STYLE2" onClick="window.open('account_edit.jsp?name=<%=StrUtil.UrlEncode(adb.getName())%>','','height=150, width=350, top=200,left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onClick="if (confirm('您确定要删除<%=adb.getName()%>吗？')) window.location.href='?op=del&name=<%=StrUtil.UrlEncode(adb.getName())%>'">删除</a></td>
    </tr>
    <%}%>
  </table></td>
</tr>
<tr>
  <td align="right">&nbsp;
    <%
			   out.print(paginator.getCurPageBlock("?"+querystr));
			 %></td>
</tr>
</table>
</body>
</html>
