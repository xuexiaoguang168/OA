<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.util.Date"%>
<%@ page import = "com.redmoon.oa.db.Conn"%>
<%@ page import = "com.redmoon.oa.db.PageQuery"%>
<%@ include file="../inc/inc.jsp"%>
<%@ page import="java.text.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>请假申请</title>
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
<body background="" leftmargin="0" topmargin="3" marginwidth="0" marginheight="0">
<jsp:useBean id="calsheet" scope="page" class="com.redmoon.oa.CalendarSheet"/>
<%
	String showtype = fchar.getNullStr(request.getParameter("showtype"));
	String stype = "";
	if (!showtype.equals(""))
	{
		if (showtype.equals("evection"))
			stype = "出差 ";
		else
			stype = "其他原因 "; 
	}
	
	int showmonth = 1, showyear = 2003;
	Calendar cal = Calendar.getInstance();

	int curday = cal.get(cal.DAY_OF_MONTH);
	int curmonth = cal.get(cal.MONTH);
	int curyear = cal.get(cal.YEAR);
	
	String strshowyear = request.getParameter("showyear");
	String strshowmonth = request.getParameter("showmonth");
	if (strshowyear!=null)
		showyear = Integer.parseInt(strshowyear);
	else
		showyear = curyear;
		
	if (strshowmonth!=null)
	{
		showmonth = Integer.parseInt(strshowmonth);
	}
	else
		showmonth = curmonth+1;
	if (showmonth==-1)
		strshowmonth = "全年";
	else
		strshowmonth = showmonth+"月";
	String myname = fchar.UnicodeToGB(request.getParameter("name"));
	if (myname==null) {	
		out.print(fchar.makeErrMsg("缺少用户名！"));
		return;
	}
%>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="23" valign="bottom" background="../images/tab-b2-top.gif">　　　　　<span class="right-title"><%=myname%> <%=strshowmonth%><%=stype%>&nbsp;请 
      假 申 请&nbsp;</span></td>
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
%>	<table width="90%" border="0" align="center">
        <tr>
          <td align="center">
		  
		  <% if (showmonth==-1)
		  		out.print("<font color=red>全年</font>");
			 else { %>
		  <a href="leave_m.jsp?name=<%=URLEncoder.encode(myname,"GBK")%>&showtype=<%=showtype%>&showmonth=-1">全年</a>
		  <% } %>
<%
for (int i=1; i<=12; i++) {
	if (showmonth==i)
		out.print("<a href='leave_m.jsp?name="+URLEncoder.encode(myname,"GBK")+"&showtype="+showtype+"&showmonth="+i+"'><font color=red>"+i+"月</font></a>&nbsp;");
	else
		out.print("<a href='leave_m.jsp?name="+URLEncoder.encode(myname,"GBK")+"&showtype="+showtype+"&showmonth="+i+"'>"+i+"月</a>&nbsp;");
}
%> 		  
		  </td>
        </tr>
        <tr> 
          <td align="center"><a href="leave_m.jsp?name=<%=URLEncoder.encode(myname,"GBK")%>&showmonth=<%=showmonth%>">全部类型</a> 
            <a href="leave_m.jsp?name=<%=URLEncoder.encode(myname,"GBK")%>&showmonth=<%=showmonth%>&showtype=evection">出差</a> 
            <a href="leave_m.jsp?name=<%=URLEncoder.encode(myname,"GBK")%>&showmonth=<%=showmonth%>&showtype=other">其他</a>
			</td>
        </tr>
      </table>
      <%
	  	PageQuery pagebean = new PageQuery("ttoa");
		String sql;
		if (!showtype.equals(""))
		{
			if (showmonth==-1) //当年所有的showtype类型记录
				sql = "select * from leave where DATEDIFF(year,mydate,getDate())=0 and name="+fchar.sqlstr(myname)+" and type="+fchar.sqlstr(showtype);
			else	//当年showmonth的记录
				sql = "select * from leave where DATEDIFF(year,mydate,getDate())=0 and DATEPART(month,mydate)="+showmonth+" and name="+fchar.sqlstr(myname)+" and type="+fchar.sqlstr(showtype);
		}
		else //显示所有的请假事项
		{
			if (showmonth == -1) //当年所有类型记录
				sql = "select * from leave where DATEDIFF(year,mydate,getDate())=0 and name="+fchar.sqlstr(myname);
			else	//当年showmonth的记录
				sql = "select * from leave where DATEDIFF(year,mydate,getDate())=0 and DATEPART(month,mydate)="+showmonth+" and name="+fchar.sqlstr(myname);
		}
		int pagesize = 40; //设为40以使不分页显示，便于统计
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
String id="",checkman="",mydate="",xjdate="",reason="",begindate="",days="",type="";

