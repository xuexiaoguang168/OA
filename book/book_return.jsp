<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.book.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>图书添加</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);
	GetDate = showModalDialog("../util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE1 {color: #0066FF}
-->
</style>
</head>

<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "book.all";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String[] ids = request.getParameterValues("ids");
int len = 0;
if (ids!=null)
	len = ids.length;
else
   out.print(StrUtil.Alert_Redirect("你没有选择要借阅的记录！", "book_query.jsp"))	;
%>
<%@ include file="book_inc_menu_top.jsp"%>
<br>
<table width="703" border="0" align="center" cellpadding="3" cellspacing="0" class="tableframe">
<form action="book_return_do.jsp?op=return" name="form1" method="post">
<tr>
  <td colspan="4" class="right-title" >图书借阅
  <%
  String strids = "";
  for (int k=0; k<len; k++) {
  	if (strids.equals(""))
		strids = ids[k];
	else
		strids += "," + ids[k];
  }
  %>
  <input name=ids type="hidden" value="<%=strids%>">  </td>
</tr>
<%	
	BookDb bd= new BookDb();
    BookTypeDb btdb = new BookTypeDb();
%>
<tr>
  <td colspan="4" ><table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#0099CC"  >
    <tr>
      <td width="19%" height="24" align="center" bgcolor="#C4DAFF">图书名称</td>
      <td width="10%" align="center" bgcolor="#C4DAFF" >图书编号</td>
      <td width="10%" align="center" bgcolor="#C4DAFF">作者</td>
      <td width="11%" align="center" bgcolor="#C4DAFF">所属类别</td>
      <td width="18%" align="center" bgcolor="#C4DAFF">借阅人</td>
      <td width="12%" align="center" bgcolor="#C4DAFF">借阅时间</td>
      <td width="20%" align="center" bgcolor="#C4DAFF">预计归还时间</td>
    </tr>
	<%
	for (int i=0; i<len; i++) {
		bd = bd.getBookDb(Integer.parseInt(ids[i]));
		
	%>
	<%
	    int typeId = bd.getTypeId();
		BookTypeDb btd = btdb.getBookTypeDb(typeId);
	%>	
    <tr>
      <td height="22" bgcolor="#FFFFFF" id="bookName" name=bookName><%=bd.getBookName()%></td>
      <td bgcolor="#FFFFFF" id="bookNum" name=bookNum ><%=bd.getBookNum()%></td>
      <td bgcolor="#FFFFFF" id="pubHouse" name=pubHouse><%=bd.getAuthor()%></td>
      <td bgcolor="#FFFFFF" id="author" name=author><%=btd.getName()%></td>
      <td bgcolor="#FFFFFF" id="deptCode" name=deptCode><%=bd.getBorrowPerson()%></td>
      <td bgcolor="#FFFFFF" id="deptCode" name=deptCode><%=bd.getBeginDate()%></td>
      <td bgcolor="#FFFFFF" id="deptCode" name=deptCode><%=bd.getEndDate()%></td>
    </tr>
	 <%}%>
  </table></td>
  </tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td width="84">归还时间：</td>
  <td width="198">
  <%
  Date d = new Date();
  String dt = DateUtil.format(d, "yyyy-MM-dd");
  d = DateUtil.addDate(d, 30);
  String edt = DateUtil.format(d, "yyyy-MM-dd");
  %>
  <input type="text" name="beginDate" id="beginDate" value="<%=dt%>" maxlength="100" >  </td>
 <td width="103">&nbsp;</td>
  <td width="292">&nbsp;</td>
</tr>
<tr>
  
  <td colspan="4" align="center"><input name="submit" type="submit" class="button1"  value=" 提 交 " ></td>
</tr>
</form>
</table>
</body>
</html>
