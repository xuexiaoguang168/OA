<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.redmoon.oa.db.PageQuery"%>
<%@ page import = "com.redmoon.oa.db.Conn"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>通知管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
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
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:setProperty name="privilege" property="defaulturl" value="../index.jsp"/>
<!--重定向至 :<jsp:getProperty name="privilege" property="defaulturl"   />-->
<%
		String priv="admin";
		String priv1="notice_public";
		boolean isadmin = false, isdepartment = false;
		isadmin = privilege.isUserPrivValid(request,priv);
		isdepartment = privilege.isUserDepartmentPrivValid(request,priv1);
		if (!isadmin && !isdepartment)
		{
			out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
%>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b-top.gif">　　　　　<span class="right-title">公 共 通 
      知 管 理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="../images/tab-b-back.gif">
        <%
		PageQuery pagebean = new PageQuery("ttoa");
		String sql;
		String myname = privilege.getUser(request);
		String department_id = privilege.getDepartmentID(request);
		if (isadmin)
			sql = "select id,title,mydate from notice order by mydate desc";
		else
			sql = "select id,title,mydate from notice where department_id="+department_id+" order by mydate desc";
		
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
String id="",title="",mydate="";
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
          <td width="47"><img src="../images/title1-l.gif" width="47" height="25"></td>
          <td valign="top" background="../images/title1-back.gif"><div align="center" class="title1">找到符合条件的记录 
              <b><%=pagebean.getTotal() %></b> 条　每页显示 <b><%=pagebean.getPageSize() %></b> 
              条　页次 <b><%=curpage %>/<%=totalpages %></b></div></td>
          <td width="47"><img src="../images/title1-r.gif" width="47" height="25"></td>
        </tr>
      </table>
      <br>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
        <tr bgcolor="#EFEFEF"> 
          <td> <div align="center">标题</div></td>
          <td width="28%">日期</td>
          <td width="15%">删除</td>
        </tr>
      </table>
      <%	
		do
		{
		i++;
		id = rs.getString("id");
		title = rs.getString("title");
		mydate = rs.getString("mydate").substring(0,10);
		%>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="line-st-1">
        <tr> 
          <td> &nbsp;<a href=notice_show.jsp?id=<%=id%>><%=title%></a></td>
          <td width="28%"><%=mydate.substring(0,10)%></td>
          <td width="15%"><a href="notice_del.jsp?id=<%=id%>">删除</a></td>
        </tr>
      </table>
      <%
		}
		while(i<pagesize && rs.next());
	}
	else
		out.println(fchar.p_center("暂无通知!"));
  }
  else
	out.println(fchar.p_center("暂无通知!"));
  
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
      <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td width="100%" height="23"> 
            <div align="right"> 
              <%
	  String querystr = "";
	  %>
              <%if(!pagebean.getFirstPage().equals("none")) {%>
              <a href="address.jsp?<%=pagebean.getFirstPage()+querystr%>"><img src="../images/first.gif" width="41" height="12" border="0"></a> 
              <% }
			    if(!pagebean.getPrevPage().equals("none")){
			     %>
              &nbsp;<a href="address.jsp?<%=pagebean.getPrevPage()+querystr%>"><img src="../images/forward.gif" width="47" height="12" border="0"></a> 
              <% } 
			    
				  if(!pagebean.getNextPage().equals("none")){%>
              &nbsp;<a href="address.jsp?<%=pagebean.getNextPage()+querystr%>"><img src="../images/next.gif" width="47" height="12" border="0"></a> 
              <% }
                  if(!pagebean.getLastPage().equals("none")){   %>
              &nbsp;<a href="address.jsp?<%=pagebean.getLastPage()+querystr%>"><img src="../images/last.gif" width="41" height="12" border="0"></a> 
              <% }%>
              &nbsp;</div></td>
        </tr>
      </table>
      <br> 
      <table width="95%" border="0" align="center" cellpadding="2" cellspacing="0" class="p9">
        <tr> 
          <td width="11%" height="21" align="center" bgcolor="#C4DAFF" class="stable">&nbsp;</td>
          <td height="21" colspan="2" bgcolor="#C4DAFF" class="stable">撰写通知</td>
        </tr>
        <form name="form1" enctype="MULTIPART/FORM-DATA" action="notice_add_do.jsp" method="post" onSubmit="">
          <tr> 
            <td height="19" align="center" bgcolor="#EEEEEE" class="stable">标&nbsp;&nbsp;题</td>
            <td height="19" colspan="2" class="stable"> <input name=title class="singleboarder" size=45> 
            </td>
          </tr>
          <tr> 
            <td height="20" align="center" bgcolor="#EEEEEE" class="stable">附&nbsp;&nbsp;件</td>
            <td height="20" colspan="2" class="stable"> <p> 
                <input name=filename type=file class="singleboarder" id="filename">
                选择要上载的文件</p></td>
          </tr>
          <tr> 
            <td width="11%" height="17" align="center" bgcolor="#EEEEEE" class="stable">内&nbsp;&nbsp;容</td>
            <td height="17" colspan="2" class="stable"> <textarea name=content cols="60" class="singleboarder" rows="15"></textarea> 
            </td>
          </tr>
          <tr> 
            <td colspan="3" align="center">&nbsp; </td>
          </tr>
          <tr> 
            <td align="center">&nbsp; </td>
            <td width="40%"> <input name="submit" type=submit class="singleboarder" value="发送">
              &nbsp;&nbsp;&nbsp; </td>
            <td width="49%"><input name="reset" type=reset class="singleboarder" value="取消"></td>
          </tr>
          <tr> 
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>
