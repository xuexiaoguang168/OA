<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.base.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>用户管理</title>
<link href="default.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--

//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.STYLE2 {color: #000000}
-->
</style>
<body bgcolor="#FFFFFF" leftmargin='0' topmargin='5' marginwidth="0" marginheight="0">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.user")) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = StrUtil.getNullString(request.getParameter("op"));

if (op.equals("del")) {
	UserMgr um = new UserMgr();
	if (um.del(request))
		out.print(StrUtil.Alert("操作成功！"));
	else
		out.print(StrUtil.Alert("操作失败！"));
}

%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">用户管理</td>
    </tr>
  </tbody>
</table>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%"><font size="-1"><b>用户列表</b></font></TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><p>

        <table width="90%" border="0" align="center">
          <tr>
            <td align="center"><a href="user_list.jsp">合法用户</a> <a href="user_list.jsp?op=notvalid">已禁用的用户</a> <a href="user_add.jsp">增加用户</a> </td>
          </tr>
        </table>
        <form name="form1" method="post" action="?op=search">
          <table width="90%" border="0" align="center">
            <tr>
              <td height="25" align="center">用户查找：
                <input type="text" name="content" style="height:18px;width:100px">
                &nbsp;&nbsp;
                <select name="condition" style="height:18px">
                  <option value="realname" selected>真实姓名</option>
                  <option value="nick">用户名</option>
                </select>
                &nbsp;&nbsp;
                <input type="submit" name="Submit" value="查找"></td>
            </tr>
          </table>
        </form>
        <%
		String sql;
	    String querystr = "";
		if(op.equals("search")){
			String content = ParamUtil.get(request,"content");
			String condition = ParamUtil.get(request,"condition");		
		    if(condition.equals("realname"))
			   sql = "select name from users where realname like "+StrUtil.sqlstr("%" + content + "%")+" order by regDate desc";
			else
			   sql = "select name from users where name like "+ StrUtil.sqlstr("%" + content + "%")+" order by regDate desc";
		    querystr += "op=" + op + "&content=" + StrUtil.UrlEncode(content) + "&condition=" + condition;
		}else{
			if (op==null)
				sql = "select name from users where isvalid=1 order by regDate desc";
			else {
				if (op.equals("notvalid"))
					sql = "select name from users where isvalid=0 order by regDate desc";
				else
					sql = "select name from users where isvalid=1 order by regDate desc";
			}
		}	  
		int pagesize = 10;
		UserDb userdb = new UserDb();
	    int total = userdb.getUserCount(sql);
		int curpage,totalpages;
		Paginator paginator = new Paginator(request, total, pagesize);
        //设置当前页数和总页数
	    totalpages = paginator.getTotalPages();
		curpage	= paginator.getCurrentPage();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}		
%>
        <br>
        <table width="90%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="right"><span class="title1">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></span></td>
          </tr>
        </table>
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" class="stable">
          <tr align="center" bgcolor="#C4DAFF">
            <td width="12%" height="24" bgcolor="#ded7c1"> <span class="stable STYLE2">用户名</span></td>
            <td width="16%" bgcolor="#ded7c1" class="stable STYLE2">真实姓名</td>
            <td width="13%" bgcolor="#ded7c1" class="stable STYLE2">职级</td>
            <td width="16%" bgcolor="#ded7c1" class="stable STYLE2">所属部门</td>
            <td width="11%" bgcolor="#ded7c1" class="stable STYLE2">管理部门</td>
            <td width="15%" bgcolor="#ded7c1" class="stable STYLE2">角色</td>
            <td width="17%" bgcolor="#ded7c1" class="stable STYLE2">操作</td>
          </tr>        <%
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
            <td width="12%" height="22" align="center" bgcolor="#ECE7E1" class="stable"><a href="user_edit.jsp?name=<%=StrUtil.UrlEncode(user.getName())%>"><%=user.getName()%></a></td>
            <td width="16%" align="center" bgcolor="#ECE7E1" class="stable"><a href="user_edit.jsp?name=<%=StrUtil.UrlEncode(user.getName())%>"><%=user.getRealName()%></a></td>
            <td width="13%" align="center" bgcolor="#ECE7E1" class="stable">
			<%
			com.redmoon.oa.basic.RankDb rd = new com.redmoon.oa.basic.RankDb();
			rd = rd.getRankDb(user.getRankCode());
			out.print(StrUtil.getNullString(rd.getName()));
			%>			</td>
            <td width="16%" align="center" bgcolor="#ECE7E1" class="stable">
			<%
			DeptUserDb du = new DeptUserDb();
			Iterator ir2 = du.getDeptsOfUser(user.getName()).iterator();
			int k = 0;
			while (ir2.hasNext()) {
				DeptDb dd = (DeptDb)ir2.next();
				if (k==0)
					out.print("<a href='#' onClick=\"openWin('dept_user.jsp?deptCode=" + StrUtil.UrlEncode(dd.getCode()) + "', 620, 420)\">" + dd.getName() + "</a>");
				else
					out.print("，&nbsp;" + "<a href='#' onClick=\"openWin('dept_user.jsp?deptCode=" + StrUtil.UrlEncode(dd.getCode()) + "', 620, 420)\">" + dd.getName() + "</a>");
				k++;
			} 
			%>			</td>
            <td width="11%" align="center" bgcolor="#ECE7E1" class="stable"><a title="用户所管理的部门" href="user_admin_department.jsp?name=<%=StrUtil.UrlEncode(user.getName())%>">管理部门</a></td>
            <td align="center" bgcolor="#ECE7E1" class="stable"><%
com.redmoon.oa.pvg.RoleDb[] rld = user.getRoles();
int rolelen = 0;
if (rld!=null)
	rolelen = rld.length;
for (int m=0; m<rolelen; m++) {
	out.print(rld[m].getDesc() + "&nbsp;&nbsp;");
}
%></td>
            <td width="17%" align="left" bgcolor="#ECE7E1" class="stable">&nbsp;&nbsp;<a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(user.getName())%>">权限</a>&nbsp;&nbsp;<a href="user_edit.jsp?name=<%=StrUtil.UrlEncode(user.getName())%>">信息</a>&nbsp;&nbsp;<!--<a href="user_post.jsp">职位</a>--><a href="#" onClick="if (confirm('您确定要删除吗？删除用户将同时清除论坛帐号！\n请确认该用户是否已使用过系统，否则可能带来未知问题！')) window.location.href='?op=del&userName=<%=StrUtil.UrlEncode(user.getName())%>'">删除</a>&nbsp;&nbsp;<br>
            &nbsp;&nbsp;<a href="../user_proxy.jsp?userName=<%=StrUtil.UrlEncode(user.getName())%>">代理</a>&nbsp;&nbsp;<a href="#" onClick="setDept('<%=StrUtil.UrlEncode(user.getName())%>')">部门</a></td>
          </tr>
        <%
	}
%>
        </table>
        <br>
        <table width="92%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
          <tr>
            <td height="23"><div align="right">
                <%
    out.print(paginator.getCurPageBlock("user_list.jsp?"+querystr));
%>
              &nbsp;</div></td>
          </tr>
        </table>
        <br>
        <p> </TD>
    </TR>
    <TR>
      <TD class=tfoot align=right><DIV align=right>
	   </DIV></TD>
    </TR>
  </TBODY>
</TABLE>
</body>
<script>
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function setDept(userName) {
	openWin("user_dept_modify.jsp?userName=" + userName, 400, 300);
}
</script>
</html>                            
  