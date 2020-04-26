<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>图书归还</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<style type="text/css">
<!--
.STYLE1 {color: #FFFFFF}
.STYLE2 {color: #0033FF}
-->
</style>
</head>
<script language="javascript">
function getcheckbox(checkboxname){
	var checkboxboxs = document.all.item(checkboxname);
	var CheckboxValue = '';
	if (checkboxboxs!=null)
	{
		if (checkboxboxs.length==null) {
			if (checkboxboxs.checked) {
				return checkboxboxs.value;
			}
		}
		for (i=0; i<checkboxboxs.length; i++)
		{
			if (checkboxboxs[i].type=="checkbox" && checkboxboxs[i].checked)
			{
				if (CheckboxValue==''){
					CheckboxValue += checkboxboxs[i].value;
				}
				else{
					CheckboxValue += ","+ checkboxboxs[i].value;
				}
			}
		}
		//return checkboxboxs.value
	}
	return CheckboxValue;
}
</script>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%
String priv = "book.all";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%@ include file="book_inc_menu_top.jsp"%>
<br>
<table width="643" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <tr> 
    <td width="877" height="23" valign="middle" class="right-title"><span>&nbsp;图书归还</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql;
		String myname = privilege.getUser(request);
		sql = "select id from book where borrowState='1' ";
		String querystr="";
		System.out.println("book_return_list.jsp: " + sql);
		//if (op.equals("mine"))
			//sql = "select id from work_plan where author=" + StrUtil.sqlstr(privilege.getUser(request));
		
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		BookDb bd = new BookDb();
		
		ListResult lr = bd.listResult(sql, curpage, pagesize);
		int total = lr.getTotal();
		Vector v = lr.getResult();
	    Iterator ir = null;
		if (v!=null)
			ir = v.iterator();
		paginator.init(total, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}

%>
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47">&nbsp;</td>
          <td align="right" backgroun="images/title1-back.gif">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></td>
        </tr>
      </table> 
      <form name=form1 action="book_return.jsp" method="post">
	    <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" >
          <tr align="center" bgcolor="#C4DAFF">
            <td width="4%" >&nbsp;</td>
            <td width="33%" height="24" >图书名称</td>
            <td width="23%" bgcolor="#C4DAFF" >借阅人</td>
            <td width="22%" >借阅时间</td>
            <td width="18%" >预计归还时间</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		BookTypeDb btdb = new BookTypeDb();
		UserMgr um = new UserMgr();
		while (ir!=null && ir.hasNext()) {
			bd = (BookDb)ir.next();
			i++;
			int id = bd.getId();
			int typeId = bd.getTypeId();
			BookTypeDb btd = btdb.getBookTypeDb(typeId);
			DeptDb dd = new DeptDb();
			dd = dd.getDeptDb(bd.getDeptCode());
			// out.print("deptCode=" + bd.getDeptCode());
			String deptName = "";
			if (dd!=null && dd.isLoaded())
				deptName = dd.getName();
			String borrowState="";
			String  checkbox;
			if (bd!=null && !bd.getBorrowState()) {
				borrowState="未借出"; 
			}
			else {
			 	borrowState="已借出";   
			}
		%>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="4%"><input name="ids" type="checkbox" value="<%=bd.getId()%>"> </td> 
          <td width="33%" height="22" ><a href="#" class="STYLE2" onClick="window.open('book_show.jsp?id=<%=bd.getId()%>','','height=181, width=400, top=200,left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no')"><%=bd.getBookName()%></a></td>
          <td width="23%"><%
		  UserDb ud = um.getUserDb(bd.getBorrowPerson());
		  %>
		  <%=ud.getRealName()%>
		  </td>
		  <td width="22%"><%=bd.getBeginDate()%></td>
          <td width="18%">
		  <%=bd.getEndDate()%>
		  </td> 
        </tr>
      </table>
      <%}%>	  
	  </form>
      <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td width="1%" height="23">&nbsp;</td>
          <td height="23" valign="baseline"> 
            <div align="right">
              <%
			   out.print(paginator.getCurPageBlock("?"+querystr));
			 %>
            &nbsp;</div></td>
        </tr>
      </table>    </td>
  </tr>
  <tr> 
    <td height="30" colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="submit" class="button1"  value="  还  书 " onClick="form1.submit()">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>

</body>
</html>
