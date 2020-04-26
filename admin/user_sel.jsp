<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.account.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.base.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>用户-选择</title>
<link href="default.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
  function setPerson(userName, userRealName) {
	window.opener.setPerson(userName, userRealName);
	window.close();
  }
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
body {
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE2 {color: #000000}
-->
</style>
<body bgcolor="#FFFFFF" leftmargin='0' topmargin='5'>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="100%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%"><font size="-1"><b>选择用户</b></font> </TD>
    </TR>
    <TR>
      <TD height="175" align="center" bgcolor="#FFFFFF" style="PADDING-LEFT: 10px">
        <table width="90%" border="0" align="center">
          <form name="form1" method="post" action="?op=search"><tr>
            <td height="25" align="center">请输入真实姓名：
              <input type="text" name="realName" style="height:18px;width:100px">
              &nbsp;
              <input type="submit" name="Submit" value="查找">
            </td>
            </tr></form>
        </table>
<%
/*
String priv="admin";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
*/

		String sql;
	  	String op = ParamUtil.get(request, "op");
		// sql = "select u.name from users u, account a where u.isvalid=1 and u.name=a.userName order by a.name asc";
		sql = "select name from users where isvalid=1 order by name asc";
	  	if (op.equals("search")) {
			String realName = ParamUtil.get(request, "realName");
			sql = "select name from users where realName like " + StrUtil.sqlstr("%" + realName + "%") + " and isvalid=1 order by name asc";
		}
	  	
		int pagesize = 2000;
		UserDb userdb = new UserDb();
	    int total = userdb.getUserCount(sql);
		int curpage,totalpages;
		Paginator paginator = new Paginator(request, total, pagesize);
        // 设置当前页数和总页数
	    totalpages = paginator.getTotalPages();
		curpage	= paginator.getCurrentPage();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}		
%>
        <table width="90%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="right"><span class="title1">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　</b></span></td>
          </tr>
        </table>
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1">
          <tr align="center" bgcolor="#C4DAFF">
            <td width="21%" height="24" bgcolor="#EFEBDE" class="stable STYLE2">真实姓名</td>
            <td width="20%" bgcolor="#EFEBDE" class="stable STYLE2">职级</td>
            <td width="43%" bgcolor="#EFEBDE" class="stable STYLE2">角色</td>
            <td width="16%" bgcolor="#EFEBDE" class="stable STYLE2">操作</td>
          </tr>
        <%
	  	// Vector v = userdb.list(sql, (curpage-1)*pagesize, curpage*pagesize);
		// Iterator ir = v.iterator();
		int start = (curpage-1)*pagesize;
		int end = curpage*pagesize;
		
        ObjectBlockIterator ir = userdb.getObjects(sql, start, end);		
		int i = 0;
		while (ir.hasNext()) {
			i++;
			UserDb user = (UserDb)ir.next();
		%>
          <tr align="left">
            <td width="21%" height="22" align="center" bgcolor="#EEEDF3" class="stable"><a href="user_edit.jsp?name=<%=StrUtil.UrlEncode(user.getName())%>"></a><%=user.getRealName()%></td>
            <td width="20%" align="center" bgcolor="#EEEDF3" class="stable"><%
			com.redmoon.oa.basic.RankDb rd = new com.redmoon.oa.basic.RankDb();
			rd = rd.getRankDb(user.getRankCode());
			out.print(StrUtil.getNullString(rd.getName()));
			%></td>
            <td width="43%" align="center" bgcolor="#EEEDF3" class="stable">
<%
com.redmoon.oa.pvg.RoleDb[] rld = user.getRoles();
int rolelen = 0;
if (rld!=null)
	rolelen = rld.length;
for (int m=0; m<rolelen; m++) {
	out.print(rld[m].getDesc() + "&nbsp;&nbsp;");
}
%>			</td>
            <td width="16%" align="center" bgcolor="#EEEDF3" class="stable"><a href="#" onClick="setPerson('<%=user.getName()%>', '<%=user.getRealName()%>')">选择</a></td>
          </tr>
        <%
	}
%>
        </table>
        <br>
        <table width="92%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
          <tr>
            <td height="23" align="right"><%
	String querystr = "";
    out.print(paginator.getCurPageBlock("?"+querystr));
%></td>
          </tr>
        </table>
        <br>
      <p> </TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
</body>
</html>                            
  