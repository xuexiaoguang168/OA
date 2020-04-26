<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%!
String connname = "forum";
int CountSize = 6;    //计数不足在前面加零
boolean CountView = true;  //计数是否显示在页面上,False/True
boolean CountType = true;  //统计是记时间还是不记.True记，False不记
boolean CountMode = true; //在页面上显示不计时的计数结果，还是显示计时的结果，默认为不计时（计时为：20分钟内不加数)
int Avera,DayMax,AllCount;
 //计算两个日期之间相隔的天数
 public int DateDiff(java.util.Date lowerLimitDate,java.util.Date upperLimitDate){
   long upperTime,lowerTime;
   upperTime=upperLimitDate.getTime();
   lowerTime=lowerLimitDate.getTime();
   if(upperTime<lowerTime)
	return -1;
   Long result=new Long((upperTime-lowerTime)/(1000*60*60*24));
   return result.intValue();   
 }
%>
<%
ConnUpdate conn = new ConnUpdate(connname);

//==========================================================================
String CountLink = request.getContextPath()+"/forum/admin/counter/ViewInfo.asp"; //查看统计结果的连接。
String ImageLink = request.getContextPath()+"/forum/admin/counter";              //图片地址
Calendar cal = Calendar.getInstance();
String today = cal.get(cal.YEAR)+"-"+cal.get(cal.MONTH)+"-"+cal.get(cal.DATE);
//===========================================================================
String NewYear,NewMonth,NewDay;
NewYear = Integer.toString(cal.get(cal.YEAR));
NewMonth = Integer.toString(cal.get(cal.MONTH)+1);
NewDay = Integer.toString(cal.get(cal.DATE));

if (NewYear.length()<=2)	NewYear="20" + NewYear;
if (NewMonth.length()<=1)	NewMonth="0" + NewMonth;
if (Integer.parseInt(NewDay)<=1)				NewDay="0" + NewDay;
//===========================================================================  基本统计数据
int DayTotal = 0;
ResultSet rs = conn.executeQuery("Select count(*) from DayCount");
if (rs!=null && rs.next())
	DayTotal = rs.getInt(1);                             			//获得统计总天数
else
	DayTotal = 0;
if (rs!=null)	rs.close();
rs = conn.executeQuery("Select * from Count");
java.util.Date StartDate,LogDate=null;
int ToDay=0,TotalDays=0;
if (rs!=null && rs.next())
{
	StartDate = rs.getDate("StartDate");                                 //开始统计日期
	DayMax    = rs.getInt("DayMax");                                     //最高一天流量
	AllCount  = rs.getInt("AllCount");                                   //统计访问总数(使用的天数)
	ToDay     = rs.getInt("ToDayCount");                                 //今天访问流量
	LogDate   = rs.getDate("LogDate");                              	    //统计截止日期
	TotalDays = DateDiff(StartDate,new java.util.Date())+1;         		//统计访问日期数(不管有没有使用，从开始统计算起.)
	Avera     = rs.getInt("AllCount") % TotalDays;                  		//日均访问流量
}
if (rs!=null) rs.close();
if (DateDiff(LogDate,new java.util.Date())>=1) ToDay = 0;

//===========================================================================  预计一天访问量
int intending=(ToDay/(cal.get(cal.HOUR)+1)*(24-cal.get(cal.HOUR)-1)+ToDay);

//===================================================================
String DayID,MonID,YearID;
boolean MyDay;
DayID = request.getParameter("day");
MonID = request.getParameter("mon");

if (DayID==null || !fchar.isNumeric(DayID))
{
     DayID  = NewDay;
     MyDay  = false;
}
else
{
     DayID = DayID.trim();
	 MyDay  = true;
}
if (MonID==null || !fchar.isNumeric(MonID))
{
	MonID = NewYear + NewMonth;
}
else
	MonID = MonID.trim();
YearID = MonID.substring(0,4);
String Mon = MonID.substring(MonID.length()-2);
String dToday = YearID + "-" + Mon;
%>
<%
//===========================================================================
%>
<html>
<head>
<title>风之城统计系统</title>
<%@ include file="../../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../common.css" type="text/css">
<style type="text/css">
<!--
BODY {font-size:9pt;font-family:Tahoma,Verdana,MS Sans Serif,Courier New;}
A:link,A:visited{text-decoration:none;}
A:hover {text-decoration:underline;}
A:hover {text-decoration:overline;color:#FFFF00}
TR,TD,P{font-size:9pt}
B{color:#E1005D;}
INPUT.text,INPUT.file,SELECT,TEXTAREA{color:#000000;background-color:#FFFFFF;border:1 solid #220430}
#TITLE{height:20;Filter: shadow(color=#00AAFF,direction=135);}
.notice{position:relative;height:50;overflow:visible;border:0;z-index:2}
FONT.table{color:#000000}
FONT.strong{color:#FFFFEE;font-weight:bold}
.footer{color:#FFFFEE;font-size:8pt}
.info,.title{background-color:#002F90}
.outter{background-color:#350682}
.cell{background-color:#9B9D9A}
FONT.search{color:#FFFFFF}
FONT.notice{color:#FFFFFF}
.retable{background-color:#FFFFFF}
.rcontent{background-color:#F0F0F0}
FONT.small{font-size:7pt}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<table width="576" border="0" cellpadding="0" cellspacing="0" align="center" height="48">
  <tr> 
    <td align="center"><font color="#000000">今日: <%=today%><img src="<%=ImageLink%>/theme/default/vstatb.gif"> 
      全部: <%=AllCount%><img src="<%=ImageLink%>/theme/default/hstatt.gif"> 最高: 
      <%=DayMax%><img src="<%=ImageLink%>/theme/default/vstatg.gif"> 日均: <%=Avera%> 
      </font></td>
  </tr>
</table>
<table width="576" height="21" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr class=info><td align=right colspan=3><font class=strong>最后20位访问 统计</font></td></tr>
<%        
        ResultSet MyCount = conn.executeQuery("Select * FROM lastly order by Date desc");
        if (conn.getRows()>0)
		{
			while (MyCount.next())
			{
				 String Online = "<Img Src=" + ImageLink + "/theme/default/online.gif align=absmiddle width=13 height=15>";
				 %>
				 <tr class=rcontent><td height=30><nobr><%=MyCount.getDate("Date")%></nobr></td><td><nobr><%=Online%><%=MyCount.getString("IP")%></td><td><%=MyCount.getString("BC")%>&nbsp;&nbsp;<%=MyCount.getString("OS")%></td></tr>
				 <%
			}
		}
		else
            out.println("<tr class=rcontent><TD colspan=3 align=center>没有统计数据</TD></TR>");
        MyCount.close();
        conn.close();  
%>
	</table>
<table width="576" border="0" class="p9" cellpadding="0" align="center">
  <tr>
    <td align="center" height="42"> 
      截止日期: <%=LogDate%>, 统计天数: <%=DayTotal%>/<%=TotalDays%> 天, 预计本日访问量: <%=intending%> 
      人 </td>
  </tr>
</table>
     
<table cellspacing='0' cellpadding='3' width='576' border='0' align="center">
  <tr><td align=center><font class=footer>风之城<br><img src='theme/default/hr_black.gif' height=2 width='60%'><br>Copyright &copy2000-2001 <A href='mailto:bestfeng@163.com'>风青云</A>,All Rights Reserved</font></td></tr>
     <tr><td>
     </td></tr></table>
</body>
</html>