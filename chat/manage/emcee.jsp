<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.db.*"%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<TITLE>茶室管理</TITLE>
<LINK href="../../common.css" type=text/css rel=stylesheet>
<script language="javascript">
<!--
function btnadd_onclick()
{
  errmsg=""
  if (form1.newemcee.value=="")
    errmsg += "请填写新主持人姓名！\n";
  if (errmsg!="")
  {
  	alert(errmsg);
	return;
  }
  var opt = document.createElement('OPTION');
  opt.value=form1.newemcee.value;
  opt.text=form1.newemcee.value;
  form1.emcees.add(opt);
  form1.newemcee.value="";
 }
 
function btndel_onclick()
{
   len = form1.emcees.options.length;
   for (i=0; i<len; i++)
   {
     if (form1.emcees.options(i).selected)
     {
     form1.emcees.remove(i);
     len -= 1;
     i -= 1;
     }
   }
} 

function btnup_onclick() {
index = form1.emcees.selectedIndex
if (index==0)
	return;

temp = form1.emcees.options(index).text
form1.emcees.options(index).value = form1.emcees.options(index-1).value;
form1.emcees.options(index).text = form1.emcees.options(index-1).text;
form1.emcees.options(index-1).value = temp
form1.emcees.options(index-1).text = temp;
form1.emcees.selectedIndex = index-1;
}

function btndown_onclick() {
index = form1.emcees.selectedIndex
if (index==form1.emcees.length-1)
	return;

temp = form1.emcees.options(index).text
form1.emcees.options(index).value = form1.emcees.options(index+1).value;
form1.emcees.options(index).text = form1.emcees.options(index+1).text;
form1.emcees.options(index+1).value = temp
form1.emcees.options(index+1).text = temp;
form1.emcees.selectedIndex = index+1;
}

function form1_onsubmit() {
   len = form1.emcees.options.length;
   for (i=0; i<len; i++)
   {
     form1.emcees.options(i).selected = true;
   }
   return true;
}
//-->
</script>
<%@ include file="../../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><BODY>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.chat")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" class="right-title">&nbsp;讨 
      论 室 主 持 人</td>
  </tr>
  <tr> 
    <td valign="top">
<%
String room = ParamUtil.get(request, "room");
if (room==null)
{
	out.println(fchar.makeErrMsg("茶室不能为空！"));
	return;
}
%>
<%
String sql = "Select * from sq_roomemcee where room="+fchar.sqlstr(room);
RMConn rmconn = new RMConn(Global.defaultDB);
ResultIterator ri = rmconn.executeQuery(sql);
ResultRecord rr = null;
String opt = "";
String emcee = "";
if (ri!=null) {
	while (ri.hasNext())
	{
		rr = (ResultRecord)ri.next();
		emcee = fchar.toHtml(rr.getString("name"));
		opt += "<option value='"+emcee+"'>"+emcee+"</option>";
	}
}
%>
      <br>
      <table width="63%" height="278" border="0" align="center" cellpadding="2" cellspacing="0">
        <form name="form1" id="form1" method="post" action="emcee_do.jsp" LANGUAGE="javascript" onSubmit="return form1_onsubmit()">
          <tr> 
            <td height="22" colspan="2" align="center" bgcolor="#C4DAFF" class="stable"><%=room%>&nbsp;讨论室主持</td>
          </tr>
          <tr> 
            <td width="86%" height="196" align="center" class="stable"> <select id=emcees name=emcees size=2 style="HEIGHT: 180px; WIDTH: 250px" multiple>
                <%=opt%> </select> </td>
            <td width="14%" class="stable"> <input id=btnup name=btnup type=button value=上移 language=javascript onClick="return btnup_onclick()"> 
              <br> <br> <input id=btndown name=btndown type=button value=下移 language=javascript onClick="return btndown_onclick()"></td>
          </tr>
          <tr> 
            <td height="39" colspan="2" align="center" class="stable">主持人 
              <input id=newemcee name=newemcee style="HEIGHT: 22px; WIDTH: 80px"> 
              <input id=btnadd2 language=javascript name=btnadd onClick="return btnadd_onclick()" type=button value=添加> 
              &nbsp; <input id=btndel2 language=javascript name=btndel onClick="return btndel_onclick()" type=button value=删除>            </td>
          </tr>
          <tr> 
            <td colspan="2" align="center" class="stable"> <input name="submit" type="submit" class="button1"value="确定"> 
              &nbsp;&nbsp;&nbsp; <input name="reset" type="reset" class="button1" value="重设"> 
              <input type=hidden name="room" value="<%=room%>"> </td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr>
    <td valign="top">&nbsp;</td>
  </tr>
</table>
</BODY>
</HTML>
