<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>图书类别编辑</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--

//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "book.all";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("modify")) {
	BookMgr bm = new BookMgr();
	boolean re = false;
	try {
		re = bm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

int id = ParamUtil.getInt(request, "id");
BookDb btd = new BookDb();
BookTypeDb btdb = new BookTypeDb();
btd = btd.getBookDb(id);
int typeId = btd.getTypeId();
String pubDate = DateUtil.format(btd.getPubDate(), "yyyy-MM-dd");
%>
<%@ include file="book_inc_menu_top.jsp"%>
<br>
<table width="629" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <form action="book_do.jsp?op=modify" name="form1" method="post">
    <tr>
      <td colspan="4" class="right-title">修改图书</td>
    </tr>
    <tr>
      <td width="74">书名： </td>
      <td width="231"><input name="bookName" type="text" id="bookName" value="<%=btd.getBookName()%>" size="30" maxlength="100">
      <font color=red>*<span class="TableData">
      <input type=hidden name="id" value="<%=btd.getId()%>">
      </span></font></td>
      <td width="79">图书编号：</td>
      <td width="183"><input type="text"  name="bookNum" id="bookNum" value="<%=btd.getBookNum()%>" maxlength="110" >
      <font color=red>*</font></td>
    </tr>
    <tr>
      <td>图书类别：</td>
      <td><%
	  String opts = "";
	  Iterator ir = btdb.list().iterator();
	  while (ir.hasNext()) {
	  	 btdb = (BookTypeDb)ir.next();
	  	 opts += "<option value='" + btdb.getId() + "'>" + btdb.getName() + "</option>";
	  }
	  %>
          <select name="typeId" id="typeId" >
            <option selected>-----请选择-----</option>
            <%=opts%>
          </select>
        <font color=red>*</font>
		<script>
		form1.typeId.value = "<%=btdb.getId()%>";
		</script>
		</td>
      <td>图书归属：</td>
      <td width="183"><select name="deptCode">
        <%
	DeptMgr dm = new DeptMgr();
	DeptDb lf = dm.getDeptDb(DeptDb.ROOTCODE);
	DeptView dv = new DeptView(lf);
	dv.ShowDeptAsOptions(out, lf, lf.getLayer()); 
 %>
      </select>
		<script>
		form1.deptCode.value = "<%=btd.getDeptCode()%>";
		</script>
	  </td>
    </tr>
    <tr>
      <td>作者： </td>
      <td><input name="author" type="text" id="author" value="<%=btd.getAuthor()%>" size="30" maxlength="100"></td>
      <td>价格：(￥)</td>
      <td><input type="text" name="price" id="price" maxlength="100" value="<%=btd.getPrice()%>">
          <font color=red>*</font></td>
    </tr>
    <tr>
      <td>出版社：</td>
      <td><input name="pubHouse" type="text" id="pubHouse" value="<%=btd.getPubHouse()%>" size="30" maxlength="100"></td>
      <td>出版日期： </td>
      <td><input name="pubDate" type="text" id="pubDate"value="<%=pubDate%>" maxlength="100">
          <img style="CURSOR: hand" onClick="SelectDate('pubDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
    </tr>
    <tr>
      <td align="left" nowrap>内容简介：</td>
      <td colspan="3"><textarea  name="brief"  id="brief" style="width:100%" rows="8" ><%=btd.getBrief()%></textarea>      </td>
    </tr>
    <tr>
      <td colspan="4" align="center"><input name="submit2" type="submit"  value="确定" >
        &nbsp;
        <input name="reset" type="reset"  value="重置" >      </td>
    </tr>
  </form>
</table>
<br>
<br>
</body>
</html>