//用于计算请假次数，销假次数，按时销假次数，超时销假天数，总请假天数，总实际请假天数，总超假天数
int qjcount=0,xjcount=0,asxjcount=0;
float csxjdays=0,allqjdays=0,allrealqjdays=0,allcjdays=0;

float fdays = 0;//本次请假的天数
Date dqjdate,dxjdate;

boolean isxj = false;
try
{
  if (rs!=null )
  {
    if (pagebean.getTotalPages()>0)
	{
%>
      <br> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47"><img src="../images/title1-l.gif" width="47" height="25"></td>
          <td valign="top" background="../images/title1-back.gif"><div align="center" class="title1">共有请假记录 
              <b><%=pagebean.getTotal() %></b> 条　<!--每页显示 <b><%=pagebean.getPageSize() %></b> 
              条　页次 <b><%=curpage %>/<%=totalpages %></b>--></div></td>
          <td width="47"><img src="../images/title1-r.gif" width="47" height="25"></td>
        </tr>
      </table>
      <%	
		do
		{
		i++;
		id = rs.getString("id");
		checkman = rs.getString("checkman");
		mydate = rs.getString("mydate").substring(0,10);
		begindate = rs.getString("begindate").substring(0,10);
		dqjdate = rs.getDate("begindate");
		
		days = rs.getString("days");
		fdays = rs.getFloat("days");
		allqjdays += fdays;
		
		reason = rs.getString("reason");
		isxj = rs.getBoolean("isxj"); //是不否已销假
		type = rs.getString("type");
		xjdate = fchar.getNullStr(rs.getString("xjdate"));
		if (!xjdate.equals(""))
			xjdate = xjdate.substring(0,19);
			
		qjcount++;
		if (isxj)
		{
			xjcount++;
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			dxjdate = format.parse(xjdate);
			long timeqj = dqjdate.getTime();	//假期开始时间
			long timeyxj = timeqj+(int)(fdays*24*60*60*1000);//应销假的时间
			long timexj = dxjdate.getTime();			//实际销假的时间
			//计算是否超出天数，如果超出半天时间，则认为是超假
			int m = (int)(timexj-timeyxj)/1000/60;//销假时的假期总分钟数
			int d = (int)(timexj-timeqj)/1000/60/60/24;//实际请假的天数
			if (m<12*60)	//如果销假时间不超出半天，则认为是按时销假
				asxjcount++;	//按时销假次数
			else {
				csxjdays += m/60/24;//超时销假天数
				allcjdays += csxjdays;//总超假天数				
			}
				
			allrealqjdays += d;//实际总请假天数
		}
		%>
      <table width="100%" border="0" height="5">
        <tr> 
          <td></td>
        </tr>
      </table>
      <table width="416" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr bgcolor="#C4DAFF" class="stable"> 
          <td class="stable" width="18%">准 假 人：</td>
          <td width="19%" class="stable" ><%=checkman%> </td>
          <td width="17%" class="stable" >申请日期：</td>
          <td width="46%" class="stable" ><%=mydate%></td>
        </tr>
        <tr bgcolor="#FFFFFF" class="stable">
          <td class="stable" bgcolor="#EEEEEE">状&nbsp;&nbsp;&nbsp; 态：</td>
          <td colspan="3" class="stable">
		  <%
		  if (isxj)
		  {
		  	out.print("已销假   销假时间 "+xjdate);
		  }
		  else
		  {
		  	out.print("未销假&nbsp;&nbsp;&nbsp;");
			out.print("<a href='leave_xj.jsp?id="+id+"'>现在销假</a>");
		  }
		  %>
		  </td>
        </tr>
        <tr bgcolor="#FFFFFF" class="stable"> 
          <td class="stable" bgcolor="#EEEEEE">开始时间：</td>
          <td colspan="3" class="stable"><%=begindate%></td>
        </tr>
        <tr bgcolor="#FFFFFF" class="stable"> 
          <td class="stable" valign="top" bgcolor="#EEEEEE">天&nbsp;&nbsp;&nbsp;&nbsp;数：</td>
          <td colspan="3" class="stable"><%=days%></td>
        </tr>
        <tr bgcolor="#FFFFFF" class="stable"> 
          <td class="stable" valign="top" bgcolor="#EEEEEE">类 &nbsp;&nbsp;&nbsp;型：</td>
          <td colspan="3" class="stable"> <%
		  if (type.equals("evection"))
		  	type = "出差";
		  else
		  	type = "其他";
		  %><%=type%></td>
        </tr>
        <tr bgcolor="#FFFFFF" class="stable"> 
          <td class="stable" valign="top" bgcolor="#EEEEEE">事&nbsp;&nbsp; &nbsp;由：</td>
          <td colspan="3" class="stable"><%=reason%> </td>
        </tr>
      </table>
      <table width="100%" border="0" height="5">
        <tr> 
          <td></td>
        </tr>
      </table>
      <%
		}
		while(i<pagesize && rs.next());
	}
	else
		out.println(fchar.p_center("暂无请假记录!"));
  }
  else
	out.println(fchar.p_center("暂无请假记录!"));
  
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
      <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td height="23"> <div align="right"> 
              <%
	  String querystr = "&showmonth="+showmonth+"&showtype="+showtype;
	  %>
              <%if(!pagebean.getFirstPage().equals("none")) {%>
              <a href="leave_m.jsp?<%=pagebean.getFirstPage()+querystr%>"><img src="images/first.gif" width="41" height="12" border="0"></a> 
              <% }
			    if(!pagebean.getPrevPage().equals("none")){
			     %>
              &nbsp;<a href="leave_m.jsp?<%=pagebean.getPrevPage()+querystr%>"><img src="images/forward.gif" width="47" height="12" border="0"></a> 
              <% } 
			    
				  if(!pagebean.getNextPage().equals("none")){%>
              &nbsp;<a href="leave_m.jsp?<%=pagebean.getNextPage()+querystr%>"><img src="images/next.gif" width="47" height="12" border="0"></a> 
              <% }
                  if(!pagebean.getLastPage().equals("none")){   %>
              &nbsp;<a href="leave_m.jsp?<%=pagebean.getLastPage()+querystr%>"><img src="images/last.gif" width="41" height="12" border="0"></a> 
              <% }%>
              &nbsp;</div></td>
        </tr>
      </table>
      <table width="98%" border="0" align="center">
        <tr>
          <td align="center"> 
		  <%
		  	 if (showmonth==-1)
		  		out.print("全年：");
			 else
			 	out.print(showmonth+"月：");
		  %>
		  &nbsp;请假次数<%=qjcount%>，销假次数<%=xjcount%>，按时销假次数<%=asxjcount%>， 超时销假天数<%=csxjdays%><br>
            总请假天数<%=allqjdays%>，总实际请假天数<%=allrealqjdays%>，总超假天数<%=allcjdays%>
		  </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="9"><img src="../images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>
