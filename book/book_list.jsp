<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>图书查询</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<style type="text/css">
<!--
.STYLE2 {color: #0033FF}
.STYLE3 {color: #FF0000}
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
<%@ include file="book_inc_menu_top.jsp"%>
<br>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">

  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;图书查询</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
String priv = "read";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
	
		String sql;
		String myname = privilege.getUser(request);
		sql = "select id from book b" ;
		String querystr = "";
		String op = ParamUtil.get(request, "op");
		String cond = "";
		if (op.equals("search")) {
		    String department=ParamUtil.get(request,"department");
			String bookName=ParamUtil.get(request,"bookName");
			String strTypeId=ParamUtil.get(request,"typeId");
			String author=ParamUtil.get(request,"author");
			String bookNum=ParamUtil.get(request,"bookNum");
			String pubHouse=ParamUtil.get(request,"pubHouse");
			String keepSite=ParamUtil.get(request,"keepSite");
			if (!department.equals(""))
				cond = " where b.department like " + StrUtil.sqlstr("%" + department + "%");
			if (!bookName.equals(""))
				if (cond.equals(""))
					cond = " where b.bookName like " + StrUtil.sqlstr("%" + bookName + "%");
				else
					cond += " and  b.bookName like " + StrUtil.sqlstr("%" + bookName + "%");
			if (!strTypeId.equals("all"))
			    if (cond.equals(""))
					cond = " where b.typeId="+strTypeId;
				else
			        cond += " and b.typeId=" + strTypeId;
			if (!author.equals(""))
			    if (cond.equals(""))
					cond = " where b.author like " + StrUtil.sqlstr("%" + author + "%");
				else
					cond += " and b.author like " + StrUtil.sqlstr("%" + author + "%");
			if (!bookNum.equals(""))
			    if (cond.equals(""))
					cond = " where b.bookNum =" + StrUtil.sqlstr(bookNum);
				else
					cond += " and b.bookNum =" + StrUtil.sqlstr(bookNum); 

			if (!pubHouse.equals(""))
			   if (cond.equals(""))
					cond = " where b.pubHouse like " + StrUtil.sqlstr("%" + pubHouse + "%");
				else
					cond+= " and b.pubHouse like " + StrUtil.sqlstr("%" + pubHouse + "%");
			if (!keepSite.equals(""))
			   if (cond.equals(""))
					cond = " where b.keepSite like " + StrUtil.sqlstr("%" + keepSite + "%");
				else
			        cond += " and b.keepSite like " + StrUtil.sqlstr("%" + keepSite + "%");
			sql+=cond;	
			querystr += "op=" +op + "&department=" + StrUtil.UrlEncode(department) + "&bookName=" + StrUtil.UrlEncode(bookName)+ "&typeId=" + strTypeId+ "&author=" + StrUtil.UrlEncode(author)+"&bookNum=" + StrUtil.UrlEncode(bookNum) +"&pubHouse=" + StrUtil.UrlEncode(pubHouse) +"&keepSite=" + StrUtil.UrlEncode(keepSite);
		}
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
      <form name=form1 action="book_borrow.jsp" method="post">
	    <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0" >
          <tr align="center" bgcolor="#C4DAFF">
            <td width="8%" >&nbsp;</td>
            <td width="14%" height="24" >图书类别</td>
            <td width="19%" bgcolor="#C4DAFF" >图书名称</td>
            <td width="12%" bgcolor="#C4DAFF" >图书编号</td>
            <td width="9%" >作者</td>
            <td width="18%" >出版社</td>
            <td width="9%" >借出</td>
            <td width="11%" >操作</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		BookTypeDb btdb = new BookTypeDb();
		while (ir!=null && ir.hasNext()) {
			bd = (BookDb)ir.next();
			i++;
			int id = bd.getId();
			int typeId = bd.getTypeId();
			BookTypeDb btd = btdb.getBookTypeDb(typeId);
			DeptDb dd = new DeptDb();
			dd = dd.getDeptDb(bd.getDeptCode());

			String deptName = "";
			if (dd!=null && dd.isLoaded())
				deptName = dd.getName();
			String borrowState="";
			String  checkbox;
			if (bd!=null && !bd.getBorrowState()) {
				borrowState="否";
				checkbox = ""; 
			}
			else {
			 	borrowState="是";   
				checkbox= "disabled";
			}
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="7%"><input name="ids" type="checkbox" value="<%=bd.getId()%>" <%=checkbox%>> </td> 
          <td width="14%" height="22" ><%=btd.getName()%></td>
          <td width="20%"  ><a href="#" class="STYLE2" onClick="window.open('book_show.jsp?id=<%=bd.getId()%>','','height=181, width=400, top=200,left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no')"><%=bd.getBookName()%></a></td>
		  <td width="12%"  ><%=bd.getBookNum()%></td>
		  <td width="9%"  ><%=bd.getAuthor()%></td>
		  <td width="19%" ><%=bd.getPubHouse()%></td>
          <td width="8%"  ><%=borrowState%></td>
          <td width="6%"  ><a href="book_edit.jsp?id=<%=bd.getId()%>">编辑</a>&nbsp;&nbsp;		  </td>
		  <td width="5%">
		  <a href="book_do.jsp?op=del&id=<%=bd.getId()%>">
		   <%
		     if (!bd.getBorrowState())
		         out.print("删除");
		   %>
          </a></td> 
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
      <%if (privilege.isUserPrivValid(request, "book.all")) {%>
	  <input name="button" type="submit" class="button1"  value="  借  书 " onClick="form1.submit()">
&nbsp;&nbsp;    &nbsp;&nbsp;&nbsp;<input type="button" class="button1" onClick="window.location.href='book_return_list.jsp'" value=" 还  书 ">
	  <%}%>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <input name="button2" type="button" class="button1" onClick="window.location.href='book_query.jsp'" value=" 查  询 "></td>
  </tr>
</table>

</body>
</html>
