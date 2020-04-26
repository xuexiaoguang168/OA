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

function setPerson(deptCode, deptName, user, userRealName)
{
	form1.borrowPerson.value = user;
	form1.userRealName.value = userRealName;
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #313031}
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
<table width="643" border="0" align="center" cellpadding="3" cellspacing="0" class="tableframe">
<form action="book_do.jsp?op=borrow" name="form1" method="post">
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
  <td colspan="4" ><table width="625" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#8F95CF" bgcolor="#9CCFCE"  >
    <tr>
      <td width="103" align="center" bgcolor="#E7E4E2">图书名称</td>
      <td width="103" align="center" bgcolor="#E7E4E2" >图书编号</td>
      <td width="158" align="center" bgcolor="#E7E4E2">出版社</td>
      <td width="114" align="center" bgcolor="#E7E4E2">作者</td>
      <td width="121" align="center" bgcolor="#E7E4E2">所属类别</td>
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
      <td bgcolor="#FFFFFF" id="bookName" name=bookName><span class="STYLE3"><%=bd.getBookName()%></span></td>
      <td bgcolor="#FFFFFF" id="bookNum" name=bookNum ><span class="STYLE3"><%=bd.getBookNum()%></span></td>
      <td bgcolor="#FFFFFF" id="pubHouse" name=pubHouse><span class="STYLE3"><%=bd.getPubHouse()%></span></td>
      <td bgcolor="#FFFFFF" id="author" name=author><span class="STYLE3"><%=bd.getAuthor()%></span></td>
      <td bgcolor="#FFFFFF" id="deptCode" name=deptCode><span class="STYLE3"><%=btd.getName()%></span></td>
     </tr>
	 <%}%>
  </table></td>
  </tr>
<tr>
  <td width="72">借阅时间：</td>
  <td width="191">
  <%
  Date d = new Date();
  String dt = DateUtil.format(d, "yyyy-MM-dd");
  d = DateUtil.addDate(d, 30);
  String edt = DateUtil.format(d, "yyyy-MM-dd");
  %>
  <input type="text" name="beginDate" id="beginDate" value="<%=dt%>" maxlength="100" >  </td>
 <td width="112">预计归还时间：  </td>
  <td width="242"><input type="text" name="endDate" id="endDate" value="<%=edt%>" maxlength="100"><img style="CURSOR: hand" onClick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
</tr>
<tr>
  <td align="left" nowrap>借阅人：</td>
  <td colspan="3"><input type="hidden" name="borrowPerson" id="borrowPerson" value="">
  <input name="userRealName" type="text" id="userRealName" value="" readonly>
    <a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:500px;dialogHeight:480px;status:no;help:no;')">选择用户</a></td>
</tr>
<tr> 
      <td align="left" nowrap>备注：</td>
      <td colspan="3"><textarea  name="brief"  id="brief" style="width:100%" rows="8"></textarea></td>
    </tr><tr>
  
  <td colspan="4" align="center">
     <input name="submit" type="submit" class="button1"  value="提  交" > 
     &nbsp;</td>
</tr>
</form>
</table>
</body>
</html>
