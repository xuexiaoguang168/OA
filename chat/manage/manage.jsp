<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.db.*"%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<TITLE>讨论室管理</TITLE>
<link href="../../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<BODY leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.chat")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String sql = "Select * from sq_chatroom";
RMConn rmconn = new RMConn(Global.defaultDB);
ResultIterator ri = rmconn.executeQuery(sql);
ResultRecord rr = null;
%>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD class=right-title>讨论管理</TD>
  </TR></TBODY></TABLE>
<br>
<table align="center" border="0" cellPadding="2" cellSpacing="0" class="p9" height="54" width="61%">
  <tr class="right-title"> 
    <td width="22%" height="28" align="center">讨论室名称</td>
    <td width="36%" height="28" align="center">主&nbsp;&nbsp;&nbsp;&nbsp;题</td>
    <td width="17%" height="28" align="center">满座人数</td>
    <td width="25%" height="28" align="center"> 
      更改 </td>
  </tr>
  <%
int i = 0;
while (ri.hasNext()) {
 	rr = (ResultRecord)ri.next();%>
  <tr align="middle" bgColor="#eeeeee" vAlign="center"> 
    <form method="post" action="manage_do.jsp" id="formadd<%=i%>" name="formadd<%=i%>" LANGUAGE="javascript">
      <td width="22%" height="24"> 
        <input id="id" name="id" type=hidden value=<%=rr.getInt("id")%>>
        <input id="name" name="name" type=hidden value=<%=rr.getString("name")%>>
      <%=rr.getString("name")%> </td>
      <td width="36%" height="24" align="center"> 
      <INPUT class=stedit id=topic name=topic style="HEIGHT: 22px; WIDTH: 90%" value='<%=fchar.getNullStr(rr.getString("topic"))%>'>      </td>
      <td width="17%" height="24" align="center"> 
      <INPUT class=stedit id=peopleNum name=peopleNum style="HEIGHT: 22px; WIDTH: 40px" value='<%=rr.getInt("peopleNum")%>'>      </td>
      <td width="25%" height="24" align="left"> 
        <% 
	  String checkm = "";
	  if (rr.getInt("playMusic")==1) 
	  	checkm = "checked";
	  %>
        <input id=playMusic name=playMusic value='1' type="hidden" <%=checkm%>>
        <input name="submit1" type="submit" id="submit1" value="确定">
        &nbsp;
		<%if (!rr.getString("name").equals("办公室")) {%>
        <a target="_blank" href="room_del.jsp?id=<%=rr.getInt("id")%>&room=<%=StrUtil.UrlEncode(rr.getString("name"))%>">删除</a> 
		<%}%>
      <a href="emcee.jsp?room=<%=StrUtil.UrlEncode(rr.getString("name"))%>">主持</a></td>
    </form>
  </tr>
  <%
	i = i+1;
}
%>
</table>
<form target="" method="post" action="room_add.jsp" LANGUAGE="javascript">
  <table align="center" border="0" cellPadding="2" cellSpacing="0" class="p9" width="61%">
    <tr class="right-title" align="center"> 
      <td height="27" colspan="2">添加讨论室</td>
    </tr>
    <tr bgColor="#eeeeee"> 
      <td width="17%" align="middle">房间名称</td>
      <td width="83%" align="left"> 
      <INPUT type="text"  id="name" name="name" style="width:80">      </td>
    </tr>
    <tr bgColor="#eeeeee"> 
      <td width="17%" align="middle">主 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题</td>
      <td width="83%" align="left"> 
      <INPUT type="text" id=topic name=topic style="width:200">      </td>
    </tr>
    <tr bgColor="#eeeeee"> 
      <td width="17%" align="middle">满座人数</td>
      <td width="83%" align="left"> 
        <INPUT type="text" id=peopleNum name=peopleNum style="width:50" value="100">
      <input type="hidden" id=playMusic2 name=playMusic2 value="1">      </td>
    </tr>
    
    <tr bgColor="#eeeeee"> 
      <td height="33" colspan="2" align="center"> 
        <INPUT type="submit" value="添加" id=submit2 name=submit2> 
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <INPUT type="reset" value="重写" id=reset1 name=reset1></td>
    </tr>
  </table>
</form>
</BODY>
<SCRIPT LANGUAGE=javascript>
<!--
function dodelete(roomname)
{
	window.open("deleteroom.asp?name="+roomname)
}
//-->
</SCRIPT>
</HTML>
