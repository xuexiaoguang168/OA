<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.redmoon.oa.db.PageQuery"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%@ include file="../inc/nocache.jsp"%>
<title>镇江GIS黄页系统</title>
<link href="../common.css" rel="stylesheet" type="text/css">
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
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b5-top.gif">　　　　　<span class="right-title">文 
      件 管 理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="../images/tab-b-back.gif">
        <%
String priv="admin";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
		
		PageQuery pagebean = new PageQuery("ttoa");
		String sql;
		String myname = privilege.getUser(request);
		String department_id = privilege.getDepartmentID(request);
		sql = "select d.id,d.filename,d.title,d.extname,d.opengroup,d.uploaddate,d.username,t.name as typename from document as d,doc_type as t where d.typeid=t.id order by mydate";
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
String id="",filename="";
String title = "",typename = "",extname="",username="",uploaddate="";
int templete = 0;	
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
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0">
        <tr align="center" bgcolor="#C4DAFF"> 
          <td width="26%" class="stable"> 
            <div align="center">标题</div></td>
          <td width="15%" class="stable">类型</td>
          <td width="11%" class="stable"> 上报人</td>
          <td width="14%" class="stable">上报日期</td>
          <td width="14%" class="stable">删除</td>
        </tr>
      </table>
      <%	
		do
		{
		i++;
		id = rs.getString("id");
		title = rs.getString("title");
		username = rs.getString("username");
		uploaddate = rs.getString("uploaddate").substring(0,19);
		typename = rs.getString("typename");
		extname = rs.getString("extname");
		filename = rs.getString("filename");		
		%>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0">
        <tr> 
          <td width="26%" class="stable"><%=title%></td>
          <td width="15%" align="center" class="stable"><%=typename%></td>
          <td width="11%" align="center" class="stable"><%=username%></td>
          <td width="14%" align="center" class="stable"><%=uploaddate%></td>
          <td width="14%" align="center" class="stable"><a href="doc_del.jsp?document_id=<%=id%>">删除</a></td>
        </tr>
      </table>
      <%
		}
		while(i<pagesize && rs.next());
	}
	else
		out.println(fchar.p_center("暂无文件!"));
  }
  else
	out.println(fchar.p_center("暂无文件!"));
  
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
      <br>
      <table width="80%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td height="23"> <div align="right"> 
              <%
	  String querystr = "";
	  %>
              <%if(!pagebean.getFirstPage().equals("none")) {%>
              <a href="doc_m.jsp?<%=pagebean.getFirstPage()+querystr%>"><img src="../images/first.gif" width="41" height="12" border="0"></a> 
              <% }
			    if(!pagebean.getPrevPage().equals("none")){
			     %>
              &nbsp;<a href="doc_m.jsp?<%=pagebean.getPrevPage()+querystr%>"><img src="../images/forward.gif" width="47" height="12" border="0"></a> 
              <% } 
			    
				  if(!pagebean.getNextPage().equals("none")){%>
              &nbsp;<a href="doc_m.jsp?<%=pagebean.getNextPage()+querystr%>"><img src="../images/next.gif" width="47" height="12" border="0"></a> 
              <% }
                  if(!pagebean.getLastPage().equals("none")){   %>
              &nbsp;<a href="doc_m.jsp?<%=pagebean.getLastPage()+querystr%>"><img src="../images/last.gif" width="41" height="12" border="0"></a> 
              <% }%>
              &nbsp;</div></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>
