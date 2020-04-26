<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.redmoon.oa.db.PageQuery"%>
<%@ include file="inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>审批流程</title>
<link href="common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language=javascript>
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}
//-->
</script>
</head>
<body background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="90%" border="0">
  <tr>
    <td></td>
  </tr>
</table>
<jsp:useBean id="pdflow" scope="page" class="com.redmoon.oa.flow.PreDefinedFlow"/>
<%
priv="predefinedflow";
boolean isPrivValid = privilege.isUserDepartmentPrivValid(request,priv);
if (!isPrivValid) {
	out.println(fchar.makeErrMsg("您无定义流程的权限！"));
	return;
}
String op = fchar.getNullString(request.getParameter("op"));
if (op.equals("add")) {
	if (pdflow.Add(request))
		out.println(fchar.Alert("增加成功！"));
	else
		out.println(fchar.Alert("增加失败！"));
}
if (op.equals("modify")) {
	if (pdflow.Modify(request))
		out.println(fchar.Alert("修改成功！"));
	else
		out.println(fchar.Alert("修改失败！"));
}
if (op.equals("delete")) {
	if (pdflow.Delete(request))
		out.println(fchar.Alert("删除成功！"));
	else
		out.println(fchar.Alert("删除失败！"));
}
%>
<table width="494" height="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="images/tab-b-top.gif">　　　　　<span class="right-title">预 
      定 义 审 批 流 程</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <form name="form1" method="post" action="?op=add">
	    <tr>
            <td height="28" align="center">流程名称&nbsp; 
              <input type="text" name="title">
              &nbsp; 
              <input name="Submit" type="submit" class="singleboarder" value="增加流程">
           
            </td>
  </tr> </form>
</table>

      <%		
		PageQuery pagebean = new PageQuery("ttoa");
		String sql;
		String myname = privilege.getUser(request);
		String department_id = privilege.getDepartmentID(request);
		sql = "select id,title from predefined_flow where department_id="+department_id;
		int pagesize = 10;
		pagebean.setPageSize(pagesize);
		String Query = fchar.getNullString(request.getParameter("Query"));
		if (!Query.equals(""))
			sql = Query;
			
		ResultSet rs=pagebean.myQuery(sql,request) ; 
		pagebean.PageLegend(response);			
		int curpage,totalpages;
		curpage = pagebean.getCurrentPages();
		totalpages = pagebean.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
int i = 0;
String id="";
String title="";
try
{
  if (rs!=null )
  {
    if (pagebean.getTotalPages()>0)
	{
%>
      <br>
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47"><img src="images/title1-l.gif" width="47" height="25"></td>
          <td valign="top" background="images/title1-back.gif"><div align="center" class="title1">找到符合条件的记录 
              <b><%=pagebean.getTotal() %></b> 条　每页显示 <b><%=pagebean.getPageSize() %></b> 
              条　页次 <b><%=curpage %>/<%=totalpages %></b></div></td>
          <td width="47"><img src="images/title1-r.gif" width="47" height="25"></td>
        </tr>
      </table>
      <br> <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="pt1">
        <tr> 
          <td width="632" height="24" background=""><table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
              <tr align="center" bgcolor="#C4DAFF" class="stable"> 
                <td width="18%" height="22" class="stable"> <div align="center">ID</div></td>
                <td width="54%" class="stable">标题</td>
                <td width="28%" class="stable">设定流程</td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td valign="top" background=""> 
            <%	
		do
		{
		i++;
		id = rs.getString(1);
		title = rs.getString(2);
		%>
            <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
			<form action="?op=modify" method=post>
              <tr bgcolor="#EEEEEE" class="stable"> 
                <td width="19%" class="stable"><%=id%><input type=hidden name=id value="<%=id%>"></td>
                <td width="53%" bgcolor="#EEEEEE" class="stable"><input name=title class="singleboarder" value="<%=title%>" size=40></td>
                <td width="28%" bgcolor="#EEEEEE" class="stable"><input name="Submit2" type="submit" class="singleboarder" value="修改">
                    <input name="Submit3" type="button" class="singleboarder" onClick="javascript:window.location.href='predefinedflow.jsp?op=delete&id=<%=id%>'" value="删除">
                    <input name="Submit4" type="button" class="singleboarder" onClick="javascript:window.location.href='predefinedflow_edit.jsp?predefined_flow_id=<%=id%>'" value="定义">
                  </td>
              </tr>
			 </form>
            </table>
            <%
		}
		while(i<pagesize && rs.next());
	}
	else
		out.println(fchar.p_center("<BR><BR><BR><BR>暂无文件!"));
  }
  else
	out.println(fchar.p_center("<BR><BR><BR><BR>暂无文件!"));
  
}
catch(SQLException e)
{
  out.print("出错: ");
  out.print(e);
  out.print(e.getMessage());
}
if (rs!=null)
{
	rs.close();
	rs = null;
}
pagebean.clear();
%>
          </td>
        </tr>
        <tr> 
          <td height="13" background="" class="pt1">&nbsp;</td>
        </tr>
      </table>
</td>
  </tr>
  <tr> 
    <td height="9"><img src="images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
<table width="61%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
  <tr> 
    <td width="2%" height="23">&nbsp;</td>
    <td width="91%" valign="baseline" height="23"> 
      <div align="right"> 
        <%
	  String querystr = "";
	  %>
        <%if(!pagebean.getFirstPage().equals("none")) {%>
        <a href="predefinedflow.jsp?<%=pagebean.getFirstPage()+querystr%>"><img src="images/first.gif" width="41" height="12" border="0"></a> 
        <% }
			    if(!pagebean.getPrevPage().equals("none")){
			     %>
        &nbsp;<a href="predefinedflow.jsp?<%=pagebean.getPrevPage()+querystr%>"><img src="images/forward.gif" width="47" height="12" border="0"></a> 
        <% } 
			    
				  if(!pagebean.getNextPage().equals("none")){%>
        &nbsp;<a href="predefinedflow.jsp?<%=pagebean.getNextPage()+querystr%>"><img src="images/next.gif" width="47" height="12" border="0"></a> 
        <% }
                  if(!pagebean.getLastPage().equals("none")){   %>
        &nbsp;<a href="predefinedflow.jsp?<%=pagebean.getLastPage()+querystr%>"><img src="images/last.gif" width="41" height="12" border="0"></a> 
        <% }%>
        &nbsp;</div></td>
    <td width="7%" height="23"></td>
  </tr>
</table>
</body>
</html>
